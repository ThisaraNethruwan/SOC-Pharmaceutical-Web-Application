using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SPC_Admin
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // If the admin is already logged in, redirect to Dashboard
            if (Session["AdminID"] != null)
            {
                Response.Redirect("Dashboard.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Please enter both email and password.";
                lblError.Visible = true;
                return;
            }

            // Database connection string
            string connString = "Data Source=DESKTOP-M3HCAA5\\SQLEXPRESS;Initial Catalog=SPC_DB;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "SELECT id, password FROM Admins WHERE email = @Email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read()) // Check if admin exists
                    {
                        string storedPassword = reader["password"].ToString();
                        int adminID = Convert.ToInt32(reader["id"]);

                        // Directly compare plain text passwords
                        if (password == storedPassword)
                        {
                            // Store admin session and redirect to dashboard
                            Session["AdminID"] = adminID;
                            Response.Redirect("Dashboard.aspx");
                        }
                        else
                        {
                            lblError.Text = "Invalid email or password.";
                            lblError.Visible = true;
                        }
                    }
                    else
                    {
                        lblError.Text = "Invalid email or password.";
                        lblError.Visible = true;
                    }
                }
            }
        }
    }
}