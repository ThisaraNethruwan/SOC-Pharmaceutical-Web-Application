<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlaceOrder.aspx.cs" Inherits="SPC_Pharmacy.WebForm3" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Place Order</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3b82f6',
                        'primary-dark': '#2563eb',
                        'primary-light': '#60a5fa',
                        success: '#10b981',
                        error: '#ef4444',
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center p-4">
    <form id="form1" runat="server" class="w-full max-w-lg">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        
        <div class="bg-white rounded-lg shadow-xl p-8 border border-gray-100">
            <div class="mb-8 text-center">
                <h2 class="text-2xl font-bold text-gray-800">Place New Order</h2>
                <p class="text-gray-500 mt-2">Complete the form below to place your order</p>
            </div>
            
            <div class="mb-6">
                <label for="ddlProducts" class="block text-sm font-medium text-gray-700 mb-2">Select Product</label>
                <div class="relative">
                    <asp:DropDownList ID="ddlProducts" runat="server" AutoPostBack="true" 
                        OnSelectedIndexChanged="ddlProducts_SelectedIndexChanged" 
                        CssClass="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring focus:ring-primary focus:ring-opacity-50 bg-white py-2 px-3 border appearance-none">
                    </asp:DropDownList>
                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                            <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/>
                        </svg>
                    </div>
                </div>
                <asp:RequiredFieldValidator ID="rfvProduct" runat="server" 
                    ControlToValidate="ddlProducts" 
                    ErrorMessage="Please select a product" 
                    CssClass="text-error text-xs mt-1 block">
                </asp:RequiredFieldValidator>
            </div>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="mb-6 bg-green-50 p-4 rounded-md border border-green-100">
                        <asp:Label ID="lblProductInfo" runat="server" CssClass="text-success text-md"></asp:Label>
                    </div>

                    <div class="mb-6">
                        <label for="txtQuantity" class="block text-sm font-medium text-gray-700 mb-2">Quantity</label>
                        <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" min="1" 
                            CssClass="block w-full rounded-md border-gray-300 shadow-sm focus:border-primary focus:ring focus:ring-primary focus:ring-opacity-50 bg-white py-2 px-3 border">
                        </asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" 
                            ControlToValidate="txtQuantity" 
                            ErrorMessage="Quantity is required" 
                            CssClass="text-error text-xs mt-1 block">
                        </asp:RequiredFieldValidator>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlProducts" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
            
            <div class="mt-8">
                <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" 
                    OnClick="btnPlaceOrder_Click" 
                    CssClass="w-full bg-primary hover:bg-primary-dark text-white font-bold py-3 px-4 rounded-md transition duration-300 ease-in-out transform hover:scale-105 focus:outline-none focus:ring-2 focus:ring-primary focus:ring-opacity-50" />
            </div>
            
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="mt-6 p-4 rounded-md text-center">
                <asp:Label ID="lblMessage" runat="server" CssClass="font-medium"></asp:Label>
            </asp:Panel>
        </div>
    </form>

    <script>
        // Add JavaScript to apply conditional classes to the message panel
        function setMessageStyle(type) {
            var panel = document.getElementById('<%= pnlMessage.ClientID %>');
            if (panel) {
                if (type === 'success') {
                    panel.className = 'mt-6 p-4 rounded-md text-center bg-green-50 border border-green-100 text-success';
                } else if (type === 'error') {
                    panel.className = 'mt-6 p-4 rounded-md text-center bg-red-50 border border-red-100 text-error';
                }
            }
        }
    </script>
</body>
    <style>
      .message {
            margin-top: 15px;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
        }

        .message.success {
            background-color: #d4edda;
            color:green;
          
           
        }

        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .required-field-validator {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }
    </style>
</html>