using System;
using System.Web;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Student : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"])
            {
                Response.Redirect("login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            if (!string.Equals(Session["Role"]?.ToString(), "Student", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Teacher.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
                LoadUserInfo();
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("SearchStudent.aspx");
        }

        private void LoadUserInfo()
        {
            string fullName = Session["FullName"]?.ToString() ?? "Student";
            string email    = Session["Email"]?.ToString()    ?? "";
            string role     = Session["Role"]?.ToString()     ?? "Student";
            string username = Session["Username"]?.ToString() ?? "";

            string fn = HttpUtility.JavaScriptStringEncode(fullName);
            string em = HttpUtility.JavaScriptStringEncode(email);
            string rl = HttpUtility.JavaScriptStringEncode(role);
            string un = HttpUtility.JavaScriptStringEncode(username);

            string script = "<script>"
                + "var el;"
                + "el=document.getElementById('userName');    if(el) el.innerText=\"" + fn + "\";"
                + "el=document.getElementById('userRole');    if(el) el.innerText=\"" + rl + "\";"
                + "el=document.getElementById('pm-fullname'); if(el) el.innerText=\"" + fn + "\";"
                + "el=document.getElementById('pm-username'); if(el) el.innerText=\"" + un + "\";"
                + "el=document.getElementById('pm-email');    if(el) el.innerText=\"" + em + "\";"
                + "el=document.getElementById('pm-role');     if(el) el.innerText=\"" + rl + "\";"
                + "el=document.getElementById('pm-role2');    if(el) el.innerText=\"" + rl + "\";"
                + "</script>";

            ClientScript.RegisterStartupScript(GetType(), "LoadUser", script);
        }
    }
}
