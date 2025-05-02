using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SPCPharmaceutical
{
    public partial class SupplierDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null)
            {
                Response.Redirect("LoginSupplier.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadSupplierDetails();
            }
        }

        private void LoadSupplierDetails()
        {
            try
            {
                string query = "SELECT name, email, phone FROM SPC_Suppliers WHERE id = @id";
                SqlParameter[] parameters = { new SqlParameter("@id", Session["id"]) };
                DataTable dt = DatabaseHelper.ExecuteQuery(query, parameters);

                if (dt.Rows.Count > 0)
                {
                    lblSupplierName.Text = dt.Rows[0]["Name"].ToString();
                    txtName.Text = dt.Rows[0]["Name"].ToString();
                    txtEmail.Text = dt.Rows[0]["Email"].ToString();
                    txtPhone.Text = dt.Rows[0]["Phone"].ToString();
                }
            }
            catch (Exception ex)
            {
                lblProfileMessage.Text = "Error loading profile. Please try again.";
                lblProfileMessage.CssClass = "message error";
            }
        }

        protected void UpdateProfile(object sender, EventArgs e)
        {
            try
            {
                string query = "UPDATE SPC_Suppliers SET name = @Name, email = @Email, phone = @Phone WHERE id = @id";
                SqlParameter[] parameters = {
                    new SqlParameter("@id", Session["id"]),
                    new SqlParameter("@Name", txtName.Text.Trim()),
                    new SqlParameter("@Email", txtEmail.Text.Trim()),
                    new SqlParameter("@Phone", txtPhone.Text.Trim())
                };

                int result = DatabaseHelper.ExecuteNonQuery(query, parameters);

                if (result > 0)
                {
                    lblProfileMessage.Text = "Profile updated successfully!";
                    lblProfileMessage.CssClass = "message success";
                    lblSupplierName.Text = txtName.Text;
                    Session["SupplierName"] = txtName.Text;
                }
                else
                {
                    lblProfileMessage.Text = "Failed to update profile.";
                    lblProfileMessage.CssClass = "message error";
                }
            }
            catch (Exception ex)
            {
                lblProfileMessage.Text = "Error updating profile. Please try again.";
                lblProfileMessage.CssClass = "message error";
            }
        }

        protected void SubmitTender(object sender, EventArgs e)
        {
            try
            {
                string query = "INSERT INTO Tenders (name, email, phone, Proposal_Title, ProposalDetails) " +
                               "VALUES (@Name, @Email, @Phone, @Proposal_Title, @ProposalDetails)";

                SqlParameter[] parameters = {
                    new SqlParameter("@Name", txtName.Text.Trim()),
                    new SqlParameter("@Email", txtEmail.Text.Trim()),
                    new SqlParameter("@Phone", txtPhone.Text.Trim()),
                    new SqlParameter("@Proposal_Title", txtProposalTitle.Text.Trim()),
                    new SqlParameter("@ProposalDetails", txtProposal.Text.Trim())
                };

                int result = DatabaseHelper.ExecuteNonQuery(query, parameters);

                if (result > 0)
                {
                    lblTenderMessage.Text = "Tender submitted successfully!";
                    lblTenderMessage.CssClass = "message success";
                    txtProposal.Text = "";
                    txtProposalTitle.Text = "";
                }
                else
                {
                    lblTenderMessage.Text = "Failed to submit tender.";
                    lblTenderMessage.CssClass = "message error";
                }
            }
            catch (Exception ex)
            {
                lblTenderMessage.Text = "Error submitting tender. Please try again.";
                lblTenderMessage.CssClass = "message error";
            }
        }

        protected void Logout(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("LoginSupplier.aspx");
        }
    }
}
