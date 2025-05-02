<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddAccount.aspx.cs" Inherits="SPC_Admin.WebForm4" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Account Registration</title>
    <style>
        body {
          
            max-width: 600px;
            margin: 30px auto;
           
            background-color: #ffffff;
        }

        .registration-container {
            width: 100%;
        }

        .registration-header {
           
            margin-bottom: 12px;
           

        }

        .registration-header h2 {
            font-size: 25px;
            font-weight: 700;
            color: #000000;
            margin: 0;
        }

        .registration-form {
            max-width: 600px;
  margin: 0 auto;
  padding: 20px;
        }

       .form-group {
      margin-bottom: 12px;
  }
  .form-group label {
      display: block;
      margin-bottom: 5px;
  }

        .form-control, 
        .form-select {
            width: 100%;
            padding: 8px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }

        textarea.form-control {
            width: 100%;
 padding: 8px;
 border: 1px solid #ddd;
 border-radius: 4px;
        }

        .row {
            margin-bottom: 20px;
        }

        .btn-register {
            background-color: #007bff;
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-register:hover {
            background-color: #0056b3;
        }

        .alert {
            padding: 12px;
            margin-top: 20px;
            border-radius: 4px;
            display: none;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .password-hint {
            font-size: 12px;
            color: #666666;
            margin-top: 4px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
       <div class="registration-container">
            <div class="registration-header">
                <h2>Account Registration</h2>
            </div>
            
            <div class="registration-form">
                <div class="form-group">
                    <label for="ddlAccountType">Account Type</label>
                    <asp:DropDownList ID="ddlAccountType" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Select Account Type" Value="" />
                        <asp:ListItem Text="Admin" Value="Admin" />
                        <asp:ListItem Text="Warehouse" Value="Warehouse" />
                        <asp:ListItem Text="Pharmacy" Value="Pharmacy" />
                    </asp:DropDownList>
                </div>
                
                <div class="form-group">
                    <label for="txtCompanyName">Company Name</label>
                    <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group">
                    <label for="txtName">Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                </div>
                
                <div class="form-group">
                    <label for="txtEmail">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                </div>

                <div class="form-group">
                    <label for="txtPhone">Phone</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group">
                    <label for="txtAddress">Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" />
                </div>

                <div class="form-group">
                    <label for="txtPassword">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    <div class="password-hint">Password must be 8 characters, including uppercase, lowercase, number, and special character.</div>
               
                </div>
                
                <div class="form-group">
                    <label for="txtConfirmPassword">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" />
                </div>

                <div style="text-align: left;">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn-register" Text="Register" OnClick="btnSubmit_Click" />
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="alert" role="alert"></asp:Label>
            </div>
        </div>
    </form>

    <script>
        function setMessageStyle() {
            var label = document.getElementById('<%= lblMessage.ClientID %>');
            if (label.innerHTML.trim() !== '') {
                label.style.display = 'block';
                if (label.style.color === 'green') {
                    label.className = 'alert alert-success';
                } else {
                    label.className = 'alert alert-danger';
                }
            }
        }
        window.onload = setMessageStyle;
    </script>
</body>
</html>