using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Profile : Page
    {
        protected string FullName     { get; private set; }
        protected string Username     { get; private set; }
        protected string Email        { get; private set; }
        protected string Role         { get; private set; }
        protected string BackUrl      { get; private set; }
        protected string ProfileImage { get; private set; }
        protected string UploadMessage { get; private set; }

        private static readonly string[] AllowedExtensions =
            { ".jpg", ".jpeg", ".png", ".gif", ".webp" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"])
            {
                Response.Redirect("login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            FullName = Session["FullName"] != null ? Session["FullName"].ToString() : "User";
            Username = Session["Username"] != null ? Session["Username"].ToString() : "user";
            Email    = Session["Email"]    != null ? Session["Email"].ToString()    : "";
            Role     = Session["Role"]     != null ? Session["Role"].ToString()     : "Student";
            BackUrl  = string.Equals(Role, "Admin", StringComparison.OrdinalIgnoreCase)
                       ? "Teacher.aspx" : "Student.aspx";

            if (IsPostBack)
            {
                // Find the FileUpload control by ID
                var upload = FindControl("photoUpload") as FileUpload;
                if (upload != null && upload.HasFile)
                {
                    ProcessUpload(upload);
                }
                else if (upload == null)
                {
                    UploadMessage = "Upload control not found.";
                }
                else
                {
                    UploadMessage = "No file was received. Please try again.";
                }
            }

            // Always load the latest image from DB / session
            LoadProfileImage();
        }

        private void LoadProfileImage()
        {
            if (Session["UserId"] == null) return;
            int userId = Convert.ToInt32(Session["UserId"]);

            try
            {
                string cs = ConfigurationManager.ConnectionStrings["CampusConnectDB"].ConnectionString;
                using (var con = new SqlConnection(cs))
                {
                    con.Open();
                    using (var cmd = new SqlCommand(
                        "SELECT ProfileImage FROM Users WHERE UserId = @uid", con))
                    {
                        cmd.Parameters.AddWithValue("@uid", userId);
                        var result = cmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            ProfileImage = result.ToString();
                            Session["ProfileImage"] = ProfileImage;
                        }
                        else
                        {
                            ProfileImage = string.Empty;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ProfileImage = Session["ProfileImage"] != null
                    ? Session["ProfileImage"].ToString() : string.Empty;
                UploadMessage = string.IsNullOrEmpty(UploadMessage)
                    ? "Could not load profile image: " + ex.Message : UploadMessage;
            }
        }

        private void ProcessUpload(FileUpload upload)
        {
            var postedFile = upload.PostedFile;

            // Validate extension
            string ext = Path.GetExtension(postedFile.FileName ?? "").ToLowerInvariant();
            if (Array.IndexOf(AllowedExtensions, ext) < 0)
            {
                UploadMessage = "Only JPG, PNG, GIF, or WEBP images are allowed.";
                return;
            }

            // Validate size (max 2MB to stay within NVARCHAR(MAX) comfort zone)
            if (postedFile.ContentLength <= 0)
            {
                UploadMessage = "The file appears to be empty.";
                return;
            }
            if (postedFile.ContentLength > 2 * 1024 * 1024)
            {
                UploadMessage = "Image must be smaller than 2MB.";
                return;
            }

            if (Session["UserId"] == null)
            {
                UploadMessage = "Session expired. Please log in again.";
                return;
            }
            int userId = Convert.ToInt32(Session["UserId"]);

            try
            {
                // Read bytes and build data URI
                byte[] bytes = new byte[postedFile.ContentLength];
                using (var stream = postedFile.InputStream)
                {
                    int totalRead = 0;
                    while (totalRead < bytes.Length)
                    {
                        int read = stream.Read(bytes, totalRead, bytes.Length - totalRead);
                        if (read == 0) break;
                        totalRead += read;
                    }
                }

                string base64  = Convert.ToBase64String(bytes);
                string dataUri = "data:" + postedFile.ContentType + ";base64," + base64;

                // Save to database
                string cs = ConfigurationManager.ConnectionStrings["CampusConnectDB"].ConnectionString;
                using (var con = new SqlConnection(cs))
                {
                    con.Open();
                    using (var cmd = new SqlCommand(
                        "UPDATE Users SET ProfileImage = @img WHERE UserId = @uid", con))
                    {
                        cmd.Parameters.AddWithValue("@img", dataUri);
                        cmd.Parameters.AddWithValue("@uid", userId);
                        int rows = cmd.ExecuteNonQuery();
                        if (rows == 0)
                        {
                            UploadMessage = "No matching user found in database.";
                            return;
                        }
                    }
                }

                // Update session immediately
                Session["ProfileImage"] = dataUri;
                ProfileImage = dataUri;
                UploadMessage = "Profile photo updated successfully!";
            }
            catch (SqlException sqlEx)
            {
                UploadMessage = sqlEx.Message.IndexOf("truncat", StringComparison.OrdinalIgnoreCase) >= 0
                    ? "Image too large for database. Use a smaller photo (under 2MB)."
                    : "Database error: " + sqlEx.Message;
            }
            catch (Exception ex)
            {
                UploadMessage = "Upload failed: " + ex.Message;
            }
        }
    }
}
