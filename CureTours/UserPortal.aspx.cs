using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using UserBSLayer;

namespace CureTours
{
    public partial class UserPortal : System.Web.UI.Page
    {
        string Name = "";
        string User_Role = "";
        string UserID = "";
        UserBS user = new UserBS();

        protected void Page_Load(object sender, EventArgs e)
        {
            UserID = Request.QueryString["ID"];

            if (!Page.IsPostBack)
            {
                tour_detail_box();
                accepted_list_show();
            }

            //name and user role corresponding to a userID
            object obj = user.returnRole_BS(UserID);
            DataTable dt = obj as DataTable;
            Name = dt.Rows[0][0].ToString();
            User_Role = dt.Rows[0][1].ToString();
            NameLabel.Text = Name;
            UserRoleLabel.Text = User_Role;

        }

        protected void tour_detail_box()    //listing all the tours for user view
        {
            object reader = user.tourList_BS();
            TourGrid.DataSource = reader as DataSet;
            TourGrid.DataBind();
        }

        protected void accepted_list_show()
        {
            object reader = user.accept_list_BS(UserID);
            acceptedTourGrid.DataSource = reader as DataSet;
            acceptedTourGrid.DataBind();
        }

        protected void InterestedButton_Click(object sender, EventArgs e)   //if user shows interest against a specfied tour
        {
            if ((sender as Button).Text == "Interested")
            {
                Button lb = (Button)sender;
                GridViewRow Row = (GridViewRow)lb.NamingContainer;
                GridViewRow row = TourGrid.Rows[Row.RowIndex];
                bool valid_date = user.dateComparator(row.Cells[3].Text.ToString());

                int rem_seats = Int32.Parse(row.Cells[7].Text.ToString());
                if (rem_seats == 0)
                    TourInterestLabel.Text = "No Seat Remainings!";
                else if (!valid_date)
                    TourInterestLabel.Text = "Time to register has exceeded!";
                else
                {
                    user.interestUser_BS(UserID, row.Cells[1].Text.ToString());
                    TourInterestLabel.Text = "Request Submitted!";
                }
            }
        }

        protected void TourGrid_RowDataBound(object sender, GridViewRowEventArgs e)     //modifying datetime string to date
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[3].Text = Convert.ToDateTime(e.Row.Cells[3].Text).ToString("dd-MM-yyyy");
                e.Row.Cells[4].Text = Convert.ToDateTime(e.Row.Cells[4].Text).ToString("dd-MM-yyyy");
            }
        }

        protected void LogOutButton_Click(object sender, EventArgs e)       //redirecting to login page
        {
            Response.Redirect("Login.aspx");
        }
    }
}