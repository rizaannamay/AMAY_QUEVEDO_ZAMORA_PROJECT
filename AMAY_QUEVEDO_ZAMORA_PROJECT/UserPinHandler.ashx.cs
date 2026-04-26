using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class UserPinHandler : IHttpHandler, IRequiresSessionState
    {
        private string ConnStr
        {
            get { return ConfigurationManager.ConnectionStrings["CampusConnectDB"].ConnectionString; }
        }

        public void ProcessRequest(HttpContext ctx)
        {
            // Always return JSON — never let ASP.NET return an HTML error page
            ctx.Response.ContentType = "application/json";
            ctx.Response.TrySkipIisCustomErrors = true;

            var js = new JavaScriptSerializer();
            string action = ctx.Request["action"] ?? "";

            try
            {
                switch (action)
                {
                    case "toggle":      TogglePin(ctx, js);    break;
                    case "getUserPins": GetUserPins(ctx, js);  break;
                    default:
                        ctx.Response.Write(js.Serialize(new { ok = false, error = "Unknown action: " + action }));
                        break;
                }
            }
            catch (SqlException sqlEx)
            {
                string errorMsg = sqlEx.Message;
                if (errorMsg.Contains("Invalid object name 'Pinned'"))
                    errorMsg = "Pinned table does not exist in the database. Please run the schema SQL to create it.";
                ctx.Response.StatusCode = 200; // keep 200 so JS can read the JSON body
                ctx.Response.Write(js.Serialize(new { ok = false, error = errorMsg, sqlError = true }));
            }
            catch (Exception ex)
            {
                ctx.Response.StatusCode = 200;
                ctx.Response.Write(js.Serialize(new { ok = false, error = ex.Message, detail = ex.GetType().Name }));
            }
        }

        // ── TOGGLE PIN ───────────────────────────────────────────
        private void TogglePin(HttpContext ctx, JavaScriptSerializer js)
        {
            bool isLoggedIn = ctx.Session["IsLoggedIn"] is bool b && b;
            if (!isLoggedIn)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Not logged in. Please refresh and log in again." }));
                return;
            }

            // Safe parse — bad values return a clear error instead of a 500
            if (!int.TryParse(ctx.Session["UserId"]?.ToString(), out int userId) || userId <= 0)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid session UserId." }));
                return;
            }

            string rawId = ctx.Request["announcementId"] ?? "";
            if (!int.TryParse(rawId, out int announcementId) || announcementId <= 0)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid announcementId: '" + rawId + "'" }));
                return;
            }

            bool isPinned;
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();

                // Check if already pinned
                const string checkSql = "SELECT COUNT(*) FROM Pinned WHERE UserId = @UserId AND AnnouncementId = @AnnouncementId";
                using (var cmd = new SqlCommand(checkSql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@AnnouncementId", announcementId);
                    int count = (int)cmd.ExecuteScalar();
                    isPinned = count > 0;
                }

                if (isPinned)
                {
                    // Unpin
                    const string deleteSql = "DELETE FROM Pinned WHERE UserId = @UserId AND AnnouncementId = @AnnouncementId";
                    using (var cmd = new SqlCommand(deleteSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@AnnouncementId", announcementId);
                        cmd.ExecuteNonQuery();
                    }
                    isPinned = false;
                }
                else
                {
                    // Pin
                    const string insertSql = "INSERT INTO Pinned (UserId, AnnouncementId) VALUES (@UserId, @AnnouncementId)";
                    using (var cmd = new SqlCommand(insertSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@AnnouncementId", announcementId);
                        cmd.ExecuteNonQuery();
                    }
                    isPinned = true;
                }
            }

            ctx.Response.Write(js.Serialize(new { ok = true, isPinned = isPinned }));
        }

        // ── GET USER PINS ────────────────────────────────────────
        private void GetUserPins(HttpContext ctx, JavaScriptSerializer js)
        {
            bool isLoggedIn = ctx.Session["IsLoggedIn"] is bool b && b;
            if (!isLoggedIn)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Not logged in." }));
                return;
            }

            if (!int.TryParse(ctx.Session["UserId"]?.ToString(), out int userId) || userId <= 0)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid session UserId." }));
                return;
            }
            var pinnedIds = new List<int>();

            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                const string sql = "SELECT AnnouncementId FROM Pinned WHERE UserId = @UserId";
                using (var cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    using (var r = cmd.ExecuteReader())
                    {
                        while (r.Read())
                        {
                            pinnedIds.Add(r.GetInt32(0));
                        }
                    }
                }
            }

            ctx.Response.Write(js.Serialize(new { ok = true, pinnedIds = pinnedIds }));
        }

        public bool IsReusable { get { return false; } }
    }
}
