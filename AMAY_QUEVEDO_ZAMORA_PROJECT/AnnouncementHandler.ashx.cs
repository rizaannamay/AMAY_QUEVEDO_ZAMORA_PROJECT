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
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;");

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
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
        }

        private void GetAll(HttpContext ctx, JavaScriptSerializer js)
        {
            var list = new List<object>();

            string category = ctx.Request["category"];
            string date     = ctx.Request["date"];
            bool filterCat  = !string.IsNullOrEmpty(category) && category != "All";
            bool filterDate = !string.IsNullOrEmpty(date);

            // Get current user's liked post IDs
            var likedIds = new System.Collections.Generic.HashSet<int>();
            int currentUserId = ctx.Session["UserId"] != null ? Convert.ToInt32(ctx.Session["UserId"]) : 0;

            con.Open();

            if (currentUserId > 0)
            {
                using (var likeCmd = new SqlCommand(
                    "SELECT AnnouncementId FROM UserLikes WHERE UserId = @uid", con))
                {
                    likeCmd.Parameters.AddWithValue("@uid", currentUserId);
                    using (var lr = likeCmd.ExecuteReader())
                        while (lr.Read())
                            likedIds.Add(Convert.ToInt32(lr["AnnouncementId"]));
                }
            }

            string sql = "SELECT a.AnnouncementId, a.Title, a.Content, a.Category, a.ImageUrl, a.Date_Posted, " +
                         "a.LikeCount, a.CommentCount, a.ShareCount, a.IsPinned, u.Username, u.FullName, " +
                         "ISNULL(u.ProfileImage, '') AS AuthorImage " +
                         "FROM Announcements a JOIN Users u ON u.UserId = a.UserId";

            if (filterCat)  sql += " WHERE a.Category = @cat";
            if (filterDate) sql += (filterCat ? " AND" : " WHERE") + " CAST(a.Date_Posted AS DATE) = @date";
            sql += " ORDER BY a.IsPinned DESC, a.Date_Posted DESC";

            SqlCommand cmd = new SqlCommand(sql, con);
            if (filterCat)  cmd.Parameters.AddWithValue("@cat",  category);
            if (filterDate) cmd.Parameters.AddWithValue("@date", date);

            SqlDataReader dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                int annId = Convert.ToInt32(dr["AnnouncementId"]);
                list.Add(new
                {
                    id           = annId,
                    title        = dr["Title"].ToString(),
                    content      = dr["Content"].ToString(),
                    category     = dr["Category"].ToString(),
                    imageUrl     = dr["ImageUrl"] != DBNull.Value ? dr["ImageUrl"].ToString() : "",
                    date         = Convert.ToDateTime(dr["Date_Posted"]).ToString("yyyy-MM-ddTHH:mm:ss"),
                    likeCount    = Convert.ToInt32(dr["LikeCount"]),
                    commentCount = Convert.ToInt32(dr["CommentCount"]),
                    shareCount   = Convert.ToInt32(dr["ShareCount"]),
                    isPinned     = Convert.ToBoolean(dr["IsPinned"]),
                    author       = dr["Username"].ToString(),
                    authorFullName = dr["FullName"].ToString(),
                    authorImage  = dr["AuthorImage"].ToString(),
                    userLiked    = likedIds.Contains(annId)
                });
            }
            dr.Close();
            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true, data = list }));
        }

        // ── Query #1 INSERT ──────────────────────────────────────────────────────────────────────────
        private void Create(HttpContext ctx, JavaScriptSerializer js)
        {
            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"] ||
                ctx.Session["Role"].ToString() != "Admin")
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            string title   = ctx.Request.Form["title"]    != null ? ctx.Request.Form["title"].Trim()    : "";
            string content = ctx.Request.Form["content"]  != null ? ctx.Request.Form["content"].Trim()  : "";
            string cat     = ctx.Request.Form["category"] != null ? ctx.Request.Form["category"].Trim() : "General";
            string imgUrl  = "";
            int    uid     = Convert.ToInt32(ctx.Session["UserId"]);

            if (ctx.Request.Files.Count > 0 && ctx.Request.Files["imageFile"] != null)
            {
                var file = ctx.Request.Files["imageFile"];
                if (file.ContentLength > 0)
                {
                    string uploadsDir = ctx.Server.MapPath("~/uploads/announcements/");
                    if (!System.IO.Directory.Exists(uploadsDir))
                        System.IO.Directory.CreateDirectory(uploadsDir);
                    string fileName = Guid.NewGuid().ToString() + System.IO.Path.GetExtension(file.FileName);
                    file.SaveAs(System.IO.Path.Combine(uploadsDir, fileName));
                    imgUrl = "uploads/announcements/" + fileName;
                }
            }

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(content))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Title and content are required" }));
                return;
            }

            con.Open();
            string sql = "INSERT INTO Announcements (UserId, Title, Content, Category, ImageUrl) " +
                         "OUTPUT INSERTED.AnnouncementId VALUES (@uid, @title, @content, @cat, @img)";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@uid",     uid);
            cmd.Parameters.AddWithValue("@title",   title);
            cmd.Parameters.AddWithValue("@content", content);
            cmd.Parameters.AddWithValue("@cat",     cat);
            cmd.Parameters.AddWithValue("@img",     imgUrl);
            int newId = (int)cmd.ExecuteScalar();

            string notifSql = "INSERT INTO Notifications (UserId, Message) SELECT UserId, @msg FROM Users WHERE Role = 'Student'";
            SqlCommand notifCmd = new SqlCommand(notifSql, con);
            notifCmd.Parameters.AddWithValue("@msg", "New announcement: " + title);
            notifCmd.ExecuteNonQuery();
            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true, id = newId }));
        }

        // ── Query #3 UPDATE ──────────────────────────────────────────────────────────────────────────
        private void Update(HttpContext ctx, JavaScriptSerializer js)
        {
            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"] ||
                ctx.Session["Role"].ToString() != "Admin")
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            int    id      = Convert.ToInt32(ctx.Request["id"]);
            string title   = ctx.Request.Form["title"]    != null ? ctx.Request.Form["title"].Trim()    : "";
            string content = ctx.Request.Form["content"]  != null ? ctx.Request.Form["content"].Trim()  : "";
            string cat     = ctx.Request.Form["category"] != null ? ctx.Request.Form["category"].Trim() : "General";
            string imgUrl  = null;

            if (ctx.Request.Files.Count > 0 && ctx.Request.Files["imageFile"] != null)
            {
                var file = ctx.Request.Files["imageFile"];
                if (file.ContentLength > 0)
                {
                    string uploadsDir = ctx.Server.MapPath("~/uploads/announcements/");
                    if (!System.IO.Directory.Exists(uploadsDir))
                        System.IO.Directory.CreateDirectory(uploadsDir);
                    string fileName = Guid.NewGuid().ToString() + System.IO.Path.GetExtension(file.FileName);
                    file.SaveAs(System.IO.Path.Combine(uploadsDir, fileName));
                    imgUrl = "uploads/announcements/" + fileName;
                }
            }

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(content))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Title and content are required" }));
                return;
            }

            con.Open();
            string sql = imgUrl != null
                ? "UPDATE Announcements SET Title=@title, Content=@content, Category=@cat, ImageUrl=@img WHERE AnnouncementId=@id"
                : "UPDATE Announcements SET Title=@title, Content=@content, Category=@cat WHERE AnnouncementId=@id";
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@title",   title);
            cmd.Parameters.AddWithValue("@content", content);
            cmd.Parameters.AddWithValue("@cat",     cat);
            cmd.Parameters.AddWithValue("@id",      id);
            if (imgUrl != null) cmd.Parameters.AddWithValue("@img", imgUrl);
            cmd.ExecuteNonQuery();
            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        // ── Query #4 DELETE ──────────────────────────────────────────────────────────────────────────
        private void Delete(HttpContext ctx, JavaScriptSerializer js)
        {
            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"] ||
                ctx.Session["Role"].ToString() != "Admin")
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            int id = Convert.ToInt32(ctx.Request["id"]);
            con.Open();

            SqlCommand c1 = new SqlCommand("DELETE FROM Comments      WHERE AnnouncementId=@id", con);
            c1.Parameters.AddWithValue("@id", id); c1.ExecuteNonQuery();

            SqlCommand c2 = new SqlCommand("DELETE FROM UserLikes     WHERE AnnouncementId=@id", con);
            c2.Parameters.AddWithValue("@id", id); c2.ExecuteNonQuery();

            SqlCommand c3 = new SqlCommand("DELETE FROM Announcements WHERE AnnouncementId=@id", con);
            c3.Parameters.AddWithValue("@id", id); c3.ExecuteNonQuery();

            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        private void TogglePin(HttpContext ctx, JavaScriptSerializer js)
        {
            // Delegate to UserPinHandler logic — update IsPinned on the Announcements row
            if (ctx.Session["Role"] == null || ctx.Session["Role"].ToString() != "Admin")
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Only admins can pin." }));
                return;
            }
            int id = Convert.ToInt32(ctx.Request["id"]);
            con.Open();
            bool current;
            using (var chk = new SqlCommand("SELECT IsPinned FROM Announcements WHERE AnnouncementId=@id", con))
            {
                chk.Parameters.AddWithValue("@id", id);
                current = Convert.ToBoolean(chk.ExecuteScalar());
            }
            using (var upd = new SqlCommand("UPDATE Announcements SET IsPinned=@v WHERE AnnouncementId=@id", con))
            {
                upd.Parameters.AddWithValue("@v", current ? 0 : 1);
                upd.Parameters.AddWithValue("@id", id);
                upd.ExecuteNonQuery();
            }
            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true, isPinned = !current }));
        }

        public bool IsReusable { get { return false; } }
    }
}
