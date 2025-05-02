<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WereHouse.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Warehouse Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }

        .top-bar {
            background-color: #2c3e50;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-bar h2 {
            margin: 0;
            font-size: 1.2rem;
        }

        #btnLogout {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
        }

        .container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            padding: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .profile-card {
            background: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }

        .profile-icon {
            width: 40px;
            height: 40px;
            background-color: #3498db;
            border-radius: 50%;
            margin-right: 15px;
        }

        .profile-header h2 {
            margin: 0;
            font-size: 1.5rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }

        .form-group input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        #btnUpdate {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
        }

        .right-column {
            display: grid;
            grid-template-rows: repeat(3, auto);
            gap: 20px;
        }

        .action-card {
            background: #3498db;
            border-radius: 8px;
            padding: 25px;
            color: white;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .nav-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .nav-link {
            background: #3498db;
            color: white;
            text-decoration: none;
            padding: 15px;
            border-radius: 6px;
            text-align: center;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        .nav-link:hover {
            background: #2980b9;
        }

        .action-button {
            background-color: white;
            color: #3498db;
            border: none;
            padding: 12px 24px;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 750;
            text-decoration: none;
            margin-top: 60px;
        }

        #lblMessage {
            margin-top: 15px;
            display: block;
            padding: 10px;
            border-radius: 4px;
        }

        .success {
            background-color: #2ecc71;
            color: white;
        }

        .error {
            background-color: #e74c3c;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="top-bar">
            <h2>Welcome, <asp:Label ID="lblWarehouseName" runat="server" Text=""></asp:Label></h2>
            <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" />
        </div>

        <div class="container">
            <div class="profile-card">
                <div class="profile-header">
                    <div class="profile-icon"></div>
                    <h2>Profile Details</h2>
                </div>

                <div class="form-group">
                    <label>Company Name:</label>
                    <asp:TextBox ID="txtCompanyName" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Warehouse Name:</label>
                    <asp:TextBox ID="txtWarehouseName" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Email:</label>
                    <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Address:</label>
                    <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Phone:</label>
                    <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                </div>

                <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" OnClick="btnUpdate_Click" />
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </div>

            <div class="nav-grid">
                <a href="AddProduct.aspx" class="nav-link">Add Product</a>
                <a href="ViewProduct.aspx" class="nav-link">View Products</a>
                <a href="DeleteProduct.aspx" class="nav-link">Delete Product</a>
                <a href="UpdateProduct.aspx" class="nav-link">Update Product</a>
                <a href="ViewOrders.aspx" class="nav-link">View Orders</a> <!-- New Link for View Orders -->
            </div>
        </div>
    </form>
</body>
</html>
