using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    /// <summary>
    /// Handles pin/unpin using the IsPinned column on the Announcements table.
    /// No separate Pinned table is needed — follows the ERD.
    /// Admin pins are global (IsPinned = 1 on the row).
    /// Students see pinned posts at the top based on IsPinned.
    /// </summary>
    public class UserPinHandler : IHttpHandler, IRequiresSessionState
    {
        private static readonly string ConnStr =
            ConfigurationManager.ConnectionStrings["CampusConnectDB"].ConnectionString;

        public bool IsReusable => false;

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            ctx.Response.TrySkipIisCustomErrors = true;

            var    js     = new JavaScriptSerializer();
            string action = ctx.Request["action"] ?? "";

            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"])
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Not logged in." }));
                return;
            }

            try
            {
                switch (action)
                {
                    case "toggle":      TogglePin(ctx, js); break;
                    case "getUserPins": GetPinned(ctx, js); break;
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

        /// <summary>
        /// Toggles IsPinned on the Announcements row.
        /// Only Admin can pin/unpin (students see the pin state but can't change it).
        /// </summary>
        private void TogglePin(HttpContext ctx, JavaScriptSerializer js)
        {
            int announcementId = Convert.ToInt32(ctx.Request["announcementId"]);
            string role = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString() : "";

            // Only Admin can pin/unpin
            if (!string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Only admins can pin announcements." }));
                return;
            }

            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();

                // Get current pin state
                bool isPinned;
                using (var chk = new SqlCommand(
                    "SELECT IsPinned FROM Announcements WHERE AnnouncementId = @aid", con))
                {
                    chk.Parameters.AddWithValue("@aid", announcementId);
                    var result = chk.ExecuteScalar();
                    if (result == null || result == DBNull.Value)
                    {
                        ctx.Response.Write(js.Serialize(new { ok = false, error = "Announcement not found." }));
                        return;
                    }
                    isPinned = Convert.ToBoolean(result);
                }

                // Toggle
                bool newState = !isPinned;
                using (var upd = new SqlCommand(
                    "UPDATE Announcements SET IsPinned = @val WHERE AnnouncementId = @aid", con))
                {
                    upd.Parameters.AddWithValue("@val", newState ? 1 : 0);
                    upd.Parameters.AddWithValue("@aid", announcementId);
                    upd.ExecuteNonQuery();
                }

                ctx.Response.Write(js.Serialize(new { ok = true, isPinned = newState }));
            }
        }

        /// <summary>
        /// Returns all announcement IDs where IsPinned = 1.
        /// Used by Student/Pinned pages to know which posts are pinned.
        /// </summary>
        private void GetPinned(HttpContext ctx, JavaScriptSerializer js)
        {
            var pinnedIds = new List<int>();

            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();
                using (var cmd = new SqlCommand(
                    "SELECT AnnouncementId FROM Announcements WHERE IsPinned = 1", con))
                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                        pinnedIds.Add(Convert.ToInt32(dr["AnnouncementId"]));
                }
            }

            ctx.Response.Write(js.Serialize(new { ok = true, pinnedIds = pinnedIds }));
        }
    }
}
