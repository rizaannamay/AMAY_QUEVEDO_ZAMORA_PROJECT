using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class AdminHandler : IHttpHandler, IRequiresSessionState
    {
        private const string Conn =
            @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;";

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";

            // Auth check
            var session = ctx.Session;
            if (session["IsLoggedIn"] == null || !(bool)session["IsLoggedIn"] ||
                !string.Equals(session["Role"]?.ToString(), "SuperAdmin", StringComparison.OrdinalIgnoreCase))
            {
                ctx.Response.Write("{\"ok\":false,\"error\":\"Unauthorized\"}");
                return;
            }

            string action = ctx.Request.QueryString["action"] ?? "";
            string idStr  = ctx.Request.QueryString["id"]     ?? "";
            string reason = ctx.Request.QueryString["reason"] ?? "";

            if (!int.TryParse(idStr, out int announcementId))
            {
                ctx.Response.Write("{\"ok\":false,\"error\":\"Invalid ID\"}");
                return;
            }

            string newStatus = action == "Approve" ? "Approved"
                             : action == "Reject"  ? "Rejected"
                             : action == "Pending" ? "Pending"
                             : null;

            if (newStatus == null)
            {
                ctx.Response.Write("{\"ok\":false,\"error\":\"Unknown action\"}");
                return;
            }

            try
            {
                using (var con = new SqlConnection(Conn))
                {
                    con.Open();
                    string sql = newStatus == "Rejected"
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
                }
                ctx.Response.Write("{\"ok\":true,\"status\":\"" + newStatus + "\"}");
            }
            catch (Exception ex)
            {
                ctx.Response.Write("{\"ok\":false,\"error\":\"" + ex.Message.Replace("\"","'") + "\"}");
            }
        }

        public bool IsReusable => false;
    }
}
