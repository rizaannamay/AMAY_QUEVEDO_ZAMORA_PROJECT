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
        private static readonly string ConnStr =
            @"Data Source=LAPTOP-GPJQLLD4\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;";

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            var js = new JavaScriptSerializer();
            js.MaxJsonLength = int.MaxValue;
            string action = ctx.Request["action"] ?? "";

            try
            {
                switch (action)
                {
                    case "getAll": GetAll(ctx, js); break;
                    case "create": Create(ctx, js); break;
                    case "update": Update(ctx, js); break;
                    case "delete": Delete(ctx, js); break;
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

        private void GetAll(HttpContext ctx, JavaScriptSerializer js)
        {
            var list = new List<object>();
            string category = ctx.Request["category"];
            string date = ctx.Request["date"];
            bool filterCat = !string.IsNullOrEmpty(category) && category != "All";
            bool filterDate = !string.IsNullOrEmpty(date);

            var likedIds = new System.Collections.Generic.HashSet<int>();
            int currentUserId = ctx.Session["UserId"] != null ? Convert.ToInt32(ctx.Session["UserId"]) : 0;

            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();

                if (currentUserId > 0)
                {
                    using (var likeCmd = new SqlCommand("SELECT AnnouncementId FROM UserLikes WHERE UserId = @uid", con))
                    {
                        likeCmd.Parameters.AddWithValue("@uid", currentUserId);
                        using (var lr = likeCmd.ExecuteReader())
                            while (lr.Read())
                                likedIds.Add(Convert.ToInt32(lr["AnnouncementId"]));
                    }
                }

                string sql = "SELECT a.AnnouncementId, a.Title, a.Content, a.Category, a.ImageUrl, a.Date_Posted, " +
                             "(SELECT COUNT(*) FROM UserLikes  ul WHERE ul.AnnouncementId = a.AnnouncementId) AS LikeCount, " +
                             "(SELECT COUNT(*) FROM Comments   c  WHERE c.AnnouncementId  = a.AnnouncementId) AS CommentCount, " +
                             "a.ShareCount, a.IsPinned, u.Username, u.FullName, " +
                             "ISNULL(u.ProfileImage, '') AS AuthorImage " +
                             "FROM Announcements a JOIN Users u ON u.UserId = a.UserId";

                if (filterCat) sql += " WHERE a.Category = @cat";
                if (filterDate) sql += (filterCat ? " AND" : " WHERE") + " CAST(a.Date_Posted AS DATE) = @date";
                sql += " ORDER BY a.IsPinned DESC, a.Date_Posted DESC";

                using (var cmd = new SqlCommand(sql, con))
                {
                    if (filterCat) cmd.Parameters.AddWithValue("@cat", category);
                    if (filterDate) cmd.Parameters.AddWithValue("@date", date);

                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            int annId = Convert.ToInt32(dr["AnnouncementId"]);
                            list.Add(new
                            {
                                id = annId,
                                title = dr["Title"].ToString(),
                                content = dr["Content"].ToString(),
                                category = dr["Category"].ToString(),
                                imageUrl = dr["ImageUrl"] != DBNull.Value ? dr["ImageUrl"].ToString() : "",
                                date = Convert.ToDateTime(dr["Date_Posted"]).ToString("yyyy-MM-ddTHH:mm:ss"),
                                likeCount = Convert.ToInt32(dr["LikeCount"]),
                                commentCount = Convert.ToInt32(dr["CommentCount"]),
                                shareCount = Convert.ToInt32(dr["ShareCount"]),
                                isPinned = Convert.ToBoolean(dr["IsPinned"]),
                                author = dr["Username"].ToString(),
                                authorFullName = dr["FullName"].ToString(),
                                authorImage = dr["AuthorImage"].ToString(),
                                userLiked = likedIds.Contains(annId)
                            });
                        }
                    }
                }
            }

            ctx.Response.Write(js.Serialize(new { ok = true, data = list }));
        }

        // ── Helper: save all uploaded files and return comma-separated URLs ──
        private string SaveUploadedFiles(HttpContext ctx)
        {
            var urls = new System.Collections.Generic.List<string>();
            string uploadsDir = ctx.Server.MapPath("~/uploads/announcements/");
            if (!System.IO.Directory.Exists(uploadsDir))
                System.IO.Directory.CreateDirectory(uploadsDir);

            var allowedImageExts = new System.Collections.Generic.HashSet<string>(StringComparer.OrdinalIgnoreCase)
                { ".jpg", ".jpeg", ".png", ".gif", ".webp", ".bmp" };
            var allowedVideoExts = new System.Collections.Generic.HashSet<string>(StringComparer.OrdinalIgnoreCase)
                { ".mp4", ".webm", ".ogg", ".mov", ".avi" };
            var allowedAttachExts = new System.Collections.Generic.HashSet<string>(StringComparer.OrdinalIgnoreCase)
                { ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".txt", ".zip" };

            for (int i = 0; i < ctx.Request.Files.Count; i++)
            {
                var file = ctx.Request.Files[i];
                if (file == null || file.ContentLength == 0) continue;

                string ext = System.IO.Path.GetExtension(file.FileName).ToLower();
                bool allowed = allowedImageExts.Contains(ext) || allowedVideoExts.Contains(ext) || allowedAttachExts.Contains(ext);
                if (!allowed) continue;

                string fileName = Guid.NewGuid().ToString() + ext;
                file.SaveAs(System.IO.Path.Combine(uploadsDir, fileName));
                urls.Add("uploads/announcements/" + fileName);
            }

            return string.Join(",", urls);
        }

        // ── INSERT ──────────────────────────────────────────────────────────
        private void Create(HttpContext ctx, JavaScriptSerializer js)
        {
            bool isLoggedIn = ctx.Session["IsLoggedIn"] != null && (bool)ctx.Session["IsLoggedIn"];
            string sessionRole = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString().Trim() : "";

            if (!isLoggedIn || !sessionRole.Equals("Admin", StringComparison.OrdinalIgnoreCase))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized (role=" + sessionRole + ", loggedIn=" + isLoggedIn + ")" }));
                return;
            }

            string title = ctx.Request.Form["title"] != null ? ctx.Request.Form["title"].Trim() : "";
            string content = ctx.Request.Form["content"] != null ? ctx.Request.Form["content"].Trim() : "";
            string cat = ctx.Request.Form["category"] != null ? ctx.Request.Form["category"].Trim() : "General";
            int uid = Convert.ToInt32(ctx.Session["UserId"]);
            string mediaUrls = SaveUploadedFiles(ctx);

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(content))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Title and content are required" }));
                return;
            }

            int newId = 0;
            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();

                // Insert the announcement and get the new ID
                using (var cmd = new SqlCommand(
                    "INSERT INTO Announcements (UserId, Title, Content, Category, ImageUrl) " +
                    "OUTPUT INSERTED.AnnouncementId VALUES (@uid, @title, @content, @cat, @img)", con))
                {
                    cmd.Parameters.AddWithValue("@uid", uid);
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Parameters.AddWithValue("@content", content);
                    cmd.Parameters.AddWithValue("@cat", cat);
                    cmd.Parameters.AddWithValue("@img", mediaUrls);
                    newId = (int)cmd.ExecuteScalar();
                }

                // ✅ Notify all students — now includes AnnouncementId so clicking works
                using (var notifCmd = new SqlCommand(
                    "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                    "SELECT UserId, @aid, @msg, 0, GETDATE() FROM Users WHERE Role = 'Student'", con))
                {
                    notifCmd.Parameters.AddWithValue("@aid", newId);
                    notifCmd.Parameters.AddWithValue("@msg", "New announcement: " + title);
                    notifCmd.ExecuteNonQuery();
                }
            }

            ctx.Response.Write(js.Serialize(new { ok = true, id = newId }));
        }

        private void Update(HttpContext ctx, JavaScriptSerializer js)
        {
            bool isLoggedIn = ctx.Session["IsLoggedIn"] != null && (bool)ctx.Session["IsLoggedIn"];
            string sessionRole = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString().Trim() : "";

            if (!isLoggedIn || !sessionRole.Equals("Admin", StringComparison.OrdinalIgnoreCase))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized (role=" + sessionRole + ")" }));
                return;
            }

            int id = Convert.ToInt32(ctx.Request["id"]);
            string title = ctx.Request.Form["title"] != null ? ctx.Request.Form["title"].Trim() : "";
            string content = ctx.Request.Form["content"] != null ? ctx.Request.Form["content"].Trim() : "";
            string cat = ctx.Request.Form["category"] != null ? ctx.Request.Form["category"].Trim() : "General";

            string keepUrls = ctx.Request.Form["keepUrls"] ?? "";
            string newMediaUrls = SaveUploadedFiles(ctx);

            var finalParts = new List<string>();
            if (!string.IsNullOrEmpty(keepUrls))
                foreach (var u in keepUrls.Split(','))
                    if (!string.IsNullOrEmpty(u.Trim())) finalParts.Add(u.Trim());
            if (!string.IsNullOrEmpty(newMediaUrls))
                foreach (var u in newMediaUrls.Split(','))
                    if (!string.IsNullOrEmpty(u.Trim())) finalParts.Add(u.Trim());

            string finalMediaUrls = string.Join(",", finalParts);

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(content))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Title and content are required" }));
                return;
            }

            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();
                using (var cmd = new SqlCommand(
                    "UPDATE Announcements SET Title=@title, Content=@content, Category=@cat, ImageUrl=@img WHERE AnnouncementId=@id", con))
                {
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Parameters.AddWithValue("@content", content);
                    cmd.Parameters.AddWithValue("@cat", cat);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.Parameters.AddWithValue("@img", finalMediaUrls);
                    cmd.ExecuteNonQuery();
                }
            }

            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        private void Delete(HttpContext ctx, JavaScriptSerializer js)
        {
            bool isLoggedIn = ctx.Session["IsLoggedIn"] != null && (bool)ctx.Session["IsLoggedIn"];
            string sessionRole = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString().Trim() : "";

            if (!isLoggedIn || !sessionRole.Equals("Admin", StringComparison.OrdinalIgnoreCase))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            int id = Convert.ToInt32(ctx.Request["id"]);
            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();
                using (var c1 = new SqlCommand("DELETE FROM Comments      WHERE AnnouncementId=@id", con))
                { c1.Parameters.AddWithValue("@id", id); c1.ExecuteNonQuery(); }

                using (var c2 = new SqlCommand("DELETE FROM UserLikes     WHERE AnnouncementId=@id", con))
                { c2.Parameters.AddWithValue("@id", id); c2.ExecuteNonQuery(); }

                using (var c3 = new SqlCommand("DELETE FROM Announcements WHERE AnnouncementId=@id", con))
                { c3.Parameters.AddWithValue("@id", id); c3.ExecuteNonQuery(); }
            }

            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        private void TogglePin(HttpContext ctx, JavaScriptSerializer js)
        {
            if (ctx.Session["Role"] == null || ctx.Session["Role"].ToString() != "Admin")
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Only admins can pin." }));
                return;
            }

            int id = Convert.ToInt32(ctx.Request["id"]);
            bool current;

            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();

                using (var chk = new SqlCommand("SELECT IsPinned FROM Announcements WHERE AnnouncementId=@id", con))
                {
                    chk.Parameters.AddWithValue("@id", id);
                    current = Convert.ToBoolean(chk.ExecuteScalar());
                }

                bool newPinState = !current;

                using (var upd = new SqlCommand("UPDATE Announcements SET IsPinned=@v WHERE AnnouncementId=@id", con))
                {
                    upd.Parameters.AddWithValue("@v", newPinState ? 1 : 0);
                    upd.Parameters.AddWithValue("@id", id);
                    upd.ExecuteNonQuery();
                }

                // ✅ Notify all students when a post is pinned (not when unpinned)
                if (newPinState)
                {
                    string postTitle = "";
                    using (var titleCmd = new SqlCommand("SELECT Title FROM Announcements WHERE AnnouncementId=@id", con))
                    {
                        titleCmd.Parameters.AddWithValue("@id", id);
                        var result = titleCmd.ExecuteScalar();
                        if (result != null) postTitle = result.ToString();
                    }

                    using (var notifCmd = new SqlCommand(
                        "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                        "SELECT UserId, @aid, @msg, 0, GETDATE() FROM Users WHERE Role = 'Student'", con))
                    {
                        notifCmd.Parameters.AddWithValue("@aid", id);
                        notifCmd.Parameters.AddWithValue("@msg", "📌 Pinned announcement: " + postTitle);
                        notifCmd.ExecuteNonQuery();
                    }
                }

                ctx.Response.Write(js.Serialize(new { ok = true, isPinned = newPinState }));
            }
        }

        public bool IsReusable { get { return false; } }
    }
}
