<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchOrders.aspx.cs" Inherits="SPC_Pharmacy.WebForm4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Search Product</title>
     <style>

        body {
           
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
        
            padding: 30px;
           
            width: 400px;
            text-align: center;
        }

        h2 {
            color: black;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        input:focus {
            border-color: #007bff;
            outline: none;
        }

        .btn-search {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .btn-search:hover {
            background-color: #0056b3;
        }

        .message {
            font-size: 18px;
            margin-top: 15px;
            padding: 10px;
            border-radius: 4px;
            text-align:left;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Search Product by Product ID</h2>

            <div class="form-group">
                <label for="txtProductID">Enter Product ID:</label>
                <asp:TextBox ID="txtProductID" runat="server" />
            </div>

            <div class="form-group">
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearch_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="message" /><br /><br /><br />
            <asp:Label ID="lblProductDetails" runat="server" CssClass="message" />
        </div>
    </form>
</body>
</html>
