using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class signin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["IsLoggedIn"] is bool b && b)
            {
                string role = Session["Role"]?.ToString() ?? "";
                Response.Redirect(role == "Admin" ? "Teacher.aspx" : "Student.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            string fullName        = txtFullName.Text.Trim();
            string email           = txtEmail.Text.Trim();
            string username        = txtUsername.Text.Trim();
            string password        = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;
            string role            = rbAdmin.Checked ? "Admin" : "Student";

            // Validation
            if (string.IsNullOrWhiteSpace(fullName)  || string.IsNullOrWhiteSpace(email) ||
                string.IsNullOrWhiteSpace(username)  || string.IsNullOrWhiteSpace(password) ||
                string.IsNullOrWhiteSpace(confirmPassword))
            {
                ShowMessage("Please complete all required fields.", false); return;
            }
            if (!IsValidEmail(email))
            {
                ShowMessage("Please enter a valid email address.", false); return;
            }
            if (password.Length < 6)
            {
                ShowMessage("Password must be at least 6 characters long.", false); return;
            }
            if (!string.Equals(password, confirmPassword, StringComparison.Ordinal))
            {
                ShowMessage("Passwords do not match.", false); return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["CampusConnectDB"].ConnectionString;

            try
            {
                using (var conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Check for duplicate username or email
                    const string checkSql = @"
                        SELECT COUNT(1) FROM Users
                        WHERE Username = @Username OR Email = @Email";

                    using (var check = new SqlCommand(checkSql, conn))
                    {
                        check.Parameters.AddWithValue("@Username", username);
                        check.Parameters.AddWithValue("@Email",    email);
                        int count = (int)check.ExecuteScalar();
                        if (count > 0)
                        {
                            ShowMessage("That username or email is already registered.", false);
                            return;
                        }
                    }

                    // Insert new user into database
                    const string insertSql = @"
                        INSERT INTO Users (FullName, Email, Username, Password, Role)
                        VALUES (@FullName, @Email, @Username, @Password, @Role)";

                    using (var insert = new SqlCommand(insertSql, conn))
                    {
                        insert.Parameters.AddWithValue("@FullName", fullName);
                        insert.Parameters.AddWithValue("@Email",    email);
                        insert.Parameters.AddWithValue("@Username", username);
                        insert.Parameters.AddWithValue("@Password", password);
                        insert.Parameters.AddWithValue("@Role",     role);
                        insert.ExecuteNonQuery();
                    }
                }

                ClearForm();
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
            lblMessage.CssClass = success ? "success-message" : "error-message";
        }

        private void ClearForm()
        {
            txtFullName.Text = txtEmail.Text = txtUsername.Text =
            txtPassword.Text = txtConfirmPassword.Text = string.Empty;
            rbStudent.Checked = true;
            rbAdmin.Checked   = false;
        }

        private bool IsValidEmail(string email)
        {
            try { new MailAddress(email); return true; }
            catch { return false; }
        }
    }
}
