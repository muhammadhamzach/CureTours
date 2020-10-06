using IntroDBLayer;

namespace IntroBSLayer
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
}
