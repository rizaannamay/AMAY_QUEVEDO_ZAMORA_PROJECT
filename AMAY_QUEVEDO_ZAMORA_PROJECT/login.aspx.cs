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
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            // Demo accounts with roles
            if (username == "student" && password == "1234")
            {
                Session["UserRole"] = "Student"; // store role
                Response.Redirect("MainForm.aspx"); // goes to Announcement Board
            }
            else if (username == "teacher" && password == "admin")
            {
                Session["UserRole"] = "Teacher"; // store role
                Response.Redirect("MainForm.aspx"); // goes to Announcement Board
            }
            else
            {
                lblError.Text = "Invalid username or password.";
            }
        }

    }
}