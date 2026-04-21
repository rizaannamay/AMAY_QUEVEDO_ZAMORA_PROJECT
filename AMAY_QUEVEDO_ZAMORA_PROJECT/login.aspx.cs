using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string role = txtRole.SelectedValue;
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (role == "Student" && username == "student" && password == "1234")
            {
                Session["UserRole"] = "Student";
                Session["Username"] = username;

                Response.Redirect("Main.aspx");
            }
            else if (role == "Admin" && username == "teacher" && password == "admin")
            {
                Session["UserRole"] = "Admin";
                Session["Username"] = username;

                Response.Redirect("Main.aspx");
            }
            else
            {
                lblError.Text = "Invalid role, username, or password.";
            }
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}