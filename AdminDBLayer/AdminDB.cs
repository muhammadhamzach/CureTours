using System;
using System.Linq;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace AdminDBLayer
{
    public class AdminDB
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;

        public object tour_detail_DB()
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("ADMIN_TOUR_SHOW", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet dt = new DataSet();
                    da.Fill(dt);
                    return dt;
                }
                catch { return 0; }
            }
        }

        public object show_users_DB()
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("USERS_SHOW", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet dt = new DataSet();
                    da.Fill(dt);
                    return dt;
                }
               catch { return 0; }
            }
        }

        public object show_specfic_user_DB(string tourID)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SHOW_SPECIFIC_TOUR", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TOURID", tourID);
                connection.Open();
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
                catch { return 0; }
            }
        }

        public void tourSave_DB(string command, string tourID, string title, string dateFrom, string dateTo, string PlanBox, string seatCount, string cost)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(command, connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                if (tourID.All(Char.IsDigit))
                    cmd.Parameters.AddWithValue("@TOURID", tourID);
                cmd.Parameters.AddWithValue("@TITLE", title);
                cmd.Parameters.AddWithValue("@FROMDATE", Convert.ToDateTime(dateFrom));
                cmd.Parameters.AddWithValue("@TODATE", Convert.ToDateTime(dateTo));
                cmd.Parameters.AddWithValue("@DETAILS", PlanBox);
                cmd.Parameters.AddWithValue("@TOTALSEATS", Int32.Parse(seatCount));
                cmd.Parameters.AddWithValue("@COST", Int32.Parse(cost));
                connection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch { }
            }
        }

        public object show_specific_tour_DB(string tourID)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("RETURN_TOUR", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TOURID", tourID);
                connection.Open();
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
                catch { return 0; }
            }
        }

        public object interested_user_list_DB(string tourID)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SHOW_INTERESTED_DETAILS", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TOURID", tourID);
                connection.Open();
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet dt = new DataSet();
                    da.Fill(dt);
                    return dt;
                }
                catch { return 0; }
            }
        }

        public bool acceptUser_DB(string tourID, string name)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd1 = new SqlCommand("RETURN_REM_SEAT_COUNT", connection);
                SqlCommand cmd2 = new SqlCommand("ACCEPT_USER", connection);

                cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                cmd2.CommandType = System.Data.CommandType.StoredProcedure;

                cmd1.Parameters.AddWithValue("@TOURID", tourID);

                cmd2.Parameters.AddWithValue("@TOURID", tourID);
                cmd2.Parameters.AddWithValue("@NAME", name);


                connection.Open();
                try
                {
                    int rem_count = Int32.Parse(cmd1.ExecuteScalar().ToString());
                    if (rem_count != 0)
                    {
                        cmd2.ExecuteNonQuery();
                        return true;
                    }
                    else
                        return false;
                }
                catch { return false; }

            }
        }

        public void rejectUser_DB(string tourID, string name)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {

                SqlCommand cmd = new SqlCommand("REJECT_USER", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TOURID", tourID);
                cmd.Parameters.AddWithValue("@NAME", name);
                connection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch { }
            }
        }

        public object finalizedUser_DB(string tourID)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SHOW_FINALIZED_USERS", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TOURID", tourID);
                connection.Open();
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet dt = new DataSet();
                    da.Fill(dt);
                    return dt;
                }
                catch { return 0; }
            }
        }

        public void deleteTour_DB(string tourID)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {

                SqlCommand cmd = new SqlCommand("DELETE_TOUR", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TOURID", tourID);
                connection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch { }
            }
        }
    }
}
