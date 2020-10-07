<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CureTours.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta http-equiv="Expires" content="0"/>
        <meta http-equiv="Cache-Control" content="no-cache"/>
        <meta http-equiv="Pragma" content="no-cache"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link href="style/LoginStyle.css" rel="stylesheet" />
        <title>CureTours</title>
    </head>
    <body>
        <form id="form1" runat="server">
            <div class="ProjectTitle">
                <h1 >CureTours</h1>
            </div>
            
            <div class="loginForm">

                <p class ="text">Username</p>
                <p><asp:TextBox ID="Username" runat="server" Width="45%" Height="30px" Font-Size="16px" AutoCompleteType="Disabled"></asp:TextBox></p>

                <p class ="text">Password</p>
                <p ><asp:TextBox ID="Password" runat="server" Width="45%" Height="30px" TextMode="Password" Font-Size="16px" AutoCompleteType="Disabled"></asp:TextBox></p>

                <p class="Logbox"><asp:Button ID="LogInButton" runat="server" Text="Log In" Width="45%" Height="30px" OnClick="LogInButton_Click" /></p>
                <p class="errorlabel"><asp:Label ID="LoginErrorLabel" runat="server" ForeColor="Red"></asp:Label></p>

                <p class="signup">Dont have an account?</p>
                <p><asp:Button ID="SignUpButton" runat="server" Text="Sign Up" Width="45%" Height="30px" OnClick="SignUpButton_Click" /></p>
            </div>
            
        </form>

    </body>
</html>
