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
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-C0LQQT8\SQLEXPRESS;Initial Catalog=CAPdb;Integrated Security=True;TrustServerCertificate=True;");

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            string action = ctx.Request.QueryString["action"] ?? "";

            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"])
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Not logged in\"}");
                return;
            }

            // Auto-run migration to add reply/like columns if they don't exist yet
            EnsureSchema();

            try
            {
                switch (action)
                {
                    case "add":         AddComment(ctx);    break;
                    case "reply":       ReplyComment(ctx);  break;
                    case "get":         GetComments(ctx);   break;
                    case "likeComment": LikeComment(ctx);   break;
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

        // ── ADD TOP-LEVEL COMMENT ─────────────────────────────────────────────
        private void AddComment(HttpContext ctx)
        {
            var data = ReadJson(ctx);
            if (data == null) return;

            if (!data.ContainsKey("postId") || !data.ContainsKey("comment"))
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Missing fields\"}"); return;
            }

            int    announcementId = Convert.ToInt32(data["postId"]);
            string commentText    = data["comment"].ToString().Trim();
            int    userId         = Convert.ToInt32(ctx.Session["UserId"]);

            if (string.IsNullOrEmpty(commentText))
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Comment cannot be empty\"}"); return;
            }

            con.Open();

            var cmd1 = new SqlCommand(
                "INSERT INTO Comments (AnnouncementId, UserId, CommentText) VALUES (@aid, @uid, @txt)", con);
            cmd1.Parameters.AddWithValue("@aid", announcementId);
            cmd1.Parameters.AddWithValue("@uid", userId);
            cmd1.Parameters.AddWithValue("@txt", commentText);
            cmd1.ExecuteNonQuery();

            var cmd2 = new SqlCommand(
                "UPDATE Announcements SET CommentCount = (SELECT COUNT(*) FROM Comments WHERE AnnouncementId=@aid) WHERE AnnouncementId=@aid", con);
            cmd2.Parameters.AddWithValue("@aid", announcementId);
            cmd2.ExecuteNonQuery();

            // Notify announcement author
            var notifCmd = new SqlCommand(
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

        // ── REPLY TO A COMMENT ────────────────────────────────────────────────
        private void ReplyComment(HttpContext ctx)
        {
            var data = ReadJson(ctx);
            if (data == null) return;

            if (!data.ContainsKey("postId") || !data.ContainsKey("parentCommentId") || !data.ContainsKey("comment"))
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Missing fields\"}"); return;
            }

            int    announcementId   = Convert.ToInt32(data["postId"]);
            int    parentCommentId  = Convert.ToInt32(data["parentCommentId"]);
            string commentText      = data["comment"].ToString().Trim();
            int    userId           = Convert.ToInt32(ctx.Session["UserId"]);

            if (string.IsNullOrEmpty(commentText))
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Reply cannot be empty\"}"); return;
            }

            con.Open();

            var cmd = new SqlCommand(
                "INSERT INTO Comments (AnnouncementId, UserId, CommentText, ParentCommentId) VALUES (@aid, @uid, @txt, @pid)", con);
            cmd.Parameters.AddWithValue("@aid", announcementId);
            cmd.Parameters.AddWithValue("@uid", userId);
            cmd.Parameters.AddWithValue("@txt", commentText);
            cmd.Parameters.AddWithValue("@pid", parentCommentId);
            cmd.ExecuteNonQuery();

            con.Close();
            ctx.Response.Write("{\"success\":true}");
        }

        // ── LIKE / UNLIKE A COMMENT ───────────────────────────────────────────
        private void LikeComment(HttpContext ctx)
        {
            if (!int.TryParse(ctx.Request.QueryString["commentId"], out int commentId))
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Invalid commentId\"}"); return;
            }

            int userId = Convert.ToInt32(ctx.Session["UserId"]);
            con.Open();

            // Check if already liked
            var chk = new SqlCommand(
                "SELECT COUNT(1) FROM CommentLikes WHERE CommentId=@cid AND UserId=@uid", con);
            chk.Parameters.AddWithValue("@cid", commentId);
            chk.Parameters.AddWithValue("@uid", userId);
            bool alreadyLiked = (int)chk.ExecuteScalar() > 0;

            if (alreadyLiked)
            {
                var del = new SqlCommand(
                    "DELETE FROM CommentLikes WHERE CommentId=@cid AND UserId=@uid", con);
                del.Parameters.AddWithValue("@cid", commentId);
                del.Parameters.AddWithValue("@uid", userId);
                del.ExecuteNonQuery();
            }
            else
            {
                var ins = new SqlCommand(
                    "INSERT INTO CommentLikes (CommentId, UserId) VALUES (@cid, @uid)", con);
                ins.Parameters.AddWithValue("@cid", commentId);
                ins.Parameters.AddWithValue("@uid", userId);
                ins.ExecuteNonQuery();
            }

            // Update LikeCount on Comments table
            var upd = new SqlCommand(
                "UPDATE Comments SET LikeCount = (SELECT COUNT(*) FROM CommentLikes WHERE CommentId=@cid) WHERE CommentId=@cid", con);
            upd.Parameters.AddWithValue("@cid", commentId);
            upd.ExecuteNonQuery();

            // Get new count
            var cnt = new SqlCommand("SELECT LikeCount FROM Comments WHERE CommentId=@cid", con);
            cnt.Parameters.AddWithValue("@cid", commentId);
            int newCount = (int)cnt.ExecuteScalar();

            con.Close();
            ctx.Response.Write("{\"success\":true,\"liked\":" + (!alreadyLiked ? "true" : "false") + ",\"likeCount\":" + newCount + "}");
        }

        // ── GET COMMENTS (with replies + like info) ───────────────────────────
        private void GetComments(HttpContext ctx)
        {
            if (!int.TryParse(ctx.Request.QueryString["postId"], out int announcementId))
            {
                ctx.Response.Write("[]"); return;
            }

            int currentUserId = ctx.Session["UserId"] != null ? Convert.ToInt32(ctx.Session["UserId"]) : 0;

            var list = new List<object>();
            con.Open();

            var cmd = new SqlCommand(
                "SELECT c.CommentId, c.ParentCommentId, c.CommentText, c.CreatedDate, c.LikeCount, " +
                "u.Username, ISNULL(u.ProfileImage,'') AS ProfileImage, " +
                "ISNULL((SELECT COUNT(1) FROM CommentLikes cl WHERE cl.CommentId=c.CommentId AND cl.UserId=@uid),0) AS UserLiked " +
                "FROM Comments c JOIN Users u ON u.UserId = c.UserId " +
                "WHERE c.AnnouncementId = @aid ORDER BY c.CreatedDate ASC", con);
            cmd.Parameters.AddWithValue("@aid", announcementId);
            cmd.Parameters.AddWithValue("@uid", currentUserId);

            var dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                list.Add(new
                {
                    commentId       = Convert.ToInt32(dr["CommentId"]),
                    parentCommentId = dr["ParentCommentId"] == DBNull.Value ? (int?)null : Convert.ToInt32(dr["ParentCommentId"]),
                    author          = dr["Username"].ToString(),
                    text            = dr["CommentText"].ToString(),
                    date            = GetTimeAgo(Convert.ToDateTime(dr["CreatedDate"])),
                    likeCount       = Convert.ToInt32(dr["LikeCount"]),
                    userLiked       = Convert.ToInt32(dr["UserLiked"]) > 0,
                    profileImage    = dr["ProfileImage"].ToString()
                });
            }

            dr.Close();
            con.Close();

            var js = new JavaScriptSerializer();
            ctx.Response.Write(js.Serialize(list));
        }

        // ── Auto-migration: add reply/like columns if missing ────────────────
        private static bool _schemaChecked = false;
        private static readonly object _schemaLock = new object();

        private void EnsureSchema()
        {
            if (_schemaChecked) return;
            lock (_schemaLock)
            {
                if (_schemaChecked) return;
                try
                {
                    using (var c = new SqlConnection(con.ConnectionString))
                    {
                        c.Open();

                        // Add ParentCommentId
                        var chk1 = new SqlCommand(
                            "IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('Comments') AND name='ParentCommentId') " +
                            "ALTER TABLE Comments ADD ParentCommentId INT NULL REFERENCES Comments(CommentId)", c);
                        chk1.ExecuteNonQuery();

                        // Add LikeCount
                        var chk2 = new SqlCommand(
                            "IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('Comments') AND name='LikeCount') " +
                            "ALTER TABLE Comments ADD LikeCount INT NOT NULL DEFAULT 0", c);
                        chk2.ExecuteNonQuery();

                        // Create CommentLikes table
                        var chk3 = new SqlCommand(
                            "IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name='CommentLikes' AND type='U') " +
                            "CREATE TABLE CommentLikes (" +
                            "  CommentLikeId INT PRIMARY KEY IDENTITY(1,1)," +
                            "  CommentId INT NOT NULL REFERENCES Comments(CommentId) ON DELETE CASCADE," +
                            "  UserId INT NOT NULL REFERENCES Users(UserId)," +
                            "  CreatedDate DATETIME NOT NULL DEFAULT GETDATE()," +
                            "  UNIQUE (CommentId, UserId)" +
                            ")", c);
                        chk3.ExecuteNonQuery();
                    }
                    _schemaChecked = true;
                }
                catch
                {
                    // If migration fails, mark as checked anyway so we don't retry every request
                    _schemaChecked = true;
                }
            }
        }

        // ── Helpers ───────────────────────────────────────────────────────────
        private Dictionary<string, object> ReadJson(HttpContext ctx)
        {
            string json = "";
            using (var reader = new System.IO.StreamReader(ctx.Request.InputStream))
                json = reader.ReadToEnd();

            var js = new JavaScriptSerializer();
            try
            {
                return js.Deserialize<Dictionary<string, object>>(json);
            }
            catch
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Invalid JSON\"}");
                return null;
            }
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
