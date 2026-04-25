using System;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class login : Page
    {
        // Hardcoded credentials — { username, password, fullName, email, role }
        private static readonly string[,] HardcodedUsers =
        {
            { "admin",   "admin123",   "John Dela Cruz",  "admin@ctu.edu.ph",   "Admin"   },
            { "student", "student123", "Maria Santos",    "student@ctu.edu.ph", "Student" }
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = string.Empty;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string role     = txtRole.SelectedValue;
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                ShowError("Please enter your username and password.");
                return;
            }

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
            {
                ShowError("Invalid role, username, or password.");
                return;
            }

            // Store session — same keys used across the app
            Session["UserId"]     = username;
            Session["Username"]   = username;
            Session["FullName"]   = matchedFullName;
            Session["Email"]      = matchedEmail;
            Session["Role"]       = matchedRole;
            Session["IsLoggedIn"] = true;

            // Role-based redirection
            if (string.Equals(matchedRole, "Admin", StringComparison.OrdinalIgnoreCase))
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
            lblError.Text      = message;
        }
    }
}
