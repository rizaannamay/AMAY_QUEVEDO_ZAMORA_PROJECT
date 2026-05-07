using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Admin : Page
    {
        protected Label lblTotal, lblPending, lblApproved, lblRejected;
        protected Repeater rptPosts;

        private const string Conn =
            @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Only SuperAdmin may access this page
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"] ||
                !string.Equals(Session["Role"]?.ToString(), "SuperAdmin", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
                LoadData();
        }

        private void LoadData()
        {
            using (var con = new SqlConnection(Conn))
            {
                con.Open();

                // Stats
                lblTotal.Text    = Scalar(con, "SELECT COUNT(1) FROM Announcements");
                lblPending.Text  = Scalar(con, "SELECT COUNT(1) FROM Announcements WHERE Status='Pending'");
                lblApproved.Text = Scalar(con, "SELECT COUNT(1) FROM Announcements WHERE Status='Approved'");
                lblRejected.Text = Scalar(con, "SELECT COUNT(1) FROM Announcements WHERE Status='Rejected'");

                // Posts with author info
                string sql = @"
                    SELECT a.AnnouncementId, a.Title, a.Content, a.Category,
                           a.ImageUrl, a.Date_Posted, a.LikeCount, a.CommentCount,
                           a.Status, a.RejectionReason,
                           u.FullName AS AuthorName, u.ProfileImage
                    FROM Announcements a
                    JOIN Users u ON u.UserId = a.UserId
                    ORDER BY
                        CASE a.Status WHEN 'Pending' THEN 0 WHEN 'Rejected' THEN 1 ELSE 2 END,
                        a.Date_Posted DESC";

                using (var cmd = new SqlCommand(sql, con))
                using (var da  = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);

                    // Ensure Status column exists (fallback if migration not run yet)
                    if (!dt.Columns.Contains("Status"))
                        dt.Columns.Add("Status", typeof(string)).DefaultValue = "Approved";
                    if (!dt.Columns.Contains("RejectionReason"))
                        dt.Columns.Add("RejectionReason", typeof(string));

                    rptPosts.DataSource = dt;
                    rptPosts.DataBind();
                }
            }
        }

        private static string Scalar(SqlConnection con, string sql)
        {
            using (var cmd = new SqlCommand(sql, con))
            {
                var r = cmd.ExecuteScalar();
                return r != null ? r.ToString() : "0";
            }
        }
    }
}
