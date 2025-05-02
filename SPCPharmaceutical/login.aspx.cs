using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SPCPharmaceutical
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["SPC_DB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT account_type, status FROM account WHERE phone=@phone AND password=@password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@phone", phone);
                cmd.Parameters.AddWithValue("@password", password);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string accountType = reader["account_type"].ToString();
                    string status = reader["status"].ToString();

                    if (status == "pending")
                    {
                        Response.Write("<script>alert('Your account is pending approval. Please wait.');</script>");
                    }
                    else
                    {
                        if (accountType == "admin")
                        {
                            Response.Redirect("Dashboard.aspx");
                        }
                        else if (accountType == "supplier")
                        {
                            Response.Redirect("SupplierDashboard.aspx");
                        }
                    }
                }
                else
                {
                    Response.Write("<script>alert('Invalid phone number or password!');</script>");
                }

                conn.Close();
            }
        }
    }
}