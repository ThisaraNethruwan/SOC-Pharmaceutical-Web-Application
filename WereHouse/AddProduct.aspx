<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="WereHouse.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>Add Product</title>
    <style type="text/css">
        .container {
            width: 50%;
            margin: 20px auto;
            padding: 20px;
           
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            box-sizing: border-box;
        }
        .message {
            margin-top: 10px;
            padding: 10px;
        }
        .success { color: green; }
        .error { color: green; }
        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }
           .btn-submit {
       background-color: #007bff;
       color: white;
       padding: 10px 20px;
       border: none;
       border-radius: 4px;
       cursor: pointer;
   }
   .btn-submit:hover {
       background-color: #0056b3;
   }

    </style>
</head>
<body>
    <form id="form1" runat="server">
          <div class="container">
            <h2>Add New Product</h2>
            <div class="form-group">
                <label>Product Name:</label>
                <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvProductName" runat="server" 
                    ControlToValidate="txtProductName" 
                    ErrorMessage="Product name is required" 
                    ForeColor="Red">
                </asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label>Description:</label>
                <asp:TextBox ID="txtDescription" runat="server" 
                    TextMode="MultiLine" 
                    Rows="4" 
                    CssClass="form-control">
                </asp:TextBox>
            </div>

            <div class="form-group">
                <label>Quantity:</label>
                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" 
                    ControlToValidate="txtQuantity" 
                    ErrorMessage="Quantity is required" 
                    ForeColor="Red">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revQuantity" runat="server" 
                    ControlToValidate="txtQuantity" 
                    ErrorMessage="Please enter a valid number" 
                    ValidationExpression="^\d+$" 
                    ForeColor="Red">
                </asp:RegularExpressionValidator>
            </div>

            <div class="form-group">
                <label>Price:</label>
                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPrice" runat="server" 
                    ControlToValidate="txtPrice" 
                    ErrorMessage="Price is required" 
                    ForeColor="Red">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPrice" runat="server" 
                    ControlToValidate="txtPrice" 
                    ErrorMessage="Please enter a valid price" 
                    ValidationExpression="^\d+(\.\d{1,2})?$" 
                    ForeColor="Red">
                </asp:RegularExpressionValidator>
            </div>

            <div class="form-group">
                <asp:Button ID="btnAddProduct" runat="server" 
                    Text="Add Product" 
                    OnClick="btnAddProduct_Click" 
                    CssClass="btn-submit" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>
   
</body>
</html>
