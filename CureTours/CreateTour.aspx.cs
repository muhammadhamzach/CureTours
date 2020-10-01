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
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void TourSaveButton_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("NEW_TOUR_ADD", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TITLE", TourTitle.Text);
                cmd.Parameters.AddWithValue("@FROMDATE", Convert.ToDateTime(DateFromBox.Text));
                cmd.Parameters.AddWithValue("@TODATE", Convert.ToDateTime(DateToBox.Text));
                cmd.Parameters.AddWithValue("@DETAILS", PlanBox.Text);
                cmd.Parameters.AddWithValue("@TOTALSEATS", Int32.Parse(SeatCountBox.Text));
                connection.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch { }
            }
            Response.Redirect("AdminPortal.aspx");
        }
    }
}