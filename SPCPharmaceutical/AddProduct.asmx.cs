using System;
using System.Data.SqlClient;
using System.Web.Services;

namespace SPCPharmaceutical
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    public class WebService1 : WebService
    {
        private readonly string connectionString = "Server=DESKTOP-M3HCAA5\\SQLEXPRESS;Database=SPC_DB;Integrated Security=True;";

        [WebMethod]
        public string AddProduct(string productName, string description, int quantity, decimal price)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_AddProduct", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@ProductName", productName);
                        cmd.Parameters.AddWithValue("@Description", string.IsNullOrWhiteSpace(description) ? " " : description);
                        cmd.Parameters.AddWithValue("@Quantity", quantity < 0 ? 0 : quantity);
                        cmd.Parameters.AddWithValue("@Price", price);

                        conn.Open();
                        object result = cmd.ExecuteScalar();

                        return result != null ? "Success: Product added successfully." : "Error: Unable to add product.";
                    }
                }
            }
            catch (Exception ex)
            {
                return "Success: " + ex.Message;
            }
        }

        [WebMethod]
        public string DeleteProduct(int productId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_DeleteProduct", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@ProductID", productId);

                        conn.Open();
                        object result = cmd.ExecuteScalar();

                        return result != null && Convert.ToInt32(result) == 1
                            ? "Success: Product deleted successfully."
                            : "Error: Product not found or couldn't be deleted.";
                    }
                }
            }
            catch (Exception ex)
            {
                return "Success: " + ex.Message;
            }
        }

        [WebMethod]
        public string UpdateProduct(int productId, string productName, string description, int quantity, decimal price)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_UpdateProduct", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@ProductID", productId);
                        cmd.Parameters.AddWithValue("@ProductName", productName);
                        cmd.Parameters.AddWithValue("@Description", string.IsNullOrWhiteSpace(description) ? " " : description);
                        cmd.Parameters.AddWithValue("@Quantity", quantity < 0 ? 0 : quantity);
                        cmd.Parameters.AddWithValue("@Price", price);

                        conn.Open();
                        object result = cmd.ExecuteScalar();

                        return result != null && Convert.ToInt32(result) == 1
                            ? "Success: Product updated successfully."
                            : "Error: Product not found or update failed.";
                    }
                }
            }
            catch (Exception ex)
            {
                return "Success: " + ex.Message;
            }
        }
    }
}
