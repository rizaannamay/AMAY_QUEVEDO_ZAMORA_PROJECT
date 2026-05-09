using System;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            // Only Admin and Teacher can use the search dashboard
            string role = Session["Role"] != null ? Session["Role"].ToString() : "";
            bool isAdmin   = string.Equals(role, "Admin",   StringComparison.OrdinalIgnoreCase);
            bool isTeacher = string.Equals(role, "Teacher", StringComparison.OrdinalIgnoreCase);

            if (!isAdmin && !isTeacher)
            {
                Response.Redirect("SearchStudent.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Set home button URL based on role
            homeLink.NavigateUrl = isAdmin ? "Admin.aspx" : "Teacher.aspx";

            if (!IsPostBack)
            {
                string q = Request.QueryString["query"];
                if (!string.IsNullOrWhiteSpace(q))
                    lastSearchTerm.Value = q.Trim();
            }
        }
    }
}
