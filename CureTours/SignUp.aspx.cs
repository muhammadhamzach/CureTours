using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using IntroBSLayer;

namespace CureTours
{
    public partial class SignUp : System.Web.UI.Page
    {
        IntroBS intro = new IntroBS();

        public enum teamlist
        {
            Integration = 1, EHR = 2, Billing = 3, EDI = 4, Oncology = 5, Avalon = 6, QA = 7, 
            Client_Services = 8, CureX = 9, DevOps = 10, HR = 11, IT = 12, Database = 13
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
                intro.SignUpButton_Business(UsernameBox.Text, NameBox.Text, PasswordBox.Text, TeamListDropDown.SelectedItem.Text, PhoneBox.Text, EmailBox.Text, DescriptionBox.Text);
                Response.Redirect("Login.aspx");
            }
        }

        protected bool UsernameBox_TextVerify()
        {
            object obj = intro.UsernameBox_TextVerify(UsernameBox.Text);
            DataTable dt = obj as DataTable;
            if (dt.Rows.Count == 0)
                return true;
            else
                UsernameLabel.Text = "Username already exists";
            
            return false;
        }

        protected void LogInButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}