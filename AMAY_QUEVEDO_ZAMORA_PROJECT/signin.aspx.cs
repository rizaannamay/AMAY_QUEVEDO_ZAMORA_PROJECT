using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class signin : Page
    {
        // SAME connection string as login
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CampusAnnouncementDB;User ID=Campus_Announcement;Password=campus123");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Clear();
            }
        }

        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
            if (!ValidateInputs())
                return;

            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = rbStudent.Checked ? "Student" : "Admin";

            if (UserExists(username, email))
            {
                ShowMessage("Username or email already exists.", false);
                return;
            }

            if (CreateUser(fullName, email, username, password, role))
            {
                ShowMessage("Account created successfully! Redirecting to login...", true);
                ClearForm();
                ScriptManager.RegisterStartupScript(this, GetType(), "redirect",
                    "setTimeout(function(){ window.location.href='login.aspx'; }, 2000);", true);
            }
            else
            {
                ShowMessage("Error creating account. Please try again.", false);
            }
        }

        private bool UserExists(string username, string email)
        {
            try
            {
                con.Open();
                string query = "SELECT COUNT(*) FROM Users WHERE Username = @Username OR Email = @Email";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Email", email);
                int count = Convert.ToInt32(cmd.ExecuteScalar());
                con.Close();
                return count > 0;
            }
            catch
            {
                con.Close();
                return false;
            }
        }

        private bool CreateUser(string fullName, string email, string username, string password, string role)
        {
            try
            {
                con.Open();
                string query = @"INSERT INTO Users (FullName, Email, Username, Password, Role, IsActive, CreatedDate) 
                                VALUES (@FullName, @Email, @Username, @Password, @Role, 1, @CreatedDate)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@Role", role);
                cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
                cmd.ExecuteNonQuery();
                con.Close();
                return true;
            }
            catch (Exception ex)
            {
                con.Close();
                System.Diagnostics.Debug.WriteLine("CreateUser Error: " + ex.Message);
                return false;
            }
        }

        private bool ValidateInputs()
        {
            if (string.IsNullOrWhiteSpace(txtFullName.Text))
            {
                ShowMessage("Please enter your full name.", false);
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                ShowMessage("Please enter your email address.", false);
                return false;
            }

            if (!IsValidEmail(txtEmail.Text.Trim()))
            {
                ShowMessage("Please enter a valid email address.", false);
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtUsername.Text))
            {
                ShowMessage("Please choose a username.", false);
                return false;
            }

            if (txtUsername.Text.Trim().Length < 3)
            {
                ShowMessage("Username must be at least 3 characters.", false);
                return false;
            }

            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                ShowMessage("Please create a password.", false);
                return false;
            }

            if (txtPassword.Text.Length < 6)
            {
                ShowMessage("Password must be at least 6 characters.", false);
                return false;
            }

            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                ShowMessage("Passwords do not match.", false);
                return false;
            }

            return true;
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

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = isSuccess ? "success-message" : "error-message";
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