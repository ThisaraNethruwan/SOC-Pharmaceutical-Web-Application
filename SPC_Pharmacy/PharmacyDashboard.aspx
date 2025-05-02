<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PharmacyDashboard.aspx.cs" Inherits="SPC_Pharmacy.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Pharmacy Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
    <style>
        :root {
            --primary-color: #2C3E50;
            --secondary-color: #3498DB;
            --accent-color: #E74C3C;
            --light-gray: #ECF0F1;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f6fa;
        }

        .navbar {
            background-color: var(--primary-color);
            padding: 1rem;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .welcome-text {
            font-size: 1.2rem;
        }

        .logout-btn {
            background-color: var(--accent-color);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 2rem;
            margin-top: 2rem;
        }

        .profile-section {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .profile-header {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
        }

        .profile-icon {
            font-size: 3rem;
            color: var(--secondary-color);
            margin-right: 1rem;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1rem;
            margin-top: 2rem;
        }

        .dashboard-button {
            padding: 1rem;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: transform 0.2s;
            text-align: center;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .order-btn {
            background-color: var(--secondary-color);
            color: white;
        }

        .search-btn {
            background-color: var(--primary-color);
            color: white;
        }

        .dashboard-button:hover {
            transform: translateY(-2px);
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-control {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-top: 0.5rem;
        }

        .btn-update {
            background-color: var(--secondary-color);
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
        }

        .message {
            padding: 1rem;
            border-radius: 4px;
            margin-bottom: 1rem;
        }

        .success {
            background-color: #2ecc71;
            color: white;
        }

        .error {
            background-color: var(--accent-color);
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <div class="navbar">
            <div class="welcome-text">
                Welcome, <asp:Label ID="lblPharmacyName" runat="server"></asp:Label>
            </div>
            <asp:LinkButton ID="btnLogout" runat="server" CssClass="logout-btn" OnClick="btnLogout_Click">
                <i class="fas fa-sign-out-alt"></i> Logout
            </asp:LinkButton>
        </div>

        <div class="container">
            <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label>

            <div class="dashboard-grid">
                <div class="profile-section">
                    <div class="profile-header">
                        <i class="fas fa-user-circle profile-icon"></i>
                        <h2>Profile Details</h2>
                    </div>

                    <div class="form-group">
                        <label for="txtPharmacyName">Pharmacy Name</label>
                        <asp:TextBox ID="txtPharmacyName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="txtEmail">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="txtPhone">Phone Number</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label for="txtAddress">Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" CssClass="btn-update" OnClick="btnUpdateProfile_Click" />
                </div>

                <div class="action-buttons">
                    <asp:LinkButton ID="btnPlaceOrder" runat="server" CssClass="dashboard-button order-btn" OnClick="btnPlaceOrder_Click">
                        <i class="fas fa-shopping-cart"></i>&nbsp; Place Order
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnSearchProduct" runat="server" CssClass="dashboard-button search-btn" OnClick="btnSearchProduct_Click">
                        <i class="fas fa-search"></i>&nbsp; Search Product
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </form>
</body>