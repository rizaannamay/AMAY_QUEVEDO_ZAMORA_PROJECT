using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    /// <summary>
    /// HTTP handler for DTR (Daily Time Record) AJAX operations.
    /// Actions: timein | timeout | getrecords | getstatus
    /// </summary>
    public class DTRHandler : IHttpHandler, IRequiresSessionState
    {
        private static readonly string ConnStr =
            ConfigurationManager.ConnectionStrings["CampusConnectDB"].ConnectionString;

        public bool IsReusable => false;

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            ctx.Response.Cache.SetCacheability(HttpCacheability.NoCache);

            // Auth guard
            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"])
            {
                ctx.Response.Write("{\"success\":false,\"message\":\"Not authenticated.\"}");
                return;
            }

            int userId = Convert.ToInt32(ctx.Session["UserId"] ?? 0);
            if (userId == 0)
            {
                ctx.Response.Write("{\"success\":false,\"message\":\"Invalid session.\"}");
                return;
            }

            string action = (ctx.Request["action"] ?? "").ToLower();

            try
            {
                switch (action)
                {
                    case "timein":    TimeIn(ctx, userId);    break;
                    case "timeout":   TimeOut(ctx, userId);   break;
                    case "getrecords":GetRecords(ctx, userId); break;
                    case "getstatus": GetStatus(ctx, userId); break;
                    default:
                        ctx.Response.Write("{\"success\":false,\"message\":\"Unknown action.\"}");
                        break;
                }
            }
            catch (Exception ex)
            {
                ctx.Response.Write("{\"success\":false,\"message\":" +
                    JsonStr("Server error: " + ex.Message) + "}");
            }
        }

        // ── TIME IN ──────────────────────────────────────────────────────────
        private void TimeIn(HttpContext ctx, int userId)
        {
            string notes = (ctx.Request["notes"] ?? "").Trim();
            DateTime today = DateTime.Today;

            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();

                // Prevent duplicate time-in on the same day
                using (var chk = new SqlCommand(
                    "SELECT COUNT(1) FROM DTR WHERE UserId=@uid AND WorkDate=@wd AND TimeOut IS NULL", conn))
                {
                    chk.Parameters.AddWithValue("@uid", userId);
                    chk.Parameters.AddWithValue("@wd", today);
                    int open = (int)chk.ExecuteScalar();
                    if (open > 0)
                    {
                        ctx.Response.Write("{\"success\":false,\"message\":\"You already have an open Time-In for today.\"}");
                        return;
                    }
                }

                using (var cmd = new SqlCommand(
                    "INSERT INTO DTR (UserId, TimeIn, WorkDate, Notes) " +
                    "OUTPUT INSERTED.DTRId, INSERTED.TimeIn " +
                    "VALUES (@uid, GETDATE(), @wd, @notes)", conn))
                {
                    cmd.Parameters.AddWithValue("@uid", userId);
                    cmd.Parameters.AddWithValue("@wd", today);
                    cmd.Parameters.AddWithValue("@notes", string.IsNullOrEmpty(notes) ? (object)DBNull.Value : notes);

                    using (var rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            int dtrId = rdr.GetInt32(0);
                            string timeIn = rdr.GetDateTime(1).ToString("hh:mm:ss tt");
                            ctx.Response.Write("{\"success\":true,\"dtrId\":" + dtrId +
                                ",\"timeIn\":" + JsonStr(timeIn) + "}");
                        }
                    }
                }
            }
        }

        // ── TIME OUT ─────────────────────────────────────────────────────────
        private void TimeOut(HttpContext ctx, int userId)
        {
            DateTime today = DateTime.Today;

            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();

                // Find the open record for today
                int dtrId = 0;
                using (var find = new SqlCommand(
                    "SELECT TOP 1 DTRId FROM DTR " +
                    "WHERE UserId=@uid AND WorkDate=@wd AND TimeOut IS NULL " +
                    "ORDER BY TimeIn DESC", conn))
                {
                    find.Parameters.AddWithValue("@uid", userId);
                    find.Parameters.AddWithValue("@wd", today);
                    object res = find.ExecuteScalar();
                    if (res == null || res == DBNull.Value)
                    {
                        ctx.Response.Write("{\"success\":false,\"message\":\"No open Time-In found for today.\"}");
                        return;
                    }
                    dtrId = (int)res;
                }

                using (var upd = new SqlCommand(
                    "UPDATE DTR SET TimeOut=GETDATE() " +
                    "OUTPUT INSERTED.TimeOut, INSERTED.TimeIn " +
                    "WHERE DTRId=@id", conn))
                {
                    upd.Parameters.AddWithValue("@id", dtrId);
                    using (var rdr = upd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            DateTime timeOut = rdr.GetDateTime(0);
                            DateTime timeIn  = rdr.GetDateTime(1);
                            TimeSpan duration = timeOut - timeIn;
                            string hours = ((int)duration.TotalHours).ToString("D2") + "h " +
                                           duration.Minutes.ToString("D2") + "m";
                            ctx.Response.Write("{\"success\":true,\"timeOut\":" +
                                JsonStr(timeOut.ToString("hh:mm:ss tt")) +
                                ",\"duration\":" + JsonStr(hours) + "}");
                        }
                    }
                }
            }
        }

        // ── GET STATUS (today's open record) ─────────────────────────────────
        private void GetStatus(HttpContext ctx, int userId)
        {
            DateTime today = DateTime.Today;
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                using (var cmd = new SqlCommand(
                    "SELECT TOP 1 DTRId, TimeIn FROM DTR " +
                    "WHERE UserId=@uid AND WorkDate=@wd AND TimeOut IS NULL " +
                    "ORDER BY TimeIn DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@uid", userId);
                    cmd.Parameters.AddWithValue("@wd", today);
                    using (var rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            ctx.Response.Write("{\"success\":true,\"timedIn\":true,\"dtrId\":" +
                                rdr.GetInt32(0) + ",\"timeIn\":" +
                                JsonStr(rdr.GetDateTime(1).ToString("hh:mm:ss tt")) + "}");
                        }
                        else
                        {
                            ctx.Response.Write("{\"success\":true,\"timedIn\":false}");
                        }
                    }
                }
            }
        }

        // ── GET RECORDS (paginated, last 30 days) ────────────────────────────
        private void GetRecords(HttpContext ctx, int userId)
        {
            int page = Math.Max(1, int.TryParse(ctx.Request["page"], out int p) ? p : 1);
            int pageSize = 10;
            int offset = (page - 1) * pageSize;

            var sb = new StringBuilder();
            sb.Append("{\"success\":true,\"records\":[");

            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();

                // Total count
                int total = 0;
                using (var cnt = new SqlCommand(
                    "SELECT COUNT(1) FROM DTR WHERE UserId=@uid", conn))
                {
                    cnt.Parameters.AddWithValue("@uid", userId);
                    total = (int)cnt.ExecuteScalar();
                }

                using (var cmd = new SqlCommand(
                    "SELECT DTRId, WorkDate, TimeIn, TimeOut, Notes " +
                    "FROM DTR WHERE UserId=@uid " +
                    "ORDER BY WorkDate DESC, TimeIn DESC " +
                    "OFFSET @off ROWS FETCH NEXT @ps ROWS ONLY", conn))
                {
                    cmd.Parameters.AddWithValue("@uid", userId);
                    cmd.Parameters.AddWithValue("@off", offset);
                    cmd.Parameters.AddWithValue("@ps", pageSize);

                    bool first = true;
                    using (var rdr = cmd.ExecuteReader())
                    {
                        while (rdr.Read())
                        {
                            if (!first) sb.Append(",");
                            first = false;

                            DateTime timeIn  = rdr.GetDateTime(2);
                            bool hasOut      = !rdr.IsDBNull(3);
                            DateTime timeOut = hasOut ? rdr.GetDateTime(3) : DateTime.MinValue;
                            string duration  = hasOut
                                ? FormatDuration(timeOut - timeIn)
                                : "—";

                            sb.Append("{");
                            sb.Append("\"id\":"    + rdr.GetInt32(0) + ",");
                            sb.Append("\"date\":"  + JsonStr(rdr.GetDateTime(1).ToString("MMM dd, yyyy")) + ",");
                            sb.Append("\"timeIn\":" + JsonStr(timeIn.ToString("hh:mm tt")) + ",");
                            sb.Append("\"timeOut\":" + (hasOut ? JsonStr(timeOut.ToString("hh:mm tt")) : "null") + ",");
                            sb.Append("\"duration\":" + JsonStr(duration) + ",");
                            sb.Append("\"notes\":"  + JsonStr(rdr.IsDBNull(4) ? "" : rdr.GetString(4)) + ",");
                            sb.Append("\"open\":"   + (!hasOut ? "true" : "false"));
                            sb.Append("}");
                        }
                    }
                }

                sb.Append("],\"total\":" + total + ",\"page\":" + page +
                          ",\"pageSize\":" + pageSize + "}");
            }

            ctx.Response.Write(sb.ToString());
        }

        // ── Helpers ──────────────────────────────────────────────────────────
        private static string FormatDuration(TimeSpan ts)
        {
            int h = (int)ts.TotalHours;
            return h + "h " + ts.Minutes.ToString("D2") + "m";
        }

        private static string JsonStr(string s)
        {
            if (s == null) return "null";
            return "\"" + s.Replace("\\", "\\\\").Replace("\"", "\\\"")
                           .Replace("\n", "\\n").Replace("\r", "\\r") + "\"";
        }
    }
}
