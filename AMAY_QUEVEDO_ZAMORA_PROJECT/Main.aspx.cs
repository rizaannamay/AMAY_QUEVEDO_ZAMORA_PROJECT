using System;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MainMultiView.ActiveViewIndex = 0;
            }
        }

        protected void Nav_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string section = btn.CommandArgument;

            // Reset Styles
            btnHome.CssClass = "sidebar-item";
            btnCat.CssClass = "sidebar-item";
            btnPin.CssClass = "sidebar-item";
            btnSet.CssClass = "sidebar-item";
            btnGroup.CssClass = "sidebar-item";

            // Set Active
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
    }
}