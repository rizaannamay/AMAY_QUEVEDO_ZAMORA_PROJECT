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
        SqlConnection con = new SqlConnection(@"Data Source=LAPTOP-GPJQLLD4\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;");

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            string action = ctx.Request.QueryString["action"] ?? "";

            // GetComments is public — no login required
            if (action == "get")
            {
                EnsureSchema();
                try { GetComments(ctx); }
                catch (Exception ex)
                {
                    ctx.Response.Write("{\"success\":false,\"error\":\"" + EscapeJson(ex.Message) + "\"}");
                }
                return;
            }

            // All other actions require login
            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"] || ctx.Session["UserId"] == null)
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Not logged in\"}");
                return;
            }

            EnsureSchema();

            try
            {
                switch (action)
                {
                    case "add":
                        AddComment(ctx);
                        break;

                    case "reply":
                        ReplyComment(ctx);
                        break;

                    case "likeComment":
                        LikeComment(ctx);
                        break;

                    default:
                        ctx.Response.Write("{\"success\":false,\"error\":\"Invalid action\"}");
                        break;
                }
            }
            catch (Exception ex)
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"" + EscapeJson(ex.Message) + "\"}");
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
        }

        // Helper: check if current user is a Teacher (Admin role)
        private bool IsTeacher(HttpContext ctx)
        {
            string role = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString() : "";
            return string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase);
        }

        private void AddComment(HttpContext ctx)
        {
            Dictionary<string, object> data = ReadJson(ctx);
            if (data == null) return;

            if (!data.ContainsKey("postId") || !data.ContainsKey("comment"))
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Missing fields\"}");
                return;
            }

            int announcementId = Convert.ToInt32(data["postId"]);
            string commentText = data["comment"].ToString().Trim();
            int userId = Convert.ToInt32(ctx.Session["UserId"]);

            if (string.IsNullOrEmpty(commentText))
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Comment cannot be empty\"}");
                return;
            }

            con.Open();

            // Insert the comment
            SqlCommand cmd1 = new SqlCommand(
                "INSERT INTO Comments (AnnouncementId, UserId, CommentText, CreatedDate) VALUES (@aid, @uid, @txt, GETDATE())", con);
            cmd1.Parameters.AddWithValue("@aid", announcementId);
            cmd1.Parameters.AddWithValue("@uid", userId);
            cmd1.Parameters.AddWithValue("@txt", commentText);
            cmd1.ExecuteNonQuery();

            // Update comment count
            SqlCommand cmd2 = new SqlCommand(
                "UPDATE Announcements SET CommentCount = (SELECT COUNT(*) FROM Comments WHERE AnnouncementId=@aid) WHERE AnnouncementId=@aid", con);
            cmd2.Parameters.AddWithValue("@aid", announcementId);
            cmd2.ExecuteNonQuery();

            if (IsTeacher(ctx))
            {
                // ✅ TEACHER commented → notify ALL students
                SqlCommand notifCmd = new SqlCommand(
                    "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                    "SELECT u2.UserId, @aid, " +
                    "   (SELECT u.Username FROM Users u WHERE u.UserId = @uid) + ' (Teacher) commented on: ' + " +
                    "   LEFT((SELECT a.Title FROM Announcements a WHERE a.AnnouncementId = @aid), 60), " +
                    "   0, GETDATE() " +
                    "FROM Users u2 " +
                    "WHERE u2.Role = 'Student' AND u2.UserId <> @uid", con);
                notifCmd.Parameters.AddWithValue("@aid", announcementId);
                notifCmd.Parameters.AddWithValue("@uid", userId);
                notifCmd.ExecuteNonQuery();
            }
            else
            {
                // Student commented → notify the teacher (announcement owner)
                SqlCommand notifCmd = new SqlCommand(
                    "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                    "SELECT a.UserId, a.AnnouncementId, u.Username + ' commented on your announcement: ' + a.Title, 0, GETDATE() " +
                    "FROM Announcements a " +
                    "JOIN Users u ON u.UserId = @uid " +
                    "WHERE a.AnnouncementId = @aid AND a.UserId <> @uid", con);
                notifCmd.Parameters.AddWithValue("@aid", announcementId);
                notifCmd.Parameters.AddWithValue("@uid", userId);
                notifCmd.ExecuteNonQuery();
            }

            con.Close();
            ctx.Response.Write("{\"success\":true}");
        }

        private void ReplyComment(HttpContext ctx)
        {
            Dictionary<string, object> data = ReadJson(ctx);
            if (data == null) return;

            if (!data.ContainsKey("postId") || !data.ContainsKey("parentCommentId") || !data.ContainsKey("comment"))
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Missing fields\"}");
                return;
            }

            int announcementId = Convert.ToInt32(data["postId"]);
            int parentCommentId = Convert.ToInt32(data["parentCommentId"]);
            string commentText = data["comment"].ToString().Trim();
            int userId = Convert.ToInt32(ctx.Session["UserId"]);

            if (string.IsNullOrEmpty(commentText))
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Reply cannot be empty\"}");
                return;
            }

            con.Open();

            // Insert the reply
            SqlCommand cmd = new SqlCommand(
                "INSERT INTO Comments (AnnouncementId, UserId, CommentText, ParentCommentId, CreatedDate) VALUES (@aid, @uid, @txt, @pid, GETDATE())", con);
            cmd.Parameters.AddWithValue("@aid", announcementId);
            cmd.Parameters.AddWithValue("@uid", userId);
            cmd.Parameters.AddWithValue("@txt", commentText);
            cmd.Parameters.AddWithValue("@pid", parentCommentId);
            cmd.ExecuteNonQuery();

            // Update comment count
            SqlCommand countCmd = new SqlCommand(
                "UPDATE Announcements SET CommentCount = (SELECT COUNT(*) FROM Comments WHERE AnnouncementId=@aid) WHERE AnnouncementId=@aid", con);
            countCmd.Parameters.AddWithValue("@aid", announcementId);
            countCmd.ExecuteNonQuery();

            if (IsTeacher(ctx))
            {
                // ✅ TEACHER replied → notify ONLY the student who owns the parent comment
                SqlCommand notifCmd = new SqlCommand(
                    "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                    "SELECT c.UserId, c.AnnouncementId, " +
                    "   (SELECT u.Username FROM Users u WHERE u.UserId = @uid) + ' (Teacher) replied to your comment: ' + LEFT(c.CommentText, 50), " +
                    "   0, GETDATE() " +
                    "FROM Comments c " +
                    "WHERE c.CommentId = @parentCommentId AND c.UserId <> @uid", con);
                notifCmd.Parameters.AddWithValue("@uid", userId);
                notifCmd.Parameters.AddWithValue("@parentCommentId", parentCommentId);
                notifCmd.ExecuteNonQuery();
            }
            else
            {
                // Student replied → notify the teacher (announcement owner)
                SqlCommand notifCmd = new SqlCommand(
                    "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                    "SELECT a.UserId, a.AnnouncementId, u.Username + ' replied on your announcement: ' + a.Title, 0, GETDATE() " +
                    "FROM Announcements a " +
                    "JOIN Users u ON u.UserId = @uid " +
                    "WHERE a.AnnouncementId = @aid AND a.UserId <> @uid", con);
                notifCmd.Parameters.AddWithValue("@aid", announcementId);
                notifCmd.Parameters.AddWithValue("@uid", userId);
                notifCmd.ExecuteNonQuery();
            }

            con.Close();
            ctx.Response.Write("{\"success\":true}");
        }

        private void LikeComment(HttpContext ctx)
        {
            int commentId;
            if (!int.TryParse(ctx.Request.QueryString["commentId"], out commentId))
            {
                ctx.Response.Write("{\"success\":false,\"error\":\"Invalid commentId\"}");
                return;
            }

            int userId = Convert.ToInt32(ctx.Session["UserId"]);
            con.Open();

            SqlCommand chk = new SqlCommand(
                "SELECT COUNT(1) FROM CommentLikes WHERE CommentId=@cid AND UserId=@uid", con);
            chk.Parameters.AddWithValue("@cid", commentId);
            chk.Parameters.AddWithValue("@uid", userId);
            bool alreadyLiked = Convert.ToInt32(chk.ExecuteScalar()) > 0;

            if (alreadyLiked)
            {
                SqlCommand del = new SqlCommand(
                    "DELETE FROM CommentLikes WHERE CommentId=@cid AND UserId=@uid", con);
                del.Parameters.AddWithValue("@cid", commentId);
                del.Parameters.AddWithValue("@uid", userId);
                del.ExecuteNonQuery();
            }
            else
            {
                SqlCommand ins = new SqlCommand(
                    "INSERT INTO CommentLikes (CommentId, UserId, CreatedDate) VALUES (@cid, @uid, GETDATE())", con);
                ins.Parameters.AddWithValue("@cid", commentId);
                ins.Parameters.AddWithValue("@uid", userId);
                ins.ExecuteNonQuery();
            }

            // Update like count
            SqlCommand upd = new SqlCommand(
                "UPDATE Comments SET LikeCount = (SELECT COUNT(*) FROM CommentLikes WHERE CommentId=@cid) WHERE CommentId=@cid", con);
            upd.Parameters.AddWithValue("@cid", commentId);
            upd.ExecuteNonQuery();

            SqlCommand cnt = new SqlCommand(
                "SELECT ISNULL(LikeCount, 0) FROM Comments WHERE CommentId=@cid", con);
            cnt.Parameters.AddWithValue("@cid", commentId);
            int newCount = Convert.ToInt32(cnt.ExecuteScalar());

            con.Close();
            ctx.Response.Write("{\"success\":true,\"liked\":" + (!alreadyLiked ? "true" : "false") + ",\"likeCount\":" + newCount + "}");
        }

        private void GetComments(HttpContext ctx)
        {
            int announcementId;
            if (!int.TryParse(ctx.Request.QueryString["postId"], out announcementId))
            {
                ctx.Response.Write("[]");
                return;
            }

            int currentUserId = 0;
            if (ctx.Session["UserId"] != null)
                currentUserId = Convert.ToInt32(ctx.Session["UserId"]);

            List<object> list = new List<object>();

            con.Open();

                using (var cmd = new SqlCommand(
                    "SELECT c.CommentId, c.ParentCommentId, c.CommentText, c.CreatedDate, ISNULL(c.LikeCount, 0) AS LikeCount, " +
                    "u.Username, ISNULL(u.ProfileImage,'') AS ProfileImage, " +
                    "ISNULL((SELECT COUNT(1) FROM CommentLikes cl WHERE cl.CommentId=c.CommentId AND cl.UserId=@uid),0) AS UserLiked " +
                    "FROM Comments c " +
                    "JOIN Users u ON u.UserId = c.UserId " +
                    "WHERE c.AnnouncementId = @aid " +
                    "ORDER BY c.CreatedDate ASC", con))
                {
                    cmd.Parameters.AddWithValue("@aid", announcementId);
                    cmd.Parameters.AddWithValue("@uid", currentUserId);

                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            list.Add(new
                            {
                                commentId = Convert.ToInt32(dr["CommentId"]),
                                parentCommentId = dr["ParentCommentId"] == DBNull.Value ? (int?)null : Convert.ToInt32(dr["ParentCommentId"]),
                                author = dr["Username"].ToString(),
                                text = dr["CommentText"].ToString(),
                                date = GetTimeAgo(Convert.ToDateTime(dr["CreatedDate"])),
                                likeCount = Convert.ToInt32(dr["LikeCount"]),
                                userLiked = Convert.ToInt32(dr["UserLiked"]) > 0,
                                profileImage = dr["ProfileImage"].ToString()
                            });
                        }
                    }
                }
            }

            dr.Close();
            con.Close();

            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = int.MaxValue;
            ctx.Response.Write(js.Serialize(list));
        }

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
                    using (SqlConnection c = new SqlConnection(con.ConnectionString))
                    {
                        c.Open();

                        SqlCommand chk1 = new SqlCommand(
                            "IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('Comments') AND name='ParentCommentId') " +
                            "ALTER TABLE Comments ADD ParentCommentId INT NULL REFERENCES Comments(CommentId)", c);
                        chk1.ExecuteNonQuery();

                        SqlCommand chk2 = new SqlCommand(
                            "IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('Comments') AND name='LikeCount') " +
                            "ALTER TABLE Comments ADD LikeCount INT NOT NULL DEFAULT 0", c);
                        chk2.ExecuteNonQuery();

                        SqlCommand chk3 = new SqlCommand(
                            "IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('Comments') AND name='CreatedDate') " +
                            "ALTER TABLE Comments ADD CreatedDate DATETIME NOT NULL DEFAULT GETDATE()", c);
                        chk3.ExecuteNonQuery();

                        SqlCommand chk4 = new SqlCommand(
                            "IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name='CommentLikes' AND type='U') " +
                            "CREATE TABLE CommentLikes (" +
                            "  CommentLikeId INT PRIMARY KEY IDENTITY(1,1)," +
                            "  CommentId INT NOT NULL REFERENCES Comments(CommentId) ON DELETE CASCADE," +
                            "  UserId INT NOT NULL REFERENCES Users(UserId)," +
                            "  CreatedDate DATETIME NOT NULL DEFAULT GETDATE()," +
                            "  UNIQUE (CommentId, UserId)" +
                            ")", c);
                        chk4.ExecuteNonQuery();

                        SqlCommand chk5 = new SqlCommand(
                            "IF EXISTS (SELECT 1 FROM sys.objects WHERE name='CommentLikes' AND type='U') " +
                            "AND NOT EXISTS (SELECT 1 FROM sys.columns WHERE object_id=OBJECT_ID('CommentLikes') AND name='CreatedDate') " +
                            "ALTER TABLE CommentLikes ADD CreatedDate DATETIME NOT NULL DEFAULT GETDATE()", c);
                        chk5.ExecuteNonQuery();
                    }

                    _schemaChecked = true;
                }
                catch
                {
                    // Don't mark as checked on failure — allow retry next request
                }
            }
        }

        private Dictionary<string, object> ReadJson(HttpContext ctx)
        {
            string json = "";
            using (System.IO.StreamReader reader = new System.IO.StreamReader(ctx.Request.InputStream))
            {
                json = reader.ReadToEnd();
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            js.MaxJsonLength = int.MaxValue;
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
            if (ts.TotalSeconds < 60) return "Just now";
            if (ts.TotalMinutes < 60) return (int)ts.TotalMinutes + "m ago";
            if (ts.TotalHours < 24) return (int)ts.TotalHours + "h ago";
            if (ts.TotalDays < 7) return (int)ts.TotalDays + "d ago";
            if (ts.TotalDays < 30) return ((int)(ts.TotalDays / 7)) + "w ago";
            return date.ToString("MMM dd");
        }

        private string EscapeJson(string value)
        {
            if (string.IsNullOrEmpty(value)) return "";
            return value.Replace("\\", "\\\\").Replace("\"", "\\\"");
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}
