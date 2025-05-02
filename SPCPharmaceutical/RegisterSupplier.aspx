<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterSupplier.aspx.cs" Inherits="SPCPharmaceutical.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  
   <title>Supplier Registration</title>
   <style>
        .form-container {
            max-width: 650px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group input[type="email"],
        .form-group textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    .error-message {
    background-color: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
    padding: 10px;
    margin-bottom: -20px; /* Added margin-bottom of -20px */
    border-radius: 4px;
    font-weight: bold;
}

.success-message {
    background-color: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
    padding: 10px;
    margin-bottom: -20px; /* Added margin-bottom of -20px */
    border-radius: 4px;
    font-weight: bold;
}

        .btn-register {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-register:hover {
            background-color: #0056b3;
        }
        .password-requirements {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>Supplier Registration</h2>
            
            <asp:Label ID="lblMessage" runat="server" EnableViewState="false"></asp:Label>
            
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtCompanyName">Company Name</asp:Label>
                <asp:TextBox ID="txtCompanyName" runat="server" MaxLength="100"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtName">Name</asp:Label>
                <asp:TextBox ID="txtName" runat="server" MaxLength="100"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtEmail">Email</asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" MaxLength="100" TextMode="Email"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtPhone">Phone</asp:Label>
                <asp:TextBox ID="txtPhone" runat="server" MaxLength="20"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtAddress">Address</asp:Label>
                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="txtPassword">Password</asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                <div class="password-requirements">
                    Password must contain at least 8 characters, including uppercase, lowercase, number, and special character.
                </div>
            </div>
            
            <div class="form-group">
                <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass="btn-register" />
            </div>
        </div>
    </form>
</body>
</html>
