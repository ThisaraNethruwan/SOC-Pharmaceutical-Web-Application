using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SPC_Pharmacy
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        PlaceOrderServiceReference.WebService1SoapClient orderService = new PlaceOrderServiceReference.WebService1SoapClient();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
            }
        }

        private void LoadProducts()
        {
            try
            {
                DataSet ds = orderService.GetProducts();
                ddlProducts.DataSource = ds.Tables["Products"];
                ddlProducts.DataTextField = "ProductName";
                ddlProducts.DataValueField = "ProductID";
                ddlProducts.DataBind();

                ddlProducts.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Product --", ""));
                UpdateProductInfo();
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading products: {ex.Message}", false);
            }
        }

        protected void ddlProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateProductInfo();
        }

        private void UpdateProductInfo()
        {
            if (string.IsNullOrEmpty(ddlProducts.SelectedValue))
            {
                lblProductInfo.Text = "";
                return;
            }

            try
            {
                DataSet ds = orderService.GetProducts();
                DataRow[] selectedProduct = ds.Tables["Products"].Select($"ProductID = {ddlProducts.SelectedValue}");

                if (selectedProduct.Length > 0)
                {
                    decimal price = Convert.ToDecimal(selectedProduct[0]["Price"]);
                    int stock = Convert.ToInt32(selectedProduct[0]["Quantity"]);

                    lblProductInfo.Text = $"Price: ${price:F2}<br/>Available Stock: {stock}";
                }
            }
            catch (Exception ex)
            {
                ShowMessage($"Error loading product details: {ex.Message}", false);
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate input
                if (string.IsNullOrEmpty(ddlProducts.SelectedValue))
                {
                    ShowMessage("Please select a product.", false);
                    return;
                }

                if (!int.TryParse(txtQuantity.Text, out int quantity) || quantity <= 0)
                {
                    ShowMessage("Please enter a valid quantity.", false);
                    return;
                }

                int productId = Convert.ToInt32(ddlProducts.SelectedValue);

                // Assuming the customer ID is available somehow; adjust as necessary
                int customerId = 1;  

                // Place the order
                int newOrderId = orderService.PlaceNewOrder(productId, quantity, customerId);

                ShowMessage($"Order placed successfully!<br/>Order ID: {newOrderId}<br/>Product: {ddlProducts.SelectedItem.Text}<br/>Quantity: {quantity}", true);

                // Reset the form
                ddlProducts.SelectedIndex = 0;
                txtQuantity.Text = "";
                UpdateProductInfo();
            }
            catch (Exception ex)
            {
                ShowMessage($"Error placing order: {ex.Message}", false);
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            pnlMessage.Visible = true;
            pnlMessage.CssClass = $"message {(isSuccess ? "success" : "error")}";
            lblMessage.Text = message;
        }
    }
}
