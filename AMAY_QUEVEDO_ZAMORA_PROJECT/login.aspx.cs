using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AMAY_QUEVEDO_ZAMORA_PROJECT
{
    public partial class login : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=.;Initial Catalog=CampusAnnouncementDB;Integrated Security=True;");

        protected void Page_Load(object sender, EventArgs e)
        {
            lblError.Text = "";

            if (!IsPostBack && Session["Username"] != null)
            {
                if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Student")
                    Response.Redirect("Student.aspx");
                else if (Session["UserRole"] != null && Session["UserRole"].ToString() == "Admin")
                    Response.Redirect("Teacher.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string role = txtRole.SelectedValue;
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Validation
            if (string.IsNullOrEmpty(username))
            {
                lblError.Text = "Please enter username.";
                return;
            }

            if (string.IsNullOrEmpty(password))
            {
                lblError.Text = "Please enter password.";
                return;
            }

            try
            {
                con.Open();

                string query = "SELECT UserId, FullName, Username, Password, Role, IsActive FROM Users WHERE Username = @Username AND Password = @Password AND Role = @Role";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@Role", role);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Read all data BEFORE closing connection
                    int userId = Convert.ToInt32(reader["UserId"]);
                    string fullName = reader["FullName"].ToString();
                    string dbUsername = reader["Username"].ToString();
                    string dbRole = reader["Role"].ToString();
                    bool isActive = Convert.ToBoolean(reader["IsActive"]);

                    reader.Close();
                    con.Close();

                    if (!isActive)
                    {
                        lblError.Text = "Your account is deactivated. Please contact administrator.";
                        return;
                    }

                    Session["UserId"] = userId;
                    Session["Username"] = dbUsername;
                    Session["FullName"] = fullName;
                    Session["UserRole"] = dbRole;

                    UpdateLastLogin(userId);

                    if (role == "Student")
                    {
                        Response.Redirect("Student.aspx");
                    }
                    else if (role == "Admin")
                    {
                        Response.Redirect("Teacher.aspx");
                    }
                }
                else
                {
                    reader.Close();
                    con.Close();

                    // Check if username exists
                    con.Open();
                    SqlCommand checkUserCmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Username = @Username", con);
                    checkUserCmd.Parameters.AddWithValue("@Username", username);
                    int userExists = Convert.ToInt32(checkUserCmd.ExecuteScalar());
                    con.Close();

                    if (userExists > 0)
                    {
                        lblError.Text = "Invalid password. Please try again.";
                    }
                    else
                    {
                        lblError.Text = "Invalid role, username, or password. Please try again or <a href='signin.aspx'>Sign Up</a>.";
                    }
                }
            }
            catch (Exception ex)
            {
                if (con.State == ConnectionState.Open)
                    con.Close();

                lblError.Text = "Database error: " + ex.Message;
                System.Diagnostics.Debug.WriteLine("Login Error: " + ex.Message);
            }
        }

        private void UpdateLastLogin(int userId)
        {
            try
            {
                con.Open();
                string query = "UPDATE Users SET LastLoginDate = @LastLoginDate WHERE UserId = @UserId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@LastLoginDate", DateTime.Now);
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch
            {
                // Don't show error for last login update failure
            }
        }
    }
}