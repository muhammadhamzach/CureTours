<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="CureTours.SignUp" Culture = "en-GB"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignUp Page</title>
    <link href="style/SignUpStyle.css" rel="stylesheet" />
    <script src="script/SignUpScript.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">

        <h1 class="pageTitle">Sign Up!</h1>

        <div class="signupForm">

            <p class="text">Username:*
                <asp:TextBox ID="UsernameBox" runat="server" style="margin-left: 59px" CausesValidation="True" placeholder ="Enter a username" Height="30px" Width="400px" AutoCompleteType="Disabled" MaxLength="20" OnKeyUp ="javascript:usernameValid()"></asp:TextBox>
                <asp:Label ID="UsernameLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>
        
            <p class="text">Password:*
                <asp:TextBox ID="PasswordBox" runat="server" style="margin-left: 62px" TextMode="Password" placeholder ="Enter password for sign-in:" Height="30px" Width="400px" AutoCompleteType="Disabled" MaxLength="20" OnKeyUp ="javascript:passwordValid()"></asp:TextBox>
                <asp:Label ID="PasswordLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>
            <p  class="pwd" style ="font-size: 12px">Password is atleast 8 character long, contains atleast 1 Uppercase, 1 Lowercase, 1 Number and 1 Special Character</p>

            <p class="text">Name:*
                <asp:TextBox ID="NameBox" runat="server" style="margin-left: 90px" placeholder ="Enter your Name" Height="30px" Width="400px" AutoCompleteType="Disabled" MaxLength="20" OnKeyUp ="javascript:nameValid()"></asp:TextBox>
                <asp:Label ID="NameLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>

            <p class="text">Team:*
                <asp:DropDownList ID="TeamListDropDown" runat="server" style="margin-left: 93px" Height="30px" Width="405px" onchange ="teamValid()">
                    <asp:ListItem Text="Please Select--" Value="0"></asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="TeamListLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>

            <p class="text">Mobile No:*
                <asp:TextBox ID="PhoneBox" runat="server" style="margin-left: 49px" placeholder ="+92-XXX-XXXXXXX" Height="30px" Width="400px" AutoCompleteType="Disabled" OnKeyUp ="javascript:phoneValid()"></asp:TextBox>
                <asp:Label ID="PhoneLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>

            <p class="text">Email:*
                <asp:TextBox ID="EmailBox" runat="server" style="margin-left: 88px" placeholder ="Enter your email address:" Height="30px" Width="400px" AutoCompleteType="Disabled" MaxLength="30" OnKeyUp ="javascript:emailValid()"></asp:TextBox>
                <asp:Label ID="EmailLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>

            <p class="text">About You!</p>
            <p><asp:TextBox ID="DescriptionBox" runat="server" Height="80px" Width="560px" TextMode="MultiLine" Font-Size="14pt" AutoCompleteType="Disabled" MaxLength="200"></asp:TextBox>
            </p>
        
            <p class="signupButton">
                <asp:Button ID="SignUpSubmit" runat="server" Text="Submit" Width= "565px" Height="40px" OnClick="SignUpSubmit_Click" Font-Size="14pt" OnClientClick="return Validation()"/>
            </p>

            
        </div>
        
        <div class="loginButton">
            
            <p class="text">Already a user?</p>
            <p>
                <asp:Button ID="LogInButton" runat="server" OnClick="LogInButton_Click" Text="Log In" Width= "565px" Height="40px" CausesValidation="False" Font-Size="14pt" />
            </p>
        </div>
        
    </form>
        
        
    
</body>
</html>
