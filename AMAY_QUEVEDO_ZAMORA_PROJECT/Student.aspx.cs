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
            // Session guard — must be logged in as Student
            if (Session["IsLoggedIn"] == null || !(bool)Session["IsLoggedIn"])
            {
                Response.Redirect("login.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            if (!string.Equals(Session["Role"]?.ToString(), "Student", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Teacher.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadUserInfo();
                LoadAnnouncements();
                LoadNotifications();
            }
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("SearchStudent.aspx");
        }

        private void LoadUserInfo()
        {
            string fullName = Session["FullName"]?.ToString() ?? "Student";
            string email    = Session["Email"]?.ToString()    ?? "";
            string role     = Session["Role"]?.ToString()     ?? "Student";
            string username = Session["Username"]?.ToString() ?? "";

            string fn = HttpUtility.JavaScriptStringEncode(fullName);
            string em = HttpUtility.JavaScriptStringEncode(email);
            string rl = HttpUtility.JavaScriptStringEncode(role);
            string un = HttpUtility.JavaScriptStringEncode(username);

            string script = "<script>"
                + "var el; "
                + "el=document.getElementById('userName');    if(el) el.innerText=\"" + fn + "\";"
                + "el=document.getElementById('userRole');    if(el) el.innerText=\"" + rl + "\";"
                + "el=document.getElementById('pm-fullname'); if(el) el.innerText=\"" + fn + "\";"
                + "el=document.getElementById('pm-username'); if(el) el.innerText=\"" + un + "\";"
                + "el=document.getElementById('pm-email');    if(el) el.innerText=\"" + em + "\";"
                + "el=document.getElementById('pm-role');     if(el) el.innerText=\"" + rl + "\";"
                + "el=document.getElementById('pm-role2');    if(el) el.innerText=\"" + rl + "\";"
                + "</script>";

            ClientScript.RegisterStartupScript(GetType(), "LoadUser", script);
        }

        private void LoadAnnouncements()
        {
            var items = new List<Announcement>
            {
                new Announcement { Id=1, Title="Final Exam Schedule Spring 2026",   Category="Exam",       Author="Dr. Reyes",       Date=DateTime.Now.AddDays(-5),  Content="Final exams will be held from May 15-20, 2026. Please check your exam permits online. Bring school ID and test permit.", Likes=24, Comments=5, Shares=3, Pinned=true  },
                new Announcement { Id=2, Title="Class Suspension due to Typhoon",   Category="Suspension", Author="Admin Office",    Date=DateTime.Now.AddDays(-2),  Content="Classes suspended on April 26-27 due to Typhoon. All activities will shift to online learning platforms.",              Likes=18, Comments=3, Shares=7, Pinned=false },
                new Announcement { Id=3, Title="University Hackathon 2026",         Category="Event",      Author="IT Department",   Date=DateTime.Now.AddDays(-10), Content="48-hour coding challenge with exciting prizes. Form teams of 3-4 members. Registration ends May 15.",                   Likes=42, Comments=9, Shares=15,Pinned=false },
                new Announcement { Id=4, Title="Midterm Grade Release",             Category="Exam",       Author="Registrar",       Date=DateTime.Now.AddDays(-7),  Content="Midterm grades are now available via the student portal. Check your assessment and email your instructors for concerns.",  Likes=31, Comments=6, Shares=4, Pinned=false },
                new Announcement { Id=5, Title="Cultural Festival 2026",            Category="Event",      Author="OSA",             Date=DateTime.Now.AddDays(-14), Content="Celebration of arts, international food fair, and cultural performances. Free entrance for all students!",                Likes=56, Comments=12,Shares=20,Pinned=false }
            };

            var sb = new StringBuilder();
            foreach (var a in items)
            {
                string catClass = a.Category == "Exam" ? "post-category-exam" : a.Category == "Suspension" ? "post-category-suspension" : "post-category-event";
                string catIcon  = a.Category == "Exam" ? "fas fa-file-alt"    : a.Category == "Suspension" ? "fas fa-cloud-rain"         : "fas fa-calendar-alt";
                string pinClass = a.Pinned ? "pinned" : "";
                string pinColor = a.Pinned ? "#e65100" : "var(--muted-light)";
                string pinIcon  = a.Pinned ? "fas" : "far";

                sb.Append("<div class='announcement-card' data-category='" + HttpUtility.HtmlEncode(a.Category) + "' data-post-id='" + a.Id + "'>");
                sb.Append("<div class='post-header'><div class='post-header-left'>");
                sb.Append("<div class='post-avatar'><i class='" + catIcon + "'></i></div>");
                sb.Append("<div class='post-user-info'><div class='post-author'>" + EscapeHtml(a.Author) + "</div>");
                sb.Append("<div class='post-meta'><span><i class='far fa-calendar-alt'></i> " + a.Date.ToString("MMMM dd, yyyy") + "</span>");
                sb.Append("<span class='post-category " + catClass + "'>" + EscapeHtml(a.Category) + "</span></div></div></div>");
                sb.Append("<button type='button' class='pin-btn-top " + pinClass + "' onclick='togglePin(" + a.Id + ")' style='color:" + pinColor + "'><i class='" + pinIcon + " fa-thumbtack'></i></button>");
                sb.Append("</div>");
                sb.Append("<div class='post-content'><div class='post-title'>" + EscapeHtml(a.Title) + "</div><div class='post-text'>" + EscapeHtml(a.Content) + "</div></div>");
                sb.Append("<div class='post-stats'>");
                sb.Append("<span onclick='toggleLike(" + a.Id + ")'><i class='far fa-heart'></i> <span class='like-count'>" + a.Likes + "</span> Likes</span>");
                sb.Append("<span onclick='toggleCommentSection(" + a.Id + ")'><i class='far fa-comment'></i> <span class='comment-count'>" + a.Comments + "</span> Comments</span>");
                sb.Append("<span onclick='sharePost(" + a.Id + ", null)'><i class='far fa-share-square'></i> " + a.Shares + " Shares</span>");
                sb.Append("</div>");
                sb.Append("<div class='action-buttons'>");
                sb.Append("<button type='button' class='action-btn like-btn' onclick='toggleLike(" + a.Id + ")'><i class='far fa-heart'></i> Like</button>");
                sb.Append("<button type='button' class='action-btn' onclick='toggleCommentSection(" + a.Id + ")'><i class='far fa-comment'></i> Comment</button>");
                sb.Append("<button type='button' class='action-btn' onclick='sharePost(" + a.Id + ", null)'><i class='fas fa-share-alt'></i> Share</button>");
                sb.Append("</div>");
                sb.Append("<div class='comments-section' id='commentsSection_" + a.Id + "' style='display:none;'>");
                sb.Append("<div class='comment-input'><input type='text' placeholder='Write a comment...' id='commentInput_" + a.Id + "' />");
                sb.Append("<button type='button' onclick='addComment(this," + a.Id + ")'>Post</button></div>");
                sb.Append("<div class='comments-list' id='commentsList_" + a.Id + "'><div class='no-comments'>No comments yet. Be the first!</div></div>");
                sb.Append("</div></div>");
            }

            string html    = sb.Length == 0 ? "<div style='text-align:center;padding:40px;'>No announcements available.</div>" : sb.ToString();
            string encoded = HttpUtility.JavaScriptStringEncode(html);
            ClientScript.RegisterStartupScript(GetType(), "LoadAnnouncements",
                "<script>document.getElementById('announcementsContainer').innerHTML=\"" + encoded + "\";</script>");
        }

        private void LoadNotifications()
        {
            var notes = new[] {
                new { Id=1, Message="Final Exam Schedule posted.",  IsRead=false, Created=DateTime.Now.AddHours(-2) },
                new { Id=2, Message="Campus maintenance Apr 30.",   IsRead=true,  Created=DateTime.Now.AddDays(-2)  }
            };

            var sb = new StringBuilder();
            int unread = 0;
            foreach (var n in notes)
            {
                if (!n.IsRead) unread++;
                string cls = n.IsRead ? "" : "unread";
                string dot = n.IsRead ? "" : "<div class='notification-dot'></div>";
                sb.Append("<div class='notification-item " + cls + "' onclick='markNotificationRead(this," + n.Id + ")'>");
                sb.Append(dot + "<div class='notification-text'>" + EscapeHtml(n.Message) + "</div>");
                sb.Append("<div class='notification-time'>" + GetTimeAgo(n.Created) + "</div></div>");
            }

            string html    = sb.Length == 0 ? "<div style='padding:20px;text-align:center;'>No new notifications</div>" : sb.ToString();
            string encoded = HttpUtility.JavaScriptStringEncode(html);
            var s = new StringBuilder("<script>");
            s.Append("var nl=document.getElementById('notificationList'); if(nl) nl.innerHTML=\"" + encoded + "\";");
            s.Append("var nb=document.getElementById('notificationBadge'); if(nb){ if(" + unread + ">0){nb.innerText=" + unread + ";nb.style.display='inline-block';}else{nb.style.display='none';}}");
            s.Append("</script>");
            ClientScript.RegisterStartupScript(GetType(), "LoadNotifications", s.ToString());
        }

        private string GetTimeAgo(DateTime d)
        {
            var ts = DateTime.Now - d;
            if (ts.TotalMinutes < 1)  return "Just now";
            if (ts.TotalMinutes < 60) return (int)ts.TotalMinutes + " minutes ago";
            if (ts.TotalHours   < 24) return (int)ts.TotalHours   + " hours ago";
            if (ts.TotalDays    < 7)  return (int)ts.TotalDays    + " days ago";
            return d.ToString("MMM dd, yyyy");
        }

        private string EscapeHtml(string t) =>
            string.IsNullOrEmpty(t) ? "" : System.Security.SecurityElement.Escape(t);

        private class Announcement
        {
            public int      Id       { get; set; }
            public string   Title    { get; set; }
            public string   Content  { get; set; }
            public string   Category { get; set; }
            public string   Author   { get; set; }
            public DateTime Date     { get; set; }
            public int      Likes    { get; set; }
            public int      Comments { get; set; }
            public int      Shares   { get; set; }
            public bool     Pinned   { get; set; }
        }
    }
}
