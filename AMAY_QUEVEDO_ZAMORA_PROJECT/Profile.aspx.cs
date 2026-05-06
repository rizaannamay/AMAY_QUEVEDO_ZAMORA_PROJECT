using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Profile : Page
    {
        // Hidden fields declared in ASPX — referenced here since no designer file exists
        protected global::System.Web.UI.WebControls.HiddenField hfAction;
        protected global::System.Web.UI.WebControls.HiddenField hfFullName;
        protected global::System.Web.UI.WebControls.HiddenField hfUsername;
        protected global::System.Web.UI.WebControls.HiddenField hfEmail;
        protected global::System.Web.UI.WebControls.FileUpload  photoUpload;

        protected string FullName      { get; private set; }
        protected string Username      { get; private set; }
        protected string Email         { get; private set; }
        protected string Role          { get; private set; }
        protected string BackUrl       { get; private set; }
        protected string ProfileImage  { get; private set; }
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
                string action = hfAction != null ? hfAction.Value : "";

                if (action == "updateProfile")
                {
                    ProcessProfileUpdate();
                }
                else
                {
                    // Photo upload
                    var upload = FindControl("photoUpload") as FileUpload;
                    if (upload != null && upload.HasFile)
                        ProcessUpload(upload);
                }
            }

            LoadProfileImage();
        }

        // ── Update Full Name / Username / Email ───────────────────────────────
        private void ProcessProfileUpdate()
        {
            string newFullName = hfFullName != null ? hfFullName.Value.Trim() : "";
            string newUsername = hfUsername != null ? hfUsername.Value.Trim() : "";
            string newEmail    = hfEmail    != null ? hfEmail.Value.Trim()    : "";

            if (string.IsNullOrEmpty(newFullName) || string.IsNullOrEmpty(newUsername) || string.IsNullOrEmpty(newEmail))
            {
                UploadMessage = "All fields are required.";
                return;
            }

            // Basic email validation
            try { new MailAddress(newEmail); }
            catch { UploadMessage = "Please enter a valid email address."; return; }

            if (Session["UserId"] == null) { UploadMessage = "Session expired. Please log in again."; return; }
            int userId = Convert.ToInt32(Session["UserId"]);

            try
            {
                string cs = @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;";
                using (var con = new SqlConnection(cs))
                {
                    con.Open();

                    // Check username uniqueness (exclude current user)
                    using (var chk = new SqlCommand(
                        "SELECT COUNT(1) FROM Users WHERE Username = @u AND UserId <> @id", con))
                    {
                        chk.Parameters.AddWithValue("@u",  newUsername);
                        chk.Parameters.AddWithValue("@id", userId);
                        if ((int)chk.ExecuteScalar() > 0)
                        {
                            UploadMessage = "That username is already taken.";
                            return;
                        }
                    }

                    // Check email uniqueness (exclude current user)
                    using (var chk = new SqlCommand(
                        "SELECT COUNT(1) FROM Users WHERE Email = @e AND UserId <> @id", con))
                    {
                        chk.Parameters.AddWithValue("@e",  newEmail);
                        chk.Parameters.AddWithValue("@id", userId);
                        if ((int)chk.ExecuteScalar() > 0)
                        {
                            UploadMessage = "That email is already registered.";
                            return;
                        }
                    }

                    // Update
                    using (var cmd = new SqlCommand(
                        "UPDATE Users SET FullName=@fn, Username=@u, Email=@e WHERE UserId=@id", con))
                    {
                        cmd.Parameters.AddWithValue("@fn", newFullName);
                        cmd.Parameters.AddWithValue("@u",  newUsername);
                        cmd.Parameters.AddWithValue("@e",  newEmail);
                        cmd.Parameters.AddWithValue("@id", userId);
                        cmd.ExecuteNonQuery();
                    }
                }

                // Update session
                Session["FullName"] = newFullName;
                Session["Username"] = newUsername;
                Session["Email"]    = newEmail;

                FullName = newFullName;
                Username = newUsername;
                Email    = newEmail;

                UploadMessage = "Profile updated successfully!";
            }
            catch (Exception ex)
            {
                UploadMessage = "Could not save changes: " + ex.Message;
            }
        }

        // ── Load profile image from DB ────────────────────────────────────────
        private void LoadProfileImage()
        {
            if (Session["UserId"] == null) return;
            int userId = Convert.ToInt32(Session["UserId"]);

            try
            {
                string cs = @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;";
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
            catch
            {
                ProfileImage = Session["ProfileImage"] != null
                    ? Session["ProfileImage"].ToString() : string.Empty;
            }
        }

        // ── Upload profile photo ──────────────────────────────────────────────
        private void ProcessUpload(FileUpload upload)
        {
            var postedFile = upload.PostedFile;
            string ext = Path.GetExtension(postedFile.FileName ?? "").ToLowerInvariant();

            if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".gif" && ext != ".webp")
            { UploadMessage = "Only JPG, PNG, GIF, or WEBP images are allowed."; return; }

            if (postedFile.ContentLength <= 0)
            { UploadMessage = "The file appears to be empty."; return; }

            if (postedFile.ContentLength > 2 * 1024 * 1024)
            { UploadMessage = "Image must be smaller than 2MB."; return; }

            if (Session["UserId"] == null)
            { UploadMessage = "Session expired. Please log in again."; return; }

            int userId = Convert.ToInt32(Session["UserId"]);

            try
            {
                // Save file to disk — store only the path in the DB, not the image itself
                string folderPath = Server.MapPath("~/uploads/profiles/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                // Use userId as filename so each user has exactly one photo file
                string fileName     = userId + ext;
                string fullPath     = Path.Combine(folderPath, fileName);
                string relativePath = "uploads/profiles/" + fileName;

                postedFile.SaveAs(fullPath);

                // Save the relative path to the database
                string cs = @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;";
                using (var con = new SqlConnection(cs))
                {
                    con.Open();
                    using (var cmd = new SqlCommand(
                        "UPDATE Users SET ProfileImage = @img WHERE UserId = @uid", con))
                    {
                        cmd.Parameters.AddWithValue("@img", relativePath);
                        cmd.Parameters.AddWithValue("@uid", userId);
                        cmd.ExecuteNonQuery();
                    }
                }

                Session["ProfileImage"] = relativePath;
                ProfileImage = relativePath;
                UploadMessage = "Profile photo updated successfully!";
            }
            catch (Exception ex)
            {
                UploadMessage = "Upload failed: " + ex.Message;
            }
        }
    }
}
