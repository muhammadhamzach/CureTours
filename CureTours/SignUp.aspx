<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="CureTours.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Sign Up Portal</h1>
        <p>Username 
            <asp:TextBox ID="UsernamBox" runat="server" style="margin-left: 59px" Width="201px"></asp:TextBox>
        </p>
        
        <p>Password
            <asp:TextBox ID="PasswordBox" runat="server" style="margin-left: 62px" Width="195px"></asp:TextBox>
        </p>

        <p>Name
            <asp:TextBox ID="NameBox" runat="server" style="margin-left: 90px" Width="195px"></asp:TextBox>
        </p>

        <p>Team
            <asp:DropDownList ID="TeamListDropDown" runat="server" Height="16px" style="margin-left: 93px" Width="202px">
                <asp:ListItem Text="Please Select--" Value="0"></asp:ListItem>
            </asp:DropDownList>
        </p>

        <p>Phone
            <asp:TextBox ID="PhoneBox" runat="server" style="margin-left: 90px" Width="195px"></asp:TextBox>
        </p>

        <p>Email
            <asp:TextBox ID="EmailBox" runat="server" style="margin-left: 90px" Width="195px"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" 
                 runat="server" 
                    ControlToValidate="EmailBox"
                    ForeColor="Red" 
                    ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                    Display = "Dynamic" 
                    ErrorMessage = "Invalid email address"/>
        </p>

        <p>About You!
            <br />
            <asp:TextBox ID="TextBox1" runat="server" Height="77px" Width="338px"></asp:TextBox>
        </p>
        
        <asp:Button ID="SignUpSubmit" runat="server" Text="Submit" Width="344px" OnClick="SignUpSubmit_Click" />
        
    </form>
</body>
</html>
