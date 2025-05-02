using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SPC_Admin
{
    public partial class WebForm5 : System.Web.UI.Page
    {
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
                    LoadProposals();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading page: " + ex.Message, "error");
            }
        }

        private string GetConnectionString()
        {
            string connString = ConfigurationManager.ConnectionStrings["ConnectionString"]?.ConnectionString;
            if (string.IsNullOrEmpty(connString))
            {
                throw new Exception("Database connection string is missing in web.config.");
            }
            return connString;
        }

        private void LoadProposals()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    string query = @"SELECT id, name, email, phone, Proposal_Title, ProposalDetails 
                                   FROM Tenders 
                                   ORDER BY id DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            gvProposals.DataSource = dt.Rows.Count > 0 ? dt : null;
                            gvProposals.DataBind();

                            if (dt.Rows.Count == 0)
                                ShowMessage("No proposals found.", "info");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading proposals: " + ex.Message, "error");
            }
        }

        protected void gvProposals_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                gvProposals.PageIndex = e.NewPageIndex;
                LoadProposals();
            }
            catch (Exception ex)
            {
                ShowMessage("Error while changing pages: " + ex.Message, "error");
            }
        }

        protected void gvProposals_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewDetails")
            {
                try
                {
                    int proposalId = Convert.ToInt32(e.CommandArgument);
                    DisplayProposalDetails(proposalId);
                }
                catch (Exception ex)
                {
                    ShowMessage("Error viewing proposal details: " + ex.Message, "error");
                }
            }
        }

        private void DisplayProposalDetails(int proposalId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("SELECT ProposalDetails FROM Tenders WHERE id = @ProposalId", conn))
                    {
                        cmd.Parameters.AddWithValue("@ProposalId", proposalId);
                        string details = cmd.ExecuteScalar()?.ToString() ?? string.Empty;

                        if (!string.IsNullOrEmpty(details))
                        {
                            lblProposalDetails.Text = Server.HtmlEncode(details).Replace(Environment.NewLine, "<br />");
                            ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "showModal();", true);
                        }
                        else
                        {
                            ShowMessage("Proposal details not found.", "warning");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error retrieving proposal details: " + ex.Message, "error");
            }
        }

        protected void gvProposals_Sorting(object sender, GridViewSortEventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    string query = $"SELECT id, name, email, phone, Proposal_Title, ProposalDetails FROM Tenders ORDER BY {e.SortExpression}";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            gvProposals.DataSource = dt;
                            gvProposals.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error sorting proposals: " + ex.Message, "error");
            }
        }

        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "hideModal", "hideModal();", true);
        }

        private void ShowMessage(string message, string type)
        {
            if (lblMessage != null)
            {
                lblMessage.Text = message;
                lblMessage.CssClass = $"message {type}";
                lblMessage.Visible = true;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("AdminLogin.aspx");
        }
        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                int proposalId = Convert.ToInt32(btn.CommandArgument);
                DisplayProposalDetails(proposalId);
            }
            catch (Exception ex)
            {
                ShowMessage("Error viewing proposal details: " + ex.Message, "error");
            }
        }

    }
}