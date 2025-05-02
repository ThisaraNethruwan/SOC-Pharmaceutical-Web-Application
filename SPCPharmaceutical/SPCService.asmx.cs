using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Services;

[WebService(Namespace = "http://spc.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class SPCService : WebService
{
    private string connectionString = "Server=DESKTOP-M3HCAA5\\SQLEXPRESS;Database=SPC_DB;Trusted_Connection=True;";

    [WebMethod]
    public string RegisterSupplier(string name, string email, string phone)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "INSERT INTO Suppliers (Name, Email, Phone) VALUES (@Name, @Email, @Phone)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Phone", phone);

            conn.Open();
            cmd.ExecuteNonQuery();
        }
        return "Supplier registered successfully!";
    }

 
   

   
    
    
}
