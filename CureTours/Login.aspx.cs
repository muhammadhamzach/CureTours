using System;
using System.Data;
using System.Web.Security;
using IntroBSLayer;

namespace CureTours
{
    public partial class Login : System.Web.UI.Page
    {
        IntroBS intro = new IntroBS();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LogInButton_Click(object sender, EventArgs e)
        {
            object ob = intro.LogInButton_Business(Username.Text, Password.Text);

            DataTable dt = ob as DataTable;
            if (dt.Rows.Count > 0)
            {
                FormsAuthentication.RedirectFromLoginPage(Username.Text, false);
                if (dt.Rows[0][0].ToString().Equals("0"))
                    Response.Redirect("AdminPortal.aspx?ID=" + "0");
                else
                    Response.Redirect("UserPortal.aspx?ID=" + dt.Rows[0][0].ToString());
            }
            else
                LoginErrorLabel.Text = "Invalid Login Attempt, Try Again";
        }

        protected void SignUpButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("SignUp.aspx");
        }
    }
}