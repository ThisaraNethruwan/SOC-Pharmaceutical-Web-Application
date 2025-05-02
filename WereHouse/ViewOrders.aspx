<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewOrders.aspx.cs" Inherits="WereHouse.WebForm7" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <title>View Orders</title>
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

        h2 {
            color: var(--text-color);
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: var(--card-background);
            border-radius: 12px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }

        .message {
            margin-bottom: 1rem;
            padding: 1rem;
            border-radius: 8px;
            background-color: #f0fdf4;
            border: 1px solid #86efac;
            color: #16a34a;
            display: none;
        }

        .message:not(:empty) {
            display: block;
        }

        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 1rem;
        }

        .table th {
            background-color: var(--header-bg);
            color: white;
            font-weight: 600;
            padding: 1rem;
            text-align: left;
            border-top: 1px solid var(--border-color);
        }

        .table th:first-child {
            border-top-left-radius: 8px;
        }

        .table th:last-child {
            border-top-right-radius: 8px;
        }

        .table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            background-color: var(--card-background);
        }

        .table tr:hover td {
            background-color: var(--hover-color);
        }

        .table tr:last-child td:first-child {
            border-bottom-left-radius: 8px;
        }

        .table tr:last-child td:last-child {
            border-bottom-right-radius: 8px;
        }

        /* Empty state styling */
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #64748b;
            font-style: italic;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

            .container {
                padding: 1rem;
            }

            .table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }

            .table th, 
            .table td {
                padding: 0.75rem;
            }

            h2 {
                font-size: 1.5rem;
            }
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

        /* Animation for new rows */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .table tr {
            animation: fadeIn 0.3s ease-out forwards;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>
                <i class="fas fa-shopping-cart"></i>
                View Orders
            </h2>
            
            <asp:Label ID="lblMessage" runat="server" CssClass="message" />
            
            <asp:GridView ID="gvOrders" runat="server" 
                AutoGenerateColumns="False" 
                CssClass="table"
                EmptyDataText="No orders found." 
                OnPageIndexChanging="gvOrders_PageIndexChanging"
                AllowPaging="True"
                PageSize="10"
                PagerSettings-Mode="NumericFirstLast"
                PagerStyle-CssClass="pagination"
                PagerSettings-FirstPageText="First"
                PagerSettings-LastPageText="Last"
                PagerSettings-PageButtonCount="5">
                <Columns>
                    <asp:BoundField DataField="OrderID" HeaderText="Order ID" SortExpression="OrderID" />
                    <asp:BoundField DataField="ProductName" HeaderText="Product Name" SortExpression="ProductName" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                  <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" SortExpression="TotalAmount" DataFormatString="Rs. {0:N2}" />
                    <asp:BoundField DataField="OrderDate" HeaderText="Order Date" SortExpression="OrderDate" DataFormatString="{0:MM/dd/yyyy}" />
                </Columns>
                <EmptyDataTemplate>
                    <div class="empty-state">
                        <i class="fas fa-box-open fa-3x"></i>
                        <p>No orders found.</p>
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </form>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Add animation to table rows
            const rows = document.querySelectorAll('.table tr');
            rows.forEach((row, index) => {
                row.style.animationDelay = `${index * 50}ms`;
            });

            // Handle message display
            const message = document.querySelector('.message');
            if (message && message.textContent.trim() !== '') {
                message.style.display = 'block';
                setTimeout(() => {
                    message.style.opacity = '0';
                    message.style.transition = 'opacity 0.3s ease';
                    setTimeout(() => {
                        message.style.display = 'none';
                    }, 300);
                }, 2000);
            }
        });
    </script>
</body>
</html>
