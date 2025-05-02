<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="SPC_Admin.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login | Control Panel</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center p-4">
    <!-- Decorative Background Elements -->
    <div class="fixed top-0 left-0 w-64 h-64 bg-purple-600 rounded-full mix-blend-multiply filter blur-3xl opacity-10"></div>
    <div class="fixed bottom-0 right-0 w-64 h-64 bg-blue-600 rounded-full mix-blend-multiply filter blur-3xl opacity-10"></div>
    
    <form id="form1" runat="server" class="w-full max-w-md relative z-10">
        <div class="bg-white rounded-xl shadow-lg p-8 border border-gray-100">
            <!-- Logo and Header -->
            <div class="text-center mb-8">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-teal-500 rounded-full mb-4">
                    <i class="fas fa-user-shield text-white text-2xl"></i>
                </div>
                <h1 class="text-2xl font-bold text-gray-800">Admin Login</h1>
                <p class="text-gray-500 mt-2">Access the administrative control panel</p>
            </div>
            
            <!-- Error Message -->
            <asp:Label ID="lblError" runat="server" CssClass="mb-6 p-3 rounded-lg text-sm font-medium bg-red-100 text-red-800 border border-red-200 w-full block text-center" Visible="false"></asp:Label>
            
            <!-- Email Field -->
            <div class="mb-6">
                <label for="txtEmail" class="block text-sm font-medium text-gray-700 mb-2">Email Address</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-envelope text-gray-400"></i>
                    </div>
                    <asp:TextBox ID="txtEmail" runat="server" 
                        CssClass="pl-10 w-full py-3 px-4 rounded-lg border border-gray-300 focus:ring-2 focus:ring-purple-500 focus:border-purple-500 focus:outline-none transition duration-150 ease-in-out" 
                        placeholder="admin@example.com" required>
                    </asp:TextBox>
                </div>
            </div>
            
            <!-- Password Field -->
            <div class="mb-6">
                <div class="flex items-center justify-between mb-2">
                    <label for="txtPassword" class="block text-sm font-medium text-gray-700">Password</label>
                    <a href="#" class="text-sm text-teal-600 hover:text-green-600 transition duration-150 ease-in-out">
                        Forgot password?
                    </a>
                </div>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <i class="fas fa-lock text-gray-400"></i>
                    </div>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                        CssClass="pl-10 w-full py-3 px-4 rounded-lg border border-gray-300 focus:ring-2 focus:ring-purple-500 focus:border-teal-500 focus:outline-none transition duration-150 ease-in-out" 
                        placeholder="••••••••" required>
                    </asp:TextBox>
                </div>
            </div>
            
            <!-- Remember Me Checkbox -->
            <div class="mb-6 flex items-center">
                <input id="remember_me" type="checkbox" class="h-4 w-4 text-purple-600 border-gray-300 rounded focus:ring-purple-500">
                <label for="remember_me" class="ml-2 block text-sm text-gray-700">Remember this device</label>
            </div>
            
            <!-- Login Button -->
            <div class="mb-4">
                <asp:Button ID="btnLogin" runat="server" Text="Sign In" OnClick="btnLogin_Click" 
                    CssClass="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-base font-medium text-white bg-teal-500 hover:bg-teal-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500 transition duration-150 ease-in-out transform hover:-translate-y-0.5" />
            </div>
        </div>
        
        <!-- Security Notice -->
        <div class="mt-8 text-center">
            <p class="text-sm text-gray-600 flex items-center justify-center">
                <i class="fas fa-shield-alt mr-2 text-gray-500"></i>
                <span>Secure login. All activities are monitored and logged.</span>
            </p>
        </div>
    </form>
</body>
</html>