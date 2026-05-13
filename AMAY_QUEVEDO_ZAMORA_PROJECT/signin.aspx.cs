using System;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class signin : Page
    {
        private const string ConnStr =
            @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CampusAnnouncementPortalDB;User ID=CampusAnnouncementPortall;Password=campus123;Connect Timeout=30;TrustServerCertificate=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"])
            {
                string role = Session["Role"] != null ? Session["Role"].ToString() : "";
                if (role == "Admin")
                    Response.Redirect("Admin.aspx");
                else if (role == "Teacher")
                    Response.Redirect("Teacher.aspx");
                else
                    Response.Redirect("Student.aspx");
            }
        }

        // SHA-256 hash — same algorithm used in login
        private static string HashPassword(string password)
        {
            using (var sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                var sb = new StringBuilder(64);
                foreach (byte b in bytes) sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }

        // Strong password: min 8 chars, uppercase, lowercase, digit, special char
        private static bool IsStrongPassword(string password)
        {
            if (password == null || password.Length < 8) return false;
            bool hasUpper   = Regex.IsMatch(password, @"[A-Z]");
            bool hasLower   = Regex.IsMatch(password, @"[a-z]");
            bool hasDigit   = Regex.IsMatch(password, @"[0-9]");
            bool hasSpecial = Regex.IsMatch(password, @"[^A-Za-z0-9]");
            return hasUpper && hasLower && hasDigit && hasSpecial;
        }

        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            string fullName        = txtFullName.Text.Trim();
            string email           = txtEmail.Text.Trim();
            string username        = txtUsername.Text.Trim();
            string password        = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            // Role: only Student or Teacher allowed from public registration
            // rbTeacher is the second radio button (Teacher option)
            string role = rbTeacher.Checked ? "Teacher" : "Student";

            // ── Input validation ──────────────────────────────────────────
            if (string.IsNullOrWhiteSpace(fullName) || string.IsNullOrWhiteSpace(email) ||
                string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password) ||
                string.IsNullOrWhiteSpace(confirmPassword))
            {
                ShowMessage("Please complete all required fields.", false); return;
            }

            if (!IsValidEmail(email))
            {
                ShowMessage("Please enter a valid email address.", false); return;
            }

            if (!IsStrongPassword(password))
            {
                ShowMessage(
                    "Password must be at least 8 characters and include an uppercase letter, " +
                    "a lowercase letter, a number, and a special character (e.g. Amay@2026).",
                    false);
                return;
            }

            if (password != confirmPassword)
            {
                ShowMessage("Passwords do not match.", false); return;
            }

            // Teacher accounts start as Pending; Students are Active immediately
            string accountStatus = role == "Teacher" ? "Pending" : "Active";

            try
            {
                using (var con = new SqlConnection(ConnStr))
                {
                    con.Open();

                    // Check for duplicate username or email
                    using (var checkCmd = new SqlCommand(
                        "SELECT COUNT(1) FROM Users WHERE Username = @username OR Email = @email", con))
                    {
                        checkCmd.Parameters.AddWithValue("@username", username);
                        checkCmd.Parameters.AddWithValue("@email",    email);
                        int count = (int)checkCmd.ExecuteScalar();
                        if (count > 0)
                        {
                            ShowMessage("That username or email is already registered.", false);
                            return;
                        }
                    }

                    string hashedPassword = HashPassword(password);

                    // Insert user — AccountStatus column added by AdminMigration.sql
                    using (var insertCmd = new SqlCommand(
                        "INSERT INTO Users (FullName, Email, Username, Password, Role, AccountStatus) " +
                        "VALUES (@fullName, @email, @username, @password, @role, @status)", con))
                    {
                        insertCmd.Parameters.AddWithValue("@fullName", fullName);
                        insertCmd.Parameters.AddWithValue("@email",    email);
                        insertCmd.Parameters.AddWithValue("@username", username);
                        insertCmd.Parameters.AddWithValue("@password", hashedPassword);
                        insertCmd.Parameters.AddWithValue("@role",     role);
                        insertCmd.Parameters.AddWithValue("@status",   accountStatus);
                        insertCmd.ExecuteNonQuery();
                    }
                }

                ClearForm();

                if (role == "Teacher")
                    ShowMessage(
                        "Teacher account created! Your account is pending admin approval. " +
                        "You will be notified once approved.",
                        true);
                else
                    ShowMessage("Account created! You can now log in.", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Database error: " + ex.Message, false);
            }
        }

        private void ShowMessage(string msg, bool success)
        {
            lblMessage.Text     = msg;
            lblMessage.Visible  = true;
            lblMessage.CssClass = success ? "msg-box success-message" : "msg-box error-message";
        }

        private void ClearForm()
        {
            txtFullName.Text = txtEmail.Text = txtUsername.Text =
            txtPassword.Text = txtConfirmPassword.Text = string.Empty;
            rbStudent.Checked = true;
            rbTeacher.Checked = false;
        }

        private static bool IsValidEmail(string email)
        {
            try { new MailAddress(email); return true; }
            catch { return false; }
        }
    }
}
