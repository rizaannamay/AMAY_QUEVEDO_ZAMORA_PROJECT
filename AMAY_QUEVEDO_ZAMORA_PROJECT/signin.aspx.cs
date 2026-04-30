using System;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class signin : Page
    {
        readonly SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"])
            {
                string role = Session["Role"] != null ? Session["Role"].ToString() : "";
                Response.Redirect(role == "Admin" ? "Teacher.aspx" : "Student.aspx");
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

            // ── Input validation ─────────────────────────────────────────────
            if (string.IsNullOrWhiteSpace(fullName) || string.IsNullOrWhiteSpace(email) ||
                string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password) ||
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
            if (password != confirmPassword)
            {
                ShowMessage("Passwords do not match.", false); return;
            }

            try
            {
                con.Open();

                // ── Parameterized query — prevents SQL injection ──────────────
                // Check for duplicate username or email
                string checkSql = "SELECT COUNT(1) FROM Users WHERE Username = @username OR Email = @email";
                SqlCommand checkCmd = new SqlCommand(checkSql, con);
                checkCmd.Parameters.AddWithValue("@username", username);
                checkCmd.Parameters.AddWithValue("@email",    email);
                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    ShowMessage("That username or email is already registered.", false);
                    con.Close();
                    return;
                }

                // Insert new user — parameterized
                string insertSql = "INSERT INTO Users (FullName, Email, Username, Password, Role) " +
                                   "VALUES (@fullName, @email, @username, @password, @role)";
                SqlCommand insertCmd = new SqlCommand(insertSql, con);
                insertCmd.Parameters.AddWithValue("@fullName", fullName);
                insertCmd.Parameters.AddWithValue("@email",    email);
                insertCmd.Parameters.AddWithValue("@username", username);
                insertCmd.Parameters.AddWithValue("@password", password);
                insertCmd.Parameters.AddWithValue("@role",     role);
                insertCmd.ExecuteNonQuery();

                con.Close();
                ClearForm();
                ShowMessage("Account created! You can now log in.", true);
            }
            catch (Exception ex)
            {
                ShowMessage("Database error: " + ex.Message, false);
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
        }

        private void ShowMessage(string msg, bool success)
        {
            lblMessage.Text     = msg;
            lblMessage.Visible  = true;
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
