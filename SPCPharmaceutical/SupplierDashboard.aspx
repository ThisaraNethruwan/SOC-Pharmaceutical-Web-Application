<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupplierDashboard.aspx.cs" Inherits="SPCPharmaceutical.SupplierDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <title>Supplier Dashboard</title>
    <style>
        :root {
            --primary-color: #2563eb;
            --danger-color: #dc2626;
            --success-color: #16a34a;
            --background-color: #f1f5f9;
            --card-background: #ffffff;
            --text-color: #1e293b;
            --border-color: #e2e8f0;
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
        }

        .container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        h1 {
            font-size: 2rem;
            color: var(--text-color);
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .header-content {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .forms-container {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .section {
            background: var(--card-background);
            border-radius: 12px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            flex: 1;
            min-width: 300px;
        }

        h2 {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            color: var(--text-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text-color);
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: #fff;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: #1d4ed8;
            transform: translateY(-2px);
        }

        .btn-danger {
            background-color: var(--danger-color);
            color: white;
        }

        .btn-danger:hover {
            background-color: #b91c1c;
            transform: translateY(-2px);
        }

        .message {
            margin-top: 1rem;
            padding: 1rem;
            border-radius: 8px;
            display: none;
        }

        .message.success {
            background-color: #f0fdf4;
            border: 1px solid #86efac;
            color: var(--success-color);
            display: block;
        }

        .message.error {
            background-color: #fef2f2;
            border: 1px solid #fecaca;
            color: var(--danger-color);
            display: block;
        }

        .validation-error {
            color: var(--danger-color);
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        @media (max-width: 992px) {
            .forms-container {
                flex-direction: column;
            }
            
            .section {
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 1rem;
                margin: 1rem auto;
            }

            .section {
                padding: 1.5rem;
            }

            h1 {
                font-size: 1.75rem;
                flex-direction: column;
                align-items: flex-start;
            }

            h2 {
                font-size: 1.25rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>
                <div class="header-content">
                    <i class="fas fa-user-circle"></i> Welcome, <asp:Label ID="lblSupplierName" runat="server"></asp:Label>
                </div>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="Logout" CssClass="btn btn-danger" />
            </h1>
            
            <div class="forms-container">
                <!-- Profile Management Section -->
                <div class="section">
                    <h2><i class="fas fa-user-edit"></i> Profile Management</h2>
                    <div class="form-group">
                        <label for="txtName">Name:</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" 
                            ErrorMessage="Name is required" CssClass="validation-error" ValidationGroup="ProfileGroup" Display="Dynamic" />
                    </div>
                    <div class="form-group">
                        <label for="txtEmail">Email:</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                            ErrorMessage="Email is required" CssClass="validation-error" ValidationGroup="ProfileGroup" Display="Dynamic" />
                    </div>
                    <div class="form-group">
                        <label for="txtPhone">Phone:</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" 
                            ErrorMessage="Phone is required" CssClass="validation-error" ValidationGroup="ProfileGroup" Display="Dynamic" />
                    </div>
                    <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" OnClick="UpdateProfile" 
                        CssClass="btn btn-primary" ValidationGroup="ProfileGroup" />
                    <asp:Label ID="lblProfileMessage" runat="server" CssClass="message"></asp:Label>
                </div>

                <!-- Tender Submission Section -->
                <div class="section">
                    <h2><i class="fas fa-file-contract"></i> Submit Tender Proposal</h2>
                    <div class="form-group">
                        <label for="txtProposalTitle">Proposal Title:</label>
                        <asp:TextBox ID="txtProposalTitle" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvProposalTitle" runat="server" ControlToValidate="txtProposalTitle" 
                            ErrorMessage="Proposal title is required" CssClass="validation-error" ValidationGroup="TenderGroup" Display="Dynamic" />
                    </div>
                    <div class="form-group">
                        <label for="txtProposal">Proposal Details:</label>
                        <asp:TextBox ID="txtProposal" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvProposal" runat="server" ControlToValidate="txtProposal" 
                            ErrorMessage="Proposal details are required" CssClass="validation-error" ValidationGroup="TenderGroup" Display="Dynamic" />
                    </div>
                    <asp:Button ID="btnSubmitTender" runat="server" Text="Submit Tender" OnClick="SubmitTender" 
                        CssClass="btn btn-primary" ValidationGroup="TenderGroup" />
                    <asp:Label ID="lblTenderMessage" runat="server" CssClass="message"></asp:Label>
                </div>
            </div>
        </div>
    </form>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Smooth section entrance animations
            const sections = document.querySelectorAll('.section');
            sections.forEach((section, index) => {
                section.style.opacity = '0';
                section.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    section.style.transition = 'all 0.5s ease';
                    section.style.opacity = '1';
                    section.style.transform = 'translateY(0)';
                }, index * 200);
            });

            // Form input animations
            const inputs = document.querySelectorAll('.form-control');
            inputs.forEach(input => {
                input.addEventListener('focus', function () {
                    this.style.transition = 'all 0.3s ease';
                    this.style.transform = 'translateX(5px)';
                });

                input.addEventListener('blur', function () {
                    this.style.transform = 'translateX(0)';
                });
            });

            // Button hover effects
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(button => {
                button.addEventListener('mouseover', function () {
                    this.style.transition = 'all 0.3s ease';
                    this.style.transform = 'translateY(-2px)';
                });

                button.addEventListener('mouseout', function () {
                    this.style.transform = 'translateY(0)';
                });
            });

            // Message handling
            const messages = document.querySelectorAll('.message');
            messages.forEach(message => {
                if (message.textContent.trim() !== '') {
                    message.style.display = 'block';
                    setTimeout(() => {
                        message.style.opacity = '0';
                        setTimeout(() => {
                            message.style.display = 'none';
                        }, 300);
                    }, 5000);
                }
            });
        });
    </script>
</body>
</html>