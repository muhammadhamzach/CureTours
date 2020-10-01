using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;


namespace CureTours
{
    public partial class SignUp : System.Web.UI.Page
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
        
        public enum teamlist
        {
            Integration = 1,
            EHR = 2,
            Billing = 3,
            EDI = 4,
            Oncology = 5,
            Avalon = 6,
            QA = 7,
            Client_Services = 8,
            CureX = 9,
            DevOps = 10,
            HR = 11,
            IT = 12
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Array enumlist = Enum.GetValues(typeof(teamlist));
                foreach (teamlist team in enumlist)
                {
                    TeamListDropDown.Items.Add(new ListItem(team.ToString(), ((int)team).ToString()));
                }
            }
        }

        protected void SignUpSubmit_Click(object sender, EventArgs e)
        {
            if (UsernameBox_TextVerify())
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand("NEW_USER_ENTRY", connection);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@USERNAME", UsernameBox.Text);
                    cmd.Parameters.AddWithValue("@NAME", NameBox.Text);
                    cmd.Parameters.AddWithValue("@PASSWORD", PasswordBox.Text);
                    cmd.Parameters.AddWithValue("@TEAM", TeamListDropDown.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@PHONE", PhoneBox.Text);
                    cmd.Parameters.AddWithValue("@EMAIL", EmailBox.Text);
                    cmd.Parameters.AddWithValue("@DESCRIPTION", DescriptionBox.Text);
                    connection.Open();
                    try { 
                        cmd.ExecuteNonQuery();
                    }
                    catch{}
                }
                Response.Redirect("Login.aspx");
            }
        }

        protected bool UsernameBox_TextVerify()
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("USERNAME_SIGNUP_VERIFY", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@USERNAME", UsernameBox.Text);
                connection.Open();
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    if (dt.Rows.Count == 0)
                        return true;
                    else
                        UsernameLabel.Text = "Username already exists";
                }
                catch { }
            }
            return false;
        }

    }
}