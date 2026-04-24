using System;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string target = Request.QueryString["type"];

            if (target == "student")
            {
                Session["UserId"] = 102;
                Session["Username"] = "student_user";
                Session["FullName"] = "Sample Student";
                Session["UserRole"] = "Student";
                Response.Redirect("Student.aspx");
            }
            else
            {
                Session["UserId"] = 101;
                Session["Username"] = "admin";
                Session["FullName"] = "John Dela Cruz";
                Session["UserRole"] = "Admin";
                Response.Redirect("Teacher.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
        }
    }
}