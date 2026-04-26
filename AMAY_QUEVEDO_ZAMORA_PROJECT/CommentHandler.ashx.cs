using System;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class CommentHandler : IHttpHandler, IRequiresSessionState
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;");

        public void ProcessRequest(HttpContext ctx)
        {
            string action = ctx.Request.QueryString["action"] ?? "";

            switch (action)
            {
                case "add": AddComment(ctx); break;
                case "get": GetComments(ctx); break;
                default:
                    ctx.Response.ContentType = "application/json";
                    ctx.Response.Write("{\"error\":\"Invalid action\"}");
                    break;
            }
        }

        private void AddComment(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";

            if (ctx.Session["UserId"] == null)
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Not logged in\"}");
                return;
            }

            string json = "";
            using (var reader = new System.IO.StreamReader(ctx.Request.InputStream))
                json = reader.ReadToEnd();

            var js = new JavaScriptSerializer();
            System.Collections.Generic.Dictionary<string, object> data;
            try { data = js.Deserialize<System.Collections.Generic.Dictionary<string, object>>(json); }
            catch
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Invalid JSON\"}");
                return;
            }

            if (!data.ContainsKey("postId") || !data.ContainsKey("comment"))
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Missing fields\"}");
                return;
            }

            int    announcementId = Convert.ToInt32(data["postId"]);
            string commentText    = data["comment"].ToString().Trim();
            int    userId         = Convert.ToInt32(ctx.Session["UserId"]);

            if (string.IsNullOrEmpty(commentText))
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Comment cannot be empty\"}");
                return;
            }

            try
            {
                con.Open();

                SqlCommand cmd1 = new SqlCommand("INSERT INTO Comments (AnnouncementId, UserId, CommentText) VALUES (" + announcementId + "," + userId + ",'" + commentText + "')", con);
                cmd1.ExecuteNonQuery();

                SqlCommand cmd2 = new SqlCommand("UPDATE Announcements SET CommentCount = (SELECT COUNT(*) FROM Comments WHERE AnnouncementId=" + announcementId + ") WHERE AnnouncementId=" + announcementId, con);
                cmd2.ExecuteNonQuery();

                // Notify announcement author
                string notifSql = "SELECT a.UserId, a.Title, u.FullName FROM Announcements a JOIN Users u ON u.UserId=" + userId + " WHERE a.AnnouncementId=" + announcementId;
                SqlCommand notifCmd = new SqlCommand(notifSql, con);
                SqlDataReader dr = notifCmd.ExecuteReader();
                if (dr.Read())
                {
                    int    authorId      = Convert.ToInt32(dr["UserId"]);
                    string annTitle      = dr["Title"].ToString();
                    string commenterName = dr["FullName"].ToString();
                    dr.Close();

                    if (authorId != userId)
                    {
                        SqlCommand insertNotif = new SqlCommand("INSERT INTO Notifications (UserId, Message) VALUES (" + authorId + ",'" + commenterName + " commented on " + annTitle + "')", con);
                        insertNotif.ExecuteNonQuery();
                    }
                }
                else
                {
                    dr.Close();
                }

                con.Close();
                ctx.Response.Write("{\"success\":true}");
            }
            catch (Exception ex)
            {
                if (con.State == System.Data.ConnectionState.Open) con.Close();
                ctx.Response.Write("{\"success\":false,\"error\":\"" + ex.Message.Replace("\"", "") + "\"}");
            }
        }

        private void GetComments(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";

            if (!int.TryParse(ctx.Request.QueryString["postId"], out int announcementId))
            {
                ctx.Response.Write("[]");
                return;
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("[");
            bool first = true;

            try
            {
                con.Open();

                string sql = "SELECT c.CommentText, c.CreatedDate, u.FullName FROM Comments c " +
                             "JOIN Users u ON u.UserId = c.UserId " +
                             "WHERE c.AnnouncementId = " + announcementId + " ORDER BY c.CreatedDate ASC";

                SqlCommand cmd = new SqlCommand(sql, con);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    if (!first) sb.Append(",");
                    first = false;
                    string text   = dr["CommentText"].ToString().Replace("\"", "").Replace("\\", "");
                    string date   = GetTimeAgo(Convert.ToDateTime(dr["CreatedDate"]));
                    string author = dr["FullName"].ToString().Replace("\"", "");
                    sb.Append("{\"author\":\"" + author + "\",\"text\":\"" + text + "\",\"date\":\"" + date + "\"}");
                }

                dr.Close();
                con.Close();
            }
            catch
            {
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }

            sb.Append("]");
            ctx.Response.Write(sb.ToString());
        }

        private string GetTimeAgo(DateTime date)
        {
            TimeSpan ts = DateTime.Now - date;
            if (ts.TotalMinutes < 1)  return "Just now";
            if (ts.TotalMinutes < 60) return (int)ts.TotalMinutes + "m ago";
            if (ts.TotalHours   < 24) return (int)ts.TotalHours   + "h ago";
            if (ts.TotalDays    < 7)  return (int)ts.TotalDays    + "d ago";
            return date.ToString("MMM dd");
        }

        public bool IsReusable { get { return false; } }
    }
}
