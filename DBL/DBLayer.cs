using System;
using System.Linq;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DBL
{
    public class IntroDB
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;

        public object LogInButton_DB(string username, string password)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("LOGINVERIFY", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@USERNAME", username);
                cmd.Parameters.AddWithValue("@PASS", password);
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

        public void SignUpButton_DB(string username, string name, string password, string team, string phone, string email, string description)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("NEW_USER_ENTRY", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@USERNAME", username);
                cmd.Parameters.AddWithValue("@NAME", name);
                cmd.Parameters.AddWithValue("@PASSWORD", password);
                cmd.Parameters.AddWithValue("@TEAM", team);
                cmd.Parameters.AddWithValue("@PHONE", phone);
                cmd.Parameters.AddWithValue("@EMAIL", email);
                cmd.Parameters.AddWithValue("@DESCRIPTION", description);
                connection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch { }
            }
        }

        public object UsernameVerify_DB(string username)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("USERNAME_SIGNUP_VERIFY", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@USERNAME", username);
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
    }

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

    public class UserDB
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;

        public object returnRole_DB(string UserID)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("RETURN_NAME_ROLE", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@USERID", UserID);
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

        public object tourList_DB()
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("USER_TOUR_SHOW", connection);
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

        public void interestUser_DB(string UserID, string tourID)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("INTERESTED_USER_LIST", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID", UserID);
                cmd.Parameters.AddWithValue("@TOURID", tourID);
                cmd.Parameters.AddWithValue("@TIME", DateTime.Now);
                connection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch { }
            }
        }

        public object accept_list_DB(string UserID)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("ACCEPT_LIST_SHOW_USER", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@UserID", UserID);

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
    }

}
