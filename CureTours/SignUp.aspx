<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="CureTours.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-align: left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Sign Up Portal</h1>
        <p class="auto-style1">Username 
            <asp:TextBox ID="UsernameBox" runat="server" style="margin-left: 59px" Width="201px"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" id="reqUserName" controltovalidate="UsernameBox" ForeColor="Red" errormessage="Please enter a username!" />
        </p>
        
        <p>Password
            <asp:TextBox ID="PasswordBox" runat="server" style="margin-left: 62px" Width="195px"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" id="reqPassWprd" controltovalidate="PasswordBox" ForeColor="Red" errormessage="Please enter Password for your profile!" />
        </p>

        <p>Name
            <asp:TextBox ID="NameBox" runat="server" style="margin-left: 90px" Width="195px"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" id="reqName" controltovalidate="NameBox" ForeColor="Red" errormessage="Please enter your Name!" />
        </p>

        <p>Team
            <asp:DropDownList ID="TeamListDropDown" runat="server" Height="30px" style="margin-left: 93px" Width="202px">
                <asp:ListItem Text="Please Select--" Value="0"></asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator runat="server" id="reqTeamName" controltovalidate="TeamListDropDown" ForeColor="Red" errormessage="Please select your team!" />
        </p>

        <p>Phone
            <asp:TextBox ID="PhoneBox" runat="server" style="margin-left: 90px" Width="195px">+92-XXX-XXXXXXX</asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" 
                    runat="server" ErrorMessage="Enter valid Phone number" 
                    ForeColor="Red"  Display = "Dynamic" 
                    ControlToValidate="PhoneBox" 
                    ValidationExpression= "/^[0-9]{0,5}[ ]{0,1}[0-9]{0,6}$/g"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator runat="server" id="reqPhoneNo" controltovalidate="PhoneBox" ForeColor="Red" errormessage="Please enter your phone number!" />
        </p>

        <p>Email
            <asp:TextBox ID="EmailBox" runat="server" style="margin-left: 90px" Width="195px"></asp:TextBox>
            <!--Email Verification Regex Query -->
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" 
                    runat="server" 
                    ControlToValidate="EmailBox"
                    ForeColor="Red" 
                    ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                    Display = "Dynamic" 
                    ErrorMessage = "Invalid email address"/>
            <asp:RequiredFieldValidator runat="server" id="reqEmailAddress" controltovalidate="EmailBox" ForeColor="Red" errormessage="Please enter your email!" />
       
        </p>

        <p>About You!
            <br />
            <asp:TextBox ID="TextBox1" runat="server" Height="77px" Width="338px"></asp:TextBox>
        </p>
        
        <asp:Button ID="SignUpSubmit" runat="server" Text="Submit" Width="344px" OnClick="SignUpSubmit_Click" />
        
    </form>
</body>
</html>
