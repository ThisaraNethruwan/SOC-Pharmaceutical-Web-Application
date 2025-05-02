using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;
using System.Configuration;
using System.Web;
using System.Security.Cryptography;
using System.Text;


namespace SPCPharmaceutical
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text.Trim();

                // Hash the password for comparison
                string hashedPassword = HashPassword(password);

                // Query to check supplier credentials
                string query = "SELECT * FROM SPC_Suppliers WHERE email = @Email AND password = @Password";

                SqlParameter[] parameters = {
                    new SqlParameter("@Email", email),
                    new SqlParameter("@Password", hashedPassword)
                };

                DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    // Check if supplier is approved
                    string status = dt.Rows[0]["status"].ToString();

                    if (status.ToLower() == "approved")
                    {
                        // Store supplier info in session
                        Session["id"] = dt.Rows[0]["id"].ToString();
                        Session["email"] = email;
                        Response.Redirect("SupplierDashboard.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Your account is pending approval.";
                        lblMessage.CssClass = "error-message";
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid email or password.";
                    lblMessage.CssClass = "error-message";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred during login.";
                lblMessage.CssClass = "error-message";
            }
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }
    }
}