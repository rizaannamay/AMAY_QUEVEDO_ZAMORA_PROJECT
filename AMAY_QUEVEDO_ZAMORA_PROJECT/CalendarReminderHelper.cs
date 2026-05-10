using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    /// <summary>
    /// Sends 1-day-ahead reminder notifications (in-app + Gmail) for calendar events.
    /// Called from Page_Load on Admin, Teacher, and Student pages.
    ///
    /// Logic:
    ///   - Private events  → remind only the event owner (in-app + Gmail)
    ///   - Public events   → remind ALL users (in-app + Gmail to each)
    ///   - ReminderSent=1 prevents duplicate reminders across multiple page loads.
    /// </summary>
    public static class CalendarReminderHelper
    {
        public const string ConnectionString =
            "Data Source=DESKTOP-O39NPLV\\SQLEXPRESS1;Initial Catalog=CampusAnnouncementPortalDB;" +
            "User ID=CampusAnnouncementPortall;Password=campus123;Connect Timeout=30;TrustServerCertificate=True;";

        public static void SendReminders(int currentUserId, string connectionString = null)
        {
            if (currentUserId <= 0) return;
            if (string.IsNullOrEmpty(connectionString))
                connectionString = ConnectionString;

            try
            {
                using (var con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // ── 1. Private events owned by this user ─────────────────
                    ProcessPrivateReminders(con, currentUserId);

                    // ── 2. Public events (any owner) — run once per event ────
                    //    Only the first user to load a page triggers this so we
                    //    use ReminderSent flag to ensure it fires exactly once.
                    ProcessPublicReminders(con);
                }
            }
            catch
            {
                // Silently swallow — reminder failure must never interrupt page load.
            }
        }

        // ── Private events: notify only the owner ────────────────────────────
        private static void ProcessPrivateReminders(SqlConnection con, int userId)
        {
            var events = new List<EventInfo>();

            using (var cmd = new SqlCommand(
                "SELECT e.EventId, e.Title, e.EventDate, e.EventTime, e.EventType, " +
                "       u.Email, u.FullName " +
                "FROM CalendarEvents e " +
                "JOIN Users u ON u.UserId = e.UserId " +
                "WHERE e.UserId = @uid " +
                "  AND e.IsPublic = 0 " +
                "  AND e.EventDate = CAST(DATEADD(day, 1, GETDATE()) AS DATE) " +
                "  AND e.ReminderSent = 0", con))
            {
                cmd.Parameters.AddWithValue("@uid", userId);
                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                        events.Add(ReadEvent(dr));
                }
            }

            foreach (var ev in events)
            {
                string message = string.Format("Reminder: \"{0}\" is scheduled for tomorrow.", ev.Title);

                InsertNotification(con, userId, message);
                MarkReminderSent(con, ev.EventId);

                // Gmail
                EmailHelper.SendCalendarReminder(ev.Email, ev.FullName, ev.Title,
                    ev.EventDate, ev.EventTime, ev.EventType, isPublic: false);
            }
        }

        // ── Public events: notify ALL users ──────────────────────────────────
        private static void ProcessPublicReminders(SqlConnection con)
        {
            var events = new List<EventInfo>();

            using (var cmd = new SqlCommand(
                "SELECT e.EventId, e.Title, e.EventDate, e.EventTime, e.EventType, " +
                "       u.Email, u.FullName " +
                "FROM CalendarEvents e " +
                "JOIN Users u ON u.UserId = e.UserId " +
                "WHERE e.IsPublic = 1 " +
                "  AND e.EventDate = CAST(DATEADD(day, 1, GETDATE()) AS DATE) " +
                "  AND e.ReminderSent = 0", con))
            {
                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                        events.Add(ReadEvent(dr));
                }
            }

            if (events.Count == 0) return;

            // Fetch all active users once
            var allUsers = new List<UserInfo>();
            using (var uCmd = new SqlCommand(
                "SELECT UserId, Email, FullName FROM Users " +
                "WHERE ISNULL(AccountStatus,'Active') = 'Active'", con))
            {
                using (var dr = uCmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        allUsers.Add(new UserInfo
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
                string message = string.Format(
                    "Reminder: Public event \"{0}\" is scheduled for tomorrow.", ev.Title);

                // In-app notification for every active user
                foreach (var user in allUsers)
                {
                    InsertNotification(con, user.UserId, message);

                    // Gmail to every active user
                    EmailHelper.SendCalendarReminder(
                        user.Email, user.FullName,
                        ev.Title, ev.EventDate, ev.EventTime, ev.EventType,
                        isPublic: true);
                }

                MarkReminderSent(con, ev.EventId);
            }
        }

        // ── Helpers ───────────────────────────────────────────────────────────
        private static EventInfo ReadEvent(SqlDataReader dr)
        {
            // Handle both query shapes: private (Email/FullName) and public (OwnerEmail/OwnerName)
            string email    = "";
            string fullName = "";
            try { email    = dr["Email"].ToString(); }    catch { }
            try { fullName = dr["FullName"].ToString(); } catch { }
            if (string.IsNullOrEmpty(email))
                try { email    = dr["OwnerEmail"].ToString(); } catch { }
            if (string.IsNullOrEmpty(fullName))
                try { fullName = dr["OwnerName"].ToString(); }  catch { }

            return new EventInfo
            {
                EventId   = Convert.ToInt32(dr["EventId"]),
                Title     = dr["Title"].ToString(),
                EventDate = Convert.ToDateTime(dr["EventDate"]),
                EventTime = dr["EventTime"] != DBNull.Value
                                ? (TimeSpan?)((TimeSpan)dr["EventTime"])
                                : null,
                EventType = dr["EventType"].ToString(),
                Email     = email,
                FullName  = fullName
            };
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

        private static void MarkReminderSent(SqlConnection con, int eventId)
        {
            using (var cmd = new SqlCommand(
                "UPDATE CalendarEvents SET ReminderSent = 1 WHERE EventId = @id", con))
            {
                cmd.Parameters.AddWithValue("@id", eventId);
                cmd.ExecuteNonQuery();
            }
        }

        private class EventInfo
        {
            public int      EventId   { get; set; }
            public string   Title     { get; set; }
            public DateTime EventDate { get; set; }
            public TimeSpan? EventTime { get; set; }
            public string   EventType { get; set; }
            public string   Email     { get; set; }
            public string   FullName  { get; set; }
        }

        private class UserInfo
        {
            public int    UserId   { get; set; }
            public string Email    { get; set; }
            public string FullName { get; set; }
        }
    }
}
