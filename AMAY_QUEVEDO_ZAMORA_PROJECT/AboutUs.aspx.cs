using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class AboutUs : System.Web.UI.Page
    {
        protected string BackUrl
        {
            get
            {
                string role = (Session["Role"] ?? "").ToString().ToLowerInvariant();
                string source = (Request.QueryString["source"] ?? "").ToString().ToLowerInvariant();

                if (role == "admin")
                    return "Admin.aspx";

                if (role == "teacher" || source == "teacher")
                    return "Teacher.aspx";

                return "Student.aspx";
            }
        }

        protected string BackLabel
        {
            get
            {
                string role = (Session["Role"] ?? "").ToString().ToLowerInvariant();
                string source = (Request.QueryString["source"] ?? "").ToString().ToLowerInvariant();

                if (role == "admin")
                    return "Back to Admin";

                if (role == "teacher" || source == "teacher")
                    return "Back to Teacher";

                return "Back to Student";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}