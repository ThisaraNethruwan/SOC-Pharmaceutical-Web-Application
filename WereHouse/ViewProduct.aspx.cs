using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WereHouse
{
    public partial class WebForm4 : Page
    {
        private readonly string connectionString = "Server=DESKTOP-M3HCAA5\\SQLEXPRESS;Database=SPC_DB;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["WarehouseEmail"] == null)
            {
                Response.Redirect("WerehouseLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ViewState["SortColumn"] = "ProductID";
                ViewState["SortDirection"] = "ASC";
                BindProductData();
            }
        }

        private void BindProductData()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT ProductID, ProductName, Quantity, Price, CreatedDate, ModifiedDate, IsActive FROM Products", conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        conn.Open();
                        sda.Fill(dt);

                        // Check if IsActive column exists
                        if (!dt.Columns.Contains("IsActive"))
                        {
                            throw new Exception("Column 'IsActive' does not exist in the database. Please check your database schema.");
                        }

                        gvProducts.DataSource = dt;
                        gvProducts.DataBind();
                    }
                }
            }
        }


        protected void gvProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvProducts.PageIndex = e.NewPageIndex;
            BindProductData();
        }

        protected void gvProducts_Sorting(object sender, GridViewSortEventArgs e)
        {
            string lastSortColumn = ViewState["SortColumn"].ToString();
            string lastSortDirection = ViewState["SortDirection"].ToString();

            if (lastSortColumn == e.SortExpression)
            {
                ViewState["SortDirection"] = lastSortDirection == "ASC" ? "DESC" : "ASC";
            }
            else
            {
                ViewState["SortColumn"] = e.SortExpression;
                ViewState["SortDirection"] = "ASC";
            }

            BindProductData();
        }
    }
}
