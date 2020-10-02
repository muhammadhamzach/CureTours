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
        protected void Page_Load(object sender, EventArgs e)
        {
            tourTitle = Request.QueryString["TourTitle"];
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
                cmd.Parameters.AddWithValue("@TITLE", tourTitle);
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
                    string username = row.Cells[1].Text.ToString();

                    SqlCommand cmd1 = new SqlCommand("REMOVE_INTERESTED_USER", connection);
                    SqlCommand cmd2 = new SqlCommand("FINALIZED_USERS", connection);
                    SqlCommand cmd3 = new SqlCommand("RETURN_REM_SEAT_COUNT", connection);

                    cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd2.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd3.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd1.Parameters.AddWithValue("@TITLE", tourTitle);
                    cmd1.Parameters.AddWithValue("@USERNAME", username);

                    cmd2.Parameters.AddWithValue("@TITLE", tourTitle);
                    cmd2.Parameters.AddWithValue("@USERNAME", username);

                    cmd3.Parameters.AddWithValue("@TITLE", tourTitle);

                    connection.Open();
                    try
                    {
                        int rem_count = Int32.Parse(cmd3.ExecuteScalar().ToString());
                        if (rem_count != 0)
                        {
                            cmd1.ExecuteNonQuery();
                            cmd2.ExecuteNonQuery();
                            DetailsMessageLabel.Text = "User added to final list";
                        }
                        else
                            DetailsMessageLabel.Text = "No More Seats";


                    }
                    catch { }
                    Response.Redirect(Request.RawUrl, true);
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
                    string username = row.Cells[1].Text.ToString();

                    SqlCommand cmd = new SqlCommand("REMOVE_INTERESTED_USER", connection);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TITLE", tourTitle);
                    cmd.Parameters.AddWithValue("@USERNAME", username);
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
                cmd.Parameters.AddWithValue("@TITLE", tourTitle);
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
    }
}