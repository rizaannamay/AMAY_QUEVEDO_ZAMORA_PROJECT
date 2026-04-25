using System;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class SearchDashboard : Page
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
            // Only Admin can use the teacher search dashboard
            if (!string.Equals(
                    Session["Role"] != null ? Session["Role"].ToString() : "",
                    "Admin", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("SearchStudent.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                string q = Request.QueryString["query"];
                if (!string.IsNullOrWhiteSpace(q))
                    lastSearchTerm.Value = q.Trim();
            }
        }
    }
}
