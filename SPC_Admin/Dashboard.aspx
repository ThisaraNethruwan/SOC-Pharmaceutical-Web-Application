<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SPC_Admin.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
    </br>
<body class="font-['Poppins']">
    <form id="form1" runat="server">
        <div class="mx-auto px-auto py-auto max-w-7xl">
            <!-- Header with Logo and Logout -->
            <div class="flex justify-between items-center mb-8">
                <h1 class="text-3xl font-bold text-blue-800 flex items-center">
                    <i class="fas fa-tachometer-alt mr-3 text-blue-600"></i>Admin Dashboard
                </h1>
                <asp:LinkButton ID="btnLogout" runat="server" 
                    CssClass="bg-gradient-to-r from-red-500 to-red-700 text-white font-semibold py-2.5 px-5 rounded-lg shadow-lg hover:shadow-xl transition duration-300 ease-in-out transform hover:-translate-y-1 flex items-center gap-2" 
                    OnClick="btnLogout_Click">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </asp:LinkButton>
            </div>

            <!-- Quick Actions Section -->
            <div class="rounded-xl p-6 mb-8">
                <h2 class="text-xl font-bold text-gray-800 mb-6 flex items-center">
                    <i class="fas fa-bolt mr-2 text-amber-500"></i>Quick Actions
                </h2>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <!-- Add Account Card -->
                    <div class="group relative">
                        <div class="absolute -inset-1 bg-gradient-to-r from-emerald-600 to-teal-600 rounded-xl blur opacity-25 group-hover:opacity-70 transition duration-300"></div>
                        <asp:LinkButton ID="btnAddAccount" runat="server" 
                            CssClass="relative block w-full bg-white border border-gray-200 rounded-xl p-6 hover:shadow-xl transition duration-300" 
                            OnClick="btnAddAccount_Click">
                            <div class="flex flex-col items-center text-center">
                                <div class="w-16 h-16 bg-emerald-100 rounded-full flex items-center justify-center mb-4 group-hover:bg-emerald-200 transition duration-300">
                                    <i class="fas fa-user-plus text-2xl text-emerald-600"></i>
                                </div>
                                <h3 class="text-lg font-semibold text-gray-800 mb-2">Add Account</h3>
                                <p class="text-gray-500 text-sm">Create new user accounts and manage permissions</p>
                            </div>
                        </asp:LinkButton>
                    </div>

                    <!-- View Proposal Card -->
                    <div class="group relative">
                        <div class="absolute -inset-1 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-xl blur opacity-25 group-hover:opacity-70 transition duration-300"></div>
                        <asp:LinkButton ID="btnProposal" runat="server" 
                            CssClass="relative block w-full bg-white border border-gray-200 rounded-xl p-6 hover:shadow-xl transition duration-300" 
                            OnClick="btnProposal_Click">
                            <div class="flex flex-col items-center text-center">
                                <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mb-4 group-hover:bg-blue-200 transition duration-300">
                                    <i class="fas fa-file-contract text-2xl text-blue-600"></i>
                                </div>
                                <h3 class="text-lg font-semibold text-gray-800 mb-2">View Proposals</h3>
                                <p class="text-gray-500 text-sm">Review and manage submitted proposal documents</p>
                            </div>
                        </asp:LinkButton>
                    </div>
                     </div>
            <!-- Supplier Registration Approvals Section -->
            <div class="bg-white rounded-xl shadow-lg p-6 border border-gray-100">
                <h2 class="text-xl font-bold text-gray-800 mb-6 flex items-center">
                    <i class="fas fa-clipboard-check mr-2 text-blue-600"></i>
                    Supplier Registration Approvals
                </h2>

                <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="block w-full p-4 mb-6 rounded-lg font-medium"></asp:Label>

                <div class="overflow-x-auto">
                    <asp:GridView ID="gvSuppliers" runat="server" AutoGenerateColumns="False" 
                        CssClass="min-w-full bg-white border border-gray-200 rounded-lg overflow-hidden" 
                        OnRowCommand="gvSuppliers_RowCommand" 
                        DataKeyNames="id" OnRowDataBound="gvSuppliers_RowDataBound">
                        <HeaderStyle CssClass="bg-gradient-to-r from-blue-600 to-blue-700 text-white text-left py-3 px-4 font-medium" />
                        <RowStyle CssClass="border-b border-gray-200 hover:bg-gray-50" />
                        <AlternatingRowStyle CssClass="border-b border-gray-200 bg-gray-50 hover:bg-gray-100" />
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="ID" ItemStyle-CssClass="py-3 px-4" HeaderStyle-CssClass="py-3 px-4" />
                            <asp:BoundField DataField="company_name" HeaderText="Company Name" ItemStyle-CssClass="py-3 px-4" HeaderStyle-CssClass="py-3 px-4" />
                            <asp:BoundField DataField="name" HeaderText="Contact Name" ItemStyle-CssClass="py-3 px-4" HeaderStyle-CssClass="py-3 px-4" />
                            <asp:BoundField DataField="email" HeaderText="Email" ItemStyle-CssClass="py-3 px-4" HeaderStyle-CssClass="py-3 px-4" />
                            <asp:BoundField DataField="phone" HeaderText="Phone" ItemStyle-CssClass="py-3 px-4" HeaderStyle-CssClass="py-3 px-4" />
                            <asp:TemplateField HeaderText="Status" ItemStyle-CssClass="py-3 px-4" HeaderStyle-CssClass="py-3 px-4">
                                <ItemTemplate>
                                    <span class='<%# Convert.ToString(Eval("status")) == "Pending" ? 
                                        "bg-yellow-100 text-yellow-800 px-3 py-1 rounded-full text-xs font-medium flex items-center w-fit" : 
                                        Convert.ToString(Eval("status")) == "Approved" ? 
                                        "bg-green-100 text-green-800 px-3 py-1 rounded-full text-xs font-medium flex items-center w-fit" : 
                                        "bg-gray-100 text-gray-800 px-3 py-1 rounded-full text-xs font-medium flex items-center w-fit" %>'>
                                        <i class='<%# Convert.ToString(Eval("status")) == "Pending" ? 
                                            "fas fa-clock mr-1" : 
                                            Convert.ToString(Eval("status")) == "Approved" ? 
                                            "fas fa-check mr-1" : 
                                            "fas fa-times mr-1" %>'></i>
                                        <%# Eval("status") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions" ItemStyle-CssClass="py-3 px-4" HeaderStyle-CssClass="py-3 px-4">
                                <ItemTemplate>
                                    <asp:Button ID="btnApprove" runat="server" 
                                        Text="Approve" 
                                        CommandName="ApproveSupplier" 
                                        CommandArgument='<%# Eval("id") %>' 
                                        CssClass='<%# Convert.ToString(Eval("status")) == "Approved" ? 
                                            "bg-gray-400 text-white font-medium py-2 px-4 rounded-lg cursor-not-allowed" : 
                                            "bg-gradient-to-r from-green-500 to-green-600 hover:from-green-600 hover:to-green-700 text-white font-medium py-2 px-4 rounded-lg transition duration-300 ease-in-out cursor-pointer shadow-md hover:shadow-lg" %>' 
                                        Enabled='<%# Convert.ToString(Eval("status")) != "Approved" %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <asp:Label ID="Label1" runat="server" CssClass="mt-4 text-green-600 font-medium block"></asp:Label>
            </div>
        </div>
    </form>

    <script>
        // Fix for Font Awesome icons in ASP.NET buttons
        $(document).ready(function () {
            $('input[type="submit"], input[type="button"]').each(function () {
                var buttonText = $(this).attr('value');
                if (buttonText && buttonText.includes('<i class')) {
                    var $buttonWrapper = $('<div>').addClass($(this).attr('class'));
                    $(this).removeClass();
                    $(this).wrap($buttonWrapper);
                    $(this).parent().html(buttonText);
                }
            });
        });
    </script>
</body>
    <style>
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 8px;
            font-weight: bold;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .success {
            background-color: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .error {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }
    </style>
</html>