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
    public partial class UserPortal : System.Web.UI.Page
    {
        string ConnectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
        string Username ="";
        string Name = "";
        string User_Role = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Username = Request.QueryString["Username"];
            if (!Page.IsPostBack)
            {
                tour_detail_box();
            }
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd1 = new SqlCommand("RETURN_NAME", connection);
                SqlCommand cmd2 = new SqlCommand("RETURN_ROLE", connection);
                cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                cmd2.CommandType = System.Data.CommandType.StoredProcedure;
                cmd1.Parameters.AddWithValue("@USERNAME", Username);
                cmd2.Parameters.AddWithValue("@USERNAME", Username);
                connection.Open();
                try
                {
                    Name = cmd1.ExecuteScalar().ToString();
                    User_Role = cmd2.ExecuteScalar().ToString();
                }
                catch { }
            }
            NameLabel.Text = Name;
            UserRoleLabel.Text = User_Role;

        }

        protected void tour_detail_box()
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("USER_TOUR_SHOW", connection);
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

        protected void InterestedButton_Click(object sender, EventArgs e)
        {
            if ((sender as Button).Text == "Interested")
            {
                Button lb = (Button)sender;
                GridViewRow Row = (GridViewRow)lb.NamingContainer;
                GridViewRow row = TourGrid.Rows[Row.RowIndex];
                bool valid_date = dateComparator(Row.RowIndex);
                int rem_seats = Int32.Parse(row.Cells[5].Text.ToString());
                if (rem_seats == 0)
                    TourInterestLabel.Text = "No Seat Remainings!";
                else if (!valid_date)
                    TourInterestLabel.Text = "Time to register has exceeded!";
                else
                {
                    TourInterestLabel.Text = "Request Submitted!";
                    using (SqlConnection connection = new SqlConnection(ConnectionString))
                    {
                        SqlCommand cmd = new SqlCommand("INTERESTED_USER_LIST", connection);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@USERNAME", Username);
                        cmd.Parameters.AddWithValue("@TOURTITLE", row.Cells[1].Text.ToString());
                        cmd.Parameters.AddWithValue("@TIME", DateTime.Now);
                        connection.Open();
                        try
                        {
                            cmd.ExecuteNonQuery();
                        }
                        catch { }
                    }
                }
            }
        }

        protected bool dateComparator(int rowIndex)
        {
            GridViewRow row = TourGrid.Rows[rowIndex];
            DateTime dt1 = DateTime.Parse(row.Cells[2].Text.ToString());
            DateTime dt2 = DateTime.Now;
            if (dt1.Date > dt2.Date)
                return true;
            else
                return false;
        }

        protected void TourGrid_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[2].Text = Convert.ToDateTime(e.Row.Cells[2].Text).ToString("dd-MM-yyyy");
                e.Row.Cells[3].Text = Convert.ToDateTime(e.Row.Cells[3].Text).ToString("dd-MM-yyyy");
            }
        }

        protected void LogOutButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}