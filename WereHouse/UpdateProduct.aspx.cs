using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WereHouse
{
    public partial class WebForm6 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtUpdateQuantity.Text = "1"; // Default quantity for update
            }
        }

        protected void btnUpdateProduct_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    // Create instance of the web service
                    WarehouseServiceReference.WebService1SoapClient service =
                        new WarehouseServiceReference.WebService1SoapClient();

                    // Parse and validate form inputs
                    int productId = int.Parse(txtUpdateProductID.Text.Trim());
                    string productName = txtUpdateProductName.Text.Trim();
                    string description = string.IsNullOrWhiteSpace(txtUpdateDescription.Text)
                        ? "No description provided" : txtUpdateDescription.Text.Trim();
                    int quantity = int.Parse(txtUpdateQuantity.Text.Trim());
                    decimal price = decimal.Parse(txtUpdatePrice.Text.Trim());

                    // Call the web service method to update the product
                    string result = service.UpdateProduct(productId, productName, description, quantity, price);

                    if (result.ToLower().Contains("success"))
                    {
                        lblUpdateMessage.Text = "Product updated successfully!";
                        lblUpdateMessage.CssClass = "message success";
                        ClearForm();
                    }
                    else
                    {
                        lblUpdateMessage.Text = $"Failed to update product. {result}";
                        lblUpdateMessage.CssClass = "message error";
                    }
                }
            }
            catch (Exception ex)
            {
                lblUpdateMessage.Text = "An error occurred: " + ex.Message;
                lblUpdateMessage.CssClass = "message error";
            }
        }

        private void ClearForm()
        {
            txtUpdateProductID.Text = string.Empty;
            txtUpdateProductName.Text = string.Empty;
            txtUpdateDescription.Text = string.Empty;
            txtUpdateQuantity.Text = "1";
            txtUpdatePrice.Text = string.Empty;
        }
    }
}