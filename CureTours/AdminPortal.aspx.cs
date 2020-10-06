using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using AdminBSLayer;

namespace CureTours
{
    public partial class AdminPortal : System.Web.UI.Page
    {
        AdminBS admin = new AdminBS();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                tour_detail_box();
        }

        protected void NewTourCreationButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateTour.aspx?ID=new");
        }

        protected void tour_detail_box()
        {
            object reader = admin.tour_detail_BS();
            TourGrid.DataSource = reader as DataSet;
            TourGrid.DataBind();
        }

        protected void TourGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[3].Text = Convert.ToDateTime(e.Row.Cells[3].Text).ToString("dd-MM-yyyy");
                e.Row.Cells[4].Text = Convert.ToDateTime(e.Row.Cells[4].Text).ToString("dd-MM-yyyy");
            }
        }

        protected void DetailsButton_Click(object sender, EventArgs e)
        {
            if ((sender as Button).Text == "Details")
            {
                Button lb = (Button)sender;
                GridViewRow Row = (GridViewRow)lb.NamingContainer;
                GridViewRow row = TourGrid.Rows[Row.RowIndex];
                Response.Redirect("TourDetailsPage.aspx?ID=" + row.Cells[1].Text.ToString());
            }
        }

        protected void LogOutButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void showUsers_Click(object sender, EventArgs e)
        {
            object reader = admin.show_users_BS();
            usersGrid.DataSource = reader as DataSet;
            usersGrid.DataBind();
        }
    }
}