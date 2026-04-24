using System;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class signin : Page
    {
<<<<<<< HEAD
        private readonly SqlConnection con = new SqlConnection(
        @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CampusAnnouncementDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True");

=======
>>>>>>> fa6f73f1f4eefd367af5254f688c3ed50e2751ff
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

            // Gather inputs (simulating what would go to the DB)
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = rbStudent.Checked ? "Student" : "Admin";

            // --- SIMULATED SUCCESS ---
            // Since SQL is detached, we skip the Database Insert command.
            // We just show a success message and perhaps clear the form.

            ShowMessage($"Success! Account for {username} created (Simulated).", true);

            // Optional: Automatically redirect to login after a short delay or via a link
            // Response.Redirect("login.aspx"); 
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
            // Ensure these CSS classes exist in your stylesheet for the red/green colors
            lblMessage.CssClass = isSuccess ? "text-success" : "text-danger";
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