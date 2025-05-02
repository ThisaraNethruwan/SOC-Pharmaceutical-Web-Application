using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public class DatabaseHelper
{
    // Ensure the connection string is retrieved safely
    private static readonly string connectionString = ConfigurationManager.ConnectionStrings["SPC_DB"]?.ConnectionString
        ?? throw new InvalidOperationException("Database connection string 'SPC_DB' is missing or incorrect in Web.config.");

    public static DataTable ExecuteQuery(string query, SqlParameter[] parameters = null)
    {
        DataTable dt = new DataTable();

        try
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                        cmd.Parameters.AddRange(parameters);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(dt);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Log error (can be replaced with actual logging system)
            Console.WriteLine("Error in ExecuteQuery: " + ex.Message);
            throw;
        }

        return dt;
    }

   
    public static int ExecuteNonQuery(string query, SqlParameter[] parameters = null)
    {
        int rowsAffected = 0;

        try
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                        cmd.Parameters.AddRange(parameters);

                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();
                }
            }
        }
        catch (Exception ex)
        {
            // Log error
            Console.WriteLine("Error in ExecuteNonQuery: " + ex.Message);
            throw;
        }

        return rowsAffected;
    }

   
    public static object ExecuteScalar(string query, SqlParameter[] parameters = null)
    {
        object result = null;

        try
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                        cmd.Parameters.AddRange(parameters);

                    conn.Open();
                    result = cmd.ExecuteScalar();
                }
            }
        }
        catch (Exception ex)
        {
            // Log error
            Console.WriteLine("Error in ExecuteScalar: " + ex.Message);
            throw;
        }

        return result;
    }
}
