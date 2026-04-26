using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class CommentHandler : IHttpHandler, IRequiresSessionState
    {
        private string ConnStr =>
            ConfigurationManager.ConnectionStrings["CampusConnectDB"].ConnectionString;

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

        // ── ADD COMMENT ──────────────────────────────────────
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
            Dictionary<string, object> data;
            try { data = js.Deserialize<Dictionary<string, object>>(json); }
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
                using (var conn = new SqlConnection(ConnStr))
                {
                    conn.Open();

                    const string insertSql = @"
                        INSERT INTO Comments (AnnouncementId, UserId, CommentText)
                        VALUES (@AnnId, @UserId, @Text)";
                    using (var cmd = new SqlCommand(insertSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@AnnId",  announcementId);
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@Text",   commentText);
                        cmd.ExecuteNonQuery();
                    }

                    const string updateSql = @"
                        UPDATE Announcements
                        SET    CommentCount = (SELECT COUNT(*) FROM Comments WHERE AnnouncementId = @AnnId)
                        WHERE  AnnouncementId = @AnnId";
                    using (var cmd = new SqlCommand(updateSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@AnnId", announcementId);
                        cmd.ExecuteNonQuery();
                    }
                }

                ctx.Response.Write("{\"success\":true}");
            }
            catch (Exception ex)
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"" + EscapeJson(ex.Message) + "\"}");
            }
        }

        // ── GET COMMENTS ─────────────────────────────────────
        private void GetComments(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";

            if (!int.TryParse(ctx.Request.QueryString["postId"], out int announcementId))
            {
                ctx.Response.Write("[]");
                return;
            }

            var sb = new StringBuilder();
            sb.Append("[");
            bool first = true;

            try
            {
                using (var conn = new SqlConnection(ConnStr))
                {
                    conn.Open();
                    const string sql = @"
                        SELECT c.CommentText, c.CreatedDate, u.FullName
                        FROM   Comments c
                        JOIN   Users u ON u.UserId = c.UserId
                        WHERE  c.AnnouncementId = @AnnId
                        ORDER  BY c.CreatedDate ASC";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@AnnId", announcementId);
                        using (var r = cmd.ExecuteReader())
                        {
                            while (r.Read())
                            {
                                if (!first) sb.Append(",");
                                first = false;
                                string text   = EscapeJson(r.GetString(0));
                                string date   = GetTimeAgo(r.GetDateTime(1));
                                string author = EscapeJson(r.GetString(2));
                                sb.Append($"{{\"author\":\"{author}\",\"text\":\"{text}\",\"date\":\"{date}\"}}");
                            }
                        }
                    }
                }
            }
            catch { /* return empty array on error */ }

            sb.Append("]");
            ctx.Response.Write(sb.ToString());
        }

        // ── HELPERS ──────────────────────────────────────────
        private string GetTimeAgo(DateTime date)
        {
            TimeSpan ts = DateTime.Now - date;
            if (ts.TotalMinutes < 1)  return "Just now";
            if (ts.TotalMinutes < 60) return $"{(int)ts.TotalMinutes}m ago";
            if (ts.TotalHours   < 24) return $"{(int)ts.TotalHours}h ago";
            if (ts.TotalDays    < 7)  return $"{(int)ts.TotalDays}d ago";
            return date.ToString("MMM dd");
        }

        private string EscapeJson(string text)
        {
            if (string.IsNullOrEmpty(text)) return "";
            return text.Replace("\\", "\\\\")
                       .Replace("\"", "\\\"")
                       .Replace("\n", "\\n")
                       .Replace("\r", "");
        }

        public bool IsReusable => false;
    }
}
