using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Security;

namespace CureTours
{
    public partial class AdminPortal : System.Web.UI.Page
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                tour_detail_box();
            }
        }

        protected void NewTourCreationButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateTour.aspx");
        }

        protected void tour_detail_box()
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("ADMIN_TOUR_SHOW", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                try
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        TourGrid.DataSource = reader;
                        TourGrid.DataBind();
                    }
                }
                catch { }
            }
        }

        protected void TourGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[2].Text = Convert.ToDateTime(e.Row.Cells[2].Text).ToString("dd-MM-yyyy");
                e.Row.Cells[3].Text = Convert.ToDateTime(e.Row.Cells[3].Text).ToString("dd-MM-yyyy");
            }
        }

        protected void DetailsButton_Click(object sender, EventArgs e)
        {
            if ((sender as Button).Text == "Details")
            {
                Button lb = (Button)sender;
                GridViewRow Row = (GridViewRow)lb.NamingContainer;
                GridViewRow row = TourGrid.Rows[Row.RowIndex];
                string title = row.Cells[1].Text.ToString();
                Response.Redirect("TourDetailsPage.aspx?TourTitle=" + title);
            }
        }

        protected void LogOutButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}