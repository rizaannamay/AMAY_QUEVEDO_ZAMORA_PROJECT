using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public class LikeHandler : IHttpHandler, IRequiresSessionState
    {
        SqlConnection con = new SqlConnection(@"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;");

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            var js = new JavaScriptSerializer();

            if (ctx.Session["IsLoggedIn"] == null || !(bool)ctx.Session["IsLoggedIn"] || ctx.Session["UserId"] == null)
            {
                ctx.Response.Write(js.Serialize(new { ok = false, error = "Not logged in" }));
                return;
            }

            int    userId = Convert.ToInt32(ctx.Session["UserId"]);
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
                if (con.State == System.Data.ConnectionState.Open) con.Close();
            }
        }

        private void Toggle(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            int postId = Convert.ToInt32(ctx.Request["postId"]);

            con.Open();

            SqlCommand checkCmd = new SqlCommand("SELECT COUNT(1) FROM UserLikes WHERE AnnouncementId=" + postId + " AND UserId=" + userId, con);
            bool alreadyLiked = (int)checkCmd.ExecuteScalar() > 0;

            if (alreadyLiked)
            {
                SqlCommand delCmd = new SqlCommand("DELETE FROM UserLikes WHERE AnnouncementId=" + postId + " AND UserId=" + userId, con);
                delCmd.ExecuteNonQuery();

                SqlCommand updCmd = new SqlCommand("UPDATE Announcements SET LikeCount = LikeCount - 1 WHERE AnnouncementId=" + postId + " AND LikeCount > 0", con);
                updCmd.ExecuteNonQuery();
            }
            else
            {
                SqlCommand insCmd = new SqlCommand("INSERT INTO UserLikes (AnnouncementId, UserId) VALUES (" + postId + "," + userId + ")", con);
                insCmd.ExecuteNonQuery();

                SqlCommand updCmd = new SqlCommand("UPDATE Announcements SET LikeCount = LikeCount + 1 WHERE AnnouncementId=" + postId, con);
                updCmd.ExecuteNonQuery();

                // Notify author
                string notifSql = "SELECT a.UserId, a.Title, u.FullName FROM Announcements a JOIN Users u ON u.UserId=" + userId + " WHERE a.AnnouncementId=" + postId;
                SqlCommand notifCmd = new SqlCommand(notifSql, con);
                SqlDataReader dr = notifCmd.ExecuteReader();
                if (dr.Read())
                {
                    int    authorId  = Convert.ToInt32(dr["UserId"]);
                    string annTitle  = dr["Title"].ToString();
                    string likerName = dr["FullName"].ToString();
                    dr.Close();

                    if (authorId != userId)
                    {
                        SqlCommand insertNotif = new SqlCommand("INSERT INTO Notifications (UserId, Message) VALUES (" + authorId + ",'" + likerName + " liked " + annTitle + "')", con);
                        insertNotif.ExecuteNonQuery();
                    }
                }
                else
                {
                    dr.Close();
                }
            }

            SqlCommand countCmd = new SqlCommand("SELECT LikeCount FROM Announcements WHERE AnnouncementId=" + postId, con);
            int newCount = (int)countCmd.ExecuteScalar();

            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true, liked = !alreadyLiked, likeCount = newCount }));
        }

        private void Status(HttpContext ctx, JavaScriptSerializer js, int userId)
        {
            int postId = Convert.ToInt32(ctx.Request["postId"]);

            con.Open();

            SqlCommand likedCmd = new SqlCommand("SELECT COUNT(1) FROM UserLikes WHERE AnnouncementId=" + postId + " AND UserId=" + userId, con);
            bool liked = (int)likedCmd.ExecuteScalar() > 0;

            SqlCommand countCmd = new SqlCommand("SELECT LikeCount FROM Announcements WHERE AnnouncementId=" + postId, con);
            int count = (int)countCmd.ExecuteScalar();

            con.Close();
            ctx.Response.Write(js.Serialize(new { ok = true, liked = liked, likeCount = count }));
        }

        public bool IsReusable { get { return false; } }
    }
}
