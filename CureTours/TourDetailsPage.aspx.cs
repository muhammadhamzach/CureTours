using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL;

namespace CureTours
{
    public partial class TourDetailsPage : System.Web.UI.Page
    {
        string tourTitle = "";
        string tourID = "";
        AdminBS admin = new AdminBS();

        protected void Page_Load(object sender, EventArgs e)
        {
            tourID = Request.QueryString["ID"];
            try
            {
                if (Session["ID"].ToString() != "0")
                {
                    Session["ID"] = "";
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    object obj = admin.show_specific_tour_BS(tourID);
                    DataTable dt = obj as DataTable;
                    tourTitle = dt.Rows[0][0].ToString();
                    TourTitleTag.Text = tourTitle;
                }
                //retrieving title of tour for use later
            }
            catch { Response.Redirect("Login.aspx");  }

            if (!Page.IsPostBack)
                interested_user_detail_box();
        }   

        protected void interested_user_detail_box()     //listing all the users which are interested in specfic tour
        {
            object reader = admin.interested_user_list_BS(tourID);
            TourInterestedDetailsGrid.DataSource = reader as DataSet;
            TourInterestedDetailsGrid.DataBind();
        }

        protected void AcceptButton_Click(object sender, EventArgs e)   //accepting user request against a particular tour 
        {
            if ((sender as Button).Text == "Accept")
            {
                Button lb = (Button)sender;
                GridViewRow Row = (GridViewRow)lb.NamingContainer;
                GridViewRow row = TourInterestedDetailsGrid.Rows[Row.RowIndex];
                string name = row.Cells[1].Text.ToString();

                bool verify = admin.acceptUser_BS(tourID, name);
                if (verify)
                    Response.Redirect(Request.RawUrl, true);
                else
                    DetailsMessageLabel.Text = "No More Seats";
            }
        }

        protected void RejectButton_Click(object sender, EventArgs e)   //rejecting user request against a particular tour
        {
            if ((sender as Button).Text == "Reject")
            {
                Button lb = (Button)sender;
                GridViewRow Row = (GridViewRow)lb.NamingContainer;
                GridViewRow row = TourInterestedDetailsGrid.Rows[Row.RowIndex];
                string name = row.Cells[1].Text.ToString();

                admin.rejectUser_BS(tourID, name);
                DetailsMessageLabel.Text = "User removed from list";
                Response.Redirect(Request.RawUrl, true);
            }
        }

        protected void FinalListViewer_Click(object sender, EventArgs e)    //listing sll the users that are accepted for a particular tour
        {
            object reader = admin.finalizedUsers_BS(tourID);
            FinalizedUserViewer.DataSource = reader as DataSet;
            FinalizedUserViewer.DataBind();
        }

        protected void ReturnButton_Click(object sender, EventArgs e)   //return redirect to admin portal
        {
            Response.Redirect("AdminPortal.aspx");
        }

        protected void EditTableButton_Click(object sender, EventArgs e)    //for tour edit purposes
        {
            Response.Redirect("CreateTour.aspx?ID=" + tourID);
        }
    }
}