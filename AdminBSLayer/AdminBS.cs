using System;
using System.Linq;
using AdminDBLayer;

namespace AdminBSLayer
{
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

        public void tourSave_BS(string tourID, string title, string dateFrom, string dateTo, string PlanBox, string seatCount, string cost)
        {
            string command = "NEW_TOUR_ADD";
            if (tourID.All(Char.IsDigit))
                command = "EDIT_TOUR";
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
