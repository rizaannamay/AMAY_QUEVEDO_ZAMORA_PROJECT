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
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;");

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            var js = new JavaScriptSerializer();

            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"])
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Not logged in" }));
                return;
            }

            int    userId = Convert.ToInt32(ctx.Session["UserId"]);
            string action = ctx.Request["action"] ?? "";

            try
            {
                switch (action)
                {
                    case "getAll":      GetAll(ctx, js, userId);         break;
                    case "getUnread":   GetUnreadCount(ctx, js, userId); break;
                    case "markRead":    MarkRead(ctx, js, userId);       break;
                    case "markAllRead": MarkAllRead(ctx, js, userId);    break;
                    case "notifyShare": NotifyShare(ctx, js, userId);    break;
                    default:
                        ctx.Response.Write(js.Serialize(new { ok = false, error = "Unknown action" }));
                        break;
                }
            }
            catch (Exception ex)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = ex.Message }));
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
        }

        private void GetAll(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            var list = new List<object>();
            con.Open();
            SqlCommand cmd = new SqlCommand(
                "SELECT TOP 50 NotificationId, Message, IsRead, CreatedDate " +
                "FROM Notifications WHERE UserId=@uid ORDER BY CreatedDate DESC", con);
            cmd.Parameters.AddWithValue("@uid", userId);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                list.Add(new
                {
                    id      = Convert.ToInt32(dr["NotificationId"]),
                    message = dr["Message"].ToString(),
                    isRead  = Convert.ToBoolean(dr["IsRead"]),
                    time    = GetTimeAgo(Convert.ToDateTime(dr["CreatedDate"]))
                });
            }
            dr.Close();
            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true, data = list }));
        }

        private void GetUnreadCount(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(1) FROM Notifications WHERE UserId=@uid AND IsRead=0", con);
            cmd.Parameters.AddWithValue("@uid", userId);
            int count = (int)cmd.ExecuteScalar();
            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true, count = count }));
        }

        private void MarkRead(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            int notifId = Convert.ToInt32(ctx.Request["id"]);
            con.Open();
            SqlCommand cmd = new SqlCommand(
                "UPDATE Notifications SET IsRead=1 WHERE NotificationId=@nid AND UserId=@uid", con);
            cmd.Parameters.AddWithValue("@nid", notifId);
            cmd.Parameters.AddWithValue("@uid", userId);
            cmd.ExecuteNonQuery();
            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        private void MarkAllRead(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(
                "UPDATE Notifications SET IsRead=1 WHERE UserId=@uid AND IsRead=0", con);
            cmd.Parameters.AddWithValue("@uid", userId);
            cmd.ExecuteNonQuery();
            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        private void NotifyShare(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            if (!int.TryParse(ctx.Request["postId"], out int postId))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid postId" }));
                return;
            }
            con.Open();
            // Notify the announcement author (only if sharer is not the author)
            SqlCommand cmd = new SqlCommand(
                "INSERT INTO Notifications (UserId, Message) " +
                "SELECT a.UserId, u.Username + ' shared your announcement: ' + a.Title " +
                "FROM Announcements a JOIN Users u ON u.UserId = @uid " +
                "WHERE a.AnnouncementId = @pid AND a.UserId <> @uid", con);
            cmd.Parameters.AddWithValue("@uid", userId);
            cmd.Parameters.AddWithValue("@pid", postId);
            cmd.ExecuteNonQuery();
            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        private string GetTimeAgo(DateTime date)
        {
            TimeSpan ts = DateTime.Now - date;
            if (ts.TotalMinutes < 1)  return "Just now";
            if (ts.TotalMinutes < 60) return (int)ts.TotalMinutes + "m ago";
            if (ts.TotalHours   < 24) return (int)ts.TotalHours   + "h ago";
            if (ts.TotalDays    < 7)  return (int)ts.TotalDays    + "d ago";
            return date.ToString("MMM dd, yyyy");
        }

        public bool IsReusable { get { return false; } }
    }
}
