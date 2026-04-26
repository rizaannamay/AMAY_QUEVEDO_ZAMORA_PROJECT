using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class NotificationHandler : IHttpHandler, IRequiresSessionState
    {
        private string ConnStr =>
            ConfigurationManager.ConnectionStrings["CampusConnectDB"].ConnectionString;

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            var js = new JavaScriptSerializer();

            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"])
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Not logged in" }));
                return;
            }

            int userId = Convert.ToInt32(ctx.Session["UserId"]);
            string action = ctx.Request["action"] ?? "";

            try
            {
                switch (action)
                {
                    case "getAll":      GetAll(ctx, js, userId);      break;
                    case "getUnread":   GetUnreadCount(ctx, js, userId); break;
                    case "markRead":    MarkRead(ctx, js, userId);    break;
                    case "markAllRead": MarkAllRead(ctx, js, userId); break;
                    default:
                        ctx.Response.Write(js.Serialize(new { ok = false, error = "Unknown action" }));
                        break;
                }
            }
            catch (Exception ex)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = ex.Message }));
            }
        }

        // ── GET ALL notifications for this user ───────────────
        private void GetAll(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            var list = new List<object>();
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                const string sql = @"
                    SELECT TOP 50 NotificationId, Message, IsRead, CreatedDate
                    FROM   Notifications
                    WHERE  UserId = @Uid
                    ORDER  BY CreatedDate DESC";

                using (var cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Uid", userId);
                    using (var r = cmd.ExecuteReader())
                    {
                        while (r.Read())
                        {
                            list.Add(new
                            {
                                id      = r.GetInt32(0),
                                message = r.GetString(1),
                                isRead  = r.GetBoolean(2),
                                time    = GetTimeAgo(r.GetDateTime(3))
                            });
                        }
                    }
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true, data = list }));
        }

        // ── GET UNREAD COUNT ──────────────────────────────────
        private void GetUnreadCount(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                using (var cmd = new SqlCommand(
                    "SELECT COUNT(1) FROM Notifications WHERE UserId=@Uid AND IsRead=0", conn))
                {
                    cmd.Parameters.AddWithValue("@Uid", userId);
                    int count = (int)cmd.ExecuteScalar();
                    ctx.Response.Write(js.Serialize(new { ok = true, count = count }));
                }
            }
        }

        // ── MARK ONE AS READ ──────────────────────────────────
        private void MarkRead(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            int notifId = Convert.ToInt32(ctx.Request["id"]);
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                using (var cmd = new SqlCommand(
                    "UPDATE Notifications SET IsRead=1 WHERE NotificationId=@Id AND UserId=@Uid", conn))
                {
                    cmd.Parameters.AddWithValue("@Id",  notifId);
                    cmd.Parameters.AddWithValue("@Uid", userId);
                    cmd.ExecuteNonQuery();
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        // ── MARK ALL AS READ ──────────────────────────────────
        private void MarkAllRead(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                using (var cmd = new SqlCommand(
                    "UPDATE Notifications SET IsRead=1 WHERE UserId=@Uid AND IsRead=0", conn))
                {
                    cmd.Parameters.AddWithValue("@Uid", userId);
                    cmd.ExecuteNonQuery();
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        // ── STATIC HELPER: insert a notification ─────────────
        public static void Insert(SqlConnection conn, int userId, string message)
        {
            using (var cmd = new SqlCommand(
                "INSERT INTO Notifications (UserId, Message) VALUES (@Uid, @Msg)", conn))
            {
                cmd.Parameters.AddWithValue("@Uid", userId);
                cmd.Parameters.AddWithValue("@Msg", message);
                cmd.ExecuteNonQuery();
            }
        }

        // ── STATIC HELPER: notify all students ───────────────
        public static void NotifyAllStudents(SqlConnection conn, string message)
        {
            const string sql = @"
                INSERT INTO Notifications (UserId, Message)
                SELECT UserId, @Msg FROM Users WHERE Role = 'Student'";
            using (var cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@Msg", message);
                cmd.ExecuteNonQuery();
            }
        }

        private string GetTimeAgo(DateTime date)
        {
            TimeSpan ts = DateTime.Now - date;
            if (ts.TotalMinutes < 1)  return "Just now";
            if (ts.TotalMinutes < 60) return $"{(int)ts.TotalMinutes}m ago";
            if (ts.TotalHours   < 24) return $"{(int)ts.TotalHours}h ago";
            if (ts.TotalDays    < 7)  return $"{(int)ts.TotalDays}d ago";
            return date.ToString("MMM dd, yyyy");
        }

        public bool IsReusable => false;
    }
}
