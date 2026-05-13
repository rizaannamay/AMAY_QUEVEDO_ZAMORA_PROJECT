using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class AnnouncementHandler : IHttpHandler, IRequiresSessionState
    {
        private static readonly string ConnStr =
            @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CampusAnnouncementPortalDB;User ID=CampusAnnouncementPortall;Password=campus123;";

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
                    case "getById": GetById(ctx, js); break;
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
            string sessionRole = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString() : "";
            bool isAdmin   = string.Equals(sessionRole, "Admin",   StringComparison.OrdinalIgnoreCase);
            bool isTeacher = string.Equals(sessionRole, "Teacher", StringComparison.OrdinalIgnoreCase);

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

                // Build WHERE clause based on role:
                // Admin    → sees only Approved posts on the main board
                //            (Pending/Rejected are handled in the Approval Panel via ApprovalHandler)
                // Teacher  → sees only Approved posts (own pending posts are NOT shown on the board)
                // Student  → sees only Approved posts
                string statusFilter = " AND ISNULL(a.Status,'Approved') = 'Approved'";

                // IsPinned meaning differs by role:
                //   Admin   → global IsPinned flag on the Announcements row
                //   Teacher/Student → personal pin row in UserPins for this user
                // We LEFT JOIN UserPins so we can compute the correct value in one query.
                string sql = "SELECT a.AnnouncementId, a.Title, a.Content, a.Category, a.ImageUrl, a.Date_Posted, " +
                             "ISNULL(a.Status,'Approved') AS Status, " +
                             "(SELECT COUNT(*) FROM UserLikes ul WHERE ul.AnnouncementId = a.AnnouncementId) AS LikeCount, " +
                             "(SELECT COUNT(*) FROM Comments  c  WHERE c.AnnouncementId  = a.AnnouncementId) AS CommentCount, " +
                             "a.ShareCount, a.IsPinned, " +
                             "CASE WHEN up.AnnouncementId IS NOT NULL THEN 1 ELSE 0 END AS UserIsPinned, " +
                             "u.Username, u.FullName, " +
                             "ISNULL(u.ProfileImage, '') AS AuthorImage " +
                             "FROM Announcements a JOIN Users u ON u.UserId = a.UserId " +
                             "LEFT JOIN UserPins up ON up.AnnouncementId = a.AnnouncementId AND up.UserId = @currentUid " +
                             "WHERE 1=1" + statusFilter;

                if (filterCat) sql += " AND a.Category = @cat";
                if (filterDate) sql += " AND CAST(a.Date_Posted AS DATE) = @date";
                sql += " ORDER BY a.IsPinned DESC, a.Date_Posted DESC";

                using (var cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@currentUid", currentUserId > 0 ? (object)currentUserId : DBNull.Value);
                    if (filterCat)  cmd.Parameters.AddWithValue("@cat",  category);
                    if (filterDate) cmd.Parameters.AddWithValue("@date", date);

                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            int annId = Convert.ToInt32(dr["AnnouncementId"]);
                            // Admins use the global IsPinned flag; everyone else uses their personal UserPins row.
                            bool isPinned = isAdmin
                                ? Convert.ToBoolean(dr["IsPinned"])
                                : Convert.ToInt32(dr["UserIsPinned"]) == 1;
                            list.Add(new
                            {
                                id           = annId,
                                title        = dr["Title"].ToString(),
                                content      = dr["Content"].ToString(),
                                category     = dr["Category"].ToString(),
                                imageUrl     = dr["ImageUrl"] != DBNull.Value ? dr["ImageUrl"].ToString() : "",
                                date         = Convert.ToDateTime(dr["Date_Posted"]).ToString("yyyy-MM-ddTHH:mm:ss"),
                                status       = dr["Status"].ToString(),
                                likeCount    = Convert.ToInt32(dr["LikeCount"]),
                                commentCount = Convert.ToInt32(dr["CommentCount"]),
                                shareCount   = Convert.ToInt32(dr["ShareCount"]),
                                isPinned     = isPinned,
                                author       = dr["Username"].ToString(),
                                authorFullName = dr["FullName"].ToString(),
                                authorImage  = dr["AuthorImage"].ToString(),
                                userLiked    = likedIds.Contains(annId)
                            });
                        }
                    }
                }
            }

            ctx.Response.Write(js.Serialize(new { ok = true, data = list }));
        }

        // ── GET SINGLE POST (owner only, any status) ────────────────────────
        private void GetById(HttpContext ctx, JavaScriptSerializer js)
        {
            bool isLoggedIn = ctx.Session["IsLoggedIn"] != null && (bool)ctx.Session["IsLoggedIn"];
            int currentUserId = ctx.Session["UserId"] != null ? Convert.ToInt32(ctx.Session["UserId"]) : 0;
            string sessionRole = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString() : "";
            bool isAdmin = string.Equals(sessionRole, "Admin", StringComparison.OrdinalIgnoreCase);

            if (!isLoggedIn)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            int id;
            if (!int.TryParse(ctx.Request["id"], out id))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Invalid ID" }));
                return;
            }

            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();
                // Owner or admin can fetch any status; others cannot
                string ownerCheck = isAdmin ? "" : " AND a.UserId = @uid";
                string sql = "SELECT a.AnnouncementId, a.Title, ISNULL(a.Status,'Approved') AS Status, " +
                             "a.RejectionReason FROM Announcements a WHERE a.AnnouncementId = @id" + ownerCheck;

                using (var cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    if (!isAdmin) cmd.Parameters.AddWithValue("@uid", currentUserId);
                    using (var dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            ctx.Response.Write(js.Serialize(new
                            {
                                ok = true,
                                id = Convert.ToInt32(dr["AnnouncementId"]),
                                title = dr["Title"].ToString(),
                                status = dr["Status"].ToString(),
                                rejectionReason = dr["RejectionReason"] != DBNull.Value ? dr["RejectionReason"].ToString() : ""
                            }));
                        }
                        else
                        {
                            ctx.Response.Write(js.Serialize(new { ok = false, error = "Not found" }));
                        }
                    }
                }
            }
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
            bool isAdmin   = string.Equals(sessionRole, "Admin",   StringComparison.OrdinalIgnoreCase);
            bool isTeacher = string.Equals(sessionRole, "Teacher", StringComparison.OrdinalIgnoreCase);

            if (!isLoggedIn || (!isAdmin && !isTeacher))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            string title   = ctx.Request.Form["title"]    != null ? ctx.Request.Form["title"].Trim()    : "";
            string content = ctx.Request.Form["content"]  != null ? ctx.Request.Form["content"].Trim()  : "";
            string cat     = ctx.Request.Form["category"] != null ? ctx.Request.Form["category"].Trim() : "General";
            int uid        = Convert.ToInt32(ctx.Session["UserId"]);
            string mediaUrls = SaveUploadedFiles(ctx);

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(content))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Title and content are required" }));
                return;
            }

            // Admin posts go live immediately; Teacher posts need approval
            string postStatus = isAdmin ? "Approved" : "Pending";

            int newId = 0;
            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();

                using (var cmd = new SqlCommand(
                    "INSERT INTO Announcements (UserId, Title, Content, Category, ImageUrl, Status) " +
                    "OUTPUT INSERTED.AnnouncementId VALUES (@uid, @title, @content, @cat, @img, @status)", con))
                {
                    cmd.Parameters.AddWithValue("@uid",    uid);
                    cmd.Parameters.AddWithValue("@title",  title);
                    cmd.Parameters.AddWithValue("@content",content);
                    cmd.Parameters.AddWithValue("@cat",    cat);
                    cmd.Parameters.AddWithValue("@img",    mediaUrls);
                    cmd.Parameters.AddWithValue("@status", postStatus);
                    newId = (int)cmd.ExecuteScalar();
                }

                if (isAdmin)
                {
                    // Admin post: notify all students immediately
                    using (var notifCmd = new SqlCommand(
                        "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                        "SELECT UserId, @aid, @msg, 0, GETDATE() FROM Users WHERE Role = 'Student'", con))
                    {
                        notifCmd.Parameters.AddWithValue("@aid", newId);
                        notifCmd.Parameters.AddWithValue("@msg", "New announcement: " + title);
                        notifCmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    // Teacher post: notify admin that a post needs review
                    using (var notifCmd = new SqlCommand(
                        "INSERT INTO Notifications (UserId, AnnouncementId, Message, IsRead, CreatedDate) " +
                        "SELECT UserId, @aid, @msg, 0, GETDATE() FROM Users WHERE Role = 'Admin'", con))
                    {
                        notifCmd.Parameters.AddWithValue("@aid", newId);
                        notifCmd.Parameters.AddWithValue("@msg", "New post pending approval: " + title);
                        notifCmd.ExecuteNonQuery();
                    }
                }
            }

            string responseMsg = isTeacher
                ? "Your post has been submitted and is pending admin approval."
                : "";

            ctx.Response.Write(js.Serialize(new { ok = true, id = newId, status = postStatus, message = responseMsg }));

            // Send email only for approved (admin) posts
            if (isAdmin)
                try { SendAnnouncementEmails(title, content, cat); } catch { }
        }

        private void SendAnnouncementEmails(string title, string content, string category)
        {
            const string fromEmail   = "rizaannamay5@gmail.com";
            const string appPassword = "kwfiqizzglqhvvde";

            var studentEmails = new List<string>();
            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();
                using (var cmd = new SqlCommand(
                    "SELECT Email FROM Users WHERE Role = 'Student' AND Email IS NOT NULL AND Email <> ''", con))
                using (var dr = cmd.ExecuteReader())
                    while (dr.Read())
                        studentEmails.Add(dr["Email"].ToString());
            }

            if (studentEmails.Count == 0) return;

            string subject = "📢 New Announcement: " + title;
            string body = string.Format(@"
<div style='font-family:Segoe UI,Arial,sans-serif;max-width:560px;margin:auto;border:1px solid #e5e7eb;border-radius:16px;overflow:hidden;'>

  <!-- Header -->
  <div style='background:linear-gradient(135deg,#c9920a,#F8E473);padding:28px 32px;text-align:center;'>
    <h1 style='margin:0;font-size:22px;color:#1a1a00;letter-spacing:0.5px;'>📢 New Announcement</h1>
    <p style='margin:6px 0 0;font-size:13px;color:#3a2e00;'>Campus Announcement Portal — CTU</p>
  </div>

  <!-- Body -->
  <div style='padding:28px 32px;background:#ffffff;'>
    <table style='width:100%;border-collapse:collapse;margin-bottom:20px;'>
      <tr>
        <td style='padding:10px 14px;background:#fefce8;border-radius:8px;border-left:4px solid #F8E473;'>
          <div style='font-size:11px;color:#92400e;font-weight:700;text-transform:uppercase;letter-spacing:0.08em;margin-bottom:4px;'>Title</div>
          <div style='font-size:16px;font-weight:700;color:#1a1a00;'>{0}</div>
        </td>
      </tr>
    </table>

    <table style='width:100%;border-collapse:collapse;margin-bottom:20px;'>
      <tr>
        <td style='padding:10px 14px;background:#f9fafb;border-radius:8px;border-left:4px solid #d1d5db;'>
          <div style='font-size:11px;color:#6b7280;font-weight:700;text-transform:uppercase;letter-spacing:0.08em;margin-bottom:4px;'>Category</div>
          <div style='font-size:14px;color:#374151;'>{1}</div>
        </td>
      </tr>
    </table>

    <table style='width:100%;border-collapse:collapse;margin-bottom:28px;'>
      <tr>
        <td style='padding:14px;background:#f9fafb;border-radius:8px;border-left:4px solid #d1d5db;'>
          <div style='font-size:11px;color:#6b7280;font-weight:700;text-transform:uppercase;letter-spacing:0.08em;margin-bottom:8px;'>Message</div>
          <div style='font-size:14px;color:#374151;line-height:1.7;'>{2}</div>
        </td>
      </tr>
    </table>

    <p style='font-size:12px;color:#9ca3af;text-align:center;margin:0;'>
      You received this because you are registered as a student at CTU Campus Connect.
    </p>
  </div>

  <!-- Footer -->
  <div style='background:#fefce8;padding:14px 32px;text-align:center;border-top:1px solid #fde68a;'>
    <p style='margin:0;font-size:11px;color:#92400e;'>Cebu Technological University — Campus Announcement Portal</p>
  </div>

</div>", title, category, content.Replace("\n", "<br/>"));

            using (var smtp = new SmtpClient("smtp.gmail.com", 587))
            {
                smtp.EnableSsl = true;
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new NetworkCredential(fromEmail, appPassword);

                foreach (var email in studentEmails)
                {
                    try
                    {
                        using (var msg = new MailMessage(fromEmail, email, subject, body))
                        {
                            msg.IsBodyHtml = true;
                            smtp.Send(msg);
                        }
                    }
                    catch { /* skip failed individual email */ }
                }
            }
        }

        private void Update(HttpContext ctx, JavaScriptSerializer js)
        {
            bool isLoggedIn = ctx.Session["IsLoggedIn"] != null && (bool)ctx.Session["IsLoggedIn"];
            string sessionRole = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString().Trim() : "";
            bool isAdmin   = string.Equals(sessionRole, "Admin",   StringComparison.OrdinalIgnoreCase);
            bool isTeacher = string.Equals(sessionRole, "Teacher", StringComparison.OrdinalIgnoreCase);
            int currentUserId = ctx.Session["UserId"] != null ? Convert.ToInt32(ctx.Session["UserId"]) : 0;

            if (!isLoggedIn || (!isAdmin && !isTeacher))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            int id      = Convert.ToInt32(ctx.Request["id"]);
            string title   = ctx.Request.Form["title"]    != null ? ctx.Request.Form["title"].Trim()    : "";
            string content = ctx.Request.Form["content"]  != null ? ctx.Request.Form["content"].Trim()  : "";
            string cat     = ctx.Request.Form["category"] != null ? ctx.Request.Form["category"].Trim() : "General";

            string keepUrls    = ctx.Request.Form["keepUrls"] ?? "";
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

                // Teachers can only edit their own posts; editing resets to Pending
                string sql = isAdmin
                    ? "UPDATE Announcements SET Title=@title, Content=@content, Category=@cat, ImageUrl=@img WHERE AnnouncementId=@id"
                    : "UPDATE Announcements SET Title=@title, Content=@content, Category=@cat, ImageUrl=@img, Status='Pending' WHERE AnnouncementId=@id AND UserId=@uid";

                using (var cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@title",   title);
                    cmd.Parameters.AddWithValue("@content", content);
                    cmd.Parameters.AddWithValue("@cat",     cat);
                    cmd.Parameters.AddWithValue("@id",      id);
                    cmd.Parameters.AddWithValue("@img",     finalMediaUrls);
                    if (!isAdmin) cmd.Parameters.AddWithValue("@uid", currentUserId);
                    int rows = cmd.ExecuteNonQuery();
                    if (rows == 0 && !isAdmin)
                    {
                        ctx.Response.Write(js.Serialize(new { ok = false, error = "Not authorized to edit this post." }));
                        return;
                    }
                }
            }

            ctx.Response.Write(js.Serialize(new { ok = true }));
        }

        private void Delete(HttpContext ctx, JavaScriptSerializer js)
        {
            bool isLoggedIn = ctx.Session["IsLoggedIn"] != null && (bool)ctx.Session["IsLoggedIn"];
            string sessionRole = ctx.Session["Role"] != null ? ctx.Session["Role"].ToString().Trim() : "";
            bool isAdmin   = string.Equals(sessionRole, "Admin",   StringComparison.OrdinalIgnoreCase);
            bool isTeacher = string.Equals(sessionRole, "Teacher", StringComparison.OrdinalIgnoreCase);
            int currentUserId = ctx.Session["UserId"] != null ? Convert.ToInt32(ctx.Session["UserId"]) : 0;

            if (!isLoggedIn || (!isAdmin && !isTeacher))
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Unauthorized" }));
                return;
            }

            int id = Convert.ToInt32(ctx.Request["id"]);

            using (var con = new SqlConnection(ConnStr))
            {
                con.Open();

                // Teachers can only delete their own posts
                if (!isAdmin)
                {
                    using (var chk = new SqlCommand(
                        "SELECT COUNT(1) FROM Announcements WHERE AnnouncementId=@id AND UserId=@uid", con))
                    {
                        chk.Parameters.AddWithValue("@id",  id);
                        chk.Parameters.AddWithValue("@uid", currentUserId);
                        if ((int)chk.ExecuteScalar() == 0)
                        {
                            ctx.Response.Write(js.Serialize(new { ok = false, error = "Not authorized to delete this post." }));
                            return;
                        }
                    }
                }

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
                        notifCmd.Parameters.AddWithValue("@msg", "Pinned announcement: " + postTitle);
                        notifCmd.ExecuteNonQuery();
                    }
                }

                ctx.Response.Write(js.Serialize(new { ok = true, isPinned = newPinState }));
            }
        }

        public bool IsReusable { get { return false; } }
    }
}
