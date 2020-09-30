using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            
        }
    }
}