<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateProduct.aspx.cs" Inherits="WereHouse.WebForm6" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Product Management</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
        }

        .container {
            width: 100%;
        }

        h2 {
            color: #333;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }

        .input-field {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .error {
            color: #dc3545;
            font-size: 14px;
            margin-bottom: 10px;
            display: block;
        }

        .btn {
            background-color: #1e90ff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #187bcd;
        }

        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
            display: block;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
        }

        .error-message {
            background-color: #f8d7da;
            color: #721c24;
        }

        #txtUpdateDescription {
            min-height: 60px;
        }
    </style>
</head>
<body>
   <div class="container">
        <h2>Update Product</h2>
        <form id="form1" runat="server">
            <asp:Label ID="lblUpdateMessage" runat="server" CssClass="message"></asp:Label>
            
            <label for="txtUpdateProductID">Product ID:</label>
            <asp:TextBox ID="txtUpdateProductID" runat="server" CssClass="input-field"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvProductID" runat="server" ControlToValidate="txtUpdateProductID"
                ErrorMessage="Product ID is required!" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            
            <label for="txtUpdateProductName">Product Name:</label>
            <asp:TextBox ID="txtUpdateProductName" runat="server" CssClass="input-field"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvProductName" runat="server" ControlToValidate="txtUpdateProductName"
                ErrorMessage="Product name is required!" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            
            <label for="txtUpdateDescription">Description:</label>
            <asp:TextBox ID="txtUpdateDescription" runat="server" CssClass="input-field" TextMode="MultiLine"></asp:TextBox>
            
            <label for="txtUpdateQuantity">Quantity:</label>
            <asp:TextBox ID="txtUpdateQuantity" runat="server" CssClass="input-field"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ControlToValidate="txtUpdateQuantity"
                ErrorMessage="Quantity is required!" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="rvQuantity" runat="server" ControlToValidate="txtUpdateQuantity"
                MinimumValue="1" MaximumValue="10000" Type="Integer"
                ErrorMessage="Quantity must be between 1 and 10,000!" CssClass="error" Display="Dynamic"></asp:RangeValidator>
            
            <label for="txtUpdatePrice">Price:</label>
            <asp:TextBox ID="txtUpdatePrice" runat="server" CssClass="input-field"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtUpdatePrice"
                ErrorMessage="Price is required!" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="rvPrice" runat="server" ControlToValidate="txtUpdatePrice"
                MinimumValue="0.01" MaximumValue="100000" Type="Double"
                ErrorMessage="Price must be greater than 0!" CssClass="error" Display="Dynamic"></asp:RangeValidator>
            
            <asp:Button ID="btnUpdateProduct" runat="server" CssClass="btn" Text="Update Product" OnClick="btnUpdateProduct_Click" />
        </form>
    </div>
</body>
</html>