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

            // homeLink NavigateUrl is set by client-side JS using the homeUrl variable
            // (role-aware: Admin→Admin.aspx, Teacher→Teacher.aspx, Student→Student.aspx)

            if (!IsPostBack)
            {
                string q = Request.QueryString["query"];
                if (!string.IsNullOrWhiteSpace(q))
                    lastSearchTerm.Value = q.Trim();
            }
        }
    }
}
