using System;
using System.Net.Mail;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    // Registered users are stored in Application state (in-memory, same process).
    // Key: "CampusConnectUsers" → List of string[5] { username, password, fullName, email, role }
    public partial class signin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Already logged in → go home
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

            // Store in Application state as string[5]
            var users = GetUsers();
            lock (users)
            {
                foreach (string[] u in users)
                {
                    if (string.Equals(u[0], username, StringComparison.OrdinalIgnoreCase))
                    { ShowMessage("That username is already taken.", false); return; }
                    if (string.Equals(u[3], email, StringComparison.OrdinalIgnoreCase))
                    { ShowMessage("That email is already registered.", false); return; }
                }
                users.Add(new string[] { username, password, fullName, email, role });
            }

            ClearForm();
            ShowMessage("Account created! You can now log in.", true);
        }

        private System.Collections.Generic.List<string[]> GetUsers()
        {
            const string key = "CampusConnectUsers";
            if (!(Application[key] is System.Collections.Generic.List<string[]> list))
            {
                list = new System.Collections.Generic.List<string[]>();
                Application[key] = list;
            }
            return list;
        }

        private void ShowMessage(string msg, bool success)
        {
            lblMessage.Text    = msg;
            lblMessage.Visible = true;
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
