using System;
using System.Data;
using System.Web.UI;

namespace SPC_Pharmacy
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        // Reference to the web service
   

        PlaceOrderServiceReference.WebService1SoapClient orderService = new PlaceOrderServiceReference.WebService1SoapClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Page load logic (if any) goes here.
        }

        // Event handler for the search button click
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate the ProductID input
                if (string.IsNullOrWhiteSpace(txtProductID.Text))
                {
                    ShowMessage("Please enter a ProductID to search.", false);
                    return;
                }

                // Try to parse the entered ProductID to an integer
                if (!int.TryParse(txtProductID.Text, out int productId))
                {
                    ShowMessage("Please enter a valid ProductID.", false);
                    return;
                }

                // Call the web service to search for the product by ProductID
                DataSet productDetails = orderService.GetProductById(productId);

                // Check if the DataSet contains data in the Product table
                if (productDetails != null && productDetails.Tables["Product"].Rows.Count > 0)
                {
                    // Display product details
                    DataRow product = productDetails.Tables["Product"].Rows[0];
                    lblProductDetails.Text = $"<strong>Product Name:</strong> {product["ProductName"]}<br />" +
                                             $"<strong>Description:</strong> {product["Description"]}<br />" +
                                             $"<strong>Price:</strong> ${product["Price"]}<br />" +
                                             $"<strong>Quantity Available:</strong> {product["Quantity"]}<br />";
                    ShowMessage("Product found successfully.", true);
                }
                else
                {
                    ShowMessage("Product not found with the given ProductID.", false);
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error: {ex.Message}", false);
            }
        }

        // Method to display success or error messages
        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.CssClass = isSuccess ? "message success" : "message error";
            lblMessage.Text = message;
        }
    }
}
