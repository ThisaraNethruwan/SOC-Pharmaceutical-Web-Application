using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SPC_Pharmacy
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        private readonly string connectionString = "Server=DESKTOP-M3HCAA5\\SQLEXPRESS;Database=SPC_DB;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["PharmacyId"] == null)
            {
                Response.Redirect("PharmacyLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadPharmacyDetails();
            }

            // Display pharmacy name in welcome message
            lblPharmacyName.Text = Session["PharmacyName"]?.ToString();
        }

        private void LoadPharmacyDetails()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT pharmacy_name, email, phone, address 
                                   FROM Pharmacy 
                                   WHERE id = @PharmacyId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@PharmacyId", Convert.ToInt32(Session["PharmacyId"]));

                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtPharmacyName.Text = reader["pharmacy_name"].ToString();
                                txtEmail.Text = reader["email"].ToString();
                                txtPhone.Text = reader["phone"].ToString();
                                txtAddress.Text = reader["address"].ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading pharmacy details: " + ex.Message, false);
            }
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE Pharmacy 
                                   SET pharmacy_name = @PharmacyName,
                                       phone = @Phone,
                                       address = @Address
                                   WHERE id = @PharmacyId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@PharmacyId", Convert.ToInt32(Session["PharmacyId"]));
                        cmd.Parameters.AddWithValue("@PharmacyName", txtPharmacyName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());

                        conn.Open();
                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            Session["PharmacyName"] = txtPharmacyName.Text.Trim();
                            lblPharmacyName.Text = txtPharmacyName.Text.Trim();
                            ShowMessage("Profile updated successfully!", true);
                        }
                        else
                        {
                            ShowMessage("Failed to update profile.", false);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error updating profile: " + ex.Message, false);
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("PlaceOrder.aspx");
        }

        protected void btnSearchProduct_Click(object sender, EventArgs e)
        {
            Response.Redirect("SearchOrders.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("PharmacyLogin.aspx");
        }

        private void ShowMessage(string message, bool isSuccess)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = $"message {(isSuccess ? "success" : "error")}";
            lblMessage.Visible = true;
        }
    }
}