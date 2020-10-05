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
        string Name = "";
        string User_Role = "";
        string UserID = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            UserID = Request.QueryString["ID"];
            if (!Page.IsPostBack)
            {
                tour_detail_box();
            }
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("RETURN_NAME_ROLE", connection);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@USERID", UserID);
                connection.Open();
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    Name = dt.Rows[0][0].ToString();
                    User_Role = dt.Rows[0][1].ToString();
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
                int rem_seats = Int32.Parse(row.Cells[7].Text.ToString());
                if (rem_seats == 0)
                    TourInterestLabel.Text = "No Seat Remainings!";
                else if (!valid_date)
                    TourInterestLabel.Text = "Time to register has exceeded!";
                else
                {
                    
                    using (SqlConnection connection = new SqlConnection(ConnectionString))
                    {
                        SqlCommand cmd = new SqlCommand("INTERESTED_USER_LIST", connection);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@UserID", UserID);
                        cmd.Parameters.AddWithValue("@TOURID", row.Cells[1].Text.ToString());
                        cmd.Parameters.AddWithValue("@TIME", DateTime.Now);
                        connection.Open();
                        try
                        {
                            cmd.ExecuteNonQuery();
                            TourInterestLabel.Text = "Request Submitted!";
                        }
                        catch { }
                    }
                }
            }
        }

        protected bool dateComparator(int rowIndex)
        {
            GridViewRow row = TourGrid.Rows[rowIndex];
            DateTime dt1 = DateTime.Parse(row.Cells[3].Text.ToString());
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
                e.Row.Cells[3].Text = Convert.ToDateTime(e.Row.Cells[3].Text).ToString("dd-MM-yyyy");
                e.Row.Cells[4].Text = Convert.ToDateTime(e.Row.Cells[4].Text).ToString("dd-MM-yyyy");
            }
        }

        protected void LogOutButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}