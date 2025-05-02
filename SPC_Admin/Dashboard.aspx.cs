using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SPC_Admin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"]?.ConnectionString;
            if (string.IsNullOrEmpty(connString))
            {
                throw new Exception("Database connection string is missing in web.config.");
            }
            return connString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    if (Session["AdminId"] == null)
                    {
                        Response.Redirect("AdminLogin.aspx");
                        return;
                    }
                    LoadPendingSuppliers();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading page: " + ex.Message, "error");
            }
        }

        private void LoadPendingSuppliers()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    string query = @"SELECT id, company_name, name, email, phone, status 
                                     FROM SPC_Suppliers 
                                     WHERE status = 'pending' 
                                     ORDER BY created_at DESC";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            gvSuppliers.DataSource = dt.Rows.Count > 0 ? dt : null;
                            gvSuppliers.DataBind();
                            if (dt.Rows.Count == 0)
                                ShowMessage("No pending suppliers found.", "info");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading supplier data: " + ex.Message, "error");
            }
        }

        protected void gvSuppliers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ApproveSupplier")
            {
                if (int.TryParse(e.CommandArgument.ToString(), out int supplierId))
                {
                    ApproveSupplier(supplierId);
                }
                else
                {
                    ShowMessage("Invalid supplier ID.", "error");
                }
            }
        }

        protected void gvSuppliers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = DataBinder.Eval(e.Row.DataItem, "status")?.ToString();
                Button btnApprove = e.Row.FindControl("btnApprove") as Button;
                if (btnApprove != null && status == "approved")
                {
                    btnApprove.Enabled = false;
                    btnApprove.Text = "Approved";
                }
            }
        }

        private void ApproveSupplier(int supplierId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();

                    string query = @"UPDATE SPC_Suppliers 
                             SET status = 'approved'
                             WHERE id = @SupplierId AND status = 'pending'";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@SupplierId", supplierId);

                        int result = cmd.ExecuteNonQuery();

                        ShowMessage(result > 0 ? "Supplier approved successfully!" : "Supplier already approved or not found.",
                                    result > 0 ? "success" : "warning");

                        if (result > 0)
                        {
                            LoadPendingSuppliers(); // Refresh pending supplier list
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error approving supplier: " + ex.Message, "error");
            }
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = $"message {type}";
            lblMessage.Visible = true;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("AdminLogin.aspx");
        }

      

        protected void btnAddAccount_Click(object sender, EventArgs e)
        {
            // Redirect to the admin account registration page
            Response.Redirect("AddAccount.aspx");
        }

        protected void btnProposal_Click(object sender, EventArgs e)
        {
            // Redirect to the proposal viewing page
            Response.Redirect("ViewProposal.aspx");
        }
    }
}