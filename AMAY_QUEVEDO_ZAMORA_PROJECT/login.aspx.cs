using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

#pragma warning disable IDE1006 // Naming rule violations � class and method names match ASPX Inherits/event wiring

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class login : Page
    {
        private readonly string connectionString = @"Data Source=DESKTOP-O39NPLV\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;Connect Timeout=30;TrustServerCertificate=True;";

        // SHA-256 hash � must match the algorithm used in signin.aspx.cs
        private static string HashPassword(string password)
        {
            using (var sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                var sb = new StringBuilder(64);
                foreach (byte b in bytes) sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = string.Empty;

                // Already logged in ? splash then dashboard
                if (Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"])
                {
                    string role = Session["Role"] != null ? Session["Role"].ToString() : "";
                    Response.Redirect(role == "Admin" ? "Splash.aspx?dest=Teacher" : "Splash.aspx?dest=Student");
                    return;
                }

                // First visit (no ?from=splash) ? show splash first, then come back here
                if (Request.QueryString["from"] != "splash")
                {
                    Response.Redirect("Splash.aspx");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string role     = txtRole.SelectedValue.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(password))
            {
                ShowError("Please enter your username and password."); return;
            }

            string hashedPassword = HashPassword(password);

            try
            {
                using (var con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // First try hashed password (new accounts)
                    string sql = "SELECT UserId, FullName, Email, Role, Username, ProfileImage, Password FROM Users WHERE Username = @u AND Role = @r";
                    using (var cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@u", username);
                        cmd.Parameters.AddWithValue("@r", role);

                        using (var dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                string storedPassword = dr["Password"].ToString();
                                bool isHashMatch      = storedPassword == hashedPassword;
                                bool isPlainMatch     = storedPassword == password;

                                if (!isHashMatch && !isPlainMatch)
                                {
                                    ShowError("Invalid role, username, or password.");
                                    return;
                                }

                                int    userId      = Convert.ToInt32(dr["UserId"]);
                                string fullName    = dr["FullName"].ToString();
                                string email       = dr["Email"].ToString();
                                string matchedRole = dr["Role"].ToString();
                                string profileImg  = dr["ProfileImage"] != DBNull.Value ? dr["ProfileImage"].ToString() : string.Empty;

                                dr.Close();

                                // Auto-upgrade plain-text password to hash on first login
                                if (isPlainMatch && !isHashMatch)
                                {
                                    using (var upd = new SqlCommand(
                                        "UPDATE Users SET Password = @h WHERE UserId = @id", con))
                                    {
                                        upd.Parameters.AddWithValue("@h",  hashedPassword);
                                        upd.Parameters.AddWithValue("@id", userId);
                                        upd.ExecuteNonQuery();
                                    }
                                }

                                Session["UserId"]       = userId;
                                Session["Username"]     = username;
                                Session["FullName"]     = fullName;
                                Session["Email"]        = email;
                                Session["Role"]         = matchedRole;
                                Session["ProfileImage"] = profileImg;
                                Session["IsLoggedIn"]   = true;

                                if (matchedRole == "Admin")
                                    Response.Redirect("Splash.aspx?dest=Teacher");
                                else
                                    Response.Redirect("Splash.aspx?dest=Student");
                            }
                            else
                            {
                                ShowError("Invalid role, username, or password.");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowError("Database error: " + ex.Message);
            }
        }

        private void ShowError(string msg)
        {
            lblError.ForeColor = System.Drawing.ColorTranslator.FromHtml("#dc2626");
            lblError.BackColor = System.Drawing.ColorTranslator.FromHtml("#fef2f2");
            lblError.Text      = msg;
        }
    }
}
