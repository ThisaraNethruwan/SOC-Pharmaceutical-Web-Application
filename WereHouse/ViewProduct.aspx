<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewProduct.aspx.cs" Inherits="WereHouse.WebForm4" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Products</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2563eb;
            --background-color: #f1f5f9;
            --card-background: #ffffff;
            --text-color: #1e293b;
            --border-color: #e2e8f0;
            --hover-color: #f8fafc;
            --header-bg: #1e40af;
            --success-color: #16a34a;
            --danger-color: #dc2626;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', system-ui, sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
            padding: 2rem;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: var(--card-background);
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            transform: translateX(-5px);
        }

        .header {
            margin-bottom: 2rem;
        }

        h2 {
            color: var(--text-color);
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .grid-container {
            overflow-x: auto;
        }

        #gvProducts {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 1rem;
        }

        #gvProducts th {
            background-color:skyblue;
            color: white;
            font-weight: 600;
            padding: 1rem;
            text-align: left;
            position: relative;
            cursor: pointer;
        }

        #gvProducts th:first-child {
            border-top-left-radius: 8px;
        }

        #gvProducts th:last-child {
            border-top-right-radius: 8px;
        }

        #gvProducts td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            background-color: var(--card-background);
        }

        #gvProducts tr:hover td {
            background-color: var(--hover-color);
        }

        #gvProducts tr:last-child td:first-child {
            border-bottom-left-radius: 8px;
        }

        #gvProducts tr:last-child td:last-child {
            border-bottom-right-radius: 8px;
        }

        .currency {
            text-align: right;
            font-family: monospace;
            font-size: 1.1em;
        }

        .date {
            white-space: nowrap;
        }

        .status-active {
            color: var(--success-color);
            background-color: #f0fdf4;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .text-danger {
            color: var(--danger-color);
            background-color: #fef2f2;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        /* Pagination styling */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 1.5rem;
        }

        .pagination a {
            padding: 0.5rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            color: var(--text-color);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .pagination a:hover,
        .pagination a.active {
            background-color: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        /* Sorting indicators */
        .sort-indicator {
            margin-left: 0.5rem;
            font-size: 0.75rem;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

            .container {
                padding: 1rem;
            }

            h2 {
                font-size: 1.5rem;
            }

            #gvProducts th,
            #gvProducts td {
                padding: 0.75rem;
            }
        }

        /* Animation for new rows */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        #gvProducts tr {
            animation: fadeIn 0.3s ease-out forwards;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <a href="WerehouseDashboard.aspx" class="back-link">
                <i class="fas fa-arrow-left"></i>
                <span style="margin-left: 0.5rem;">Back to Dashboard</span>
            </a>
            
            <div class="header">
                <h2>
                    <i class="fas fa-box"></i>
                    Product List
                </h2>
            </div>

            <div class="grid-container">
                <asp:GridView ID="gvProducts" runat="server" 
                    AutoGenerateColumns="False"
                    AllowPaging="True" 
                    AllowSorting="True" 
                    PageSize="10"
                    OnPageIndexChanging="gvProducts_PageIndexChanging"
                    OnSorting="gvProducts_Sorting"
                    PagerSettings-Mode="NumericFirstLast"
                    PagerStyle-CssClass="pagination"
                    PagerSettings-FirstPageText="First"
                    PagerSettings-LastPageText="Last"
                    PagerSettings-PageButtonCount="5">
                    <Columns>
                        <asp:BoundField DataField="ProductID" HeaderText="Product ID" SortExpression="ProductID" />
                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" SortExpression="ProductName" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                        <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" DataFormatString="Rs. {0:N2}" ItemStyle-CssClass="currency" />
                        <asp:BoundField DataField="CreatedDate" HeaderText="Created Date" SortExpression="CreatedDate" DataFormatString="{0:yyyy-MM-dd}" ItemStyle-CssClass="date" />
                        <asp:BoundField DataField="ModifiedDate" HeaderText="Modified Date" SortExpression="ModifiedDate" DataFormatString="{0:yyyy-MM-dd}" ItemStyle-CssClass="date" />
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblActiveStatus" runat="server" 
                                    Text='<%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>'
                                    CssClass='<%# Convert.ToBoolean(Eval("IsActive")) ? "status-active" : "text-danger" %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add animation to table rows
            const rows = document.querySelectorAll('#gvProducts tr');
            rows.forEach((row, index) => {
                row.style.animationDelay = `${index * 50}ms`;
            });

            // Add sort indicators to sortable columns
            const headers = document.querySelectorAll('#gvProducts th');
            headers.forEach(header => {
                if (header.getAttribute('aria-sort')) {
                    const indicator = document.createElement('span');
                    indicator.className = 'sort-indicator';
                    indicator.innerHTML = header.getAttribute('aria-sort') === 'ascending' 
                        ? ' ↑' 
                        : ' ↓';
                    header.appendChild(indicator);
                }
            });
        });
    </script>
</body>
</html>