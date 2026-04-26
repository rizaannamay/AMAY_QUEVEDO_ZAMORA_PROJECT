using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class LikeHandler : IHttpHandler, IRequiresSessionState
    {
        private string ConnStr
        {
            get { return ConfigurationManager.ConnectionStrings["CampusConnectDB"].ConnectionString; }
        }

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            var js = new JavaScriptSerializer();

            if (!(ctx.Session["IsLoggedIn"] is bool b && b) || ctx.Session["UserId"] == null)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Not logged in" }));
                return;
            }

            int userId = Convert.ToInt32(ctx.Session["UserId"]);
            string action = ctx.Request["action"] ?? "toggle";

            try
            {
                switch (action)
                {
                    case "toggle": Toggle(ctx, js, userId); break;
                    case "status": Status(ctx, js, userId); break;
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

        private void Toggle(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            int postId = Convert.ToInt32(ctx.Request["postId"]);

            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();

                bool alreadyLiked;
                using (var cmd = new SqlCommand(
                    "SELECT COUNT(1) FROM UserLikes WHERE AnnouncementId=@Aid AND UserId=@Uid", conn))
                {
                    cmd.Parameters.AddWithValue("@Aid", postId);
                    cmd.Parameters.AddWithValue("@Uid", userId);
                    alreadyLiked = (int)cmd.ExecuteScalar() > 0;
                }

                if (alreadyLiked)
                {
                    using (var cmd = new SqlCommand(
                        "DELETE FROM UserLikes WHERE AnnouncementId=@Aid AND UserId=@Uid", conn))
                    {
                        cmd.Parameters.AddWithValue("@Aid", postId);
                        cmd.Parameters.AddWithValue("@Uid", userId);
                        cmd.ExecuteNonQuery();
                    }
                    using (var cmd = new SqlCommand(
                        "UPDATE Announcements SET LikeCount = LikeCount - 1 WHERE AnnouncementId=@Aid AND LikeCount > 0", conn))
                    {
                        cmd.Parameters.AddWithValue("@Aid", postId);
                        cmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    using (var cmd = new SqlCommand(
                        "INSERT INTO UserLikes (AnnouncementId, UserId) VALUES (@Aid, @Uid)", conn))
                    {
                        cmd.Parameters.AddWithValue("@Aid", postId);
                        cmd.Parameters.AddWithValue("@Uid", userId);
                        cmd.ExecuteNonQuery();
                    }
                    using (var cmd = new SqlCommand(
                        "UPDATE Announcements SET LikeCount = LikeCount + 1 WHERE AnnouncementId=@Aid", conn))
                    {
                        cmd.Parameters.AddWithValue("@Aid", postId);
                        cmd.ExecuteNonQuery();
                    }
                }

                int newCount;
                using (var cmd = new SqlCommand(
                    "SELECT LikeCount FROM Announcements WHERE AnnouncementId=@Aid", conn))
                {
                    cmd.Parameters.AddWithValue("@Aid", postId);
                    newCount = (int)cmd.ExecuteScalar();
                }

                // Notify the announcement author when liked (not when unliked)
                if (!alreadyLiked)
                {
                    const string notifSql = @"
                        SELECT a.UserId, a.Title, u.FullName
                        FROM   Announcements a
                        JOIN   Users u ON u.UserId = @LikerUid
                        WHERE  a.AnnouncementId = @Aid";
                    using (var cmd = new SqlCommand(notifSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Aid",      postId);
                        cmd.Parameters.AddWithValue("@LikerUid", userId);
                        using (var r = cmd.ExecuteReader())
                        {
                            if (r.Read())
                            {
                                int    authorId   = r.GetInt32(0);
                                string annTitle   = r.GetString(1);
                                string likerName  = r.GetString(2);
                                r.Close();
                                if (authorId != userId)
                                {
                                    string msg = $"❤️ {likerName} liked \"{annTitle}\"";
                                    NotificationHandler.Insert(conn, authorId, msg);
                                }
                            }
                        }
                    }
                }

                ctx.Response.Write(js.Serialize(new
                {
                    ok        = true,
                    liked     = !alreadyLiked,
                    likeCount = newCount
                }));
            }
        }

        private void Status(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            int postId = Convert.ToInt32(ctx.Request["postId"]);

            using (var conn = new SqlConnection(ConnStr))
            {
                conn.Open();

                bool liked;
                using (var cmd = new SqlCommand(
                    "SELECT COUNT(1) FROM UserLikes WHERE AnnouncementId=@Aid AND UserId=@Uid", conn))
                {
                    cmd.Parameters.AddWithValue("@Aid", postId);
                    cmd.Parameters.AddWithValue("@Uid", userId);
                    liked = (int)cmd.ExecuteScalar() > 0;
                }

                int count;
                using (var cmd = new SqlCommand(
                    "SELECT LikeCount FROM Announcements WHERE AnnouncementId=@Aid", conn))
                {
                    cmd.Parameters.AddWithValue("@Aid", postId);
                    count = (int)cmd.ExecuteScalar();
                }

                ctx.Response.Write(js.Serialize(new { ok = true, liked = liked, likeCount = count }));
            }
        }

        public bool IsReusable { get { return false; } }
    }
}
