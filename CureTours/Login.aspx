<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CureTours.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link href="LoginStyle.css" rel="stylesheet" />
        <title>CureTours</title>
    </head>
    <body>
        <form id="form1" runat="server">
            <h1>CureTours</h1>
            <p>Username</p>
            <asp:TextBox ID="Username" runat="server" Width="250px"></asp:TextBox>
            <p>Password</p>
            <asp:TextBox ID="Password" runat="server" Width="250px" TextMode="Password"></asp:TextBox>
            <p>
                <asp:Button ID="LogInButton" runat="server" Text="LogIn" Width="250px" OnClick="LogInButton_Click" />
            </p>
            <p>
                <asp:Label ID="LoginErrorLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>
            <p>Dont have an account?</p>
            <p>
                <asp:Button ID="SignUpButton" runat="server" Text="SignUp" Width="250px" OnClick="SignUpButton_Click" />
            </p>
        </form>

    </body>
</html>
