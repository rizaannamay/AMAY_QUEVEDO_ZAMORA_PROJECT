using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
            ctx.Response.ContentType = "application/json";
            string action = ctx.Request.QueryString["action"] ?? "";

            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"])
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Not logged in\"}");
                return;
            }

            try
            {
                switch (action)
                {
                    case "add": AddComment(ctx); break;
                    case "get": GetComments(ctx); break;
                    default:
                        ctx.Response.Write("{\"error\":\"Invalid action\"}");
                        break;
                }
            }
            catch (Exception ex)
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"" + ex.Message.Replace("\"", "") + "\"}");
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
        }

        private void AddComment(HttpContext ctx)
        {
            string json = "";
            using (var reader = new System.IO.StreamReader(ctx.Request.InputStream))
                json = reader.ReadToEnd();

            var js = new JavaScriptSerializer();
            Dictionary<string, object> data;
            try { data = js.Deserialize<Dictionary<string, object>>(json); }
            catch { ctx.Response.Write("{\"success\":false,\"error\":\"Invalid JSON\"}"); return; }

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

            con.Open();

            SqlCommand cmd1 = new SqlCommand(
                "INSERT INTO Comments (AnnouncementId, UserId, CommentText) VALUES (@aid, @uid, @txt)", con);
            cmd1.Parameters.AddWithValue("@aid", announcementId);
            cmd1.Parameters.AddWithValue("@uid", userId);
            cmd1.Parameters.AddWithValue("@txt", commentText);
            cmd1.ExecuteNonQuery();

            SqlCommand cmd2 = new SqlCommand(
                "UPDATE Announcements SET CommentCount = (SELECT COUNT(*) FROM Comments WHERE AnnouncementId=@aid) WHERE AnnouncementId=@aid", con);
            cmd2.Parameters.AddWithValue("@aid", announcementId);
            cmd2.ExecuteNonQuery();

            // Notify announcement author
            SqlCommand notifCmd = new SqlCommand(
                "INSERT INTO Notifications (UserId, Message) " +
                "SELECT a.UserId, u.Username + ' commented on your announcement: ' + a.Title " +
                "FROM Announcements a JOIN Users u ON u.UserId=@uid " +
                "WHERE a.AnnouncementId=@aid AND a.UserId <> @uid", con);
            notifCmd.Parameters.AddWithValue("@aid", announcementId);
            notifCmd.Parameters.AddWithValue("@uid", userId);
            notifCmd.ExecuteNonQuery();

            con.Close();
            ctx.Response.Write("{\"success\":true}");
        }

        private void GetComments(HttpContext ctx)
        {
            if (!int.TryParse(ctx.Request.QueryString["postId"], out int announcementId))
            {
                ctx.Response.Write("[]");
                return;
            }

            var list = new List<object>();
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT c.CommentText, c.CreatedDate, u.Username, ISNULL(u.ProfileImage, '') AS ProfileImage " +
                "FROM Comments c JOIN Users u ON u.UserId = c.UserId " +
                "WHERE c.AnnouncementId = @aid ORDER BY c.CreatedDate ASC", con);
            cmd.Parameters.AddWithValue("@aid", announcementId);
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                list.Add(new
                {
                    author       = dr["Username"].ToString(),
                    text         = dr["CommentText"].ToString(),
                    date         = GetTimeAgo(Convert.ToDateTime(dr["CreatedDate"])),
                    profileImage = dr["ProfileImage"].ToString()
                });
            }

            dr.Close();
            con.Close();

            var js = new JavaScriptSerializer();
            ctx.Response.Write(js.Serialize(list));
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
