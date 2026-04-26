using System;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class login : Page
    {
        // Built-in hardcoded accounts
        private static readonly string[,] BuiltIn =
        {
            { "admin",   "admin123",   "John Dela Cruz", "admin@ctu.edu.ph",   "Admin"   },
            { "student", "student123", "Maria Santos",   "student@ctu.edu.ph", "Student" }
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = string.Empty;
                // Already logged in → redirect
                if (Session["IsLoggedIn"] is bool b && b)
                {
                    string role = Session["Role"]?.ToString() ?? "";
                    Response.Redirect(role == "Admin" ? "Teacher.aspx" : "Student.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string role     = txtRole.SelectedValue.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                ShowError("Please enter your username and password."); return;
            }

            string fullName = null, email = null, matchedRole = null;

            // 1. Check built-in accounts
            for (int i = 0; i < BuiltIn.GetLength(0); i++)
            {
                if (string.Equals(BuiltIn[i, 0], username, StringComparison.OrdinalIgnoreCase) &&
                    string.Equals(BuiltIn[i, 1], password, StringComparison.Ordinal) &&
                    string.Equals(BuiltIn[i, 4], role,     StringComparison.OrdinalIgnoreCase))
                {
                    fullName    = BuiltIn[i, 2];
                    email       = BuiltIn[i, 3];
                    matchedRole = BuiltIn[i, 4];
                    break;
                }
            }

            // 2. Check Application-state registered users (from signin.aspx)
            if (matchedRole == null)
            {
                const string key = "CampusConnectUsers";
                if (Application[key] is System.Collections.Generic.List<string[]> users)
                {
                    lock (users)
                    {
                        foreach (string[] u in users)
                        {
                            // u = { username, password, fullName, email, role }
                            if (string.Equals(u[0], username, StringComparison.OrdinalIgnoreCase) &&
                                string.Equals(u[1], password, StringComparison.Ordinal) &&
                                string.Equals(u[4], role,     StringComparison.OrdinalIgnoreCase))
                            {
                                fullName    = u[2];
                                email       = u[3];
                                matchedRole = u[4];
                                break;
                            }
                        }
                    }
                }
            }

            if (matchedRole == null)
            {
                ShowError("Invalid role, username, or password."); return;
            }

            Session["Username"]   = username;
            Session["FullName"]   = fullName;
            Session["Email"]      = email;
            Session["Role"]       = matchedRole;
            Session["IsLoggedIn"] = true;

            if (string.Equals(matchedRole, "Admin", StringComparison.OrdinalIgnoreCase))
                Response.Redirect("Teacher.aspx", false);
            else
                Response.Redirect("Student.aspx", false);

            Context.ApplicationInstance.CompleteRequest();
        }

        private void ShowError(string msg)
        {
            lblError.ForeColor = System.Drawing.ColorTranslator.FromHtml("#dc2626");
            lblError.BackColor = System.Drawing.ColorTranslator.FromHtml("#fef2f2");
            lblError.Text      = msg;
        }
    }
}
