<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateTour.aspx.cs" Inherits="CureTours.CreateTour" Culture = "en-GB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link href="style/CreateTourStyle.css" rel="stylesheet" />
    <script src="script/CreateTourScript.js" type="text/javascript"></script>
    <title>Create Tour (admin)</title>
</head>

<body>
    <form id="form1" runat="server">
        <div class="pageTitle">
            <h1>Create Tour</h1>
        </div>
        <div class="tourForm">
            <p class="text">Title*
                <asp:TextBox ID="TourTitle" runat="server" style="margin-left: 130px" placeholder="Tour Name" Height="30px" Width="400px" Font-Size="13pt" AutoCompleteType="Disabled" MaxLength="30" OnKeyUp ="javascript:nameValid()"></asp:TextBox>
                <asp:Label ID="TourLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>

            <div class="text">Departure Date*
                <asp:TextBox ID="DateFromBox" runat="server" style="margin-left: 44px" Height="30px" Width="400px" Font-Size="13pt" AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                <asp:Label ID="DateFromError" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="DateFromLabel" runat="server" ForeColor="Red"></asp:Label>
            </div>

            <div class="text"> Return Date*
                <asp:TextBox ID="DateToBox" runat="server" style="margin-left: 70px"  Height="30px" Width="400px" Font-Size="13pt" AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                <asp:Label ID="DateToLabel" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="DateToError" runat="server" ForeColor="Red"></asp:Label>
            </div>

            <p class="text">Plan*
                <asp:TextBox ID="PlanBox" runat="server" style="margin-left: 131px" TextMode="MultiLine" placeholder ="Enter your plan details here!" Height="190px" Width="400px" Font-Size="13pt" AutoCompleteType="Disabled" MaxLength="300"></asp:TextBox>
                <asp:Label ID="PlanLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>

            <p class="text">No of Seats*
                <asp:TextBox ID="SeatCountBox" runat="server" style="margin-left: 73px" placeholder ="Enter total seat count." Height="30px" Width="400px" Font-Size="13pt" AutoCompleteType="Disabled" OnKeyUp ="javascript:seatValid()"></asp:TextBox>
                <asp:Label ID="SeatLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>

            <p class="text">Cost Per Head (Rs)*
                <asp:TextBox ID="CostBox" runat="server" style="margin-left: 12px" Height="30px" Width="400px" Font-Size="13pt" placeholder ="Enter cost per head" AutoCompleteType="Disabled" OnKeyUp ="javascript:costValid()"></asp:TextBox>
                <asp:Label ID="costLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>

            <p class="saveButton"><asp:Button ID="TourSaveButton" runat="server" Text="Save" Width= "576px" Height="40px" OnClick="TourSaveButton_Click" OnClientClick="return Validation()"/></p>
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
