using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WereHouse
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private readonly string connectionString = "Server=DESKTOP-M3HCAA5\\SQLEXPRESS;Database=SPC_DB;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["WarehouseEmail"] == null)
            {
                Response.Redirect("WerehouseLogin.aspx");
            }

            if (!IsPostBack)
            {
                LoadWarehouseDetails();
            }
        }

        private void LoadWarehouseDetails()
        {
            string email = Session["WarehouseEmail"].ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT company_name, warehouse_name, email, address, phone FROM Warehouse WHERE email = @Email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblWarehouseName.Text = reader["warehouse_name"].ToString();
                            txtCompanyName.Text = reader["company_name"].ToString();
                            txtWarehouseName.Text = reader["warehouse_name"].ToString();
                            txtEmail.Text = reader["email"].ToString();
                            txtAddress.Text = reader["address"].ToString();
                            txtPhone.Text = reader["phone"].ToString();
                        }
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string email = Session["WarehouseEmail"].ToString();
            string companyName = txtCompanyName.Text.Trim();
            string warehouseName = txtWarehouseName.Text.Trim();
            string address = txtAddress.Text.Trim();
            string phone = txtPhone.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Warehouse SET company_name = @CompanyName, warehouse_name = @WarehouseName, address = @Address, phone = @Phone WHERE email = @Email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CompanyName", companyName);
                    cmd.Parameters.AddWithValue("@WarehouseName", warehouseName);
                    cmd.Parameters.AddWithValue("@Address", address);
                    cmd.Parameters.AddWithValue("@Phone", phone);
                    cmd.Parameters.AddWithValue("@Email", email);

                    conn.Open();
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        lblMessage.Text = "Profile updated successfully!";
                        lblMessage.CssClass = "success";
                        LoadWarehouseDetails();
                    }
                    else
                    {
                        lblMessage.Text = "Failed to update profile. Please try again.";
                        lblMessage.CssClass = "error";
                    }
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("WerehouseLogin.aspx");
        }
    }
}