using System;
using UserDBlayer;

namespace UserBSLayer
{
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

        public void interestUser_BS(string UserID,string tourID)
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
}
