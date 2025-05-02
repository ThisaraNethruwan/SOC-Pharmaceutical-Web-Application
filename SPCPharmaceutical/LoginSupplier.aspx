<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginSupplier.aspx.cs" Inherits="SPCPharmaceutical.WebForm2" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Supplier Login | SPC Pharmaceutical</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-4">
    <form id="form1" runat="server" class="w-full max-w-md">
        <div class="bg-white rounded-lg shadow-lg p-8">
            <!-- Logo and Header -->
            <div class="text-center mb-8">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-blue-600 rounded-full mb-4">
                    <i class="fas fa-pills text-white text-2xl"></i>
                </div>
                <h1 class="text-2xl font-bold text-gray-800">Supplier Login</h1>
                <p class="text-gray-500 mt-2">Access your supplier account</p>
            </div>
            
            <!-- Error Message -->
            <asp:Label ID="lblMessage" runat="server" EnableViewState="false" CssClass="mb-4 p-3 rounded-md text-sm font-medium error-message hidden"></asp:Label>
            <script type="text/javascript">
                // Show error message if it has content
                window.onload = function() {
                    var label = document.getElementById('<%= lblMessage.ClientID %>');
                    if (label.innerHTML.trim() !== '') {
                        label.classList.remove('hidden');
                        label.classList.add('bg-red-100', 'text-red-800', 'border', 'border-red-200');
                    }
                }
            </script>
            
            <!-- Email Field -->
            <div class="mb-6">
                <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="block text-sm font-medium text-gray-700 mb-2">Email Address</asp:Label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-envelope text-gray-400"></i>
                    </div>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="pl-10 w-full py-3 px-4 rounded-md border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none transition duration-150 ease-in-out" placeholder="your.email@example.com"></asp:TextBox>
                </div>
            </div>
            
            <!-- Password Field -->
            <div class="mb-6">
                <div class="flex items-center justify-between mb-2">
                    <asp:Label runat="server" AssociatedControlID="txtPassword" CssClass="block text-sm font-medium text-gray-700">Password</asp:Label>
                    <a href="#" class="text-sm text-blue-600 hover:text-blue-800 transition duration-150 ease-in-out">Forgot password?</a>
                </div>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-lock text-gray-400"></i>
                    </div>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="pl-10 w-full py-3 px-4 rounded-md border border-gray-300 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 focus:outline-none transition duration-150 ease-in-out" placeholder="••••••••"></asp:TextBox>
                </div>
            </div>
            
            <!-- Remember Me Checkbox (Optional) -->
            <div class="mb-6 flex items-center">
                <input id="remember_me" type="checkbox" class="h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500">
                <label for="remember_me" class="ml-2 block text-sm text-gray-700">Remember me</label>
            </div>
            
            <!-- Login Button -->
            <div class="mb-6">
                <asp:Button ID="btnLogin" runat="server" Text="Sign In" OnClick="btnLogin_Click" CssClass="w-full flex justify-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-150 ease-in-out" />
            </div>
            
            <!-- Registration Link -->
            <div class="text-center text-sm">
                <span class="text-gray-600">Don't have an account?</span>
                <a href="RegisterSupplier.aspx" class="font-medium text-blue-600 hover:text-blue-500 ml-1 transition duration-150 ease-in-out">Register now</a>
            </div>
        </div>
       
    </form>
</body>
</html>