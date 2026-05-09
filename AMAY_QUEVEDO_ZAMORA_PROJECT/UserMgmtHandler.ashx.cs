using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class UserMgmtHandler : IHttpHandler, IRequiresSessionState
    {
        private const string Conn =
            "Data Source=DESKTOP-O39NPLV\\SQLEXPRESS1;Initial Catalog=CampusAnnouncementPortalDB;" +
            "User ID=CampusAnnouncementPortall;Password=campus123;Connect Timeout=30;TrustServerCertificate=True;";

        public bool IsReusable { get { return false; } }

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            var js = new JavaScriptSerializer();

            // Must be logged in as Admin
            bool isLoggedIn = ctx.Session["IsLoggedIn"] != null && (bool)ctx.Session["IsLoggedIn"];
            string role = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString() : "";
            bool isAdmin = isLoggedIn && string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase);

            if (!isAdmin)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            string action = ctx.Request["action"] != null ? ctx.Request["action"] : "";

            try
            {
                if (action == "getUsers")
                {
                    GetUsers(ctx, js);
                }
                else if (action == "updateStatus")
                {
                    UpdateStatus(ctx, js);
                }
                else if (action == "getStats")
                {
                    GetStats(ctx, js);
                }
                else if (action == "getTheme")
                {
                    GetTheme(ctx, js);
                }
                else if (action == "setTheme")
                {
                    SetTheme(ctx, js);
                }
                else
                {
                    ctx.Response.Write(js.Serialize(new { ok = false, error = "Unknown action" }));
                }
            }
            catch (Exception ex)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = ex.Message }));
            }
        }

        private void GetTheme(HttpContext ctx, JavaScriptSerializer js)
        {
            string theme = "Default";
            try
            {
                using (var con = new SqlConnection(Conn))
                {
                    con.Open();
                    using (var cmd = new SqlCommand("SELECT SettingValue FROM SiteSettings WHERE SettingKey='ActiveTheme'", con))
                    {
                        var r = cmd.ExecuteScalar();
                        if (r != null) theme = r.ToString();
                    }
                }
            }
            catch { }
            ctx.Response.Write(js.Serialize(new { ok = true, theme = theme }));
        }

        private void SetTheme(HttpContext ctx, JavaScriptSerializer js)
        {
            string theme = ctx.Request["theme"] != null ? ctx.Request["theme"] : "Default";
            string[] valid = { "Default","Intramurals","FoundationWeek","WomensMonth","UniversityWeek","Christmas","Graduation" };
            bool found = false;
            foreach (string v in valid) if (v == theme) { found = true; break; }
            if (!found) theme = "Default";

            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                using (var cmd = new SqlCommand(
                    "IF EXISTS (SELECT 1 FROM SiteSettings WHERE SettingKey='ActiveTheme') " +
                    "UPDATE SiteSettings SET SettingValue=@v, UpdatedDate=GETDATE() WHERE SettingKey='ActiveTheme' " +
                    "ELSE INSERT INTO SiteSettings (SettingKey, SettingValue) VALUES ('ActiveTheme', @v)", con))
                {
                    cmd.Parameters.AddWithValue("@v", theme);
                    cmd.ExecuteNonQuery();
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true, theme = theme }));
        }

        private void GetStats(HttpContext ctx, JavaScriptSerializer js)
        {
            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                int totalPosts      = Scalar(con, "SELECT COUNT(1) FROM Announcements");
                int pendingPosts    = Scalar(con, "SELECT COUNT(1) FROM Announcements WHERE ISNULL(Status,'Approved')='Pending'");
                int approvedPosts   = Scalar(con, "SELECT COUNT(1) FROM Announcements WHERE ISNULL(Status,'Approved')='Approved'");
                int totalUsers      = Scalar(con, "SELECT COUNT(1) FROM Users");
                int pendingTeachers = Scalar(con, "SELECT COUNT(1) FROM Users WHERE Role='Teacher' AND ISNULL(AccountStatus,'Active')='Pending'");
                ctx.Response.Write(js.Serialize(new
                {
                    ok = true,
                    totalPosts = totalPosts,
                    pendingPosts = pendingPosts,
                    approvedPosts = approvedPosts,
                    totalUsers = totalUsers,
                    pendingTeachers = pendingTeachers
                }));
            }
        }

        private static int Scalar(SqlConnection con, string sql)
        {
            using (var cmd = new SqlCommand(sql, con))
            {
                var r = cmd.ExecuteScalar();
                return (r != null) ? Convert.ToInt32(r) : 0;
            }
        }

        private void GetUsers(HttpContext ctx, JavaScriptSerializer js)
        {
            var list = new List<object>();
            using (var con = new SqlConnection(Conn))
            {
                con.Open();
                string sql = "SELECT UserId, FullName, Username, Email, Role, " +
                             "ISNULL(AccountStatus, 'Active') AS AccountStatus, " +
                             "CreatedDate FROM Users " +
                             "ORDER BY CASE ISNULL(AccountStatus,'Active') " +
                             "WHEN 'Pending' THEN 0 ELSE 1 END, CreatedDate DESC";

                using (var cmd = new SqlCommand(sql, con))
                using (var dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        list.Add(new
                        {
                            userId        = Convert.ToInt32(dr["UserId"]),
                            fullName      = dr["FullName"].ToString(),
                            username      = dr["Username"].ToString(),
                            email         = dr["Email"].ToString(),
                            role          = dr["Role"].ToString(),
                            accountStatus = dr["AccountStatus"].ToString(),
                            createdDate   = Convert.ToDateTime(dr["CreatedDate"]).ToString("yyyy-MM-ddTHH:mm:ss")
                        });
                    }
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true, data = list }));
        }

        private void UpdateStatus(HttpContext ctx, JavaScriptSerializer js)
        {
            string userIdStr = ctx.Request["userId"] != null ? ctx.Request["userId"] : "";
            string status    = ctx.Request["status"]  != null ? ctx.Request["status"]  : "";

            int userId;
            if (!int.TryParse(userIdStr, out userId))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid userId" }));
                return;
            }

            // Validate status value
            if (status != "Active" && status != "Pending" && status != "Suspended" && status != "Rejected")
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid status" }));
                return;
            }

            using (var con = new SqlConnection(Conn))
            {
                con.Open();

                // Update the user status
                using (var cmd = new SqlCommand(
                    "UPDATE Users SET AccountStatus = @s WHERE UserId = @id", con))
                {
                    cmd.Parameters.AddWithValue("@s",  status);
                    cmd.Parameters.AddWithValue("@id", userId);
                    cmd.ExecuteNonQuery();
                }

                // Send notification to the user
                string msg = null;
                if (status == "Active")    msg = "Your account has been approved. You can now log in.";
                if (status == "Suspended") msg = "Your account has been suspended. Contact the administrator.";
                if (status == "Rejected")  msg = "Your account registration was not approved.";

                if (msg != null)
                {
                    using (var notif = new SqlCommand(
                        "INSERT INTO Notifications (UserId, Message, IsRead, CreatedDate) " +
                        "VALUES (@uid, @msg, 0, GETDATE())", con))
                    {
                        notif.Parameters.AddWithValue("@uid", userId);
                        notif.Parameters.AddWithValue("@msg", msg);
                        notif.ExecuteNonQuery();
                    }
                }
            }

            ctx.Response.Write(js.Serialize(new { ok = true }));
        }
    }
}
