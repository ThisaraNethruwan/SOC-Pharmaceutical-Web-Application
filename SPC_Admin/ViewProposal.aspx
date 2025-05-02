<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm5.aspx.cs" Inherits="SPC_Admin.WebForm5" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Proposals</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>
<body class="bg-gray-50">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        
        <div class="container mx-auto px-4 py-8">
            <div class="bg-white rounded-xl shadow-lg p-6 mb-8">
                <div class="flex items-center justify-between mb-6 pb-4 border-b border-indigo-200">
                    <h2 class="text-2xl font-bold text-gray-800">
                        <i class="fas fa-clipboard-list text-indigo-600 mr-2"></i>View Proposals
                    </h2>
                    <div class="flex space-x-2">
                        <button type="button" class="bg-indigo-100 text-indigo-600 px-4 py-2 rounded-lg flex items-center hover:bg-indigo-200 transition duration-150">
                            <i class="fas fa-filter mr-2"></i>Filter
                        </button>
                        <button type="button" class="bg-indigo-100 text-indigo-600 px-4 py-2 rounded-lg flex items-center hover:bg-indigo-200 transition duration-150">
                            <i class="fas fa-download mr-2"></i>Export
                        </button>
                    </div>
                </div>
                
                <asp:Label ID="lblMessage" runat="server" CssClass="hidden mb-4 p-4 rounded-lg text-sm bg-blue-100 text-blue-800 border border-blue-200" Visible="false">
                    <i class="fas fa-info-circle mr-2"></i><span id="messageText" runat="server"></span>
                </asp:Label>
                
                <div class="overflow-x-auto">
                    <asp:GridView ID="gvProposals" runat="server" 
                        CssClass="min-w-full bg-white border border-gray-200 rounded-lg overflow-hidden"
                        AutoGenerateColumns="False" 
                        AllowPaging="True" 
                        PageSize="10" 
                        OnPageIndexChanging="gvProposals_PageIndexChanging"
                        GridLines="None"
                        CellPadding="0"
                        CellSpacing="0">
                        <HeaderStyle CssClass="bg-indigo-600 text-white text-left py-4 px-6 font-medium text-sm uppercase tracking-wider" />
                        <RowStyle CssClass="border-b border-gray-200 hover:bg-gray-50 transition duration-150" />
                        <AlternatingRowStyle CssClass="bg-gray-50 border-b border-gray-200 hover:bg-gray-100 transition duration-150" />
                        <PagerStyle CssClass="bg-white border-t border-gray-200 px-4 py-3 flex items-center justify-between sm:px-6" />
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="ID" ItemStyle-CssClass="py-4 px-6 text-sm text-gray-700" HeaderStyle-CssClass="py-4 px-6 text-sm font-medium text-left text-white uppercase tracking-wider" />
                            <asp:BoundField DataField="name" HeaderText="Name" ItemStyle-CssClass="py-4 px-6 text-sm text-gray-700" HeaderStyle-CssClass="py-4 px-6 text-sm font-medium text-left text-white uppercase tracking-wider" />
                            <asp:BoundField DataField="email" HeaderText="Email" ItemStyle-CssClass="py-4 px-6 text-sm text-gray-700" HeaderStyle-CssClass="py-4 px-6 text-sm font-medium text-left text-white uppercase tracking-wider" />
                            <asp:BoundField DataField="phone" HeaderText="Phone" ItemStyle-CssClass="py-4 px-6 text-sm text-gray-700" HeaderStyle-CssClass="py-4 px-6 text-sm font-medium text-left text-white uppercase tracking-wider" />
                            <asp:BoundField DataField="Proposal_Title" HeaderText="Proposal Title" ItemStyle-CssClass="py-4 px-6 text-sm text-gray-700" HeaderStyle-CssClass="py-4 px-6 text-sm font-medium text-left text-white uppercase tracking-wider" />
                            <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="py-4 px-6 text-sm font-medium text-left text-white uppercase tracking-wider">
                                <ItemStyle CssClass="py-4 px-6 text-sm text-gray-700" />
                                <ItemTemplate>
                                    <button type="button" class="inline-flex items-center px-3 py-1.5 bg-indigo-600 text-white text-xs font-medium rounded hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" 
                                        onclick="viewDetails('<%# Eval("ProposalDetails") %>')">
                                        <i class="fas fa-eye mr-1"></i> View
                                    </button>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="text-center py-8">
                                <i class="fas fa-folder-open text-gray-300 text-4xl mb-2"></i>
                                <p class="text-gray-500">No proposals found</p>
                            </div>
                        </EmptyDataTemplate>
                        <PagerTemplate>
                            <div class="flex items-center justify-between w-full px-4 py-3 bg-white border-t border-gray-200 sm:px-6">
                                <div class="flex justify-between flex-1 sm:hidden">
                                    <asp:LinkButton ID="lnkPrevious" runat="server" 
                                        CommandName="Page" 
                                        CommandArgument="Prev" 
                                        CssClass="relative inline-flex items-center px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50">
                                        Previous
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="lnkNext" runat="server" 
                                        CommandName="Page" 
                                        CommandArgument="Next" 
                                        CssClass="relative ml-3 inline-flex items-center px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-md hover:bg-gray-50">
                                        Next
                                    </asp:LinkButton>
                                </div>
                                <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                                    <div>
                                        <p class="text-sm text-gray-700">
                                            Showing
                                            <span class="font-medium">
                                                <asp:Label ID="lblCurrentPage" runat="server" Text='<%# ((GridView)Container.Parent.Parent).PageIndex + 1 %>'></asp:Label>
                                            </span>
                                            of
                                            <span class="font-medium">
                                                <asp:Label ID="lblTotalPages" runat="server" Text='<%# ((GridView)Container.Parent.Parent).PageCount %>'></asp:Label>
                                            </span>
                                            pages
                                        </p>
                                    </div>
                                    <div>
                                        <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                            <asp:LinkButton ID="lnkPreviousPage" runat="server" 
                                                CommandName="Page" 
                                                CommandArgument="Prev" 
                                                CssClass="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                <span class="sr-only">Previous</span>
                                                <i class="fas fa-chevron-left"></i>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="lnkNextPage" runat="server" 
                                                CommandName="Page" 
                                                CommandArgument="Next" 
                                                CssClass="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                                                <span class="sr-only">Next</span>
                                                <i class="fas fa-chevron-right"></i>
                                            </asp:LinkButton>
                                        </nav>
                                    </div>
                                </div>
                            </div>
                        </PagerTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>

        <!-- Modal Overlay -->
        <div id="modal-overlay" class="fixed inset-0 bg-black bg-opacity-50 z-40 hidden flex items-center justify-center"></div>
        
        <!-- Modal -->
        <div id="modal-proposal-details" class="fixed inset-0 z-50 hidden overflow-y-auto">
            <div class="flex items-center justify-center min-h-screen p-4">
                <div class="bg-white rounded-lg shadow-xl max-w-2xl w-full mx-auto">
                    <div class="flex justify-between items-center p-6 border-b border-gray-200">
                        <h3 class="text-lg font-medium text-gray-900">
                            <i class="fas fa-file-alt text-indigo-600 mr-2"></i>Proposal Details
                        </h3>
                        <button id="close-modal" class="text-gray-400 hover:text-gray-500 focus:outline-none">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div class="p-6">
                        <div id="proposal-content" class="text-gray-700 text-sm leading-relaxed"></div>
                    </div>
                    <div class="bg-gray-50 px-6 py-4 flex justify-end">
                        <button id="close-modal-btn" class="bg-indigo-600 text-white px-4 py-2 rounded-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Close
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <asp:Panel ID="pnlOverlay" runat="server" CssClass="hidden"></asp:Panel>
        <asp:Panel ID="pnlProposalDetails" runat="server" CssClass="hidden">
            <asp:Button ID="btnCloseModal" runat="server" CssClass="hidden" Text="Close" OnClick="btnCloseModal_Click" />
            <asp:Label ID="lblProposalDetails" runat="server" CssClass="hidden"></asp:Label>
        </asp:Panel>
    </form>

    <script type="text/javascript">
        function viewDetails(details) {
            document.getElementById('proposal-content').innerHTML = details;
            document.getElementById('modal-overlay').classList.remove('hidden');
            document.getElementById('modal-proposal-details').classList.remove('hidden');
            document.body.style.overflow = 'hidden';
        }

        document.getElementById('close-modal').addEventListener('click', closeModal);
        document.getElementById('close-modal-btn').addEventListener('click', closeModal);
        document.getElementById('modal-overlay').addEventListener('click', closeModal);

        function closeModal() {
            document.getElementById('modal-overlay').classList.add('hidden');
            document.getElementById('modal-proposal-details').classList.add('hidden');
            document.body.style.overflow = 'auto';
        }
    </script>
</body>
</html>