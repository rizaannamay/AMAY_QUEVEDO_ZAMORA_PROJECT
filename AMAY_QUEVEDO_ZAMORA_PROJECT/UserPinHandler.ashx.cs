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
    /// Handles pin/unpin for both Admin (global IsPinned on Announcements)
    /// and Student (per-user row in UserPins table).
    /// </summary>
    public class UserPinHandler : IHttpHandler, IRequiresSessionState
    {
        private static readonly string ConnStr =
            @"Data Source=DESKTOP-C0LQQT8\SQLEXPRESS;Initial Catalog=CAPdb;Integrated Security=True;TrustServerCertificate=True;";

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
                    case "getUserPins": GetUserPins(ctx, js); break;
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

        // ─────────────────────────────────────────────────────────────
        // TOGGLE — Admin toggles global IsPinned; Student toggles UserPins row
        // ─────────────────────────────────────────────────────────────
        private void TogglePin(HttpContext ctx, JavaScriptSerializer js)
        {
            int announcementId;
            if (!int.TryParse(ctx.Request["announcementId"], out announcementId))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid announcement ID." }));
                return;
            }

            string role   = ctx.Session["Role"]   != null ? ctx.Session["Role"].ToString()   : "";
            int    userId = ctx.Session["UserId"]  != null ? Convert.ToInt32(ctx.Session["UserId"]) : 0;

            if (userId == 0)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Session expired." }));
                return;
            }

            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();

                if (string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase))
                {
                    // ── Admin: toggle global IsPinned on the Announcements row ──
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
                else
                {
                    // ── Student: toggle row in UserPins table ──
                    bool alreadyPinned;
                    using (var chk = new SqlCommand(
                        "SELECT COUNT(1) FROM UserPins WHERE UserId = @uid AND AnnouncementId = @aid", con))
                    {
                        chk.Parameters.AddWithValue("@uid", userId);
                        chk.Parameters.AddWithValue("@aid", announcementId);
                        alreadyPinned = Convert.ToInt32(chk.ExecuteScalar()) > 0;
                    }

                    if (alreadyPinned)
                    {
                        // Unpin — delete the row
                        using (var del = new SqlCommand(
                            "DELETE FROM UserPins WHERE UserId = @uid AND AnnouncementId = @aid", con))
                        {
                            del.Parameters.AddWithValue("@uid", userId);
                            del.Parameters.AddWithValue("@aid", announcementId);
                            del.ExecuteNonQuery();
                        }
                        ctx.Response.Write(js.Serialize(new { ok = true, isPinned = false }));
                    }
                    else
                    {
                        // Pin — insert a row
                        using (var ins = new SqlCommand(
                            "INSERT INTO UserPins (UserId, AnnouncementId) VALUES (@uid, @aid)", con))
                        {
                            ins.Parameters.AddWithValue("@uid", userId);
                            ins.Parameters.AddWithValue("@aid", announcementId);
                            ins.ExecuteNonQuery();
                        }
                        ctx.Response.Write(js.Serialize(new { ok = true, isPinned = true }));
                    }
                }
            }
        }

        // ─────────────────────────────────────────────────────────────
        // GET USER PINS — returns IDs pinned by this user
        // Admin: returns globally pinned IDs (IsPinned = 1)
        // Student: returns IDs from UserPins for this user
        //          PLUS any globally pinned IDs (admin pins are always shown)
        // ─────────────────────────────────────────────────────────────
        private void GetUserPins(HttpContext ctx, JavaScriptSerializer js)
        {
            string role   = ctx.Session["Role"]   != null ? ctx.Session["Role"].ToString()   : "";
            int    userId = ctx.Session["UserId"]  != null ? Convert.ToInt32(ctx.Session["UserId"]) : 0;

            var pinnedIds = new List<int>();

            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();

                if (string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase))
                {
                    // Admin sees globally pinned posts
                    using (var cmd = new SqlCommand(
                        "SELECT AnnouncementId FROM Announcements WHERE IsPinned = 1", con))
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                            pinnedIds.Add(Convert.ToInt32(dr["AnnouncementId"]));
                    }
                }
                else
                {
                    // Student sees their own pins + any globally pinned posts
                    using (var cmd = new SqlCommand(
                        @"SELECT AnnouncementId FROM Announcements WHERE IsPinned = 1
                          UNION
                          SELECT AnnouncementId FROM UserPins WHERE UserId = @uid", con))
                    {
                        cmd.Parameters.AddWithValue("@uid", userId);
                        using (var dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                                pinnedIds.Add(Convert.ToInt32(dr["AnnouncementId"]));
                        }
                    }
                }
            }

            ctx.Response.Write(js.Serialize(new { ok = true, pinnedIds = pinnedIds }));
        }
    }
}
