using System;
<<<<<<< HEAD
using System.Data;
using System.Data.SqlClient;
=======
using System.Collections.Generic;
using System.Linq;
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class signin : Page
    {
<<<<<<< HEAD
        private readonly SqlConnection con = new SqlConnection(
            @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CampusAnnouncementDB;User ID=Campus_Announcement;Password=campus123");
=======
        private const string UsersApplicationKey = "CampusConnectUsers";
        private static readonly object UsersLock = new object();
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnSignUp_Click(object sender, EventArgs e)
        {
<<<<<<< HEAD
            string fullName         = txtFullName.Text.Trim();
            string email            = txtEmail.Text.Trim();
            string username         = txtUsername.Text.Trim();
            string password         = txtPassword.Text;
            string confirmPassword  = txtConfirmPassword.Text;
            string role             = rbAdmin.Checked ? "Admin" : "Student";

            // Validation — unchanged
            if (string.IsNullOrWhiteSpace(fullName)  ||
                string.IsNullOrWhiteSpace(email)      ||
                string.IsNullOrWhiteSpace(username)   ||
                string.IsNullOrWhiteSpace(password)   ||
=======
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
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939
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

<<<<<<< HEAD
            string passwordHash = ComputeSha256(password);

            try
            {
                con.Open();

                // Check if username already exists
                SqlCommand checkUser = new SqlCommand(
                    "SELECT COUNT(*) FROM Users WHERE Username = @Username", con);
                checkUser.Parameters.AddWithValue("@Username", username);
                if ((int)checkUser.ExecuteScalar() > 0)
                {
                    con.Close();
=======
            lock (UsersLock)
            {
                List<Dictionary<string, string>> users = GetUsers();

                bool usernameExists = users.Any(user =>
                    string.Equals(user["Username"], username, StringComparison.OrdinalIgnoreCase));

                if (usernameExists)
                {
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939
                    ShowMessage("That username is already taken. Please choose another one.", false);
                    return;
                }

<<<<<<< HEAD
                // Check if email already exists
                SqlCommand checkEmail = new SqlCommand(
                    "SELECT COUNT(*) FROM Users WHERE Email = @Email", con);
                checkEmail.Parameters.AddWithValue("@Email", email);
                if ((int)checkEmail.ExecuteScalar() > 0)
                {
                    con.Close();
=======
                bool emailExists = users.Any(user =>
                    string.Equals(user["Email"], email, StringComparison.OrdinalIgnoreCase));

                if (emailExists)
                {
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939
                    ShowMessage("That email address is already registered.", false);
                    return;
                }

<<<<<<< HEAD
                // Insert new user with hashed password
                SqlCommand insert = new SqlCommand(
                    @"INSERT INTO Users (FullName, Email, Username, Password, Role)
                      VALUES (@FullName, @Email, @Username, @Password, @Role)", con);

                insert.Parameters.AddWithValue("@FullName", fullName);
                insert.Parameters.AddWithValue("@Email",    email);
                insert.Parameters.AddWithValue("@Username", username);
                insert.Parameters.AddWithValue("@Password", passwordHash);
                insert.Parameters.AddWithValue("@Role",     role);
                insert.ExecuteNonQuery();

                con.Close();
                ClearForm();
                ShowMessage("Account created successfully. You can now log in.", true);
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open) con.Close();
                ShowMessage("Registration failed. Please try again.", false);
                System.Diagnostics.Debug.WriteLine("SignUp Error: " + ex.Message);
            }
=======
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
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939
        }

        private void ShowMessage(string message, bool isSuccess)
        {
<<<<<<< HEAD
            lblMessage.Text    = message;
=======
            lblMessage.Text = message;
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939
            lblMessage.Visible = true;
            lblMessage.CssClass = isSuccess ? "success-message" : "error-message";
        }

        private void ClearForm()
        {
<<<<<<< HEAD
            txtFullName.Text        = string.Empty;
            txtEmail.Text           = string.Empty;
            txtUsername.Text        = string.Empty;
            txtPassword.Text        = string.Empty;
            txtConfirmPassword.Text = string.Empty;
            rbStudent.Checked       = true;
            rbAdmin.Checked         = false;
=======
            txtFullName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtUsername.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
            rbStudent.Checked = true;
            rbAdmin.Checked = false;
>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939
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
<<<<<<< HEAD
                byte[] hash  = sha256.ComputeHash(bytes);
                StringBuilder builder = new StringBuilder();
                foreach (byte value in hash)
                    builder.Append(value.ToString("x2"));
=======
                byte[] hash = sha256.ComputeHash(bytes);
                StringBuilder builder = new StringBuilder();

                foreach (byte value in hash)
                {
                    builder.Append(value.ToString("x2"));
                }

>>>>>>> 4144f728d4d05ddea409e6a8d332f33e47bb3939
                return builder.ToString();
            }
        }
    }
}
