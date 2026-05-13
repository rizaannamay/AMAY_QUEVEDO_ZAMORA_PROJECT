using System;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Admin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Only Admin role may access this page
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"] ||
                !string.Equals(Session["Role"]?.ToString(), "Admin", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                // Send 1-day-ahead reminders for any calendar events scheduled for tomorrow.
                int userId = Session["UserId"] != null ? Convert.ToInt32(Session["UserId"]) : 0;
                CalendarReminderHelper.SendReminders(userId);

                string fullName = Session["FullName"]?.ToString() ?? "Admin";
                string email    = Session["Email"]?.ToString()    ?? "";
                string role     = Session["Role"]?.ToString()     ?? "Admin";
                string username = Session["Username"]?.ToString() ?? "";

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
            Response.Redirect("SearchStudent.aspx");
        }
    }
}
