using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Collections.Concurrent;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{   
    public partial class Comments : Page
    {
        // In-memory store (announcementId -> comments list)
        private static readonly ConcurrentDictionary<int, List<CommentItem>> _comments = new ConcurrentDictionary<int, List<CommentItem>>();

        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request.QueryString["action"];

            if (action == "add")
            {
                AddComment();
            }
            else if (action == "get")
            {
                GetComments();
            }
            else
            {
                Response.ContentType = "application/json";
                Response.Write("{\"error\":\"Invalid action\"}");
                Response.End();
            }
        }

        private void AddComment()
        {
            if (Session["UserId"] == null)
            {
                Response.ContentType = "application/json";
                Response.Write("{\"success\":false,\"error\":\"Not logged in\"}");
                Response.End();
                return;
            }

            string json = "";
            using (var reader = new System.IO.StreamReader(Request.InputStream))
            {
                json = reader.ReadToEnd();
            }

            var serializer = new JavaScriptSerializer();
            dynamic data;
            try
            {
                data = serializer.Deserialize<dynamic>(json);
            }
            catch
            {
                Response.ContentType = "application/json";
                Response.Write("{\"success\":false,\"error\":\"Invalid JSON\"}");
                Response.End();
                return;
            }

            int announcementId = Convert.ToInt32(data["postId"]);
            string commentText = data["comment"].ToString();
            string userName = Session["FullName"]?.ToString() ?? Session["Username"]?.ToString() ?? "User";

            var item = new CommentItem
            {
                Author = userName,
                Text = commentText,
                Created = DateTime.Now
            };

            var list = _comments.GetOrAdd(announcementId, _ => new List<CommentItem>());
            lock (list)
            {
                list.Add(item);
            }

            Response.ContentType = "application/json";
            Response.Write("{\"success\":true}");
            Response.End();
        }

        private void GetComments()
        {
            if (!int.TryParse(Request.QueryString["postId"], out int announcementId))
            {
                Response.ContentType = "application/json";
                Response.Write("[]");
                Response.End();
                return;
            }

            if (!_comments.TryGetValue(announcementId, out List<CommentItem> list))
            {
                Response.ContentType = "application/json";
                Response.Write("[]");
                Response.End();
                return;
            }

            var sb = new StringBuilder();
            sb.Append("[");
            bool first = true;
            lock (list)
            {
                foreach (var c in list)
                {
                    if (!first) sb.Append(",");
                    first = false;
                    sb.Append($"{{\"author\":\"{EscapeJson(c.Author)}\",\"text\":\"{EscapeJson(c.Text)}\",\"date\":\"{GetTimeAgo(c.Created)}\"}}");
                }
            }
            sb.Append("]");
            Response.ContentType = "application/json";
            Response.Write(sb.ToString());
            Response.End();
        }

        private string GetTimeAgo(DateTime date)
        {
            TimeSpan timeSpan = DateTime.Now - date;
            if (timeSpan.TotalMinutes < 1) return "Just now";
            if (timeSpan.TotalMinutes < 60) return $"{(int)timeSpan.TotalMinutes}m ago";
            if (timeSpan.TotalHours < 24) return $"{(int)timeSpan.TotalHours}h ago";
            if (timeSpan.TotalDays < 7) return $"{(int)timeSpan.TotalDays}d ago";
            return date.ToString("MMM dd");
        }

        private string EscapeJson(string text)
        {
            if (string.IsNullOrEmpty(text)) return "";
            return text.Replace("\\", "\\\\").Replace("\"", "\\\"").Replace("\n", "\\n");
        }

        private class CommentItem
        {
            public string Author { get; set; }
            public string Text { get; set; }
            public DateTime Created { get; set; }
        }
    }
}