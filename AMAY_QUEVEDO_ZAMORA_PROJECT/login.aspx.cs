using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Text = "";
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string role = txtRole.SelectedValue;
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Validation
            if (string.IsNullOrEmpty(role))
            {
                lblError.Text = "Please select a role.";
                return;
            }

            if (string.IsNullOrEmpty(username))
            {
                lblError.Text = "Please enter username.";
                return;
            }

            if (string.IsNullOrEmpty(password))
            {
                lblError.Text = "Please enter password.";
                return;
            }

            bool isValidUser = false;
            string userRole = "";

            // Check if user exists in Session (from Sign Up page)
            if (Session["Users"] != null)
            {
                DataTable users = (DataTable)Session["Users"];
                foreach (DataRow row in users.Rows)
                {
                    if (row["Username"].ToString().Equals(username, StringComparison.OrdinalIgnoreCase) &&
                        row["Password"].ToString() == password &&
                        row["Role"].ToString() == role)
                    {
                        isValidUser = true;
                        userRole = row["Role"].ToString();
                        break;
                    }
                }
            }

            // Default demo accounts for testing
            if (!isValidUser)
            {
                // Demo Student Account
                if (role == "Student" && username == "student" && password == "1234")
                {
                    isValidUser = true;
                    userRole = "Student";
                }
                // Demo Admin Account
                else if (role == "Admin" && username == "admin" && password == "admin123")
                {
                    isValidUser = true;
                    userRole = "Admin";
                }
            }

            if (isValidUser)
            {
                Session["UserRole"] = userRole;
                Session["Username"] = username;

                if (userRole == "Student")
                {
                    Response.Redirect("Student.aspx");
                }
                else if (userRole == "Admin")
                {
                    Response.Redirect("Teacher.aspx");
                }
            }
            else
            {
                lblError.Text = "Invalid role, username, or password. Please try again or <a href='signin.aspx'>Sign Up</a>.";
            }
        }
    }
}