using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WereHouse
{
    public partial class WebForm3 : System.Web.UI.Page
    {
         protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtQuantity.Text = "1"; 
            }
        }

        protected void btnAddProduct_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    // Create instance of the web service
                    WarehouseServiceReference.WebService1SoapClient service = 
                        new WarehouseServiceReference.WebService1SoapClient();

                    // Parse and validate values from form
                    string productName = txtProductName.Text.Trim();
                    string description = string.IsNullOrWhiteSpace(txtDescription.Text) ? 
                        "No description provided" : txtDescription.Text.Trim();
                    int quantity = int.Parse(txtQuantity.Text.Trim());
                    decimal price = decimal.Parse(txtPrice.Text.Trim());

                    // Call the web service method
                    string result = service.AddProduct(
                        productName,
                        description,  
                        quantity,
                        price
                    );

                    if (result.ToLower() == "success")
                    {
                        lblMessage.Text = "Product added successfully!";
                        lblMessage.CssClass = "message success";
                        ClearForm();
                    }
                    else
                    {
                        lblMessage.Text = $" {result}";
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

        private void ClearForm()
        {
            txtProductName.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtQuantity.Text = "1"; 
            txtPrice.Text = string.Empty;
        }
    }
}

