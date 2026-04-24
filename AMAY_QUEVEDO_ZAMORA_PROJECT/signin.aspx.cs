using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class signin : Page
    {
        SqlConnection con = new SqlConnection(
        @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CampusAnnouncementDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True");

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

            try
            {
                // Open connection
                con.Open();

                // Create Users table if it doesn't exist
                string createTable = @"
                    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Users')
                    BEGIN
                        CREATE TABLE Users (
                            UserId INT PRIMARY KEY IDENTITY(1,1),
                            FullName NVARCHAR(100) NOT NULL,
                            Email NVARCHAR(100) NOT NULL UNIQUE,
                            Username NVARCHAR(50) NOT NULL UNIQUE,
                            Password NVARCHAR(255) NOT NULL,
                            Role NVARCHAR(20) NOT NULL,
                            IsActive BIT DEFAULT 1,
                            CreatedDate DATETIME DEFAULT GETDATE()
                        )
                    END";
                SqlCommand createCmd = new SqlCommand(createTable, con);
                createCmd.ExecuteNonQuery();

                // Check if user already exists
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username = @Username OR Email = @Email";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@Username", username);
                checkCmd.Parameters.AddWithValue("@Email", email);
                int existingCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                if (existingCount > 0)
                {
                    con.Close();
                    ShowMessage("Username or email already exists. Please try another.", false);
                    return;
                }

                // Insert new user
                string insertQuery = @"INSERT INTO Users (FullName, Email, Username, Password, Role, IsActive, CreatedDate)
                                       VALUES (@FullName, @Email, @Username, @Password, @Role, 1, @CreatedDate)";
                SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                insertCmd.Parameters.AddWithValue("@FullName", fullName);
                insertCmd.Parameters.AddWithValue("@Email", email);
                insertCmd.Parameters.AddWithValue("@Username", username);
                insertCmd.Parameters.AddWithValue("@Password", password);
                insertCmd.Parameters.AddWithValue("@Role", role);
                insertCmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
                insertCmd.ExecuteNonQuery();

                con.Close();

                // Success!
                ShowMessage("Account created successfully! Redirecting to login...", true);
                ClearForm();

                // Redirect to login page after 2 seconds
                ScriptManager.RegisterStartupScript(this, GetType(), "redirect",
                    "setTimeout(function(){ window.location.href='login.aspx'; }, 2000);", true);
            }
            catch (SqlException sqlEx)
            {
                if (con.State == ConnectionState.Open) con.Close();

                // Specific SQL error messages
                if (sqlEx.Message.Contains("Login failed"))
                {
                    ShowMessage("Database login failed. Please check your database connection.", false);
                }
                else if (sqlEx.Message.Contains("Cannot open database"))
                {
                    ShowMessage("Database not found. Please check your database name.", false);
                }
                else
                {
                    ShowMessage("Database error: " + sqlEx.Message, false);
                }
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open) con.Close();
                ShowMessage("Error: " + ex.Message, false);
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