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
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["CampusConnectDB"].ConnectionString);

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
                    case "toggle":      TogglePin(ctx, js);   break;
                    case "getUserPins": GetUserPins(ctx, js); break;
                    default:
                        ctx.Response.Write(js.Serialize(new { ok = false, error = "Unknown action: " + action }));
                        break;
                }
            }
            catch (Exception ex)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = ex.Message }));
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
        }

        private void TogglePin(HttpContext ctx, JavaScriptSerializer js)
        {
            int userId         = Convert.ToInt32(ctx.Session["UserId"]);
            int announcementId = Convert.ToInt32(ctx.Request["announcementId"]);

            con.Open();

            SqlCommand checkCmd = new SqlCommand(
                "SELECT COUNT(*) FROM Pinned WHERE UserId=@uid AND AnnouncementId=@aid", con);
            checkCmd.Parameters.AddWithValue("@uid", userId);
            checkCmd.Parameters.AddWithValue("@aid", announcementId);
            bool isPinned = (int)checkCmd.ExecuteScalar() > 0;

            if (isPinned)
            {
                SqlCommand delCmd = new SqlCommand(
                    "DELETE FROM Pinned WHERE UserId=@uid AND AnnouncementId=@aid", con);
                delCmd.Parameters.AddWithValue("@uid", userId);
                delCmd.Parameters.AddWithValue("@aid", announcementId);
                delCmd.ExecuteNonQuery();
                isPinned = false;
            }
            else
            {
                SqlCommand insCmd = new SqlCommand(
                    "INSERT INTO Pinned (UserId, AnnouncementId) VALUES (@uid, @aid)", con);
                insCmd.Parameters.AddWithValue("@uid", userId);
                insCmd.Parameters.AddWithValue("@aid", announcementId);
                insCmd.ExecuteNonQuery();
                isPinned = true;
            }

            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true, isPinned = isPinned }));
        }

        private void GetUserPins(HttpContext ctx, JavaScriptSerializer js)
        {
            int userId = Convert.ToInt32(ctx.Session["UserId"]);
            var pinnedIds = new List<int>();

            con.Open();
            SqlCommand cmd = new SqlCommand(
                "SELECT AnnouncementId FROM Pinned WHERE UserId=@uid", con);
            cmd.Parameters.AddWithValue("@uid", userId);
            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
                pinnedIds.Add(Convert.ToInt32(dr["AnnouncementId"]));
            dr.Close();
            con.Close();

            ctx.Response.Write(js.Serialize(new { ok = true, pinnedIds = pinnedIds }));
        }

        public bool IsReusable { get { return false; } }
    }
}
