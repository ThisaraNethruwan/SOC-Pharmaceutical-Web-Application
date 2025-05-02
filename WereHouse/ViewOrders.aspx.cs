using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WereHouse
{
    public partial class WebForm7 : System.Web.UI.Page
    {
        private readonly string connectionString = "Server=DESKTOP-M3HCAA5\\SQLEXPRESS;Database=SPC_DB;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load orders when the page loads for the first time
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            try
            {
                // Fetch orders data from the database
                DataSet orders = GetOrdersFromDatabase();

                // Check if any orders were retrieved
                if (orders != null && orders.Tables["Orders"].Rows.Count > 0)
                {
                    // Bind the orders data to the GridView
                    gvOrders.DataSource = orders.Tables["Orders"];
                    gvOrders.DataBind();
                    lblMessage.Text = "Orders loaded successfully.";
                    lblMessage.CssClass = "message success";
                }
                else
                {
                    lblMessage.Text = "No orders found.";
                    lblMessage.CssClass = "message error";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = $"Error: {ex.Message}";
                lblMessage.CssClass = "message error";
            }
        }

        private DataSet GetOrdersFromDatabase()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT 
                        o.OrderID, 
                        p.ProductName, 
                        o.Quantity, 
                        o.TotalAmount, 
                        o.OrderDate 
                    FROM 
                        P_Orders o
                    INNER JOIN 
                        Products p ON o.ProductID = p.ProductID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    conn.Open();
                    da.Fill(ds, "Orders");
                    return ds;
                }
            }
        }

        
        protected void gvOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvOrders.PageIndex = e.NewPageIndex;
            LoadOrders();
        }
    }
}