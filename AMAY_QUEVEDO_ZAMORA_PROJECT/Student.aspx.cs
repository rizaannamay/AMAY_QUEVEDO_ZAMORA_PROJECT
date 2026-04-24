using System;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Collections.Generic;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Student : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("login.aspx");
            }

            if (!IsPostBack)
            {
                LoadUserInfo();
                LoadAnnouncements();
                LoadNotifications();
            }
        }

        // NOTE: database calls removed. Using session values or sample data so the page builds and runs without a DB.
        private void LoadUserInfo()
        {
            try
            {
                // Prefer session values if present; otherwise use sample defaults
                string fullName = Session["FullName"]?.ToString() ?? "John Dela Cruz";
                string email = Session["Email"]?.ToString() ?? "john.delacruz@ctu.edu.ph";
                string role = Session["Role"]?.ToString() ?? "Student";

                // store back to session (keeps existing behavior)
                Session["FullName"] = fullName;
                Session["Email"] = email;
                Session["Role"] = role;

                string fn = HttpUtility.JavaScriptStringEncode(fullName);
                string em = HttpUtility.JavaScriptStringEncode(email);
                string rl = HttpUtility.JavaScriptStringEncode(role);

                string script = "<script>"
                    + "var userName = document.getElementById('userName');"
                    + "var userRole = document.getElementById('userRole');"
                    + "var profileName = document.getElementById('profileName');"
                    + "var profileEmail = document.getElementById('profileEmail');"
                    + "if(userName) userName.innerText = \"" + fn + "\";"
                    + "if(userRole) userRole.innerText = \"" + rl + "\";"
                    + "if(profileName) profileName.innerText = \"" + fn + "\";"
                    + "if(profileEmail) profileEmail.innerText = \"" + em + "\";"
                    + "</script>";

                ClientScript.RegisterStartupScript(this.GetType(), "LoadUser", script);
            }
            catch (Exception ex)
            {
                // keep debug logging so 'ex' is used (removes unused variable warnings)
                System.Diagnostics.Debug.WriteLine("LoadUserInfo Error: " + ex.Message);
            }
        }

        private void LoadAnnouncements()
        {
            try
            {
                // Sample announcements - replace with DB logic later if desired
                var items = new List<Announcement>
                {
                    new Announcement
                    {
                        AnnouncementId = 1,
                        Title = "Final Exam Schedule",
                        Content = "All final examinations will be conducted on May 11-14. Please check department schedules.",
                        Category = "Exam",
                        AuthorName = "Office of the Registrar",
                        CreatedDate = DateTime.Now.AddDays(-2),
                        LikeCount = 24,
                        CommentCount = 5,
                        ShareCount = 3,
                        IsPinned = true
                    },
                    new Announcement
                    {
                        AnnouncementId = 2,
                        Title = "Library Hours Extended",
                        Content = "Library extended hours during exam week: 7:00 AM - Midnight.",
                        Category = "Event",
                        AuthorName = "Student Affairs",
                        CreatedDate = DateTime.Now.AddDays(-10),
                        LikeCount = 8,
                        CommentCount = 2,
                        ShareCount = 1,
                        IsPinned = false
                    }
                };

                var sb = new StringBuilder();
                foreach (var a in items)
                {
                    string categoryClass = "";
                    string categoryIcon = "fas fa-bullhorn";
                    switch ((a.Category ?? "").ToLower())
                    {
                        case "exam":
                            categoryClass = "post-category-exam";
                            categoryIcon = "fas fa-file-alt";
                            break;
                        case "suspension":
                            categoryClass = "post-category-suspension";
                            categoryIcon = "fas fa-cloud-rain";
                            break;
                        case "event":
                            categoryClass = "post-category-event";
                            categoryIcon = "fas fa-calendar-alt";
                            break;
                    }

                    string pinnedClass = a.IsPinned ? "pinned" : "";

                    sb.AppendLine("<div class='announcement-card' data-category='" + HttpUtility.HtmlEncode(a.Category) + "' data-post-id='" + a.AnnouncementId + "'>");
                    sb.AppendLine("  <div class='post-header'>");
                    sb.AppendLine("    <div class='post-header-left'>");
                    sb.AppendLine("      <div class='post-avatar'><i class='" + categoryIcon + "'></i></div>");
                    sb.AppendLine("      <div class='post-user-info'>");
                    sb.AppendLine("        <div class='post-author'>" + EscapeHtml(a.AuthorName) + "</div>");
                    sb.AppendLine("        <div class='post-meta'>");
                    sb.AppendLine("          <span><i class='far fa-calendar-alt'></i> " + a.CreatedDate.ToString("MMMM dd, yyyy") + "</span>");
                    sb.AppendLine("          <span><i class='far fa-clock'></i> " + a.CreatedDate.ToString("h:mm tt") + "</span>");
                    sb.AppendLine("          <span class='post-category " + categoryClass + "'>" + EscapeHtml(a.Category) + "</span>");
                    sb.AppendLine("        </div>");
                    sb.AppendLine("      </div>");
                    sb.AppendLine("    </div>");
                    sb.AppendLine("    <button type='button' class='pin-btn-top " + pinnedClass + "' onclick='togglePinTop(this, " + a.AnnouncementId + ")'><i class='fas fa-thumbtack'></i></button>");
                    sb.AppendLine("  </div>");
                    sb.AppendLine("  <div class='post-content'>");
                    sb.AppendLine("    <div class='post-title'>" + EscapeHtml(a.Title) + "</div>");
                    sb.AppendLine("    <div class='post-text'>" + EscapeHtml(a.Content) + "</div>");
                    sb.AppendLine("  </div>");
                    sb.AppendLine("  <div class='post-stats'>");
                    sb.AppendLine("    <span onclick='toggleLikeFromStats(this, " + a.AnnouncementId + ")'><i class='far fa-heart'></i> <span class='like-count'>" + a.LikeCount + "</span> Likes</span>");
                    sb.AppendLine("    <span onclick='scrollToComments(this, " + a.AnnouncementId + ")'><i class='far fa-comment'></i> <span class='comment-count'>" + a.CommentCount + "</span> Comments</span>");
                    sb.AppendLine("    <span onclick='sharePost(" + a.AnnouncementId + ")'><i class='far fa-share-square'></i> <span class='share-count'>" + a.ShareCount + "</span> Shares</span>");
                    sb.AppendLine("  </div>");
                    sb.AppendLine("  <div class='action-buttons'>");
                    sb.AppendLine("    <button type='button' class='action-btn' onclick='toggleLike(this, " + a.AnnouncementId + ")'><i class='far fa-heart'></i> Like</button>");
                    sb.AppendLine("    <button type='button' class='action-btn' onclick='toggleComments(this, " + a.AnnouncementId + ")'><i class='far fa-comment'></i> Comment</button>");
                    sb.AppendLine("    <button type='button' class='action-btn' onclick='sharePost(" + a.AnnouncementId + ")'><i class='fas fa-share'></i> Share</button>");
                    sb.AppendLine("  </div>");  
                    sb.AppendLine("  <div class='comments-section' id='commentsSection_" + a.AnnouncementId + "'>");
                    sb.AppendLine("    <div class='comment-input'>");
                    sb.AppendLine("      <input type='text' placeholder='Write a comment...' id='commentInput_" + a.AnnouncementId + "' />");
                    sb.AppendLine("      <button type='button' onclick='addComment(this, " + a.AnnouncementId + ")'>Post</button>");
                    sb.AppendLine("    </div>");
                    sb.AppendLine("    <div class='comments-list' id='commentsList_" + a.AnnouncementId + "'>");
                    sb.AppendLine("      <div class='no-comments'>No comments yet. Be the first!</div>");
                    sb.AppendLine("    </div>");
                    sb.AppendLine("  </div>");
                    sb.AppendLine("</div>");
                }

                string html = sb.Length == 0 ? "<div style='text-align:center;padding:40px;'>No announcements available.</div>" : sb.ToString();
                string encoded = HttpUtility.JavaScriptStringEncode(html);
                string finalScript = "<script>document.getElementById('announcementsContainer').innerHTML = \"" + encoded + "\";</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadAnnouncements", finalScript);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadAnnouncements Error: " + ex);
                string errorScript = "<script>document.getElementById('announcementsContainer').innerHTML = \"<div style=\\\"text-align:center;padding:40px;color:red;\\\">Error loading announcements</div>\";</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadError", errorScript);
            }
        }

        private void LoadNotifications()
        {
            try
            {
                // sample notifications
                var notes = new[]
                {
                    new { Id = 1, Message = "Final Exam Schedule posted.", IsRead = false, Created = DateTime.Now.AddHours(-2) },
                    new { Id = 2, Message = "Campus maintenance Apr 30.", IsRead = true, Created = DateTime.Now.AddDays(-2) }
                };

                var sb = new StringBuilder();
                int unreadCount = 0;
                foreach (var n in notes)
                {
                    string unreadClass = n.IsRead ? "" : "unread";
                    string dotHtml = n.IsRead ? "" : "<div class='notification-dot'></div>";
                    if (!n.IsRead) unreadCount++;

                    sb.AppendLine("<div class='notification-item " + unreadClass + "' onclick='markNotificationRead(this, " + n.Id + ")'>");
                    sb.AppendLine(dotHtml);
                    sb.AppendLine("<div class='notification-text'>" + EscapeHtml(n.Message) + "</div>");
                    sb.AppendLine("<div class='notification-time'>" + GetTimeAgo(n.Created) + "</div>");
                    sb.AppendLine("</div>");
                }

                string html = sb.Length == 0 ? "<div class='no-notifications' style='padding:20px;text-align:center;'>No new notifications</div>" : sb.ToString();
                string encoded = HttpUtility.JavaScriptStringEncode(html);

                var scriptSb = new StringBuilder();
                scriptSb.Append("<script>");
                scriptSb.Append("var notificationList = document.getElementById('notificationList');");
                scriptSb.Append("if(notificationList) notificationList.innerHTML = \"" + encoded + "\";");
                scriptSb.Append("var badge = document.getElementById('notificationBadge');");
                scriptSb.Append("if(badge){ if(" + unreadCount + " > 0){ badge.innerText = " + unreadCount + "; badge.style.display = 'inline-block'; } else { badge.style.display = 'none'; } }");
                scriptSb.Append("</script>");

                ClientScript.RegisterStartupScript(this.GetType(), "LoadNotifications", scriptSb.ToString());
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("LoadNotifications Error: " + ex.Message);
                string errorScript = "<script>document.getElementById('notificationList').innerHTML = '<div style=\"padding:20px;text-align:center;\">Notifications unavailable</div>';</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadNotificationsError", errorScript);
            }
        }

        private string GetTimeAgo(DateTime date)
        {
            TimeSpan timeSpan = DateTime.Now - date;
            if (timeSpan.TotalMinutes < 1) return "Just now";
            if (timeSpan.TotalMinutes < 60) return $"{(int)timeSpan.TotalMinutes} minutes ago";
            if (timeSpan.TotalHours < 24) return $"{(int)timeSpan.TotalHours} hours ago";
            if (timeSpan.TotalDays < 7) return $"{(int)timeSpan.TotalDays} days ago";
            return date.ToString("MMM dd, yyyy");
        }

        private string EscapeHtml(string text)
        {
            if (string.IsNullOrEmpty(text)) return "";
            return System.Security.SecurityElement.Escape(text);
        }

        // Simple local model used for sample announcements
        private class Announcement
        {
            public int AnnouncementId { get; set; }
            public string Title { get; set; }
            public string Content { get; set; }
            public string Category { get; set; }
            public string AuthorName { get; set; }
            public DateTime CreatedDate { get; set; }
            public int LikeCount { get; set; }
            public int CommentCount { get; set; }
            public int ShareCount { get; set; }
            public bool IsPinned { get; set; }
        }
    }
}