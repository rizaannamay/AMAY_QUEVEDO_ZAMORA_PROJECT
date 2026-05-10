using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    /// <summary>
    /// Called by client-side polling (every 60 s) from any logged-in page.
    /// Finds calendar events starting within the next 5 minutes and:
    ///   - Inserts an in-app Notification for the relevant users
    ///   - Sends a Gmail reminder
    ///   - Sets ReminderSent5Min = 1 to prevent duplicates
    ///
    /// Private events  → only the event owner is notified.
    /// Public events   → all active users are notified.
    /// </summary>
    public class ReminderCheckHandler : IHttpHandler, IRequiresSessionState
    {
        private const string Conn =
            "Data Source=DESKTOP-O39NPLV\\SQLEXPRESS1;Initial Catalog=CampusAnnouncementPortalDB;" +
            "User ID=CampusAnnouncementPortall;Password=campus123;Connect Timeout=30;TrustServerCertificate=True;";

        public bool IsReusable { get { return false; } }

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            var js = new JavaScriptSerializer();

            // Must be logged in
            bool isLoggedIn = ctx.Session["IsLoggedIn"] != null && (bool)ctx.Session["IsLoggedIn"];
            if (!isLoggedIn)
            {
                ctx.Response.Write(js.Serialize(new { ok = false }));
                return;
            }

            int currentUserId = ctx.Session["UserId"] != null
                ? Convert.ToInt32(ctx.Session["UserId"]) : 0;

            int triggered = 0;

            try
            {
                using (var con = new SqlConnection(Conn))
                {
                    con.Open();

                    // ── Events starting within the next 5 minutes ────────────
                    // Window: NOW  ≤  EventDate+EventTime  ≤  NOW + 5 min
                    // Only events that have a time set and haven't been 5-min reminded yet.
                    var events = new List<EventRow>();

                    using (var cmd = new SqlCommand(
                        "SELECT e.EventId, e.Title, e.EventDate, e.EventTime, e.EventType, " +
                        "       e.IsPublic, e.UserId AS OwnerId, " +
                        "       u.Email AS OwnerEmail, u.FullName AS OwnerName " +
                        "FROM CalendarEvents e " +
                        "JOIN Users u ON u.UserId = e.UserId " +
                        "WHERE e.EventTime IS NOT NULL " +
                        "  AND e.ReminderSent5Min = 0 " +
                        "  AND CAST(e.EventDate AS DATETIME) + CAST(e.EventTime AS DATETIME) " +
                        "      BETWEEN GETDATE() AND DATEADD(MINUTE, 5, GETDATE())", con))
                    {
                        using (var dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                events.Add(new EventRow
                                {
                                    EventId    = Convert.ToInt32(dr["EventId"]),
                                    Title      = dr["Title"].ToString(),
                                    EventDate  = Convert.ToDateTime(dr["EventDate"]),
                                    EventTime  = (TimeSpan)dr["EventTime"],
                                    EventType  = dr["EventType"].ToString(),
                                    IsPublic   = Convert.ToBoolean(dr["IsPublic"]),
                                    OwnerId    = Convert.ToInt32(dr["OwnerId"]),
                                    OwnerEmail = dr["OwnerEmail"].ToString(),
                                    OwnerName  = dr["OwnerName"].ToString()
                                });
                            }
                        }
                    }

                    if (events.Count == 0)
                    {
                        ctx.Response.Write(js.Serialize(new { ok = true, triggered = 0 }));
                        return;
                    }

                    // Fetch all active users once (needed for public events)
                    var allUsers = new List<UserRow>();
                    using (var uCmd = new SqlCommand(
                        "SELECT UserId, Email, FullName FROM Users " +
                        "WHERE ISNULL(AccountStatus,'Active') = 'Active'", con))
                    {
                        using (var dr = uCmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                allUsers.Add(new UserRow
                                {
                                    UserId   = Convert.ToInt32(dr["UserId"]),
                                    Email    = dr["Email"].ToString(),
                                    FullName = dr["FullName"].ToString()
                                });
                            }
                        }
                    }

                    foreach (var ev in events)
                    {
                        string timeStr = DateTime.Today.Add(ev.EventTime).ToString("h:mm tt");
                        string message = string.Format(
                            "⏰ Reminder: \"{0}\" starts in 5 minutes at {1}.", ev.Title, timeStr);

                        if (ev.IsPublic)
                        {
                            // Notify all active users
                            foreach (var user in allUsers)
                            {
                                InsertNotification(con, user.UserId, message);
                                EmailHelper.SendCalendarReminder5Min(
                                    user.Email, user.FullName,
                                    ev.Title, ev.EventDate, ev.EventTime, ev.EventType,
                                    isPublic: true);
                            }
                        }
                        else
                        {
                            // Notify only the owner
                            InsertNotification(con, ev.OwnerId, message);
                            EmailHelper.SendCalendarReminder5Min(
                                ev.OwnerEmail, ev.OwnerName,
                                ev.Title, ev.EventDate, ev.EventTime, ev.EventType,
                                isPublic: false);
                        }

                        // Mark as sent — never fires again for this event
                        using (var flagCmd = new SqlCommand(
                            "UPDATE CalendarEvents SET ReminderSent5Min = 1 WHERE EventId = @id", con))
                        {
                            flagCmd.Parameters.AddWithValue("@id", ev.EventId);
                            flagCmd.ExecuteNonQuery();
                        }

                        triggered++;
                    }
                }
            }
            catch
            {
                // Swallow silently — never break the client
            }

            ctx.Response.Write(js.Serialize(new { ok = true, triggered = triggered }));
        }

        private static void InsertNotification(SqlConnection con, int userId, string message)
        {
            using (var cmd = new SqlCommand(
                "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                "VALUES (@uid, NULL, @msg, 0, GETDATE())", con))
            {
                cmd.Parameters.AddWithValue("@uid", userId);
                cmd.Parameters.AddWithValue("@msg", message);
                cmd.ExecuteNonQuery();
            }
        }

        private class EventRow
        {
            public int      EventId    { get; set; }
            public string   Title      { get; set; }
            public DateTime EventDate  { get; set; }
            public TimeSpan EventTime  { get; set; }
            public string   EventType  { get; set; }
            public bool     IsPublic   { get; set; }
            public int      OwnerId    { get; set; }
            public string   OwnerEmail { get; set; }
            public string   OwnerName  { get; set; }
        }

        private class UserRow
        {
            public int    UserId   { get; set; }
            public string Email    { get; set; }
            public string FullName { get; set; }
        }
    }
}
