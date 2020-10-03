﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CureTours.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <meta charset="UTF-8"/>
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
                <p><asp:TextBox ID="Username" runat="server" Width="45%" Height="30px" Font-Size="16px"></asp:TextBox></p>
                <p class ="text">Password</p>
                <p ><asp:TextBox ID="Password" runat="server" Width="45%" Height="30px" TextMode="Password" Font-Size="16px"></asp:TextBox></p>
                <p class="Logbox"><asp:Button ID="LogInButton" runat="server" Text="LogIn" Width="45%" Height="30px" OnClick="LogInButton_Click" /></p>
                <p><asp:Label ID="LoginErrorLabel" runat="server" ForeColor="Red"></asp:Label></p>
                <p class ="text">Dont have an account?</p>
                <p><asp:Button ID="SignUpButton" runat="server" Text="SignUp" Width="45%" Height="30px" OnClick="SignUpButton_Click" /></p>
            </div>
            
        </form>

    </body>
</html>
