using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DBL;

namespace BLL
{
    public class IntroBS
    {
        public IntroDB intro = new IntroDB();
        public object LogInButton_Business(string username, string password)
        {
            return intro.LogInButton_DB(username, password);
        }

        public void SignUpButton_Business(string username, string name, string password, string team, string phone, string email, string description)
        {
            intro.SignUpButton_DB(username, name, password, team, phone, email, description);
        }

        public object UsernameBox_TextVerify(string username)
        {
            return intro.UsernameVerify_DB(username);
        }
    }

    public class UserBS
    {
        UserDB user = new UserDB();
        public object returnRole_BS(string UserID)
        {
            return user.returnRole_DB(UserID);
        }

        public object tourList_BS()
        {
            return user.tourList_DB();
        }

        public void interestUser_BS(string UserID, string tourID)
        {
            user.interestUser_DB(UserID, tourID);
        }

        public bool dateComparator(string date)
        {
            DateTime dt1 = DateTime.Parse(date);
            DateTime dt2 = DateTime.Now;
            if (dt1.Date > dt2.Date)
                return true;
            else
                return false;
        }

        public object accept_list_BS(string UserID)
        {
            return user.accept_list_DB(UserID);
        }
    }

    public class AdminBS
    {
        AdminDB admin = new AdminDB();
        public object tour_detail_BS()
        {
            return admin.tour_detail_DB();
        }

        public object show_users_BS()
        {
            return admin.show_users_DB();
        }

        public object show_specific_user_BS(string tourID)
        {
            if (tourID.All(Char.IsDigit))
                return admin.show_specfic_user_DB(tourID);
            else
                return 0;
        }

        public void tourSave_BS(string tourID, string title, string dateFrom, string dateTo, string PlanBox, string seatCount, string cost)     //new tour save
        {
            admin.tourSave_DB("NEW_TOUR_ADD", tourID, title, dateFrom, dateTo, PlanBox, seatCount, cost);
        }

        public void tourSave_BS(string command, string tourID, string title, string dateFrom, string dateTo, string PlanBox, string seatCount, string cost) //existing tour save
        {
            admin.tourSave_DB(command, tourID, title, dateFrom, dateTo, PlanBox, seatCount, cost);
        }

        public object show_specific_tour_BS(string tourID)
        {
            return admin.show_specific_tour_DB(tourID);
        }

        public object interested_user_list_BS(string tourID)
        {
            return admin.interested_user_list_DB(tourID);
        }

        public bool acceptUser_BS(string tourID, string name)
        {
            return admin.acceptUser_DB(tourID, name);
        }

        public void rejectUser_BS(string tourID, string name)
        {
            admin.rejectUser_DB(tourID, name);
        }

        public object finalizedUsers_BS(string tourID)
        {
            return admin.finalizedUser_DB(tourID);
        }

        public void deleteTour_BS(string tourID)
        {
            admin.deleteTour_DB(tourID);
        }
    }


}
