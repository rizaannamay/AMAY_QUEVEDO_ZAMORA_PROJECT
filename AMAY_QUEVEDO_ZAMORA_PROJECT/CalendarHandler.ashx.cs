using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class CalendarHandler : IHttpHandler, IRequiresSessionState
    {
        private const string Conn =
            "Data Source=DESKTOP-O39NPLV\\SQLEXPRESS1;Initial Catalog=CampusAnnouncementPortalDB;" +
            "User ID=CampusAnnouncementPortall;Password=campus123;Connect Timeout=30;TrustServerCertificate=True;";

        public bool IsReusable { get { return false; } }

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            var js = new JavaScriptSerializer();

            bool isLoggedIn = ctx.Session["IsLoggedIn"] != null && (bool)ctx.Session["IsLoggedIn"];
            if (!isLoggedIn)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            string role    = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString() : "";
            bool isAdmin   = string.Equals(role, "Admin",   StringComparison.OrdinalIgnoreCase);
            bool isTeacher = string.Equals(role, "Teacher", StringComparison.OrdinalIgnoreCase);
            bool isStudent = string.Equals(role, "Student", StringComparison.OrdinalIgnoreCase);
            int userId     = ctx.Session["UserId"] != null ? Convert.ToInt32(ctx.Session["UserId"]) : 0;

            string action = ctx.Request["action"] != null ? ctx.Request["action"] : "";

            try
            {
                if (action == "getEvents")
                    GetEvents(ctx, js, isAdmin, isTeacher, userId);
                else if (action == "addEvent")
                    AddEvent(ctx, js, isAdmin, isTeacher, userId);
                else if (action == "updateEvent")
                    UpdateEvent(ctx, js, isAdmin, userId);
                else if (action == "deleteEvent")
                    DeleteEvent(ctx, js, isAdmin, userId);
                else
                    ctx.Response.Write(js.Serialize(new { ok = false, error = "Unknown action" }));
            }
            catch (Exception ex)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = ex.Message }));
            }
        }

        // ── GET EVENTS ───────────────────────────────────────────────
        // Admin:   public events only (private events belong to their owner)
        // Teacher: public events + their own private events
        // Student: public events + their own private events
        private void GetEvents(HttpContext ctx, JavaScriptSerializer js, bool isAdmin, bool isTeacher, int userId)
        {
            var list = new List<object>();
            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                // All roles share the same rule: public events are visible to everyone,
                // private events are visible only to their owner.
                // Admin is NOT exempt — they must not see other users' private schedules.
                string sql = "SELECT e.EventId, e.Title, e.Description, e.EventDate, e.EventTime, e.EventType, e.IsPublic, "
                           + "u.Username AS CreatedBy, e.UserId AS OwnerId "
                           + "FROM CalendarEvents e JOIN Users u ON u.UserId = e.UserId "
                           + "WHERE e.IsPublic = 1 OR e.UserId = @uid "
                           + "ORDER BY e.EventDate ASC, e.EventTime ASC";

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
                                description = dr["Description"] != DBNull.Value ? dr["Description"].ToString() : "",
                                eventDate   = Convert.ToDateTime(dr["EventDate"]).ToString("yyyy-MM-dd"),
                                eventTime   = dr["EventTime"] != DBNull.Value ? ((TimeSpan)dr["EventTime"]).ToString(@"hh\:mm") : "",
                                eventType   = dr["EventType"].ToString(),
                                isPublic    = Convert.ToBoolean(dr["IsPublic"]),
                                createdBy   = dr["CreatedBy"].ToString(),
                                ownerId     = Convert.ToInt32(dr["OwnerId"])
                            });
                        }
                    }
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true, data = list }));
        }

        // ── ADD EVENT ────────────────────────────────────────────────
        // Admin can set isPublic. Teacher/Student events stay private until an admin changes them.
        private void AddEvent(HttpContext ctx, JavaScriptSerializer js, bool isAdmin, bool isTeacher, int userId)
        {
            string title      = ctx.Request["title"] != null ? ctx.Request["title"].Trim() : "";
            string date       = ctx.Request["date"]  != null ? ctx.Request["date"].Trim()  : "";
            string time       = ctx.Request["time"]  != null ? ctx.Request["time"].Trim()  : "";
            string type       = ctx.Request["type"]  != null ? ctx.Request["type"].Trim()  : "General";
            string desc       = ctx.Request["desc"]  != null ? ctx.Request["desc"].Trim()  : "";
            string isPublicStr = ctx.Request["isPublic"] != null ? ctx.Request["isPublic"].Trim() : "0";

            bool isPublic = isAdmin
                && (isPublicStr == "1" || string.Equals(isPublicStr, "true", StringComparison.OrdinalIgnoreCase));

            if (string.IsNullOrEmpty(title))
            { ctx.Response.Write(js.Serialize(new { ok = false, error = "Title is required." })); return; }
            if (string.IsNullOrEmpty(date))
            { ctx.Response.Write(js.Serialize(new { ok = false, error = "Date is required." })); return; }

            DateTime eventDate;
            if (!DateTime.TryParse(date, out eventDate))
            { ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid date." })); return; }

            TimeSpan eventTime;
            bool hasTime = TimeSpan.TryParse(time, out eventTime);
            if (!string.IsNullOrEmpty(time) && !hasTime)
            { ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid time." })); return; }

            string[] validTypes = { "Exam", "Deadline", "Reminder", "Quiz", "Event", "General" };
            bool validType = false;
            foreach (string t in validTypes)
                if (string.Equals(t, type, StringComparison.OrdinalIgnoreCase)) { validType = true; break; }
            if (!validType) type = "General";

            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                using (var cmd = new SqlCommand(
                    "INSERT INTO CalendarEvents (UserId, Title, Description, EventDate, EventTime, EventType, IsPublic) "
                    + "VALUES (@uid, @title, @desc, @date, @time, @type, @pub)", con))
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
            ctx.Response.Write(js.Serialize(new { ok = true, isPublic = isPublic }));
        }

        // ── DELETE EVENT ─────────────────────────────────────────────
        // Admin: can delete any event
        // Teacher/Student: can only delete their own events
        // Admin: can edit any event and change public/private.
        // Teacher/Student: can edit only their own schedule details; visibility is unchanged.
        private void UpdateEvent(HttpContext ctx, JavaScriptSerializer js, bool isAdmin, int userId)
        {
            string idStr       = ctx.Request["id"] != null ? ctx.Request["id"].Trim() : "";
            string title       = ctx.Request["title"] != null ? ctx.Request["title"].Trim() : "";
            string date        = ctx.Request["date"]  != null ? ctx.Request["date"].Trim()  : "";
            string time        = ctx.Request["time"]  != null ? ctx.Request["time"].Trim()  : "";
            string type        = ctx.Request["type"]  != null ? ctx.Request["type"].Trim()  : "General";
            string desc        = ctx.Request["desc"]  != null ? ctx.Request["desc"].Trim()  : "";
            string isPublicStr = ctx.Request["isPublic"] != null ? ctx.Request["isPublic"].Trim() : "0";

            int eventId;
            if (!int.TryParse(idStr, out eventId))
            { ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid event ID." })); return; }
            if (string.IsNullOrEmpty(title))
            { ctx.Response.Write(js.Serialize(new { ok = false, error = "Title is required." })); return; }
            if (string.IsNullOrEmpty(date))
            { ctx.Response.Write(js.Serialize(new { ok = false, error = "Date is required." })); return; }

            DateTime eventDate;
            if (!DateTime.TryParse(date, out eventDate))
            { ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid date." })); return; }

            TimeSpan eventTime;
            bool hasTime = TimeSpan.TryParse(time, out eventTime);
            if (!string.IsNullOrEmpty(time) && !hasTime)
            { ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid time." })); return; }

            string[] validTypes = { "Exam", "Deadline", "Reminder", "Quiz", "Event", "General" };
            bool validType = false;
            foreach (string t in validTypes)
                if (string.Equals(t, type, StringComparison.OrdinalIgnoreCase)) { validType = true; break; }
            if (!validType) type = "General";

            bool isPublic = isPublicStr == "1" || string.Equals(isPublicStr, "true", StringComparison.OrdinalIgnoreCase);

            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                string sql = isAdmin
                    ? "UPDATE CalendarEvents SET Title=@title, Description=@desc, EventDate=@date, EventTime=@time, EventType=@type, IsPublic=@pub WHERE EventId=@id"
                    : "UPDATE CalendarEvents SET Title=@title, Description=@desc, EventDate=@date, EventTime=@time, EventType=@type WHERE EventId=@id AND UserId=@uid";

                using (var cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@id", eventId);
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Parameters.AddWithValue("@desc", string.IsNullOrEmpty(desc) ? (object)DBNull.Value : desc);
                    cmd.Parameters.AddWithValue("@date", eventDate.Date);
                    cmd.Parameters.AddWithValue("@time", hasTime ? (object)eventTime : DBNull.Value);
                    cmd.Parameters.AddWithValue("@type", type);
                    if (isAdmin) cmd.Parameters.AddWithValue("@pub", isPublic ? 1 : 0);
                    if (!isAdmin) cmd.Parameters.AddWithValue("@uid", userId);

                    int rows = cmd.ExecuteNonQuery();
                    if (rows == 0)
                    { ctx.Response.Write(js.Serialize(new { ok = false, error = "Event not found or not authorized." })); return; }
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        private void DeleteEvent(HttpContext ctx, JavaScriptSerializer js, bool isAdmin, int userId)
        {
            string idStr = ctx.Request["id"] != null ? ctx.Request["id"] : "";
            int eventId;
            if (!int.TryParse(idStr, out eventId))
            { ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid event ID." })); return; }

            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                string sql = isAdmin
                    ? "DELETE FROM CalendarEvents WHERE EventId = @id"
                    : "DELETE FROM CalendarEvents WHERE EventId = @id AND UserId = @uid";

                using (var cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@id", eventId);
                    if (!isAdmin) cmd.Parameters.AddWithValue("@uid", userId);
                    int rows = cmd.ExecuteNonQuery();
                    if (rows == 0)
                    { ctx.Response.Write(js.Serialize(new { ok = false, error = "Event not found or not authorized." })); return; }
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }
    }
}
