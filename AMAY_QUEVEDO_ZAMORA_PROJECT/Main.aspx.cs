using System;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 🚫 Prevent access if not logged in
            if (Session["UserRole"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (!IsPostBack)
            {
                MainMultiView.ActiveViewIndex = 0;

                string role = Session["UserRole"].ToString();
                string username = Session["Username"].ToString();

                // 🎯 Role-based UI
                if (role == "Student")
                {
                    btnSet.Visible = false;
                    btnGroup.Visible = false;
                }
                else if (role == "Teacher")
                {
                    btnSet.Visible = true;
                    btnGroup.Visible = true;
                }
            }
        }

        protected void Nav_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string section = btn.CommandArgument;

            // Reset styles
            btnHome.CssClass = "sidebar-item";
            btnCat.CssClass = "sidebar-item";
            btnPin.CssClass = "sidebar-item";
            btnSet.CssClass = "sidebar-item";
            btnGroup.CssClass = "sidebar-item";

            // Set active
            btn.CssClass = "sidebar-item active";

            switch (section)
            {
                case "Home":
                    MainMultiView.ActiveViewIndex = 0;
                    break;
                case "Cats":
                    MainMultiView.ActiveViewIndex = 1;
                    break;
                case "Settings":
                    MainMultiView.ActiveViewIndex = 2;
                    break;
                default:
                    MainMultiView.ActiveViewIndex = 0;
                    break;
            }
        }

        // 🔓 Logout
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("login.aspx");
        }
    }
}
