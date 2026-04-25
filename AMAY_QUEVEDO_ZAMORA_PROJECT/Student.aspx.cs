using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class Student : Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CampusAnnouncementDB;User ID=Campus_Announcement;Password=campus123");


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

        private void LoadUserInfo()
        {
            try
            {
                con.Open();
                string query = "SELECT FullName, Email, Role FROM Users WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"].ToString());
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    string fullName = reader["FullName"].ToString();
                    string email = reader["Email"].ToString();
                    string role = reader["Role"].ToString();

                    Session["FullName"] = fullName;
                    Session["Email"] = email;

                    string script = $@"
                        <script>
                            var userName = document.getElementById('userName');
                            var userRole = document.getElementById('userRole');
                            var profileName = document.getElementById('profileName');
                            var profileEmail = document.getElementById('profileEmail');
                            if(userName) userName.innerText = '{fullName.Replace("'", "\\'")}';
                            if(userRole) userRole.innerText = '{role.Replace("'", "\\'")}';
                            if(profileName) profileName.innerText = '{fullName.Replace("'", "\\'")}';
                            if(profileEmail) profileEmail.innerText = '{email.Replace("'", "\\'")}';
                        </script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "LoadUser", script);
                }
                reader.Close();
                con.Close();
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open) con.Close();
                System.Diagnostics.Debug.WriteLine("LoadUserInfo Error: " + ex.Message);
            }
        }

        private void LoadAnnouncements()
        {
            try
            {
                con.Open();

                string query = @"SELECT AnnouncementId, Title, Content, Category, AuthorName, 
                                        CreatedDate, LikeCount, CommentCount, ShareCount, IsPinned
                                 FROM Announcements 
                                 WHERE IsActive = 1 
                                 ORDER BY IsPinned DESC, CreatedDate DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader reader = cmd.ExecuteReader();

                string html = "";
                while (reader.Read())
                {
                    int id = Convert.ToInt32(reader["AnnouncementId"]);
                    string title = reader["Title"].ToString();
                    string content = reader["Content"].ToString();
                    string category = reader["Category"].ToString();
                    string author = reader["AuthorName"].ToString();
                    DateTime date = Convert.ToDateTime(reader["CreatedDate"]);
                    int likes = Convert.ToInt32(reader["LikeCount"]);
                    int comments = Convert.ToInt32(reader["CommentCount"]);
                    int shares = Convert.ToInt32(reader["ShareCount"]);
                    bool pinned = Convert.ToBoolean(reader["IsPinned"]);

                    string categoryClass = "";
                    string categoryIcon = "fas fa-bullhorn";
                    switch (category.ToLower())
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

                    string pinnedClass = pinned ? "pinned" : "";

                    html += $@"
                        <div class='announcement-card' data-category='{category}' data-post-id='{id}'>
                            <div class='post-header'>
                                <div class='post-header-left'>
                                    <div class='post-avatar'>
                                        <i class='{categoryIcon}'></i>
                                    </div>
                                    <div class='post-user-info'>
                                        <div class='post-author'>{EscapeHtml(author)}</div>
                                        <div class='post-meta'>
                                            <span><i class='far fa-calendar-alt'></i> {date:MMMM dd, yyyy}</span>
                                            <span><i class='far fa-clock'></i> {date:h:mm tt}</span>
                                            <span class='post-category {categoryClass}'>{category}</span>
                                        </div>
                                    </div>
                                </div>
                                <button type='button' class='pin-btn-top {pinnedClass}' onclick='togglePin({id})' title='{(pinned ? "Unpin" : "Pin this announcement")}' style='color:{(pinned ? "#e65100" : "var(--muted-light)")}'>
                                    <i class='{(pinned ? "fas" : "far")} fa-thumbtack'></i>
                                </button>
                            </div>
                            <div class='post-content'>
                                <div class='post-title'>{EscapeHtml(title)}</div>
                                <div class='post-text'>{EscapeHtml(content)}</div>
                            </div>
                            <div class='post-stats'>
                                <span onclick='toggleLike({id})'><i class='far fa-heart'></i> <span class='like-count'>{likes}</span> Likes</span>
                                <span onclick='toggleCommentSection({id})'><i class='far fa-comment'></i> <span class='comment-count'>{comments}</span> Comments</span>
                                <span onclick='sharePost({id}, null)'><i class='far fa-share-square'></i> <span class='share-count'>{shares}</span> Shares</span>
                            </div>
                            <div class='action-buttons'>
                                <button type='button' class='action-btn like-btn' onclick='toggleLike({id})'><i class='far fa-heart'></i> Like</button>
                                <button type='button' class='action-btn' onclick='toggleCommentSection({id})'><i class='far fa-comment'></i> Comment</button>
                                <button type='button' class='action-btn' onclick='sharePost({id}, null)'><i class='fas fa-share-alt'></i> Share</button>
                                <button type='button' class='action-btn notif-btn' onclick='toggleNotif({id})'><i class='far fa-bell'></i> Notify</button>
                            </div>
                            <div class='comments-section' id='commentsSection_{id}' style='display:none;'>
                                <div class='comment-input'>
                                    <input type='text' placeholder='Write a comment...' id='commentInput_{id}' />
                                    <button type='button' onclick='addComment(this, {id})'>Post</button>
                                </div>
                                <div class='comments-list' id='commentsList_{id}'>
                                    <div class='no-comments'>No comments yet. Be the first!</div>
                                </div>
                            </div>
                        </div>";
                }
                reader.Close();
                con.Close();

                if (string.IsNullOrEmpty(html))
                {
                    html = "<div style='text-align:center;padding:40px;'>No announcements available.</div>";
                }

                string finalScript = $"<script>document.getElementById('announcementsContainer').innerHTML = `{html}`;</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadAnnouncements", finalScript);
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open) con.Close();
                string errorScript = $"<script>document.getElementById('announcementsContainer').innerHTML = '<div style=\"text-align:center;padding:40px;color:red;\">Error loading announcements: {ex.Message.Replace("'", "\\'")}</div>';</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadError", errorScript);
            }
        }

        private void LoadNotifications()
        {
            try
            {
                con.Open();

                string query = @"SELECT NotificationId, Message, IsRead, CreatedDate 
                                 FROM Notifications 
                                 WHERE UserId = @UserId 
                                 ORDER BY CreatedDate DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"].ToString());
                SqlDataReader reader = cmd.ExecuteReader();

                string html = "";
                int unreadCount = 0;

                while (reader.Read())
                {
                    int id = Convert.ToInt32(reader["NotificationId"]);
                    string message = reader["Message"].ToString();
                    bool isRead = Convert.ToBoolean(reader["IsRead"]);
                    DateTime date = Convert.ToDateTime(reader["CreatedDate"]);
                    string timeAgo = GetTimeAgo(date);

                    string unreadClass = isRead ? "" : "unread";
                    string dotHtml = isRead ? "" : "<div class='notification-dot'></div>";

                    if (!isRead) unreadCount++;

                    html += $@"
                        <div class='notification-item {unreadClass}' onclick='markNotificationRead(this, {id})'>
                            {dotHtml}
                            <div class='notification-text'>{EscapeHtml(message)}</div>
                            <div class='notification-time'>{timeAgo}</div>
                        </div>";
                }
                reader.Close();
                con.Close();

                if (string.IsNullOrEmpty(html))
                {
                    html = "<div class='no-notifications' style='padding:20px;text-align:center;'>No new notifications</div>";
                }

                string script = $@"
                    <script>
                        var notificationList = document.getElementById('notificationList');
                        if(notificationList) notificationList.innerHTML = `{html}`;
                        var badge = document.getElementById('notificationBadge');
                        if(badge) {{
                            if({unreadCount} > 0) {{
                                badge.innerText = {unreadCount};
                                badge.style.display = 'inline-block';
                            }} else {{
                                badge.style.display = 'none';
                            }}
                        }}
                    </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "LoadNotifications", script);
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open) con.Close();
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
    }
}