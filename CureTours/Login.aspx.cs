using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Security;

namespace CureTours
{
    public partial class Login : System.Web.UI.Page
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LogInButton_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("LOGINVERIFY", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@USERNAME", Username.Text);
                cmd.Parameters.AddWithValue("@PASS", Password.Text);
                connection.Open();
                try {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    if (dt.Rows.Count > 0)
                    {
                        FormsAuthentication.RedirectFromLoginPage(Username.Text, false);
                        if (dt.Rows[0][0].ToString().Equals("admin"))
                        {
                            Response.Redirect("AdminPortal.aspx?Username=" + Username.Text);
                        }
                        else if (dt.Rows[0][0].ToString().Equals("user"))
                        {
                            Response.Redirect("UserPortal.aspx?Username=" + Username.Text);
                        }
                    }
                    else
                    {
                        LoginErrorLabel.Text = "Invalid Login Attempt, Try Again";
                    }
                }
                catch { }
            }
        }

        protected void SignUpButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("SignUp.aspx");
        }
    }
}