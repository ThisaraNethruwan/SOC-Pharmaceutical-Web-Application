using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SPC_Admin
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        private readonly string connectionString = "Server=DESKTOP-M3HCAA5\\SQLEXPRESS;Database=SPC_DB;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ClearForm();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtPassword.Text != txtConfirmPassword.Text)
                {
                    ShowMessage("Passwords do not match!", false);
                    return;
                }

                if (IsEmailExists(txtEmail.Text.Trim()))
                {
                    ShowMessage("Email already registered!", false);
                    return;
                }

                string accountType = ddlAccountType.SelectedValue;

                if (string.IsNullOrEmpty(accountType))
                {
                    ShowMessage("Please select an account type!", false);
                    return;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "";
                    string redirectUrl = "";

                    switch (accountType)
                    {
                        case "Admin":
                            query = @"INSERT INTO Admins 
                                     (company_name, name, email, address, phone, password, created_at) 
                                     VALUES 
                                     (@CompanyName, @Name, @Email, @Address, @Phone, @Password, GETDATE())";
                            redirectUrl = "AdminLogin.aspx";
                            break;

                        case "Warehouse":
                            query = @"INSERT INTO Warehouse 
                                     (company_name, warehouse_name, email, address, phone, password, created_at) 
                                     VALUES 
                                     (@CompanyName, @Name, @Email, @Address, @Phone, @Password, GETDATE())";
                            redirectUrl = "WarehouseDashboard.aspx";
                            break;

                        case "Pharmacy":
                            query = @"INSERT INTO Pharmacy 
                                     (company_name, pharmacy_name, email, address, phone, password, created_at) 
                                     VALUES 
                                     (@CompanyName, @Name, @Email, @Address, @Phone, @Password, GETDATE())";
                            redirectUrl = "PharmacyDashboard.aspx";
                            break;
                    }

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                        conn.Open();
                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            ShowMessage("Registration successful!", true);
                            ClearForm();
                            ScriptManager.RegisterStartupScript(this, GetType(), "redirect", $"setTimeout(function(){{ window.location.href = 'Dashboard.aspx'; }}, 2000);", true);
                        }
                        else
                        {
                            ShowMessage("Registration failed. Please try again.", false);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("An error occurred. Please try again.", false);
                // You might want to log the exception details for debugging
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        private bool IsEmailExists(string email)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT 1 FROM Admins WHERE email = @Email 
                               UNION SELECT 1 FROM Warehouse WHERE email = @Email 
                               UNION SELECT 1 FROM Pharmacy WHERE email = @Email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);

                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    return result != null;
                }
            }
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = isSuccess ? System.Drawing.Color.Green : System.Drawing.Color.Red;
            lblMessage.Visible = true;
        }

        private void ClearForm()
        {
            txtCompanyName.Text = "";
            txtName.Text = "";
            txtEmail.Text = "";
            txtAddress.Text = "";
            txtPhone.Text = "";
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
            ddlAccountType.SelectedIndex = 0;
        }

    }
}