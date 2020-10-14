using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL;

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
            try
            {
                if (Session["ID"].ToString() != UserID || Session["ID"] == null)
                {
                    Session["ID"] = "";
                    Response.Redirect("Login.aspx");
                }
            }
            catch { Response.Redirect("Login.aspx"); }
            

            if (!Page.IsPostBack)
            {
                tour_detail_box();
                accepted_list_show();
            }

            //name and user role corresponding to a userID
            object obj = user.returnRole_BS(UserID);
            DataTable dt = obj as DataTable;
            try
            {
                Name = dt.Rows[0][0].ToString();
                User_Role = dt.Rows[0][1].ToString();
            }
            catch { }
            NameLabel.Text = Name;
            UserRoleLabel.Text = User_Role;

        }

        protected void tour_detail_box()    //listing all the tours for user view
        {
            object reader = user.tourList_BS();
            DataSet ds = reader as DataSet;
            TourGrid.DataSource = ds;
            TourGrid.DataBind();

            int i = 0;
            foreach (GridViewRow row in TourGrid.Rows)
            {
                Button InterestButton = (Button)row.FindControl("InterestedButton");
                bool valid_date = user.dateComparator(TourGrid.Rows[row.RowIndex].Cells[3].Text.ToString());
                int rem_seats = Int32.Parse(TourGrid.Rows[row.RowIndex].Cells[7].Text.ToString());
                if (!valid_date || rem_seats==0)
                {
                    InterestButton.Enabled = false;
                    i++;
                }
            }
        }

        protected void accepted_list_show()
        {
            object reader = user.accept_list_BS(UserID);
            DataSet ds = reader as DataSet;
            acceptedTourGrid.DataSource = ds;
            acceptedTourGrid.DataBind();

            foreach (GridViewRow row in TourGrid.Rows)
            {
                Button InterestButton = (Button)row.FindControl("InterestedButton");
                for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                {
                    if (ds.Tables[0].Rows[j][0].ToString() == TourGrid.Rows[row.RowIndex].Cells[2].Text.ToString())
                    {      
                        InterestButton.Enabled = false;
                        break;
                    }
                }        
            }
        }

        protected void InterestedButton_Click(object sender, EventArgs e)   //if user shows interest against a specfied tour
        {
            if ((sender as Button).Text == "Interested")
            {
                Button lb = (Button)sender;
                GridViewRow Row = (GridViewRow)lb.NamingContainer;
                GridViewRow row = TourGrid.Rows[Row.RowIndex];
                bool valid_date = user.dateComparator(row.Cells[3].Text.ToString());
                user.interestUser_BS(UserID, row.Cells[1].Text.ToString());
                TourInterestLabel.Text = "Request Submitted!";
                lb.Enabled = false;
                Response.Redirect(Request.RawUrl, true);
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
            Session["ID"] = "";
            Response.Redirect("Login.aspx");
        }

        protected void TourGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            TourGrid.PageIndex = e.NewPageIndex;
            tour_detail_box();
            accepted_list_show();
        }

        protected void acceptedTourGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            acceptedTourGrid.PageIndex = e.NewPageIndex;
            accepted_list_show();
        }
    }
}