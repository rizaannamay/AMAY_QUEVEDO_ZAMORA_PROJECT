using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class AdminHandler : IHttpHandler, IRequiresSessionState
    {
        private const string Conn =
            @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CampusAnnouncementPortalDB;User ID=CampusAnnouncementPortall;Password=campus123;Connect Timeout=30;TrustServerCertificate=True;";

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            var js = new JavaScriptSerializer();

            var session = ctx.Session;
            bool isLoggedIn = session["IsLoggedIn"] != null && (bool)session["IsLoggedIn"];
            string sessionRole = (session["Role"] != null) ? session["Role"].ToString() : "";
            bool isAdmin = isLoggedIn && string.Equals(sessionRole, "Admin", StringComparison.OrdinalIgnoreCase);

            if (!isLoggedIn)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            string action = (ctx.Request["action"] != null) ? ctx.Request["action"] : "";

            bool isReadOnly = (action == "getCalendarEvents");
            bool isTeacherCalAction = (action == "addCalendarEvent" || action == "deleteCalendarEvent")
                && string.Equals(sessionRole, "Teacher", StringComparison.OrdinalIgnoreCase);

            if (!isAdmin && !isReadOnly && !isTeacherCalAction)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            try
            {
                switch (action)
                {
                    case "getStats":             GetStats(ctx, js);                   break;
                    case "getAnnouncements":     GetAnnouncements(ctx, js);           break;
                    case "Approve":
                    case "Reject":
                    case "Pending":              ReviewAnnouncement(ctx, js, action); break;
                    case "getUsers":             GetUsers(ctx, js);                   break;
                    case "updateUserStatus":     UpdateUserStatus(ctx, js);           break;
                    case "getTheme":             GetTheme(ctx, js);                   break;
                    case "setTheme":             SetTheme(ctx, js);                   break;
                    case "getCalendarEvents":    GetCalendarEvents(ctx, js);          break;
                    case "addCalendarEvent":     AddCalendarEvent(ctx, js);           break;
                    case "deleteCalendarEvent":  DeleteCalendarEvent(ctx, js);        break;
                    default:
                        ctx.Response.Write(js.Serialize(new { ok = false, error = "Unknown action: " + action }));
                        break;
                }
            }
            catch (Exception ex)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = ex.Message }));
            }
        }

        // ── STATS ────────────────────────────────────────────────────
        private void GetStats(HttpContext ctx, JavaScriptSerializer js)
        {
            try
            {
                using (var con = new SqlConnection(Conn))
                {
                    con.Open();
                    int totalPosts      = Scalar(con, "SELECT COUNT(1) FROM Announcements");
                    int pendingPosts    = Scalar(con, "SELECT COUNT(1) FROM Announcements WHERE ISNULL(Status,'Approved')='Pending'");
                    int approvedPosts   = Scalar(con, "SELECT COUNT(1) FROM Announcements WHERE ISNULL(Status,'Approved')='Approved'");
                    int totalUsers      = Scalar(con, "SELECT COUNT(1) FROM Users");
                    int pendingTeachers = Scalar(con, "SELECT COUNT(1) FROM Users WHERE Role='Teacher' AND ISNULL(AccountStatus,'Active')='Pending'");
                    ctx.Response.Write(js.Serialize(new { ok = true, totalPosts = totalPosts, pendingPosts = pendingPosts, approvedPosts = approvedPosts, totalUsers = totalUsers, pendingTeachers = pendingTeachers }));
                }
            }
            catch (Exception ex)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "getStats: " + ex.Message }));
            }
        }

        // ── ANNOUNCEMENTS ────────────────────────────────────────────
        private void GetAnnouncements(HttpContext ctx, JavaScriptSerializer js)
        {
            var list = new List<object>();
            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                string sql = "SELECT a.AnnouncementId, a.Title, a.Content, a.Category,"
                           + " ISNULL(a.Status,'Approved') AS Status,"
                           + " a.RejectionReason, a.Date_Posted, a.LikeCount, a.CommentCount,"
                           + " u.FullName AS AuthorName, u.ProfileImage"
                           + " FROM Announcements a JOIN Users u ON u.UserId = a.UserId"
                           + " ORDER BY CASE ISNULL(a.Status,'Approved') WHEN 'Pending' THEN 0 WHEN 'Rejected' THEN 1 ELSE 2 END, a.Date_Posted DESC";

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
                            rejectionReason = (dr["RejectionReason"] != DBNull.Value) ? dr["RejectionReason"].ToString() : "",
                            datePosted      = Convert.ToDateTime(dr["Date_Posted"]).ToString("yyyy-MM-ddTHH:mm:ss"),
                            likeCount       = Convert.ToInt32(dr["LikeCount"]),
                            commentCount    = Convert.ToInt32(dr["CommentCount"]),
                            authorName      = dr["AuthorName"].ToString(),
                            profileImage    = (dr["ProfileImage"] != DBNull.Value) ? dr["ProfileImage"].ToString() : ""
                        });
                    }
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true, data = list }));
        }

        private void ReviewAnnouncement(HttpContext ctx, JavaScriptSerializer js, string action)
        {
            string idStr  = (ctx.Request["id"]     != null) ? ctx.Request["id"]     : "";
            string reason = (ctx.Request["reason"] != null) ? ctx.Request["reason"] : "";
            int announcementId;
            if (!int.TryParse(idStr, out announcementId))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid ID" }));
                return;
            }
            string newStatus = (action == "Approve") ? "Approved" : (action == "Reject") ? "Rejected" : "Pending";
            using (var con = new SqlConnection(Conn))
            {
                con.Open();

                // Guard: once an announcement is Approved it cannot be downgraded.
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

                if (string.Equals(currentStatus, "Approved", StringComparison.OrdinalIgnoreCase)
                    && !string.Equals(newStatus, "Approved", StringComparison.OrdinalIgnoreCase))
                {
                    ctx.Response.Write(js.Serialize(new { ok = false, error = "Cannot change status of an already-approved announcement" }));
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
                if (newStatus == "Approved")
                {
                    using (var notifCmd = new SqlCommand(
                        "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate)"
                        + " SELECT a.UserId, a.AnnouncementId, 'Your announcement has been approved: ' + a.Title, 0, GETDATE()"
                        + " FROM Announcements a WHERE a.AnnouncementId = @id", con))
                    {
                        notifCmd.Parameters.AddWithValue("@id", announcementId);
                        notifCmd.ExecuteNonQuery();
                    }
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true, status = newStatus }));
        }

        // ── USERS ────────────────────────────────────────────────────
        private void GetUsers(HttpContext ctx, JavaScriptSerializer js)
        {
            var list = new List<object>();
            try
            {
                using (var con = new SqlConnection(Conn))
                {
                    con.Open();
                    string sql = "SELECT UserId, FullName, Username, Email, Role,"
                               + " ISNULL(AccountStatus,'Active') AS AccountStatus,"
                               + " CreatedDate FROM Users"
                               + " ORDER BY CASE ISNULL(AccountStatus,'Active') WHEN 'Pending' THEN 0 ELSE 1 END, CreatedDate DESC";
                    using (var cmd = new SqlCommand(sql, con))
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            list.Add(new
                            {
                                userId        = Convert.ToInt32(dr["UserId"]),
                                fullName      = dr["FullName"].ToString(),
                                username      = dr["Username"].ToString(),
                                email         = dr["Email"].ToString(),
                                role          = dr["Role"].ToString(),
                                accountStatus = dr["AccountStatus"].ToString(),
                                createdDate   = Convert.ToDateTime(dr["CreatedDate"]).ToString("yyyy-MM-ddTHH:mm:ss")
                            });
                        }
                    }
                }
                ctx.Response.Write(js.Serialize(new { ok = true, data = list }));
            }
            catch (Exception ex)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "getUsers: " + ex.Message }));
            }
        }

        private void UpdateUserStatus(HttpContext ctx, JavaScriptSerializer js)
        {
            string userIdStr = (ctx.Request["userId"] != null) ? ctx.Request["userId"] : "";
            string status    = (ctx.Request["status"] != null) ? ctx.Request["status"] : "";
            int userId;
            if (!int.TryParse(userIdStr, out userId))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid userId" }));
                return;
            }
            var allowed = new System.Collections.Generic.HashSet<string> { "Active", "Pending", "Suspended", "Rejected" };
            if (!allowed.Contains(status))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid status" }));
                return;
            }
            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                using (var cmd = new SqlCommand("UPDATE Users SET AccountStatus=@s WHERE UserId=@id", con))
                {
                    cmd.Parameters.AddWithValue("@s",  status);
                    cmd.Parameters.AddWithValue("@id", userId);
                    cmd.ExecuteNonQuery();
                }
                string msg = null;
                if (status == "Active")    msg = "Your account has been approved and activated.";
                else if (status == "Suspended") msg = "Your account has been suspended. Contact admin.";
                else if (status == "Rejected")  msg = "Your account registration was not approved.";
                if (msg != null)
                {
                    using (var notifCmd = new SqlCommand(
                        "INSERT INTO Notifications (UserId, Message, IsRead, CreatedDate) VALUES (@uid, @msg, 0, GETDATE())", con))
                    {
                        notifCmd.Parameters.AddWithValue("@uid", userId);
                        notifCmd.Parameters.AddWithValue("@msg", msg);
                        notifCmd.ExecuteNonQuery();
                    }
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        // ── THEME ────────────────────────────────────────────────────
        private void GetTheme(HttpContext ctx, JavaScriptSerializer js)
        {
            string theme = "Default";
            try
            {
                using (var con = new SqlConnection(Conn))
                {
                    con.Open();
                    using (var cmd = new SqlCommand("SELECT SettingValue FROM SiteSettings WHERE SettingKey='ActiveTheme'", con))
                    {
                        var result = cmd.ExecuteScalar();
                        if (result != null) theme = result.ToString();
                    }
                }
            }
            catch { }
            ctx.Response.Write(js.Serialize(new { ok = true, theme = theme }));
        }

        private void SetTheme(HttpContext ctx, JavaScriptSerializer js)
        {
            string theme = (ctx.Request["theme"] != null) ? ctx.Request["theme"] : "Default";
            var allowed = new System.Collections.Generic.HashSet<string>
                { "Default","Intramurals","FoundationWeek","WomensMonth","UniversityWeek","Christmas","Graduation" };
            if (!allowed.Contains(theme)) theme = "Default";
            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                using (var cmd = new SqlCommand(
                    "IF EXISTS (SELECT 1 FROM SiteSettings WHERE SettingKey='ActiveTheme')"
                    + " UPDATE SiteSettings SET SettingValue=@v, UpdatedDate=GETDATE() WHERE SettingKey='ActiveTheme'"
                    + " ELSE INSERT INTO SiteSettings (SettingKey, SettingValue) VALUES ('ActiveTheme', @v)", con))
                {
                    cmd.Parameters.AddWithValue("@v", theme);
                    cmd.ExecuteNonQuery();
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true, theme = theme }));
        }

        // ── CALENDAR ─────────────────────────────────────────────────
        private void GetCalendarEvents(HttpContext ctx, JavaScriptSerializer js)
        {
            var list = new List<object>();
            try
            {
                int userId = ctx.Session["UserId"] != null ? Convert.ToInt32(ctx.Session["UserId"]) : 0;
                using (var con = new SqlConnection(Conn))
                {
                    con.Open();
                    // Admin sees public events + their own private events only.
                    // Private events created by other users are not visible to admin.
                    string sql = "SELECT e.EventId, e.Title, e.Description, e.EventDate, e.EventTime, e.EventType, e.IsPublic,"
                               + " u.Username AS CreatedBy"
                               + " FROM CalendarEvents e JOIN Users u ON u.UserId = e.UserId"
                               + " WHERE e.IsPublic = 1 OR e.UserId = @uid"
                               + " ORDER BY e.EventDate ASC, e.EventTime ASC";
                    using (var cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@uid", userId);
                        using (var dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                list.Add(new
                                {
                                    eventId     = Convert.ToInt32(dr["EventId"]),
                                    title       = dr["Title"].ToString(),
                                    description = (dr["Description"] != DBNull.Value) ? dr["Description"].ToString() : "",
                                    eventDate   = Convert.ToDateTime(dr["EventDate"]).ToString("yyyy-MM-dd"),
                                    eventTime   = dr["EventTime"] != DBNull.Value ? ((TimeSpan)dr["EventTime"]).ToString(@"hh\:mm") : "",
                                    eventType   = dr["EventType"].ToString(),
                                    isPublic    = Convert.ToBoolean(dr["IsPublic"]),
                                    createdBy   = dr["CreatedBy"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch { }
            ctx.Response.Write(js.Serialize(new { ok = true, data = list }));
        }

        private void AddCalendarEvent(HttpContext ctx, JavaScriptSerializer js)
        {
            string title      = (ctx.Request["title"] != null) ? ctx.Request["title"] : "";
            string date       = (ctx.Request["date"]  != null) ? ctx.Request["date"]  : "";
            string time       = (ctx.Request["time"]  != null) ? ctx.Request["time"]  : "";
            string type       = (ctx.Request["type"]  != null) ? ctx.Request["type"]  : "General";
            string desc       = (ctx.Request["desc"]  != null) ? ctx.Request["desc"]  : "";
            string isPublicStr = (ctx.Request["isPublic"] != null) ? ctx.Request["isPublic"] : "0";
            bool isPublic     = (isPublicStr == "1" || isPublicStr.ToLower() == "true");
            int userId        = Convert.ToInt32(ctx.Session["UserId"]);
            if (string.IsNullOrWhiteSpace(title) || string.IsNullOrWhiteSpace(date))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Title and date are required." }));
                return;
            }
            DateTime eventDate;
            if (!DateTime.TryParse(date, out eventDate))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid date." }));
                return;
            }
            TimeSpan eventTime;
            bool hasTime = TimeSpan.TryParse(time, out eventTime);
            if (!string.IsNullOrWhiteSpace(time) && !hasTime)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid time." }));
                return;
            }
            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                using (var cmd = new SqlCommand(
                    "INSERT INTO CalendarEvents (UserId, Title, Description, EventDate, EventTime, EventType, IsPublic)"
                    + " VALUES (@uid, @title, @desc, @date, @time, @type, @pub)", con))
                {
                    cmd.Parameters.AddWithValue("@uid",   userId);
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Parameters.AddWithValue("@desc",  string.IsNullOrEmpty(desc) ? (object)DBNull.Value : desc);
                    cmd.Parameters.AddWithValue("@date",  eventDate.Date);
                    cmd.Parameters.AddWithValue("@time",  hasTime ? (object)eventTime : DBNull.Value);
                    cmd.Parameters.AddWithValue("@type",  type);
                    cmd.Parameters.AddWithValue("@pub",   isPublic ? 1 : 0);
                    cmd.ExecuteNonQuery();
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        private void DeleteCalendarEvent(HttpContext ctx, JavaScriptSerializer js)
        {
            string idStr = (ctx.Request["id"] != null) ? ctx.Request["id"] : "";
            int eventId;
            if (!int.TryParse(idStr, out eventId))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid ID" }));
                return;
            }
            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                using (var cmd = new SqlCommand("DELETE FROM CalendarEvents WHERE EventId=@id", con))
                {
                    cmd.Parameters.AddWithValue("@id", eventId);
                    cmd.ExecuteNonQuery();
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        // ── Helper ───────────────────────────────────────────────────
        private static int Scalar(SqlConnection con, string sql)
        {
            using (var cmd = new SqlCommand(sql, con))
            {
                var r = cmd.ExecuteScalar();
                return (r != null) ? Convert.ToInt32(r) : 0;
            }
        }

        public bool IsReusable { get { return false; } }
    }
}
