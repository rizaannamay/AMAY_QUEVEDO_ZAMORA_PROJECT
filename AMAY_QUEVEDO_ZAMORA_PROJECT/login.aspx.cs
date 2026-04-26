using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = string.Empty;
                if (Session["IsLoggedIn"] is bool b && b)
                {
                    string role = Session["Role"]?.ToString() ?? "";
                    Response.Redirect(role == "Admin" ? "Teacher.aspx" : "Student.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
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

            string connStr = ConfigurationManager.ConnectionStrings["CampusConnectDB"].ConnectionString;

            try
            {
                using (var conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    const string sql = @"
                        SELECT UserId, FullName, Email, Role
                        FROM   Users
                        WHERE  Username = @Username
                          AND  Password = @Password
                          AND  Role     = @Role";

                    using (var cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Password", password);
                        cmd.Parameters.AddWithValue("@Role",     role);

                        using (var reader = cmd.ExecuteReader())
                        {
                            if (!reader.Read())
                            {
                                ShowError("Invalid role, username, or password."); return;
                            }

                            int    userId      = reader.GetInt32(0);
                            string fullName    = reader.GetString(1);
                            string email       = reader.GetString(2);
                            string matchedRole = reader.GetString(3);

                            reader.Close();

                            Session["UserId"]     = userId;
                            Session["Username"]   = username;
                            Session["FullName"]   = fullName;
                            Session["Email"]      = email;
                            Session["Role"]       = matchedRole;
                            Session["IsLoggedIn"] = true;

                            if (string.Equals(matchedRole, "Admin", StringComparison.OrdinalIgnoreCase))
                                Response.Redirect("Teacher.aspx", false);
                            else
                                Response.Redirect("Student.aspx", false);

                            Context.ApplicationInstance.CompleteRequest();
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
