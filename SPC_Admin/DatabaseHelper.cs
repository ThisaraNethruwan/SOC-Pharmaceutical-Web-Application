using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace SPC_Admin
{
    public static class DatabaseHelper
    {
        private static readonly string connectionString = "Data Source=.;Initial Catalog=SPC_DB;Integrated Security=True";
       
        public static SqlConnection GetConnection()
        {
            SqlConnection connection = new SqlConnection(connectionString);
            if (connection.State != ConnectionState.Open)
            {
                connection.Open();
            }
            return connection;
        }

        public static DataTable ExecuteQuery(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection connection = GetConnection())
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (parameters != null)
                    {
                        command.Parameters.AddRange(parameters);
                    }

                    DataTable dt = new DataTable();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        adapter.Fill(dt);
                    }
                    return dt;
                }
            }
        }

        public static int ExecuteNonQuery(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection connection = GetConnection())
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (parameters != null)
                    {
                        command.Parameters.AddRange(parameters);
                    }
                    return command.ExecuteNonQuery();
                }
            }
        }

        public static object ExecuteScalar(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection connection = GetConnection())
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (parameters != null)
                    {
                        command.Parameters.AddRange(parameters);
                    }
                    return command.ExecuteScalar();
                }
            }
        }

        public static int ExecuteNonQuery(string query, SqlParameter[] parameters, SqlConnection connection, SqlTransaction transaction)
        {
            using (SqlCommand command = new SqlCommand(query, connection, transaction))
            {
                if (parameters != null)
                {
                    command.Parameters.AddRange(parameters);
                }
                return command.ExecuteNonQuery();
            }
        }

        public static DataTable ExecuteQuery(string query, SqlParameter[] parameters, SqlConnection connection, SqlTransaction transaction)
        {
            using (SqlCommand command = new SqlCommand(query, connection, transaction))
            {
                if (parameters != null)
                {
                    command.Parameters.AddRange(parameters);
                }

                DataTable dt = new DataTable();
                using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                {
                    adapter.Fill(dt);
                }
                return dt;
            }
        }

        public static object ExecuteScalar(string query, SqlParameter[] parameters, SqlConnection connection, SqlTransaction transaction)
        {
            using (SqlCommand command = new SqlCommand(query, connection, transaction))
            {
                if (parameters != null)
                {
                    command.Parameters.AddRange(parameters);
                }
                return command.ExecuteScalar();
            }
        }

        public static void LogError(Exception ex, string methodName = "")
        {
            try
            {
                string query = @"INSERT INTO ErrorLogs 
                                (ErrorMessage, StackTrace, MethodName, ErrorDate) 
                                VALUES 
                                (@ErrorMessage, @StackTrace, @MethodName, @ErrorDate)";

                SqlParameter[] parameters = {
                    new SqlParameter("@ErrorMessage", ex.Message),
                    new SqlParameter("@StackTrace", ex.StackTrace),
                    new SqlParameter("@MethodName", methodName),
                    new SqlParameter("@ErrorDate", DateTime.Now)
                };

                ExecuteNonQuery(query, parameters);
            }
            catch
            {
                // If logging fails, we don't want to throw another exception
            }
        }
    }
}