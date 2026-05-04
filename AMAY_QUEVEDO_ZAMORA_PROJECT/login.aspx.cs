using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

#pragma warning disable IDE1006 // Naming rule violations — class and method names match ASPX Inherits/event wiring

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class login : Page
    {
        private readonly string connectionString = @"Data Source=LAPTOP-GPJQLLD4\SQLEXPRESS1;Initial Catalog=CAPdb;User ID=CampusAnnouncementPortal;Password=campus123;Connect Timeout=30;TrustServerCertificate=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = string.Empty;

                // Already logged in → splash then dashboard
                if (Session["IsLoggedIn"] != null && (bool)Session["IsLoggedIn"])
                {
                    string role = Session["Role"] != null ? Session["Role"].ToString() : "";
                    Response.Redirect(role == "Admin" ? "Splash.aspx?dest=Teacher" : "Splash.aspx?dest=Student");
                    return;
                }

                // First visit (no ?from=splash) → show splash first, then come back here
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

            try
            {
                using (var con = new SqlConnection(connectionString))
                {
                    con.Open();

                    string sql = "SELECT UserId, FullName, Email, Role, Username, ProfileImage FROM Users WHERE Username = @u AND Password = @p AND Role = @r";
                    using (var cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@u", username);
                        cmd.Parameters.AddWithValue("@p", password);
                        cmd.Parameters.AddWithValue("@r", role);

                        using (var dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                int    userId      = Convert.ToInt32(dr["UserId"]);
                                string fullName    = dr["FullName"].ToString();
                                string email       = dr["Email"].ToString();
                                string matchedRole = dr["Role"].ToString();
                                string profileImg  = dr["ProfileImage"] != DBNull.Value ? dr["ProfileImage"].ToString() : string.Empty;

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
