<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteProduct.aspx.cs" Inherits="WereHouse.WebForm5" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Delete Product</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
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

        #txtProductID {
            width: 100%;
            padding: 8px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        #btnDeleteProduct {
            background-color: #1e90ff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #btnDeleteProduct:hover {
            background-color: #187bcd;
        }

        .message {
            padding: 10px;
            margin-top: 10px;
            border-radius: 4px;
            display: block;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
        }

        .error {
            background-color: white;
            color: green;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Delete Product</h2>
        
        <label for="txtProductID">Product ID:</label>
        <asp:TextBox ID="txtProductID" runat="server" required></asp:TextBox>
        
        <asp:Button ID="btnDeleteProduct" runat="server" Text="Delete Product" OnClick="btnDeleteProduct_Click" />
        <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
    </form>
</body>
</html>