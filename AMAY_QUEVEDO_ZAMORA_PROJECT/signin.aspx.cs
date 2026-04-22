using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class signin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            // Get form values
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            string role = GetSelectedRole();

            // Validation - Full Name
            if (string.IsNullOrEmpty(fullName))
            {
                ShowMessage("Please enter your full name.", "error");
                return;
            }

            // Validation - Email
            if (string.IsNullOrEmpty(email))
            {
                ShowMessage("Email address is required.", "error");
                return;
            }

            if (!IsValidEmail(email))
            {
                ShowMessage("Please enter a valid email address.", "error");
                return;
            }

            // Validation - Username
            if (string.IsNullOrEmpty(username))
            {
                ShowMessage("Username is required.", "error");
                return;
            }

            if (username.Length < 3)
            {
                ShowMessage("Username must be at least 3 characters.", "error");
                return;
            }

            // Check if username already exists
            if (IsUsernameTaken(username))
            {
                ShowMessage("Username '" + username + "' is already taken. Please choose another.", "error");
                return;
            }

            // Validation - Password
            if (string.IsNullOrEmpty(password))
            {
                ShowMessage("Password is required.", "error");
                return;
            }

            if (password.Length < 6)
            {
                ShowMessage("Password must be at least 6 characters long.", "error");
                return;
            }

            if (password != confirmPassword)
            {
                ShowMessage("Passwords do not match.", "error");
                return;
            }

            // Create account
            if (CreateAccount(fullName, email, username, password, role))
            {
                ShowMessage("Account created successfully! Redirecting to login page...", "success");

                // Clear form
                ClearForm();

                // Redirect after 2 seconds
                string script = "setTimeout(function() { window.location.href = 'login.aspx'; }, 2000);";
                ClientScript.RegisterStartupScript(this.GetType(), "Redirect", script, true);
            }
            else
            {
                ShowMessage("Unable to create account. Please try again.", "error");
            }
        }

        private string GetSelectedRole()
        {
            if (rbStudent.Checked)
                return "Student";
            else if (rbAdmin.Checked)
                return "Admin";
            else
                return "Student";
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        private bool IsUsernameTaken(string username)
        {
            // Check Session for existing users
            if (Session["Users"] != null)
            {
                DataTable users = (DataTable)Session["Users"];
                foreach (DataRow row in users.Rows)
                {
                    if (row["Username"].ToString().Equals(username, StringComparison.OrdinalIgnoreCase))
                        return true;
                }
            }
            return false;
        }

        private bool CreateAccount(string fullName, string email, string username, string password, string role)
        {
            try
            {
                DataTable users;

                // Create or get existing users table from Session
                if (Session["Users"] == null)
                {
                    users = new DataTable();
                    users.Columns.Add("UserID", typeof(int));
                    users.Columns.Add("FullName", typeof(string));
                    users.Columns.Add("Email", typeof(string));
                    users.Columns.Add("Username", typeof(string));
                    users.Columns.Add("Password", typeof(string));
                    users.Columns.Add("Role", typeof(string));
                    users.Columns.Add("DateCreated", typeof(DateTime));
                    Session["Users"] = users;
                }
                else
                {
                    users = (DataTable)Session["Users"];
                }

                // Check if user already exists (by email)
                foreach (DataRow row in users.Rows)
                {
                    if (row["Email"].ToString().Equals(email, StringComparison.OrdinalIgnoreCase))
                    {
                        ShowMessage("An account with this email already exists.", "error");
                        return false;
                    }
                }

                // Add new user
                DataRow newUser = users.NewRow();
                newUser["UserID"] = users.Rows.Count + 1;
                newUser["FullName"] = fullName;
                newUser["Email"] = email;
                newUser["Username"] = username;
                newUser["Password"] = password;
                newUser["Role"] = role;
                newUser["DateCreated"] = DateTime.Now;
                users.Rows.Add(newUser);

                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
                return false;
            }
        }

        private void ShowMessage(string message, string type)
        {
            if (type == "error")
            {
                lblMessage.CssClass = "error-message";
                lblMessage.Text = "<i class='fas fa-exclamation-circle'></i> " + message;
            }
            else
            {
                lblMessage.CssClass = "success-message";
                lblMessage.Text = "<i class='fas fa-check-circle'></i> " + message;
            }
            lblMessage.Visible = true;
        }

        private void ClearForm()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtUsername.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            rbStudent.Checked = true;
        }
    }
}