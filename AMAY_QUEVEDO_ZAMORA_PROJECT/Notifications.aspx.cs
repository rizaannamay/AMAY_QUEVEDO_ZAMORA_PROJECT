using System;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Notifications : Page
    {
        protected string BackUrl
        {
            get
            {
                string role = Session["Role"] != null ? Session["Role"].ToString() : "";
                if (string.Equals(role, "Admin",   StringComparison.OrdinalIgnoreCase)) return "Admin.aspx";
                if (string.Equals(role, "Teacher", StringComparison.OrdinalIgnoreCase)) return "Teacher.aspx";
                return "Student.aspx";
            }
        }

        protected string BackLabel
        {
            get
            {
                string role = Session["Role"] != null ? Session["Role"].ToString() : "";
                if (string.Equals(role, "Admin",   StringComparison.OrdinalIgnoreCase)) return "Back to Admin";
                if (string.Equals(role, "Teacher", StringComparison.OrdinalIgnoreCase)) return "Back to Teacher Portal";
                return "Back to Student Portal";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"])
            {
                Response.Redirect("login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            // Notifications are loaded client-side via NotificationHandler.ashx (getAll action)
        }
    }
}
