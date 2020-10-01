<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="CureTours.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up Page</title>
    
</head>
<body>
    <form id="form1" runat="server">

        <h1>Sign Up Portal</h1>

        <p class="auto-style1">Username 
            *<asp:TextBox ID="UsernameBox" runat="server" style="margin-left: 59px" Width="201px" AutoPostBack="True" CausesValidation="True"></asp:TextBox>
            <asp:Label ID="UsernameLabel" runat="server" ForeColor="Red"></asp:Label>
            <asp:RegularExpressionValidator ID="usernamevalidator" 
                runat="server"  ForeColor="Red" 
                ErrorMessage="Invalid Username"
                ValidationExpression="^[a-z0-9_]{5,15}$"
                ControlToValidate="UsernameBox">
            </asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="usernamevalidator1"
                runat="server" 
                ControlToValidate="UsernameBox" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </p>
        
        <p>Password
            *<asp:TextBox ID="PasswordBox" runat="server" style="margin-left: 62px" Width="195px" TextMode="Password"></asp:TextBox>
            <asp:RegularExpressionValidator ID="passwordvalidator" 
                runat="server"  ForeColor="Red" 
                ErrorMessage="Invalid Password"
                ValidationExpression="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
                ControlToValidate="PasswordBox">
            </asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="passwordvalidator1"
                runat="server" 
                ControlToValidate="PasswordBox" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </p>
        <p style ="font-size: 12px">Make sure password is atleast 8 character long, contains atleast 1 Uppercase, 1 Lowercase, 1 Number and 1 Special Character</p>

        <p>Name
            *<asp:TextBox ID="NameBox" runat="server" style="margin-left: 90px" Width="195px"></asp:TextBox>
            <asp:RegularExpressionValidator ID="namevalidator" 
                runat="server"  ForeColor="Red" 
                ErrorMessage="Invalid character in Name"
                ValidationExpression="^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
                ControlToValidate="NameBox">
            </asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="namevalidator1"
                runat="server" 
                ControlToValidate="NameBox" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </p>

        <p>Team
            *<asp:DropDownList ID="TeamListDropDown" runat="server" Height="30px" style="margin-left: 93px" Width="202px">
                <asp:ListItem Text="Please Select--" Value="0"></asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="teamValidator" 
                runat="server" 
                ControlToValidate="TeamListDropDown" 
                InitialValue="0" 
                ErrorMessage="Please select some team" ForeColor="Red" />
        </p>

        <p>Mobile No
            *<asp:TextBox ID="PhoneBox" runat="server" style="margin-left: 54px" Width="195px">+92-XXX-XXXXXXX</asp:TextBox>
            <asp:RegularExpressionValidator ID="mobilenumbervalidator" 
                runat="server"  ForeColor="Red" 
                ErrorMessage="Invalid Mobile Number Style"
                ValidationExpression="^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$"
                ControlToValidate="PhoneBox">
            </asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="mobilenumbervalidator1"
                runat="server" 
                ControlToValidate="PhoneBox" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </p>

        <p>Email
            *<asp:TextBox ID="EmailBox" runat="server" style="margin-left: 90px" Width="195px"></asp:TextBox>
            <!--Email Verification Regex Query -->
            <asp:RegularExpressionValidator ID="emailvalidator" 
                    runat="server" 
                    ControlToValidate="EmailBox"
                    ForeColor="Red" 
                    ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"
                    Display = "Dynamic" 
                    ErrorMessage = "Invalid email address">
            </asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="emailvalidator1"
                runat="server" 
                ControlToValidate="EmailBox" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
       
        </p>

        <p>About You!
            <br />
            <asp:TextBox ID="DescriptionBox" runat="server" Height="77px" Width="338px"></asp:TextBox>
        </p>
        
        <asp:Button ID="SignUpSubmit" runat="server" Text="Submit" Width="344px" OnClick="SignUpSubmit_Click" />
        
        <p>
            &nbsp;</p>
        
    </form>
</body>
</html>
