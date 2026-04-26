using System;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class SearchStudent : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Session guard
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"])
            {
                Response.Redirect("login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Only Students may use the student search — redirect Admin to their dashboard
            if (string.Equals(
                    Session["Role"] != null ? Session["Role"].ToString() : "",
                    "Admin", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("SearchDashboard.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                // If a query string term was passed (e.g. from Student.aspx search),
                // put it in the hidden field so the client-side JS picks it up on load.
                string q = Request.QueryString["query"];
                if (!string.IsNullOrWhiteSpace(q))
                    lastSearchTerm.Value = q.Trim();
            }
        }
    }
}
