using System;
using System.Linq;
using System.Web.UI;
using System.Data;
using AdminBSLayer;

namespace CureTours
{
    public partial class CreateTour : System.Web.UI.Page
    {
        string tourID ="new";
        AdminBS admin = new AdminBS();

        protected void Page_Load(object sender, EventArgs e)
        {
            tourID = Request.QueryString["ID"];     //for retrieving the tourID from URL
            if (!Page.IsPostBack)   //if tour is in edit mode, this will put all the details oin the box
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

        protected void TourSaveButton_Click(object sender, EventArgs e)     //when tour save button is pressed after saved creation/edit
        {
            if(DateTime.Parse(DateFromBox.Text) > DateTime.Parse(DateToBox.Text))
            {
                DateFromError.Text = "Invalid Date";
                DateToError.Text = "Invalid Date";
                DateFromBox.Text = "";
                DateToBox.Text = "";
            }
            else
            {
                admin.tourSave_BS(tourID, TourTitle.Text, DateFromBox.Text, DateToBox.Text, PlanBox.Text, SeatCountBox.Text, CostBox.Text);
                if (!tourID.All(Char.IsDigit))
                    Response.Redirect("CreateTour.aspx?ID=new");
                TourMessage.Text = "Tour Details Modified";
            }   
        }

        protected void ReturnButton_Click(object sender, EventArgs e)       //redirecting back to admin portal
        {
            Response.Redirect("AdminPortal.aspx?ID=" + tourID);
        }

        protected void CalendarFromDate_SelectionChanged(object sender, EventArgs e)
        {
            if (DateTime.Now < CalendarFromDate.SelectedDate)
            {
                DateFromBox.Text = CalendarFromDate.SelectedDate.ToString("dd-MM-yyyy");
            }
        }

        protected void CalendarToDate_SelectionChanged(object sender, EventArgs e)
        {
            if (DateTime.Now < CalendarToDate.SelectedDate)
            {
                DateToBox.Text = CalendarToDate.SelectedDate.ToString("dd-MM-yyyy");
            } 
        }

        protected void CalenderFrom_Click(object sender, ImageClickEventArgs e)
        {
            if (CalendarFromDate.Visible == false)
                CalendarFromDate.Visible = true;
            else
                CalendarFromDate.Visible = false;
        }

        protected void CalenderTo_Click(object sender, ImageClickEventArgs e)
        {
            if (CalendarToDate.Visible == false)
                CalendarToDate.Visible = true;
            else
                CalendarToDate.Visible = false;
        }
    }
}