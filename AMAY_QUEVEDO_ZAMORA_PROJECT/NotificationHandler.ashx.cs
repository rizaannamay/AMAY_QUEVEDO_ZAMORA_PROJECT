using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class NotificationHandler : IHttpHandler, IRequiresSessionState
    {
        SqlConnection con = new SqlConnection(@"Data Source=LAPTOP-GPJQLLD4\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;");

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            JavaScriptSerializer js = new JavaScriptSerializer();

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
                    case "getAll":
                        GetAll(ctx, js, userId);
                        break;

                    case "getUnread":
                        GetUnreadCount(ctx, js, userId);
                        break;

                    case "markRead":
                        MarkRead(ctx, js, userId);
                        break;

                    case "markAllRead":
                        MarkAllRead(ctx, js, userId);
                        break;

                    case "notifyShare":
                        NotifyShare(ctx, js, userId);
                        break;

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
            List<object> list = new List<object>();

            con.Open();
            SqlCommand cmd = new SqlCommand(
                "SELECT TOP 100 NotificationId, UserId, AnnouncementId, Message, IsRead, CreatedDate " +
                "FROM Notifications WHERE UserId=@uid ORDER BY CreatedDate DESC, NotificationId DESC", con);
            cmd.Parameters.AddWithValue("@uid", userId);

            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                DateTime created = Convert.ToDateTime(dr["CreatedDate"]);

                list.Add(new
                {
                    id = Convert.ToInt32(dr["NotificationId"]),
                    userId = Convert.ToInt32(dr["UserId"]),
                    announcementId = dr["AnnouncementId"] == DBNull.Value ? 0 : Convert.ToInt32(dr["AnnouncementId"]),
                    message = dr["Message"].ToString(),
                    isRead = Convert.ToBoolean(dr["IsRead"]),
                    time = GetTimeAgo(created),
                    createdDate = created.ToString("yyyy-MM-dd HH:mm:ss")
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

            int count = Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();

            ctx.Response.Write(js.Serialize(new { ok = true, count = count }));
        }

        private void MarkRead(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            int notifId;
            if (!int.TryParse(ctx.Request["id"], out notifId))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid notification id" }));
                return;
            }

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
            int postId;
            if (!int.TryParse(ctx.Request["postId"], out postId))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid postId" }));
                return;
            }

            con.Open();

            SqlCommand cmd = new SqlCommand(
                "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                "SELECT a.UserId, a.AnnouncementId, u.Username + ' shared your announcement: ' + a.Title, 0, GETDATE() " +
                "FROM Announcements a " +
                "JOIN Users u ON u.UserId = @uid " +
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

            if (ts.TotalSeconds < 60)
                return "Just now";

            if (ts.TotalMinutes < 60)
                return (int)ts.TotalMinutes + "m ago";

            if (ts.TotalHours < 24)
                return (int)ts.TotalHours + "h ago";

            if (ts.TotalDays < 7)
                return (int)ts.TotalDays + "d ago";

            if (ts.TotalDays < 30)
                return ((int)(ts.TotalDays / 7)) + "w ago";

            if (ts.TotalDays < 365)
                return date.ToString("MMM dd");

            return date.ToString("MMM dd, yyyy");
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}
