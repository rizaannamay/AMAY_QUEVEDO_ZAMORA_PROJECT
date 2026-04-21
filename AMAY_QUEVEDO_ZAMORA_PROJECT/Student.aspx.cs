using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace YourProjectName
{
    public partial class Student : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Initial load logic
        }

        // Toggle Category Menu
        protected void lnkCategory_Click(object sender, EventArgs e)
        {
            pnlCategoryDropdown.Visible = !pnlCategoryDropdown.Visible;
            lblArrow.Text = pnlCategoryDropdown.Visible ?
                "<i class='fas fa-chevron-up dropdown-arrow'></i>" :
                "<i class='fas fa-chevron-down dropdown-arrow'></i>";
        }

        // Toggle Settings Menu (Contains Dark Mode)
        protected void lnkSettings_Click(object sender, EventArgs e)
        {
            pnlSettingsDropdown.Visible = !pnlSettingsDropdown.Visible;
            lblSettingsArrow.Text = pnlSettingsDropdown.Visible ?
                "<i class='fas fa-chevron-up dropdown-arrow'></i>" :
                "<i class='fas fa-chevron-down dropdown-arrow'></i>";
        }

        // Handle Category Filtering
        protected void FilterCategory_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string category = btn.CommandArgument;

            lblMain.Text = "No " + category + " announcements yet";
            lblSub.Text = "We'll notify you when new " + category.ToLower() + " updates are posted.";

            // Auto-close menu after selection
            pnlCategoryDropdown.Visible = false;
            lblArrow.Text = "<i class='fas fa-chevron-down dropdown-arrow'></i>";
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
            // Save post logic here
        }
    }
}