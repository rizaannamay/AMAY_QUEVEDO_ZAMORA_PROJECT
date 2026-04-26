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
                return string.Equals(
                    Session["Role"] != null ? Session["Role"].ToString() : "",
                    "Admin", StringComparison.OrdinalIgnoreCase)
                    ? "Teacher.aspx" : "Student.aspx";
            }
        }

        protected string BackLabel
        {
            get
            {
                return string.Equals(
                    Session["Role"] != null ? Session["Role"].ToString() : "",
                    "Admin", StringComparison.OrdinalIgnoreCase)
                    ? "Back to Teacher Portal" : "Back to Student Portal";
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

            // TODO: LoadNotificationsData() — will be added when DB is connected
        }
    }
}
