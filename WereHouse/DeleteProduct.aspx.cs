using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Services;

namespace WereHouse
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        WarehouseServiceReference.WebService1SoapClient service =
                       new WarehouseServiceReference.WebService1SoapClient();
        protected void Page_Load(object sender, EventArgs e)
        {
            // Any required initialization
        }

        protected void btnDeleteProduct_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    // Create instance of the web service
                    WarehouseServiceReference.WebService1SoapClient service =
                        new WarehouseServiceReference.WebService1SoapClient();

                    // Validate and parse product ID
                    if (!int.TryParse(txtProductID.Text.Trim(), out int productId) || productId <= 0)
                    {
                        lblMessage.Text = "Please enter a valid Product ID.";
                        lblMessage.CssClass = "message error";
                        return;
                    }

                    // Call the web service method
                    string result = service.DeleteProduct(productId);

                    if (result.Equals("Success", StringComparison.OrdinalIgnoreCase))
                    {
                        lblMessage.Text = "Product deleted successfully!";
                        lblMessage.CssClass = "message success";
                        txtProductID.Text = string.Empty;
                    }
                    else
                    {
                        lblMessage.Text = $"Failed to delete product. {result}";
                        lblMessage.CssClass = "message error";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred: " + ex.Message;
                lblMessage.CssClass = "message error";
            }
        }
    }
}