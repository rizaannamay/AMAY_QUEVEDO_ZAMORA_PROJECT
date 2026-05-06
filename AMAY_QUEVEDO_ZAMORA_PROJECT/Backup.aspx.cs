using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Backup : Page
    {
        // Controls declared here since there is no designer file
        protected Label   lblUsers;
        protected Label   lblAnnouncements;
        protected Label   lblComments;
        protected Label   lblLikes;
        protected Label   lblNotifications;
        protected Label   lblTimestamp;
        protected Label   lblMsg;
        protected Button  btnExportCSV;
        protected Button  btnExportSQL;
        protected GridView gvAnnouncements;

        private readonly string _conn =
            @"Data Source=LAPTOP-GPJQLLD4\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;";

        protected void Page_Load(object sender, EventArgs e)
        {
            // Admin-only guard
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"] ||
                !string.Equals(Session["Role"] != null ? Session["Role"].ToString() : "", "Admin", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
                LoadStats();
        }

        // ── Query #8 COUNT / AGGREGATE ───────────────────────────────────────
        private void LoadStats()
        {
            using (var con = new SqlConnection(_conn))
            {
                con.Open();

                lblUsers.Text         = GetCount(con, "SELECT COUNT(1) FROM Users");
                lblAnnouncements.Text = GetCount(con, "SELECT COUNT(1) FROM Announcements");
                lblComments.Text      = GetCount(con, "SELECT COUNT(1) FROM Comments");
                lblLikes.Text         = GetCount(con, "SELECT COUNT(1) FROM UserLikes");
                lblNotifications.Text = GetCount(con, "SELECT COUNT(1) FROM Notifications");
                lblTimestamp.Text     = DateTime.Now.ToString("MMMM dd, yyyy hh:mm tt");

                // ── Query #2 SELECT + #7 JOIN + #9 ORDER BY — preview grid ──
                string sql = "SELECT TOP 20 a.AnnouncementId, a.Title, a.Category, " +
                             "u.FullName AS Author, a.Date_Posted, a.LikeCount, a.CommentCount " +
                             "FROM Announcements a " +
                             "JOIN Users u ON u.UserId = a.UserId " +
                             "ORDER BY a.Date_Posted DESC";

                using (var cmd = new SqlCommand(sql, con))
                using (var da  = new SqlDataAdapter(cmd))
                {
                    var dt = new DataTable();
                    da.Fill(dt);
                    gvAnnouncements.DataSource = dt;
                    gvAnnouncements.DataBind();
                }
            }
        }

        private string GetCount(SqlConnection con, string sql)
        {
            using (var cmd = new SqlCommand(sql, con))
                return cmd.ExecuteScalar().ToString();
        }

        // ── BACKUP: Export CSV ───────────────────────────────────────────────
        protected void btnExportCSV_Click(object sender, EventArgs e)
        {
            var sb = new StringBuilder();
            sb.AppendLine("AnnouncementId,Title,Category,Author,DatePosted,LikeCount,CommentCount,Content");

            using (var con = new SqlConnection(_conn))
            {
                con.Open();
                string sql = "SELECT a.AnnouncementId, a.Title, a.Category, u.FullName, " +
                             "a.Date_Posted, a.LikeCount, a.CommentCount, a.Content " +
                             "FROM Announcements a JOIN Users u ON u.UserId = a.UserId " +
                             "ORDER BY a.Date_Posted DESC";

                using (var cmd = new SqlCommand(sql, con))
                using (var dr  = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        sb.AppendLine(string.Format("{0},{1},{2},{3},{4},{5},{6},{7}",
                            dr["AnnouncementId"],
                            CsvEscape(dr["Title"].ToString()),
                            CsvEscape(dr["Category"].ToString()),
                            CsvEscape(dr["FullName"].ToString()),
                            Convert.ToDateTime(dr["Date_Posted"]).ToString("yyyy-MM-dd HH:mm:ss"),
                            dr["LikeCount"],
                            dr["CommentCount"],
                            CsvEscape(dr["Content"].ToString())));
                    }
                }
            }

            string fileName = "CAPdb_Announcements_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".csv";
            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("Content-Disposition", "attachment; filename=" + fileName);
            Response.Write(sb.ToString());
            Response.End();
        }

        // ── BACKUP: Export SQL INSERT statements ─────────────────────────────
        protected void btnExportSQL_Click(object sender, EventArgs e)
        {
            var sb = new StringBuilder();
            sb.AppendLine("-- CampusConnect Database Backup");
            sb.AppendLine("-- Generated: " + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            sb.AppendLine("-- Table: Announcements");
            sb.AppendLine();
            sb.AppendLine("USE CAPdb;");
            sb.AppendLine("GO");
            sb.AppendLine();

            using (var con = new SqlConnection(_conn))
            {
                con.Open();

                // Export Users (without passwords for safety — just structure)
                sb.AppendLine("-- ── USERS ──────────────────────────────────────────────────────");
                string userSql = "SELECT UserId, FullName, Email, Username, Role, CreatedDate FROM Users ORDER BY UserId";
                using (var cmd = new SqlCommand(userSql, con))
                using (var dr  = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        sb.AppendLine(string.Format(
                            "-- User: {0} | {1} | {2} | Role: {3} | Joined: {4}",
                            dr["UserId"], dr["FullName"], dr["Email"],
                            dr["Role"], Convert.ToDateTime(dr["CreatedDate"]).ToString("yyyy-MM-dd")));
                    }
                }
                sb.AppendLine();

                // Export Announcements as INSERT statements
                sb.AppendLine("-- ── ANNOUNCEMENTS ──────────────────────────────────────────────");
                string annSql = "SELECT AnnouncementId, UserId, Title, Content, Category, " +
                                "ImageUrl, Date_Posted, LikeCount, CommentCount, IsPinned " +
                                "FROM Announcements ORDER BY AnnouncementId";
                using (var cmd = new SqlCommand(annSql, con))
                using (var dr  = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        string imgVal = dr["ImageUrl"] == DBNull.Value ? "NULL" :
                                        "N'" + dr["ImageUrl"].ToString().Replace("'", "''") + "'";
                        sb.AppendLine(string.Format(
                            "INSERT INTO Announcements (UserId,Title,Content,Category,ImageUrl,Date_Posted,LikeCount,CommentCount,IsPinned) " +
                            "VALUES ({0},N'{1}',N'{2}',N'{3}',{4},'{5}',{6},{7},{8});",
                            dr["UserId"],
                            dr["Title"].ToString().Replace("'", "''"),
                            dr["Content"].ToString().Replace("'", "''"),
                            dr["Category"].ToString().Replace("'", "''"),
                            imgVal,
                            Convert.ToDateTime(dr["Date_Posted"]).ToString("yyyy-MM-dd HH:mm:ss"),
                            dr["LikeCount"],
                            dr["CommentCount"],
                            Convert.ToBoolean(dr["IsPinned"]) ? 1 : 0));
                    }
                }
                sb.AppendLine();

                // Export Comments
                sb.AppendLine("-- ── COMMENTS ───────────────────────────────────────────────────");
                string comSql = "SELECT CommentId, AnnouncementId, UserId, CommentText, CreatedDate FROM Comments ORDER BY CommentId";
                using (var cmd = new SqlCommand(comSql, con))
                using (var dr  = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        sb.AppendLine(string.Format(
                            "INSERT INTO Comments (AnnouncementId,UserId,CommentText,CreatedDate) " +
                            "VALUES ({0},{1},N'{2}','{3}');",
                            dr["AnnouncementId"], dr["UserId"],
                            dr["CommentText"].ToString().Replace("'", "''"),
                            Convert.ToDateTime(dr["CreatedDate"]).ToString("yyyy-MM-dd HH:mm:ss")));
                    }
                }
            }

            string fileName = "CAPdb_Backup_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".sql";
            Response.Clear();
            Response.ContentType = "text/plain";
            Response.AddHeader("Content-Disposition", "attachment; filename=" + fileName);
            Response.Write(sb.ToString());
            Response.End();
        }

        private static string CsvEscape(string s)
        {
            if (s == null) return "";
            if (s.Contains(",") || s.Contains("\"") || s.Contains("\n"))
                return "\"" + s.Replace("\"", "\"\"") + "\"";
            return s;
        }
    }
}
