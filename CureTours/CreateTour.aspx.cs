using System;
using System.Linq;
using System.Web.UI;
using System.Data;
using AdminBSLayer;

namespace CureTours
{
    public partial class CreateTour : System.Web.UI.Page
    {
        string tourID ="";
        AdminBS admin = new AdminBS();

        protected void Page_Load(object sender, EventArgs e)
        {
            tourID = Request.QueryString["ID"];
            if (!Page.IsPostBack)
            {
                object obj = admin.show_specific_user_BS(tourID);
                DataTable dt = obj as DataTable;
                if (dt != null)
                {
                    TourTitle.Text = dt.Rows[0][0].ToString();
                    DateFromBox.Text = Convert.ToDateTime(dt.Rows[0][1].ToString()).ToString("dd-MM-yyyy");
                    DateToBox.Text = Convert.ToDateTime(dt.Rows[0][2].ToString()).ToString("dd-MM-yyyy");
                    PlanBox.Text = dt.Rows[0][3].ToString();
                    SeatCountBox.Text = dt.Rows[0][4].ToString();
                    CostBox.Text = dt.Rows[0][6].ToString();
                }   
            }
        }

        protected void TourSaveButton_Click(object sender, EventArgs e)
        {
            admin.tourSave_BS(tourID, TourTitle.Text, DateFromBox.Text, DateToBox.Text, PlanBox.Text, SeatCountBox.Text, CostBox.Text);
            if (!tourID.All(Char.IsDigit))
                Response.Redirect("CreateTour.aspx?ID=new");
            TourMessage.Text = "Tour Details Modified";
        }

        protected void ReturnButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminPortal.aspx?ID=" + tourID);
        }
    }
}