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
<<<<<<< HEAD
        // Hardcoded credentials — { username, password, fullName, email, role }
        private static readonly string[,] HardcodedUsers =
        {
            { "admin",   "admin123",   "John Dela Cruz",  "admin@ctu.edu.ph",   "Admin"   },
            { "student", "student123", "Maria Santos",    "student@ctu.edu.ph", "Student" }
        };
=======
        private const string UsersApplicationKey = "CampusConnectUsers";
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = string.Empty;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
<<<<<<< HEAD
            string role     = txtRole.SelectedValue;
=======
            string role = txtRole.SelectedValue;
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                ShowError("Please enter your username and password.");
                return;
            }

<<<<<<< HEAD
            // Check against hardcoded credentials
            string matchedFullName = null;
            string matchedEmail    = null;
            string matchedRole     = null;

            for (int i = 0; i < HardcodedUsers.GetLength(0); i++)
            {
                bool usernameMatch = string.Equals(HardcodedUsers[i, 0], username, StringComparison.OrdinalIgnoreCase);
                bool passwordMatch = string.Equals(HardcodedUsers[i, 1], password, StringComparison.Ordinal);
                bool roleMatch     = string.Equals(HardcodedUsers[i, 4], role,     StringComparison.OrdinalIgnoreCase);

                if (usernameMatch && passwordMatch && roleMatch)
                {
                    matchedFullName = HardcodedUsers[i, 2];
                    matchedEmail    = HardcodedUsers[i, 3];
                    matchedRole     = HardcodedUsers[i, 4];
                    break;
                }
            }

            if (matchedRole == null)
=======
            string passwordHash = ComputeSha256(password);
            List<Dictionary<string, string>> users = GetUsers();

            Dictionary<string, string> matchedUser = users.FirstOrDefault(user =>
                string.Equals(user["Username"], username, StringComparison.OrdinalIgnoreCase) &&
                string.Equals(user["Role"], role, StringComparison.OrdinalIgnoreCase) &&
                string.Equals(user["PasswordHash"], passwordHash, StringComparison.Ordinal));

            if (matchedUser == null)
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939
            {
                ShowError("Invalid role, username, or password.");
                return;
            }

<<<<<<< HEAD
            // Store session — same keys used across the app
            Session["UserId"]     = username;
            Session["Username"]   = username;
            Session["FullName"]   = matchedFullName;
            Session["Email"]      = matchedEmail;
            Session["Role"]       = matchedRole;
            Session["IsLoggedIn"] = true;

            // Role-based redirection
            if (string.Equals(matchedRole, "Admin", StringComparison.OrdinalIgnoreCase))
=======
            Session["Username"] = matchedUser["Username"];
            Session["FullName"] = matchedUser["FullName"];
            Session["Email"] = matchedUser["Email"];
            Session["Role"] = matchedUser["Role"];
            Session["IsLoggedIn"] = true;

            lblError.ForeColor = System.Drawing.ColorTranslator.FromHtml("#16a34a");
            lblError.BackColor = System.Drawing.ColorTranslator.FromHtml("#f0fdf4");
            lblError.Text = "Login successful.";

            if (string.Equals(matchedUser["Role"], "Admin", StringComparison.OrdinalIgnoreCase))
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939
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
<<<<<<< HEAD
            lblError.Text      = message;
=======
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
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939
        }
    }
}
