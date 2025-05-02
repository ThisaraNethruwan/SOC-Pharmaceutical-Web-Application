<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WerehouseLogin.aspx.cs" Inherits="WereHouse.WebForm2" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Warehouse Login | Inventory Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center p-4">
    <form id="form1" runat="server" class="w-full max-w-md">
        <div class="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
            <!-- Logo and Header -->
            <div class="text-center mb-8">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-indigo-600 rounded-full mb-4">
                    <i class="fas fa-warehouse text-white text-2xl"></i>
                </div>
                <h1 class="text-2xl font-bold text-gray-800">Warehouse Login</h1>
                <p class="text-gray-500 mt-2">Access your inventory management system</p>
            </div>
            
            <!-- Email Field -->
            <div class="mb-6">
                <label for="txtEmail" class="block text-sm font-medium text-gray-700 mb-2">Email Address</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-envelope text-gray-400"></i>
                    </div>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" 
                        CssClass="pl-10 w-full py-3 px-4 rounded-lg border border-gray-300 focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 focus:outline-none transition duration-150 ease-in-out" 
                        placeholder="your.email@company.com">
                    </asp:TextBox>
                </div>
            </div>
            
            <!-- Password Field -->
            <div class="mb-6">
                <div class="flex items-center justify-between mb-2">
                    <label for="txtPassword" class="block text-sm font-medium text-gray-700">Password</label>
                    <a href="#" class="text-sm text-indigo-600 hover:text-indigo-800 transition duration-150 ease-in-out">
                        Forgot password?
                    </a>
                </div>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-lock text-gray-400"></i>
                    </div>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                        CssClass="pl-10 w-full py-3 px-4 rounded-lg border border-gray-300 focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 focus:outline-none transition duration-150 ease-in-out" 
                        placeholder="••••••••">
                    </asp:TextBox>
                </div>
            </div>
            
            <!-- Remember Me Checkbox -->
            <div class="mb-6 flex items-center">
                <input id="remember_me" type="checkbox" class="h-4 w-4 text-indigo-600 border-gray-300 rounded focus:ring-indigo-500">
                <label for="remember_me" class="ml-2 block text-sm text-gray-700">Remember me</label>
            </div>
            
            <!-- Login Button -->
            <div class="mb-4">
                <asp:Button ID="btnLogin" runat="server" Text="Sign In" OnClick="btnLogin_Click" 
                    CssClass="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-base font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 transition duration-150 ease-in-out" />
            </div>
            
            <!-- Error Message -->
            <div class="text-center mt-4">
                <asp:Label ID="lblMessage" runat="server" CssClass="text-red-600 text-sm font-medium"></asp:Label>
            </div>
        </div>
        
      
    </form>
</body>
</html>