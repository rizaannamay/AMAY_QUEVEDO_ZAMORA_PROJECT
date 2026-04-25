using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class login : Page
    {
        private const string UsersApplicationKey = "CampusConnectUsers";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = string.Empty;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string role = txtRole.SelectedValue;
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                ShowError("Please enter your username and password.");
                return;
            }

            string passwordHash = ComputeSha256(password);
            List<Dictionary<string, string>> users = GetUsers();

            Dictionary<string, string> matchedUser = users.FirstOrDefault(user =>
                string.Equals(user["Username"], username, StringComparison.OrdinalIgnoreCase) &&
                string.Equals(user["Role"], role, StringComparison.OrdinalIgnoreCase) &&
                string.Equals(user["PasswordHash"], passwordHash, StringComparison.Ordinal));

            if (matchedUser == null)
            {
                ShowError("Invalid role, username, or password.");
                return;
            }

            Session["Username"] = matchedUser["Username"];
            Session["FullName"] = matchedUser["FullName"];
            Session["Email"] = matchedUser["Email"];
            Session["Role"] = matchedUser["Role"];
            Session["IsLoggedIn"] = true;

            lblError.ForeColor = System.Drawing.ColorTranslator.FromHtml("#16a34a");
            lblError.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0fdf4");
            lblError.Text = "Login successful.";

            if (string.Equals(matchedUser["Role"], "Admin", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Teacher.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            Response.Redirect("Student.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        private void ShowError(string message)
        {
            lblError.ForeColor = System.Drawing.ColorTranslator.FromHtml("#dc2626");
            lblError.BackColor = System.Drawing.ColorTranslator.FromHtml("#fef2f2");
            lblError.Text = message;
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
