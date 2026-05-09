using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    /// <summary>
    /// Sends 1-day-ahead reminder notifications for calendar events.
    /// Call SendReminders from Page_Load after the session auth check passes.
    /// </summary>
    public static class CalendarReminderHelper
    {
        public const string ConnectionString =
            "Data Source=DESKTOP-O39NPLV\\SQLEXPRESS1;Initial Catalog=CampusAnnouncementPortalDB;" +
            "User ID=CampusAnnouncementPortall;Password=campus123;Connect Timeout=30;TrustServerCertificate=True;";

        /// <summary>
        /// Checks for calendar events scheduled for tomorrow that have not yet
        /// triggered a reminder, inserts a Notifications row for each, and sets
        /// ReminderSent = 1 to prevent duplicates on subsequent calls.
        /// All exceptions are silently swallowed so page load is never interrupted.
        /// </summary>
        public static void SendReminders(int userId, string connectionString = null)
        {
            if (userId <= 0) return;
            if (string.IsNullOrEmpty(connectionString))
                connectionString = ConnectionString;

            try
            {
                using (var con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // Find events scheduled for tomorrow that haven't been reminded yet.
                    var events = new List<Tuple<int, string>>();
                    using (var cmd = new SqlCommand(
                        "SELECT EventId, Title FROM CalendarEvents " +
                        "WHERE UserId = @uid " +
                        "  AND EventDate = CAST(DATEADD(day, 1, GETDATE()) AS DATE) " +
                        "  AND ReminderSent = 0", con))
                    {
                        cmd.Parameters.AddWithValue("@uid", userId);
                        using (var dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                events.Add(Tuple.Create(
                                    Convert.ToInt32(dr["EventId"]),
                                    dr["Title"].ToString()
                                ));
                            }
                        }
                    }

                    foreach (var ev in events)
                    {
                        int eventId   = ev.Item1;
                        string title  = ev.Item2;
                        string message = string.Format("Reminder: \"{0}\" is scheduled for tomorrow.", title);

                        // Insert notification
                        using (var notifCmd = new SqlCommand(
                            "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                            "VALUES (@uid, NULL, @msg, 0, GETDATE())", con))
                        {
                            notifCmd.Parameters.AddWithValue("@uid", userId);
                            notifCmd.Parameters.AddWithValue("@msg", message);
                            notifCmd.ExecuteNonQuery();
                        }

                        // Mark reminder as sent so it never fires again for this event
                        using (var flagCmd = new SqlCommand(
                            "UPDATE CalendarEvents SET ReminderSent = 1 WHERE EventId = @id", con))
                        {
                            flagCmd.Parameters.AddWithValue("@id", eventId);
                            flagCmd.ExecuteNonQuery();
                        }
                    }
                }
            }
            catch
            {
                // Silently swallow — reminder failure must never interrupt page load.
            }
        }
    }
}
