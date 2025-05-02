using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SPC_Pharmacy
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private readonly string connectionString = "Server=DESKTOP-M3HCAA5\\SQLEXPRESS;Database=SPC_DB;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Clear();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();

                if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
                {
                    ShowMessage("Please enter both email and password.", false);
                    return;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT id, pharmacy_name, email 
                                   FROM Pharmacy 
                                   WHERE email = @Email AND password = @Password";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", password);

                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                Session["PharmacyId"] = reader["id"].ToString();
                                Session["PharmacyName"] = reader["pharmacy_name"].ToString();
                                Session["PharmacyEmail"] = reader["email"].ToString();
                                Session["UserType"] = "Pharmacy";

                                LogLogin(Convert.ToInt32(reader["id"]), true, email);  // Added email parameter

                                Response.Redirect("PharmacyDashboard.aspx");
                            }
                            else
                            {
                                ShowMessage("Invalid email or password.", false);
                                LogLogin(0, false, email);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("An error occurred during login. Please try again.", false);
                System.Diagnostics.Debug.WriteLine($"Login Error: {ex.Message}");
            }
        }

        private void LogLogin(int pharmacyId, bool success, string email)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO LoginLogs 
                                   (user_id, user_type, email, success, login_time, ip_address) 
                                   VALUES 
                                   (@UserId, 'Pharmacy', @Email, @Success, GETDATE(), @IpAddress)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", pharmacyId);
                        cmd.Parameters.AddWithValue("@Email", email ?? string.Empty);  // Fixed line
                        cmd.Parameters.AddWithValue("@Success", success);
                        cmd.Parameters.AddWithValue("@IpAddress", Request.UserHostAddress);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Login Log Error: {ex.Message}");
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = isSuccess ? System.Drawing.Color.Green : System.Drawing.Color.Red;
            lblMessage.Visible = true;
        }
    }
}