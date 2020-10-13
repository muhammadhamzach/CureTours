using System;
using System.Linq;
using System.Web.UI;
using System.Data;
using BLL;

namespace CureTours
{
    public partial class CreateTour : System.Web.UI.Page
    {
        string tourID ="new";
        AdminBS admin = new AdminBS();

        protected void Page_Load(object sender, EventArgs e)
        {
            tourID = Request.QueryString["ID"];     //for retrieving the tourID from URL
            try
            {
                if (Session["ID"].ToString() != "0")
                {
                    Session["ID"] = "";
                    Response.Redirect("Login.aspx");
                }
            }
            catch {}

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
            if((DateTime.Parse(DateFromBox.Text) > DateTime.Parse(DateToBox.Text)) || (DateTime.Parse(DateFromBox.Text) < DateTime.Now))
            {
                DateFromError.Text = "Invalid Date";
                DateToError.Text = "Invalid Date";
                DateFromBox.Text = "";
                DateToBox.Text = "";
            }
            else
            {
                if (tourID.All(Char.IsDigit))
                    admin.tourSave_BS("EDIT_TOUR", tourID, TourTitle.Text, DateFromBox.Text, DateToBox.Text, PlanBox.Text, SeatCountBox.Text, CostBox.Text);
                else
                    admin.tourSave_BS(tourID, TourTitle.Text, DateFromBox.Text, DateToBox.Text, PlanBox.Text, SeatCountBox.Text, CostBox.Text);

                Response.Redirect("AdminPortal.aspx?ID=0");
            }   
        }

        protected void ReturnButton_Click(object sender, EventArgs e)       //redirecting back to admin portal
        {
            Response.Redirect("AdminPortal.aspx?ID=0");
        }
    }
}