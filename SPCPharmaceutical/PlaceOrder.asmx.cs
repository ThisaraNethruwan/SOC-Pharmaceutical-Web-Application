using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web;
using System.Web.Services;

namespace WereHouse
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class WebService1 : System.Web.Services.WebService
    {
        private readonly string connectionString = "Server=DESKTOP-M3HCAA5\\SQLEXPRESS;Database=SPC_DB;Integrated Security=True;";

        // Method to retrieve all active products
        [WebMethod]
        public DataSet GetProducts()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT ProductID, ProductName, Price, Quantity FROM Products WHERE IsActive = 1", conn))
                {
                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    conn.Open();
                    da.Fill(ds, "Products");
                    return ds;
                }
            }
        }

        // New method to search for a product by its ProductID
        [WebMethod]
        public DataSet GetProductById(int productId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT ProductID, ProductName, Description, Price, Quantity FROM Products WHERE ProductID = @ProductID AND IsActive = 1", conn))
                {
                    cmd.Parameters.AddWithValue("@ProductID", productId);
                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    conn.Open();
                    da.Fill(ds, "Product");

                    // Check if product was found
                    if (ds.Tables["Product"].Rows.Count == 0)
                    {
                        throw new Exception("Product not found.");
                    }

                    return ds;
                }
            }
        }


        // Method to place a new order
        [WebMethod]
        public int PlaceNewOrder(int productId, int quantity, int customerId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        // Check stock availability
                        int currentStock = 0;
                        decimal pricePerUnit = 0;
                        using (SqlCommand checkStock = new SqlCommand(
                            "SELECT Quantity, Price FROM Products WHERE ProductID = @ProductID", conn, transaction))
                        {
                            checkStock.Parameters.AddWithValue("@ProductID", productId);
                            using (SqlDataReader reader = checkStock.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    currentStock = reader.IsDBNull(0) ? 0 : reader.GetInt32(0);
                                    pricePerUnit = reader.IsDBNull(1) ? 0 : reader.GetDecimal(1);
                                }
                                else
                                {
                                    throw new Exception("Product not found.");
                                }
                            }
                        }

                        if (currentStock < quantity)
                            throw new Exception("Insufficient stock available.");

                        // Calculate total amount
                        decimal totalAmount = quantity * pricePerUnit;

                        // Update stock
                        using (SqlCommand updateStock = new SqlCommand(
                            "UPDATE Products SET Quantity = Quantity - @Quantity, ModifiedDate = GETDATE() WHERE ProductID = @ProductID", conn, transaction))
                        {
                            updateStock.Parameters.AddWithValue("@ProductID", productId);
                            updateStock.Parameters.AddWithValue("@Quantity", quantity);
                            int rowsAffected = updateStock.ExecuteNonQuery();
                            if (rowsAffected == 0)
                            {
                                throw new Exception("Failed to update product stock.");
                            }
                        }

                        // Insert order into P_Orders table
                        object result;
                        int newOrderId = 0;
                        using (SqlCommand placeOrder = new SqlCommand(
                            "INSERT INTO P_Orders (CustomerID, ProductID, Quantity, TotalAmount, OrderDate) " +
                            "VALUES (@CustomerID, @ProductID, @Quantity, @TotalAmount, GETDATE()); SELECT SCOPE_IDENTITY();", conn, transaction))
                        {
                            placeOrder.Parameters.AddWithValue("@CustomerID", customerId);
                            placeOrder.Parameters.AddWithValue("@ProductID", productId);
                            placeOrder.Parameters.AddWithValue("@Quantity", quantity);
                            placeOrder.Parameters.AddWithValue("@TotalAmount", totalAmount);

                            result = placeOrder.ExecuteScalar();
                            newOrderId = (result != DBNull.Value && result != null) ? Convert.ToInt32(result) : 0;
                        }

                        if (newOrderId == 0)
                        {
                            throw new Exception("Failed to place the order. New order ID was not generated.");
                        }

                        transaction.Commit();
                        return newOrderId;
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                      
                        string errorMessage = $"Error occurred while placing order. ProductID: {productId}, Quantity: {quantity}, CustomerID: {customerId}, Error: {ex.Message}";
                       
                        throw new Exception(errorMessage, ex);
                    }
                }
            }
        }
    }
}
