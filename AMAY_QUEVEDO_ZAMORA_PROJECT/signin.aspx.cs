using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class signin : Page
    {
        private const string UsersApplicationKey = "CampusConnectUsers";
        private static readonly object UsersLock = new object();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;
            string role = rbAdmin.Checked ? "Admin" : "Student";

            if (string.IsNullOrWhiteSpace(fullName) ||
                string.IsNullOrWhiteSpace(email) ||
                string.IsNullOrWhiteSpace(username) ||
                string.IsNullOrWhiteSpace(password) ||
                string.IsNullOrWhiteSpace(confirmPassword))
            {
                ShowMessage("Please complete all required fields.", false);
                return;
            }

            if (!IsValidEmail(email))
            {
                ShowMessage("Please enter a valid email address.", false);
                return;
            }

            if (password.Length < 6)
            {
                ShowMessage("Password must be at least 6 characters long.", false);
                return;
            }

            if (!string.Equals(password, confirmPassword, StringComparison.Ordinal))
            {
                ShowMessage("Passwords do not match.", false);
                return;
            }

            lock (UsersLock)
            {
                List<Dictionary<string, string>> users = GetUsers();

                bool usernameExists = users.Any(user =>
                    string.Equals(user["Username"], username, StringComparison.OrdinalIgnoreCase));

                if (usernameExists)
                {
                    ShowMessage("That username is already taken. Please choose another one.", false);
                    return;
                }

                bool emailExists = users.Any(user =>
                    string.Equals(user["Email"], email, StringComparison.OrdinalIgnoreCase));

                if (emailExists)
                {
                    ShowMessage("That email address is already registered.", false);
                    return;
                }

                users.Add(new Dictionary<string, string>
                {
                    { "FullName", fullName },
                    { "Email", email },
                    { "Username", username },
                    { "PasswordHash", ComputeSha256(password) },
                    { "Role", role },
                    { "CreatedAt", DateTime.Now.ToString("o") }
                });
            }

            ClearForm();
            ShowMessage("Account created successfully. You can now log in.", true);
        }

        private List<Dictionary<string, string>> GetUsers()
        {
            if (!(Application[UsersApplicationKey] is List<Dictionary<string, string>> users))
            {
                users = new List<Dictionary<string, string>>();
                Application[UsersApplicationKey] = users;
            }

            return users;
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.Visible = true;
            lblMessage.CssClass = isSuccess ? "success-message" : "error-message";
        }

        private void ClearForm()
        {
            txtFullName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtUsername.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
            rbStudent.Checked = true;
            rbAdmin.Checked = false;
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                MailAddress address = new MailAddress(email);
                return string.Equals(address.Address, email, StringComparison.OrdinalIgnoreCase);
            }
            catch
            {
                return false;
            }
        }

        private string ComputeSha256(string input)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(input);
                byte[] hash = sha256.ComputeHash(bytes);
                StringBuilder builder = new StringBuilder();

                foreach (byte value in hash)
                {
                    builder.Append(value.ToString("x2"));
                }

                return builder.ToString();
            }
        }
    }
}
