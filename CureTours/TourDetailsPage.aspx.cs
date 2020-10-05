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
    public partial class TourDetailsPage : System.Web.UI.Page
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
        string tourTitle = "";
        string tourID = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            tourID = Request.QueryString["ID"];
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("RETURN_TOUR", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TOURID", tourID);
                connection.Open();
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    tourTitle = dt.Rows[0][0].ToString();
                }
                catch { }
            }
            TourTitleTag.Text = tourTitle;

            if (!Page.IsPostBack)
            {
                interested_user_detail_box();
            }
        }

        protected void interested_user_detail_box()
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SHOW_INTERESTED_DETAILS", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TOURID", tourID);
                connection.Open();
                try
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        TourInterestedDetailsGrid.DataSource = reader;
                        TourInterestedDetailsGrid.DataBind();
                    }
                }
                catch { }
            }
        }

        protected void AcceptButton_Click(object sender, EventArgs e)
        {
            if ((sender as Button).Text == "Accept")
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {

                    Button lb = (Button)sender;
                    GridViewRow Row = (GridViewRow)lb.NamingContainer;
                    GridViewRow row = TourInterestedDetailsGrid.Rows[Row.RowIndex];
                    string name = row.Cells[1].Text.ToString();

                    
                    SqlCommand cmd1 = new SqlCommand("RETURN_REM_SEAT_COUNT", connection);
                    SqlCommand cmd2 = new SqlCommand("ACCEPT_USER", connection);

                    cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd2.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd1.Parameters.AddWithValue("@TOURID", tourID);

                    cmd2.Parameters.AddWithValue("@TOURID", tourID);
                    cmd2.Parameters.AddWithValue("@NAME", name);


                    connection.Open();
                    try
                    {
                        int rem_count = Int32.Parse(cmd1.ExecuteScalar().ToString());
                        if (rem_count != 0)
                        {
                            DetailsMessageLabel.Text = rem_count.ToString();
                            cmd2.ExecuteNonQuery();
                            Response.Redirect(Request.RawUrl, true);
                        }
                        else
                            DetailsMessageLabel.Text = "No More Seats";
                    }
                    catch { }
                   
                }
            }
        }

        protected void RejectButton_Click(object sender, EventArgs e)
        {
            if ((sender as Button).Text == "Reject")
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                
                    Button lb = (Button)sender;
                    GridViewRow Row = (GridViewRow)lb.NamingContainer;
                    GridViewRow row = TourInterestedDetailsGrid.Rows[Row.RowIndex];
                    string name = row.Cells[1].Text.ToString();

                    SqlCommand cmd = new SqlCommand("REJECT_USER", connection);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TOURID", tourID);
                    cmd.Parameters.AddWithValue("@NAME", name);
                    connection.Open();
                    try
                    {
                        cmd.ExecuteNonQuery();
                        DetailsMessageLabel.Text = "User removed from list";
                    }
                    catch { }
                    Response.Redirect(Request.RawUrl, true);
                }
            }
        }

        protected void FinalListViewer_Click(object sender, EventArgs e)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SHOW_FINALIZED_USERS", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TOURID", tourID);
                connection.Open();
                try
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        FinalizedUserViewer.DataSource = reader;
                        FinalizedUserViewer.DataBind();
                    }
                }
                catch { }
            }
        }

        protected void ReturnButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminPortal.aspx");
        }

        protected void EditTableButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateTour.aspx?ID=" + tourID);
        }
    }
}