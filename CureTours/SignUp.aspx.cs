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
    public partial class SignUp : System.Web.UI.Page
    {
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
            if(!Page.IsPostBack)
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
            string ConnectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SIGNUP_VERIFY", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@USERNAME", UsernameBox.Text);
                connection.Open();
                try
                {
                    string user_role = cmd.ExecuteScalar().ToString();
                    if (!user_role.Equals("admin") && !user_role.Equals("user"))
                        Response.Write("good");
                }
                catch
                {
                    
                }
            }
        }
    }
}