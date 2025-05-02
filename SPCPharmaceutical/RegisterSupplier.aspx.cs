using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace SPCPharmaceutical
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Any initialization code can go here
            }
        }

        private bool IsEmailOrPhoneExists(string email, string phone)
        {
            string query = @"
                SELECT COUNT(*) 
                FROM SPC_Suppliers 
                WHERE Email = @Email OR Phone = @Phone";

            SqlParameter[] parameters = {
                new SqlParameter("@Email", email),
                new SqlParameter("@Phone", phone)
            };

            int count = Convert.ToInt32(DatabaseHelper.ExecuteScalar(query, parameters));
            return count > 0;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                // Validate all inputs
                if (!ValidateInputs())
                {
                    return;
                }

                // Check if email or phone already exists
                if (IsEmailOrPhoneExists(txtEmail.Text.Trim(), txtPhone.Text.Trim()))
                {
                    ShowError("A supplier with this email or phone number already exists.");
                    return;
                }

                // Hash the password
                string hashedPassword = HashPassword(txtPassword.Text);

                // Insert new supplier
                string query = @"
                    INSERT INTO SPC_Suppliers (
                        company_name,
                        name,
                        email,
                        phone,
                        password,
                        address,
                        created_at,
                        status
                    ) 
                    VALUES (
                        @CompanyName,
                        @Name,
                        @Email,
                        @Phone,
                        @Password,
                        @Address,
                        GETDATE(),
                        'pending'
                    )";

                SqlParameter[] parameters = {
                    new SqlParameter("@CompanyName", txtCompanyName.Text.Trim()),
                    new SqlParameter("@Name", txtName.Text.Trim()),
                    new SqlParameter("@Email", txtEmail.Text.Trim()),
                    new SqlParameter("@Phone", txtPhone.Text.Trim()),
                    new SqlParameter("@Password", hashedPassword),
                    new SqlParameter("@Address", txtAddress.Text.Trim())
                };

                int result = DatabaseHelper.ExecuteNonQuery(query, parameters);


                if (result > 0)
                {
                    ShowSuccess("Registration successful! Redirecting to login page...");
                    Response.AppendHeader("Refresh", "2;url=LoginSupplier.aspx");
                }
                else
                {
                    ShowError("Registration failed. Please try again.");
                }
            }
            catch (Exception ex)
            {
                // Log the exception details
                Console.WriteLine($"Registration error: {ex.Message}");
                ShowError("An error occurred during registration. Please try again.");
            }
        }

        private bool ValidateInputs()
        {
            // Company Name validation
            if (string.IsNullOrWhiteSpace(txtCompanyName.Text))
            {
                ShowError("Company name is required.");
                return false;
            }

            // Name validation
            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                ShowError("Name is required.");
                return false;
            }

            // Email validation
            string email = txtEmail.Text.Trim();
            if (string.IsNullOrWhiteSpace(email))
            {
                ShowError("Email is required.");
                return false;
            }
            if (!IsValidEmail(email))
            {
                ShowError("Please enter a valid email address.");
                return false;
            }

            // Phone validation
            string phone = txtPhone.Text.Trim();
            if (string.IsNullOrWhiteSpace(phone))
            {
                ShowError("Phone number is required.");
                return false;
            }
            if (!IsValidPhone(phone))
            {
                ShowError("Please enter a valid phone number.");
                return false;
            }

            // Password validation
            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                ShowError("Password is required.");
                return false;
            }
            if (!IsValidPassword(txtPassword.Text))
            {
                ShowError("Enter at least 8 characters with uppercase, lowercase letter, number, special character.");
                return false;
            }

            // Address validation
            if (string.IsNullOrWhiteSpace(txtAddress.Text))
            {
                ShowError("Address is required.");
                return false;
            }

            return true;
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                return Regex.IsMatch(email,
                    @"^[^@\s]+@[^@\s]+\.[^@\s]+$",
                    RegexOptions.IgnoreCase);
            }
            catch
            {
                return false;
            }
        }

        private bool IsValidPhone(string phone)
        {
            try
            {
                return Regex.IsMatch(phone, @"^\+?[\d\s-]{10,}$");
            }
            catch
            {
                return false;
            }
        }

        private bool IsValidPassword(string password)
        {
            var hasNumber = new Regex(@"[0-9]+");
            var hasUpperChar = new Regex(@"[A-Z]+");
            var hasLowerChar = new Regex(@"[a-z]+");
            var hasSpecialChar = new Regex(@"[!@#$%^&*(),.?"":{}|<>]+");
            var hasMinLen = new Regex(@".{8,}");

            return hasNumber.IsMatch(password) &&
                   hasUpperChar.IsMatch(password) &&
                   hasLowerChar.IsMatch(password) &&
                   hasSpecialChar.IsMatch(password) &&
                   hasMinLen.IsMatch(password);
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "error-message";
        }

        private void ShowSuccess(string message)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "success-message";
        }
    }
}