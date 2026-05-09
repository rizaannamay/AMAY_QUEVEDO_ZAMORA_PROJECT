using System;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Teacher : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"])
            {
                Response.Redirect("login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            string role = Session["Role"] != null ? Session["Role"].ToString() : "";
            bool isTeacher = string.Equals(role, "Teacher", StringComparison.OrdinalIgnoreCase);
            bool isAdmin   = string.Equals(role, "Admin",   StringComparison.OrdinalIgnoreCase);

            // Only Teacher and Admin can access this page
            if (!isTeacher && !isAdmin)
            {
                Response.Redirect("Student.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Admin should be on Admin.aspx, not Teacher.aspx
            if (isAdmin)
            {
                Response.Redirect("Admin.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                // Send 1-day-ahead reminders for any calendar events scheduled for tomorrow.
                int userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
                CalendarReminderHelper.SendReminders(userId);

                string fullName = Session["FullName"] != null ? Session["FullName"].ToString() : "Teacher";
                string email    = Session["Email"]    != null ? Session["Email"].ToString()    : "";
                string username = Session["Username"] != null ? Session["Username"].ToString() : "";

                string fn = System.Web.HttpUtility.JavaScriptStringEncode(fullName);
                string em = System.Web.HttpUtility.JavaScriptStringEncode(email);
                string rl = System.Web.HttpUtility.JavaScriptStringEncode(role);
                string un = System.Web.HttpUtility.JavaScriptStringEncode(username);

                string script = "<script>"
                    + "var el;"
                    + "el=document.getElementById('userName'); if(el) el.innerText=\"" + un + "\";"
                    + "el=document.getElementById('userRole'); if(el) el.innerText=\"" + rl + "\";"
                    + "el=document.getElementById('pm-fullname'); if(el) el.innerText=\"" + fn + "\";"
                    + "el=document.getElementById('pm-username'); if(el) el.innerText=\"" + un + "\";"
                    + "el=document.getElementById('pm-email'); if(el) el.innerText=\"" + em + "\";"
                    + "el=document.getElementById('pm-role'); if(el) el.innerText=\"" + rl + "\";"
                    + "</script>";

                ClientScript.RegisterStartupScript(GetType(), "LoadUser", script);
            }
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("SearchDashboard.aspx");
        }
    }
}
