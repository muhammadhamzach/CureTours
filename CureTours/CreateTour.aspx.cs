using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;

namespace CureTours
{
    public partial class CreateTour : System.Web.UI.Page
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
        string tourID ="z";
        protected void Page_Load(object sender, EventArgs e)
        {
            tourID = Request.QueryString["ID"];
            if (tourID.All(Char.IsDigit) && !Page.IsPostBack)
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand("SHOW_SPECIFIC_TOUR", connection);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TOURID", tourID);
                    connection.Open();
                    try
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        TourTitle.Text = dt.Rows[0][0].ToString();
                        DateFromBox.Text = Convert.ToDateTime(dt.Rows[0][1].ToString()).ToString("dd-MM-yyyy");
                        DateToBox.Text = Convert.ToDateTime(dt.Rows[0][2].ToString()).ToString("dd-MM-yyyy");
                        PlanBox.Text = dt.Rows[0][3].ToString();
                        SeatCountBox.Text = dt.Rows[0][4].ToString();
                        CostBox.Text = dt.Rows[0][6].ToString();
                    }
                    catch { }
                }
            }
        }

        protected void TourSaveButton_Click(object sender, EventArgs e)
        {
            string command = "NEW_TOUR_ADD";
            if (tourID.All(Char.IsDigit))
                command = "EDIT_TOUR";
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(command, connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                if (tourID.All(Char.IsDigit))
                    cmd.Parameters.AddWithValue("@TOURID", tourID);
                cmd.Parameters.AddWithValue("@TITLE", TourTitle.Text);
                cmd.Parameters.AddWithValue("@FROMDATE", Convert.ToDateTime(DateFromBox.Text));
                cmd.Parameters.AddWithValue("@TODATE", Convert.ToDateTime(DateToBox.Text));
                cmd.Parameters.AddWithValue("@DETAILS", PlanBox.Text);
                cmd.Parameters.AddWithValue("@TOTALSEATS", Int32.Parse(SeatCountBox.Text));
                cmd.Parameters.AddWithValue("@COST", Int32.Parse(CostBox.Text));
                connection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch { }
            }
            if (!tourID.All(Char.IsDigit))
                Response.Redirect("CreateTour.aspx?ID=new");
            TourMessage.Text = "Tour Details Modified";
        }

        protected void ReturnButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("TourDetailsPage.aspx?ID=" + tourID);
        }
    }
}