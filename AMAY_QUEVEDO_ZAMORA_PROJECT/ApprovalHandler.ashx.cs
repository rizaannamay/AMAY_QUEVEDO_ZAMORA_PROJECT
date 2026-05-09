using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class ApprovalHandler : IHttpHandler, IRequiresSessionState
    {
        private const string Conn =
            "Data Source=DESKTOP-O39NPLV\\SQLEXPRESS1;Initial Catalog=CampusAnnouncementPortalDB;" +
            "User ID=CampusAnnouncementPortall;Password=campus123;Connect Timeout=30;TrustServerCertificate=True;";

        public bool IsReusable { get { return false; } }

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            var js = new JavaScriptSerializer();

            // Admin only
            bool isLoggedIn = ctx.Session["IsLoggedIn"] != null && (bool)ctx.Session["IsLoggedIn"];
            string role = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString() : "";
            bool isAdmin = isLoggedIn && string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase);

            if (!isAdmin)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            string action = ctx.Request["action"] != null ? ctx.Request["action"] : "";

            try
            {
                if (action == "getAnnouncements")
                    GetAnnouncements(ctx, js);
                else if (action == "Approve" || action == "Reject" || action == "Pending")
                    ReviewAnnouncement(ctx, js, action);
                else
                    ctx.Response.Write(js.Serialize(new { ok = false, error = "Unknown action" }));
            }
            catch (Exception ex)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = ex.Message }));
            }
        }

        private void GetAnnouncements(HttpContext ctx, JavaScriptSerializer js)
        {
            var list = new List<object>();
            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                string sql = "SELECT a.AnnouncementId, a.Title, a.Content, a.Category, " +
                             "ISNULL(a.Status,'Approved') AS Status, " +
                             "a.RejectionReason, a.Date_Posted, a.LikeCount, a.CommentCount, " +
                             "u.FullName AS AuthorName, ISNULL(u.ProfileImage,'') AS ProfileImage " +
                             "FROM Announcements a JOIN Users u ON u.UserId = a.UserId " +
                             "ORDER BY CASE ISNULL(a.Status,'Approved') " +
                             "WHEN 'Pending' THEN 0 WHEN 'Rejected' THEN 1 ELSE 2 END, " +
                             "a.Date_Posted DESC";

                using (var cmd = new SqlCommand(sql, con))
                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        list.Add(new
                        {
                            id              = Convert.ToInt32(dr["AnnouncementId"]),
                            title           = dr["Title"].ToString(),
                            content         = dr["Content"].ToString(),
                            category        = dr["Category"].ToString(),
                            status          = dr["Status"].ToString(),
                            rejectionReason = dr["RejectionReason"] != DBNull.Value ? dr["RejectionReason"].ToString() : "",
                            datePosted      = Convert.ToDateTime(dr["Date_Posted"]).ToString("yyyy-MM-ddTHH:mm:ss"),
                            likeCount       = Convert.ToInt32(dr["LikeCount"]),
                            commentCount    = Convert.ToInt32(dr["CommentCount"]),
                            authorName      = dr["AuthorName"].ToString(),
                            profileImage    = dr["ProfileImage"].ToString()
                        });
                    }
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true, data = list }));
        }

        private void ReviewAnnouncement(HttpContext ctx, JavaScriptSerializer js, string action)
        {
            string idStr  = ctx.Request["id"]     != null ? ctx.Request["id"]     : "";
            string reason = ctx.Request["reason"] != null ? ctx.Request["reason"] : "";

            int announcementId;
            if (!int.TryParse(idStr, out announcementId))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid ID" }));
                return;
            }

            string newStatus = (action == "Approve") ? "Approved"
                             : (action == "Reject")  ? "Rejected"
                             : "Pending";

            using (var con = new SqlConnection(Conn))
            {
                con.Open();

                // Check the announcement exists and read its current status.
                string currentStatus = "";
                using (var checkCmd = new SqlCommand(
                    "SELECT ISNULL(Status,'Approved') FROM Announcements WHERE AnnouncementId=@id", con))
                {
                    checkCmd.Parameters.AddWithValue("@id", announcementId);
                    var result = checkCmd.ExecuteScalar();
                    if (result == null)
                    {
                        ctx.Response.Write(js.Serialize(new { ok = false, error = "Announcement not found" }));
                        return;
                    }
                    currentStatus = result.ToString();
                }

                // Once approved, the status is locked — no further changes allowed.
                if (string.Equals(currentStatus, "Approved", StringComparison.OrdinalIgnoreCase)
                    && !string.Equals(newStatus, "Approved", StringComparison.OrdinalIgnoreCase))
                {
                    ctx.Response.Write(js.Serialize(new { ok = false, error = "Approved announcements cannot be changed." }));
                    return;
                }


                string sql = (newStatus == "Rejected")
                    ? "UPDATE Announcements SET Status=@s, RejectionReason=@r WHERE AnnouncementId=@id"
                    : "UPDATE Announcements SET Status=@s, RejectionReason=NULL WHERE AnnouncementId=@id";

                using (var cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@s",  newStatus);
                    cmd.Parameters.AddWithValue("@id", announcementId);
                    if (newStatus == "Rejected")
                        cmd.Parameters.AddWithValue("@r", string.IsNullOrEmpty(reason) ? (object)DBNull.Value : reason);
                    cmd.ExecuteNonQuery();
                }

                // Notify the post author
                if (newStatus == "Approved" || newStatus == "Rejected")
                {
                    string notifMsg = (newStatus == "Approved")
                        ? "Your announcement has been approved and is now live."
                        : "Your announcement was rejected" + (string.IsNullOrEmpty(reason) ? "." : ": " + reason);

                    using (var notifCmd = new SqlCommand(
                        "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                        "SELECT a.UserId, a.AnnouncementId, @msg, 0, GETDATE() " +
                        "FROM Announcements a WHERE a.AnnouncementId = @id", con))
                    {
                        notifCmd.Parameters.AddWithValue("@msg", notifMsg);
                        notifCmd.Parameters.AddWithValue("@id",  announcementId);
                        notifCmd.ExecuteNonQuery();
                    }

                    // When approved, also notify all students
                    if (newStatus == "Approved")
                    {
                        string postTitle = "";
                        using (var titleCmd = new SqlCommand(
                            "SELECT Title FROM Announcements WHERE AnnouncementId=@id", con))
                        {
                            titleCmd.Parameters.AddWithValue("@id", announcementId);
                            var r = titleCmd.ExecuteScalar();
                            if (r != null) postTitle = r.ToString();
                        }

                        using (var studentNotif = new SqlCommand(
                            "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                            "SELECT UserId, @aid, @msg, 0, GETDATE() FROM Users WHERE Role='Student'", con))
                        {
                            studentNotif.Parameters.AddWithValue("@aid", announcementId);
                            studentNotif.Parameters.AddWithValue("@msg", "New announcement: " + postTitle);
                            studentNotif.ExecuteNonQuery();
                        }
                    }
                }
            }

            ctx.Response.Write(js.Serialize(new { ok = true, status = newStatus }));
        }
    }
}
