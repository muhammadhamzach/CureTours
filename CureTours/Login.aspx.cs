using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace CureTours
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void LogInButton_Click(object sender, EventArgs e)
        {
            string ConnectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("LOGINVERIFY", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@USERNAME", Username.Text);
                cmd.Parameters.AddWithValue("@PASS", Password.Text);
                connection.Open();
                try {
                    string user_role = cmd.ExecuteScalar().ToString();
                    if (user_role.Equals("admin"))
                        Response.Redirect("AdminPortal.aspx");
                    else
                        Response.Redirect("UserPortal.aspx");
                }
                catch
                {
                    Response.Write("Invalid Username or Password");
                }
            }
        }

        protected void SignUpButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("SignUp.aspx");
        }
    }
}