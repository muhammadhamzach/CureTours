<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateTour.aspx.cs" Inherits="CureTours.CreateTour" Culture = "en-GB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link href="style/CreateTourStyle.css" rel="stylesheet" />
    <title>Create Tour (admin)</title>
</head>

<body>
    <form id="form1" runat="server">
        <div class="pageTitle">
            <h1>Create Tour</h1>
        </div>
        <div class="tourForm">
            <p class="text">Title*
                <asp:TextBox ID="TourTitle" runat="server" style="margin-left: 130px" placeholder="Tour Name" Height="30px" Width="400px" Font-Size="13pt" AutoCompleteType="Disabled"></asp:TextBox>
                <asp:RegularExpressionValidator ID="tourTitleValidator" 
                    runat="server"  ForeColor="Red" 
                    ErrorMessage="Invalid Tour Name"
                    ValidationExpression="^[a-zA-Z0-9-]+(([',. ][a-zA-Z ])?[a-zA-Z]*)*$"
                    ControlToValidate="TourTitle" Display="Dynamic"></asp:RegularExpressionValidator>
                <asp:RequiredFieldValidator ID="tourTitleValidator1"
                    runat="server" 
                    ErrorMessage="Tour name can't be blank"
                    ControlToValidate="TourTitle" 
                    Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            </p>

            <p class="text">Departure Date*
                <asp:TextBox ID="DateFromBox" runat="server" placeholder ="DD-MM-YYYY" style="margin-left: 44px" Height="30px" Width="400px" Font-Size="13pt" AutoCompleteType="Disabled"></asp:TextBox>
                <asp:CompareValidator ID="FromDateValidator" 
                        runat="server"
                        ControlToValidate="DateFromBox" ErrorMessage="Invalid Date Format"
                        Operator="DataTypeCheck"  Type="Date" ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                <asp:RequiredFieldValidator ID="FromDateValidator1"
                    runat="server" 
                    ErrorMessage="Date can't be blank"
                    ControlToValidate="DateFromBox" 
                    Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            </p>

            <p class="text">
                Return Date*
                <asp:TextBox ID="DateToBox" runat="server" style="margin-left: 70px" placeholder ="DD-MM-YYYY" Height="30px" Width="400px" Font-Size="13pt" AutoCompleteType="Disabled"></asp:TextBox>
                <asp:CompareValidator ID="ToDateValidator" 
                        runat="server"
                        ControlToValidate="DateToBox" ErrorMessage="Invalid Date Format"
                        Operator="DataTypeCheck" Type="Date" ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                <asp:RequiredFieldValidator ID="ToDateValidator1"
                    runat="server" 
                    ErrorMessage="Date can't be blank"
                    ControlToValidate="DateToBox" 
                    Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
            </p>

            <p class="text">Plan*
                <asp:TextBox ID="PlanBox" runat="server" style="margin-left: 131px" TextMode="MultiLine" placeholder ="Enter your plan details here!" Height="190px" Width="400px" Font-Size="13pt" AutoCompleteType="Disabled"></asp:TextBox>
                <asp:RequiredFieldValidator ID="PlanBoxValidator"
                    runat="server" 
                    ControlToValidate="PlanBox" 
                    Display="Dynamic" 
                    ErrorMessage="Plan cannot be blank" ForeColor="Red"></asp:RequiredFieldValidator>
            </p>

            <p class="text">No of Seats*
                <asp:TextBox ID="SeatCountBox" runat="server" style="margin-left: 73px" placeholder ="Enter total seat count." Height="30px" Width="400px" Font-Size="13pt" AutoCompleteType="Disabled"></asp:TextBox>
                <asp:RangeValidator ID="seatCountValidator" 
                    runat="server" 
                    ErrorMessage="Invalid Number" 
                    SetFocusOnError="true"
                    ControlToValidate="SeatCountBox" Display="Dynamic" ForeColor="red" Type="Integer"
                    MinimumValue="1" MaximumValue="100000"/>
                <asp:RequiredFieldValidator ID="seatCountValidator1"
                    runat="server" 
                    ControlToValidate="SeatCountBox" ErrorMessage="Seat count cant be blank" ForeColor="Red"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </p>

            <p class="text">Cost Per Head (Rs)*
                <asp:TextBox ID="CostBox" runat="server" style="margin-left: 12px" Height="30px" Width="400px" Font-Size="13pt" placeholder ="Enter cost per head" AutoCompleteType="Disabled"></asp:TextBox>
                <asp:RangeValidator ID="costValidator" 
                    runat="server" 
                    ErrorMessage="Invalid Number" 
                    SetFocusOnError="true"
                    ControlToValidate="CostBox" Display="Dynamic" ForeColor="red" Type="Integer"
                    MinimumValue="1" MaximumValue="100000"/>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                    runat="server" 
                    ControlToValidate="CostBox" ErrorMessage="Cost/Head cant be blank" ForeColor="Red"
                    Display="Dynamic">
                </asp:RequiredFieldValidator>
            </p>

            <p class="saveButton"><asp:Button ID="TourSaveButton" runat="server" Text="Save" Width= "576px" Height="40px" OnClick="TourSaveButton_Click" /></p>
            <p class="saveButton">
                <asp:Label ID="TourMessage" runat="server" ForeColor="Red"></asp:Label>
            </p>
        </div>

        <p class="returnButton">
            <asp:Button ID="ReturnButton" runat="server" CausesValidation="False" OnClick="ReturnButton_Click" Text="Return to Admin Portal" Height="25px" Width="170px" />
        </p>

    </form>
</body>
</html>
