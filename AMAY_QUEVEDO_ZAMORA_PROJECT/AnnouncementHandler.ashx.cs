using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class AnnouncementHandler : IHttpHandler, IRequiresSessionState
    {
        private string ConnStr
        {
            get { return ConfigurationManager.ConnectionStrings["CampusConnectDB"].ConnectionString; }
        }

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            var js = new JavaScriptSerializer();
            string action = ctx.Request["action"] ?? "";

            try
            {
                switch (action)
                {
                    case "getAll":    GetAll(ctx, js);    break;
                    case "create":    Create(ctx, js);    break;
                    case "update":    Update(ctx, js);    break;
                    case "delete":    Delete(ctx, js);    break;
                    case "togglePin": TogglePin(ctx, js); break;
                    default:
                        ctx.Response.Write(js.Serialize(new { ok = false, error = "Unknown action" }));
                        break;
                }
            }
            catch (Exception ex)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = ex.Message }));
            }
        }

        // ── GET ALL ──────────────────────────────────────────────
        private void GetAll(HttpContext ctx, JavaScriptSerializer js)
        {
            var list = new List<object>();
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                const string sql = @"
                    SELECT a.AnnouncementId, a.Title, a.Content, a.Category,
                           a.ImageUrl, a.Date_Posted, a.LikeCount, a.CommentCount,
                           a.ShareCount, a.IsPinned, u.FullName AS Author
                    FROM   Announcements a
                    JOIN   Users u ON u.UserId = a.UserId
                    ORDER  BY a.IsPinned DESC, a.Date_Posted DESC";

                using (var cmd = new SqlCommand(sql, conn))
                using (var r = cmd.ExecuteReader())
                {
                    while (r.Read())
                    {
                        list.Add(new
                        {
                            id           = r.GetInt32(0),
                            title        = r.GetString(1),
                            content      = r.GetString(2),
                            category     = r.GetString(3),
                            imageUrl     = r.IsDBNull(4) ? "" : r.GetString(4),
                            date         = r.GetDateTime(5).ToString("MMMM dd, yyyy"),
                            likeCount    = r.GetInt32(6),
                            commentCount = r.GetInt32(7),
                            shareCount   = r.GetInt32(8),
                            isPinned     = r.GetBoolean(9),
                            author       = r.GetString(10)
                        });
                    }
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true, data = list }));
        }

        // ── CREATE ───────────────────────────────────────────────
        private void Create(HttpContext ctx, JavaScriptSerializer js)
        {
            bool isLoggedIn = ctx.Session["IsLoggedIn"] is bool b && b;
            string role   = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString() : "(null)";
            string userId = ctx.Session["UserId"] != null ? ctx.Session["UserId"].ToString() : "(null)";

            if (!isLoggedIn || !string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase))
            {
                ctx.Response.Write(js.Serialize(new
                {
                    ok = false,
                    error = "Unauthorized — IsLoggedIn=" + isLoggedIn + ", Role=" + role + ", UserId=" + userId
                }));
                return;
            }

            // Handle FormData (file upload)
            string title = ctx.Request.Form["title"] != null ? ctx.Request.Form["title"].Trim() : "";
            string content = ctx.Request.Form["content"] != null ? ctx.Request.Form["content"].Trim() : "";
            string cat = ctx.Request.Form["category"] != null ? ctx.Request.Form["category"].Trim() : "General";
            string imgUrl = "";

            // Handle file upload
            if (ctx.Request.Files.Count > 0 && ctx.Request.Files["imageFile"] != null)
            {
                var file = ctx.Request.Files["imageFile"];
                if (file.ContentLength > 0)
                {
                    // Create uploads directory if it doesn't exist
                    string uploadsDir = ctx.Server.MapPath("~/uploads/announcements/");
                    if (!System.IO.Directory.Exists(uploadsDir))
                    {
                        System.IO.Directory.CreateDirectory(uploadsDir);
                    }

                    // Generate unique filename
                    string fileExt = System.IO.Path.GetExtension(file.FileName);
                    string fileName = Guid.NewGuid().ToString() + fileExt;
                    string filePath = System.IO.Path.Combine(uploadsDir, fileName);

                    // Save file
                    file.SaveAs(filePath);

                    // Store relative URL in database
                    imgUrl = "uploads/announcements/" + fileName;
                }
            }

            int uid = Convert.ToInt32(ctx.Session["UserId"]);

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(content))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Title and content are required" }));
                return;
            }

            int newId;
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                const string sql = @"
                    INSERT INTO Announcements (UserId, Title, Content, Category, ImageUrl)
                    OUTPUT INSERTED.AnnouncementId
                    VALUES (@UserId, @Title, @Content, @Category, @ImageUrl)";

                using (var cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId",   uid);
                    cmd.Parameters.AddWithValue("@Title",    title);
                    cmd.Parameters.AddWithValue("@Content",  content);
                    cmd.Parameters.AddWithValue("@Category", cat);
                    cmd.Parameters.AddWithValue("@ImageUrl", string.IsNullOrEmpty(imgUrl) ? (object)DBNull.Value : imgUrl);
                    newId = (int)cmd.ExecuteScalar();
                }

                // Notify all students about the new announcement
                string notifMsg = $"📢 New announcement: \"{title}\"";
                NotificationHandler.NotifyAllStudents(conn, notifMsg);
            }
            ctx.Response.Write(js.Serialize(new { ok = true, id = newId }));
        }

        // ── UPDATE ───────────────────────────────────────────────
        private void Update(HttpContext ctx, JavaScriptSerializer js)
        {
            bool isLoggedIn = ctx.Session["IsLoggedIn"] is bool b && b;
            string role = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString() : "(null)";

            if (!isLoggedIn || !string.Equals(role, "Admin", StringComparison.OrdinalIgnoreCase))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            int announcementId = Convert.ToInt32(ctx.Request["id"]);
            string title = ctx.Request.Form["title"] != null ? ctx.Request.Form["title"].Trim() : "";
            string content = ctx.Request.Form["content"] != null ? ctx.Request.Form["content"].Trim() : "";
            string cat = ctx.Request.Form["category"] != null ? ctx.Request.Form["category"].Trim() : "General";
            string imgUrl = null;

            // Handle file upload
            if (ctx.Request.Files.Count > 0 && ctx.Request.Files["imageFile"] != null)
            {
                var file = ctx.Request.Files["imageFile"];
                if (file.ContentLength > 0)
                {
                    string uploadsDir = ctx.Server.MapPath("~/uploads/announcements/");
                    if (!System.IO.Directory.Exists(uploadsDir))
                    {
                        System.IO.Directory.CreateDirectory(uploadsDir);
                    }

                    string fileExt = System.IO.Path.GetExtension(file.FileName);
                    string fileName = Guid.NewGuid().ToString() + fileExt;
                    string filePath = System.IO.Path.Combine(uploadsDir, fileName);

                    file.SaveAs(filePath);
                    imgUrl = "uploads/announcements/" + fileName;
                }
            }

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(content))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Title and content are required" }));
                return;
            }

            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                
                string sql;
                if (imgUrl != null)
                {
                    // Update with new image
                    sql = @"UPDATE Announcements 
                            SET Title = @Title, Content = @Content, Category = @Category, ImageUrl = @ImageUrl
                            WHERE AnnouncementId = @Id";
                }
                else
                {
                    // Update without changing image
                    sql = @"UPDATE Announcements 
                            SET Title = @Title, Content = @Content, Category = @Category
                            WHERE AnnouncementId = @Id";
                }

                using (var cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", announcementId);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Content", content);
                    cmd.Parameters.AddWithValue("@Category", cat);
                    if (imgUrl != null)
                    {
                        cmd.Parameters.AddWithValue("@ImageUrl", imgUrl);
                    }
                    cmd.ExecuteNonQuery();
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        // ── DELETE ───────────────────────────────────────────────
        private void Delete(HttpContext ctx, JavaScriptSerializer js)
        {
            if (!(ctx.Session["IsLoggedIn"] is bool b && b) ||
                !string.Equals(ctx.Session["Role"] != null ? ctx.Session["Role"].ToString() : "", "Admin", StringComparison.OrdinalIgnoreCase))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            int id = Convert.ToInt32(ctx.Request["id"]);
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                foreach (var tbl in new[] { "Comments", "UserLikes" })
                {
                    using (var cmd = new SqlCommand("DELETE FROM " + tbl + " WHERE AnnouncementId = @Id", conn))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        cmd.ExecuteNonQuery();
                    }
                }
                using (var cmd = new SqlCommand("DELETE FROM Announcements WHERE AnnouncementId = @Id", conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.ExecuteNonQuery();
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        // ── TOGGLE PIN ───────────────────────────────────────────
        private void TogglePin(HttpContext ctx, JavaScriptSerializer js)
        {
            if (!(ctx.Session["IsLoggedIn"] is bool b && b) ||
                !string.Equals(ctx.Session["Role"] != null ? ctx.Session["Role"].ToString() : "", "Admin", StringComparison.OrdinalIgnoreCase))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            int id = Convert.ToInt32(ctx.Request["id"]);
            bool newPinState;
            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();
                using (var cmd = new SqlCommand(
                    "UPDATE Announcements SET IsPinned = ~IsPinned WHERE AnnouncementId = @Id; " +
                    "SELECT IsPinned FROM Announcements WHERE AnnouncementId = @Id", conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    newPinState = (bool)cmd.ExecuteScalar();
                }
            }
            ctx.Response.Write(js.Serialize(new { ok = true, isPinned = newPinState }));
        }

        public bool IsReusable { get { return false; } }
    }
}
