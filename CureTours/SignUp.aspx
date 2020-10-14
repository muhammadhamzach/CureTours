<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="CureTours.SignUp" Culture = "en-GB"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignUp Page</title>
    <link href="style/SignUpStyle.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <h1 class="pageTitle">Sign Up!</h1>

        <div class="signupForm">

            <p class="text">Username:*
                <asp:TextBox ID="UsernameBox" runat="server" style="margin-left: 59px" CausesValidation="True" placeholder ="Enter a username" Height="30px" Width="400px" AutoCompleteType="Disabled" MaxLength="20"></asp:TextBox>
                <asp:Label ID="UsernameLabel" runat="server" ForeColor="Red"></asp:Label>
                <asp:RegularExpressionValidator ID="usernamevalidator" 
                    runat="server"  ForeColor="Red" 
                    ErrorMessage="Invalid Username"
                    ValidationExpression="^[a-z0-9_]{5,20}$"
                    ControlToValidate="UsernameBox" Display="Dynamic"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="usernamevalidator1"
                    runat="server" 
                    ControlToValidate="UsernameBox" ErrorMessage="Username can't be empty" ForeColor="Red"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </p>
        
            <p class="text">Password:*
                <asp:TextBox ID="PasswordBox" runat="server" style="margin-left: 62px" TextMode="Password" placeholder ="Enter password for sign-in:" Height="30px" Width="400px" AutoCompleteType="Disabled" MaxLength="20" ></asp:TextBox>
                <asp:RegularExpressionValidator ID="passwordvalidator" 
                    runat="server"  ForeColor="Red" 
                    ErrorMessage="Invalid Password"
                    ValidationExpression="^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"
                    ControlToValidate="PasswordBox" Display="Dynamic"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="passwordvalidator1"
                    runat="server" 
                    ControlToValidate="PasswordBox" ErrorMessage="Password can't be empty" ForeColor="Red"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </p>
            <p  class="pwd" style ="font-size: 12px">Password is atleast 8 character long, contains atleast 1 Uppercase, 1 Lowercase, 1 Number and 1 Special Character</p>

            <p class="text">Name:*
                <asp:TextBox ID="NameBox" runat="server" style="margin-left: 90px" placeholder ="Enter your Name" Height="30px" Width="400px" AutoCompleteType="Disabled" MaxLength="20" ></asp:TextBox>
                <asp:RegularExpressionValidator ID="namevalidator" 
                    runat="server"  ForeColor="Red" 
                    ErrorMessage="Invalid character in Name"
                    ValidationExpression="^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
                    ControlToValidate="NameBox" Display="Dynamic"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="namevalidator1"
                    runat="server" 
                    ControlToValidate="NameBox" ErrorMessage="Name can't be empty" ForeColor="Red"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </p>

            <p class="text">Team:*
                <asp:DropDownList ID="TeamListDropDown" runat="server" style="margin-left: 93px" Height="30px" Width="405px" >
                    <asp:ListItem Text="Please Select--" Value="0"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="teamValidator" 
                    runat="server" 
                    ControlToValidate="TeamListDropDown" 
                    InitialValue="0" 
                    ErrorMessage="Please select some team" ForeColor="Red" />
            </p>

            <p class="text">Mobile No:*
                <asp:TextBox ID="PhoneBox" runat="server" style="margin-left: 49px" placeholder ="+92-XXX-XXXXXXX" Height="30px" Width="400px" AutoCompleteType="Disabled" ></asp:TextBox>
                <asp:RegularExpressionValidator ID="mobilenumbervalidator" 
                    runat="server"  ForeColor="Red" 
                    ErrorMessage="Invalid Mobile Number Style"
                    ValidationExpression="^((\+92)|(0092)|(92))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$"
                    ControlToValidate="PhoneBox" Display="Dynamic"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="mobilenumbervalidator1"
                    runat="server" 
                    ControlToValidate="PhoneBox" ErrorMessage="Phone No can't be empty" ForeColor="Red"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </p>

            <p class="text">Email:*
                <asp:TextBox ID="EmailBox" runat="server" style="margin-left: 88px" placeholder ="Enter your email address:" Height="30px" Width="400px" AutoCompleteType="Disabled" MaxLength="30" ></asp:TextBox>
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
                    ControlToValidate="EmailBox" ErrorMessage="Email can't be empty" ForeColor="Red"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </p>

            <p class="text">About You!</p>
            <p><asp:TextBox ID="DescriptionBox" runat="server" Height="80px" Width="560px" TextMode="MultiLine" Font-Size="14pt" AutoCompleteType="Disabled" MaxLength="200"></asp:TextBox>
            </p>
        
            <p class="signupButton">
                <asp:Button ID="SignUpSubmit" runat="server" Text="Submit" Width= "565px" Height="40px" OnClick="SignUpSubmit_Click" Font-Size="14pt" />
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
