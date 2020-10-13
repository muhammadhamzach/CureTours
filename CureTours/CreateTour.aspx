<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateTour.aspx.cs" Inherits="CureTours.CreateTour" Culture = "en-GB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta http-equiv="Expires" content="0"/>
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta http-equiv="Pragma" content="no-cache"/>
    <link href="Pikaday/css/pikaday.css" rel="stylesheet" />
    <link href="Pikaday/css/theme.css" rel="stylesheet" />
    <link href="Pikaday/css/triangle.css" rel="stylesheet" />
    <link href="style/CreateTourStyle.css" rel="stylesheet" />
    <script src="Pikaday/pikaday.js"></script>
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
                <asp:TextBox ID="DateFromBox" runat="server" placeholder ="DD-MM-YYYY" style="margin-left: 44px" Height="30px" Width="400px" Font-Size="13pt" AutoCompleteType="Disabled"></asp:TextBox>
                <asp:Label ID="DateFromError" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="DateFromLabel" runat="server" ForeColor="Red"></asp:Label>
                <script type="text/javascript">
                    var picker = new Pikaday({
                        field: document.getElementById('DateFromBox'),
                        format: 'D/M/YYYY',
                        minDate: new Date(),
                        maxDate: new Date('2030-12-31'),
                        yearRange: [2000, 2030],
                        theme: 'dark-theme',
                        toString(date, format) {
                            const day = date.getDate();
                            const month = date.getMonth() + 1;
                            const year = date.getFullYear();
                            return `${day}-${month}-${year}`;
                        },
                        parse(dateString, format) {
                            const parts = dateString.split('-');
                            const day = parseInt(parts[0], 10);
                            const month = parseInt(parts[1], 10) - 1;
                            const year = parseInt(parts[2], 10);
                            return new Date(day, month, year);
                        }
                    });
                </script>
            </div>

            <div class="text">
                Return Date*
                <asp:TextBox ID="DateToBox" runat="server" style="margin-left: 70px" placeholder ="DD-MM-YYYY" Height="30px" Width="400px" Font-Size="13pt" AutoCompleteType="Disabled"></asp:TextBox>
                <asp:Label ID="DateToLabel" runat="server" ForeColor="Red"></asp:Label>
                <asp:Label ID="DateToError" runat="server" ForeColor="Red"></asp:Label>
                <script type="text/javascript">
                    var picker = new Pikaday({
                        field: document.getElementById('DateToBox'),
                        format: 'D/M/YYYY',
                        minDate: new Date(),
                        maxDate: new Date('2030-12-31'),
                        yearRange: [2000, 2030],
                        theme: 'dark-theme',
                        toString(date, format) {
                            const day = date.getDate();
                            const month = date.getMonth() + 1;
                            const year = date.getFullYear();
                            return `${day}-${month}-${year}`;
                        },
                        parse(dateString, format) {
                            const parts = dateString.split('-');
                            const day = parseInt(parts[0], 10);
                            const month = parseInt(parts[1], 10) - 1;
                            const year = parseInt(parts[2], 10);
                            return new Date(day, month, year);
                        }
                    });
                </script>
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
