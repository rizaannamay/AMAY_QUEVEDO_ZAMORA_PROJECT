using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Profile : Page
    {
        protected global::System.Web.UI.WebControls.FileUpload photoUpload;

        protected string FullName { get; private set; }
        protected string Username { get; private set; }
        protected string Email    { get; private set; }
        protected string Role     { get; private set; }
        protected string BackUrl  { get; private set; }
        protected string ProfileImage { get; private set; }
        protected string UploadMessage { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Session guard
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"])
            {
                Response.Redirect("login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            FullName = Session["FullName"]?.ToString() ?? "User";
            Username = Session["Username"]?.ToString() ?? "user";
            Email    = Session["Email"]?.ToString()    ?? "";
            Role     = Session["Role"]?.ToString()     ?? "Student";
            BackUrl  = string.Equals(Role, "Admin", StringComparison.OrdinalIgnoreCase)
                       ? "Teacher.aspx"
                       : "Student.aspx";

            bool uploadProcessed = false;
            if (IsPostBack && photoUpload != null && photoUpload.HasFile)
            {
                uploadProcessed = ProcessUpload();
            }

            ProfileImage = Session["ProfileImage"]?.ToString() ?? string.Empty;
            if ((string.IsNullOrEmpty(ProfileImage) || uploadProcessed) && Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);
                var storedImage = LoadProfileImageFromDatabase(userId);
                if (!string.IsNullOrEmpty(storedImage))
                {
                    ProfileImage = storedImage;
                    Session["ProfileImage"] = storedImage;
                }
            }
        }

        private string LoadProfileImageFromDatabase(int userId)
        {
            try
            {
                var connectionString = ConfigurationManager.ConnectionStrings["CampusConnectDB"]?.ConnectionString;
                using (var con = new SqlConnection(connectionString))
                {
                    con.Open();
                    using (var cmd = new SqlCommand("SELECT ProfileImage FROM Users WHERE UserId = @uid", con))
                    {
                        cmd.Parameters.AddWithValue("@uid", userId);
                        var result = cmd.ExecuteScalar();
                        return result != DBNull.Value && result != null
                            ? result.ToString()
                            : string.Empty;
                    }
                }
            }
            catch
            {
                return string.Empty;
            }
        }

        private bool ProcessUpload()
        {
            if (photoUpload == null || !photoUpload.HasFile)
            {
                UploadMessage = "Please select an image file to upload.";
                return false;
            }

            var postedFile = photoUpload.PostedFile;
            var allowedExtensions = new[] { ".jpg", ".jpeg", ".png", ".gif", ".webp" };
            var extension = Path.GetExtension(postedFile.FileName)?.ToLowerInvariant() ?? string.Empty;

            if (Array.IndexOf(allowedExtensions, extension) < 0)
            {
                UploadMessage = "Only JPG, PNG, GIF, or WEBP images are allowed.";
                return false;
            }

            if (postedFile.ContentLength > 5 * 1024 * 1024)
            {
                UploadMessage = "Image size must be smaller than 5MB.";
                return false;
            }

            try
            {
                byte[] imageBytes;
                using (var stream = postedFile.InputStream)
                {
                    imageBytes = new byte[postedFile.ContentLength];
                    stream.Read(imageBytes, 0, imageBytes.Length);
                }

                var base64 = Convert.ToBase64String(imageBytes);
                var dataUri = $"data:{postedFile.ContentType};base64,{base64}";

                int userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
                if (userId <= 0)
                {
                    UploadMessage = "Unable to identify your account. Please log in again.";
                    return false;
                }

                var connectionString = ConfigurationManager.ConnectionStrings["CampusConnectDB"]?.ConnectionString;
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    string sql = "UPDATE Users SET ProfileImage = @img WHERE UserId = @uid";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@img", dataUri);
                        cmd.Parameters.AddWithValue("@uid", userId);
                        cmd.ExecuteNonQuery();
                    }
                }

                Session["ProfileImage"] = dataUri;
                ProfileImage = dataUri;
                UploadMessage = "Profile photo uploaded successfully.";
                return true;
            }
            catch (SqlException sqlEx)
            {
                if (sqlEx.Message.IndexOf("truncated", StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    UploadMessage = "Image is too large for the database. Please choose a smaller photo.";
                }
                else
                {
                    UploadMessage = "Unable to save photo. Please try again.";
                }
            }
            catch (Exception)
            {
                UploadMessage = "Unable to save photo. Please try again.";
            }

            return false;
        }
    }
}
