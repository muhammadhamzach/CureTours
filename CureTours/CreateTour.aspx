<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateTour.aspx.cs" Inherits="CureTours.CreateTour" Culture = "en-GB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Tour Details</h1>
        </div>
        <p>Title
            <asp:TextBox ID="TourTitle" runat="server" style="margin-left: 22px" placeholder="Tour Name"></asp:TextBox>
            <asp:RegularExpressionValidator ID="tourTitleValidator" 
                runat="server"  ForeColor="Red" 
                ErrorMessage="Invalid Tour Name"
                ValidationExpression="^[a-zA-Z0-9-]+(([',. ][a-zA-Z ])?[a-zA-Z]*)*$"
                ControlToValidate="TourTitle"> </asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="tourTitleValidator1"
                runat="server" 
                ControlToValidate="TourTitle" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </p>
        <p>
            Departure Date<asp:TextBox ID="DateToBox" runat="server" placeholder ="DD-MM-YYYY" style="margin-left: 43px"></asp:TextBox>
            <asp:CompareValidator ID="FromDateValidator" 
                    runat="server"
                    ControlToValidate="DateFromBox" ErrorMessage="Invalid Date Format"
                    Operator="DataTypeCheck"  Type="Date" ForeColor="Red"></asp:CompareValidator>
        </p>
        <p>
            Return Date<asp:TextBox ID="DateFromBox" runat="server" style="margin-left: 68px" placeholder ="DD-MM-YYYY"></asp:TextBox>
            <asp:CompareValidator ID="ToDateValidator" 
                    runat="server"
                    ControlToValidate="DateToBox" ErrorMessage="Invalid Date Format"
                    Operator="DataTypeCheck" Type="Date" ForeColor="Red"></asp:CompareValidator>
        </p>

        <p> Plan
            <asp:TextBox ID="PlanBox" runat="server" Height="164px" style="margin-left: 21px" Width="322px" TextMode="MultiLine"></asp:TextBox>
            <asp:RequiredFieldValidator ID="PlanBoxValidator"
                runat="server" 
                ControlToValidate="PlanBox" 
                Display="Dynamic" 
                ErrorMessage="Plan cannot be Blank" ForeColor="Red">
            </asp:RequiredFieldValidator>
        </p>

        <p>No of Seats<asp:TextBox ID="SeatCountBox" runat="server" style="margin-left: 43px" Height="18px" Width="167px"></asp:TextBox>
            <asp:RangeValidator ID="seatCountValidator" 
                runat="server" 
                ErrorMessage="Invalid Number" 
                SetFocusOnError="true"
                ControlToValidate="SeatCountBox" Display="Dynamic" ForeColor="red" Type="Integer"
                MinimumValue="1" MaximumValue="1000"/>
            <asp:RequiredFieldValidator ID="seatCountValidator1"
                runat="server" 
                ControlToValidate="SeatCountBox" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </p>
        <p>Cost Per Head (Rs)<asp:TextBox ID="CostBox" runat="server" style="margin-left: 28px" Width="171px"></asp:TextBox>
            <asp:RangeValidator ID="costValidator" 
                runat="server" 
                ErrorMessage="Invalid Number" 
                SetFocusOnError="true"
                ControlToValidate="CostBox" Display="Dynamic" ForeColor="red" Type="Integer"
                MinimumValue="1" MaximumValue="100000"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                runat="server" 
                ControlToValidate="CostBox" 
                Display="Dynamic">
            </asp:RequiredFieldValidator>
        </p>

        <asp:Button ID="TourSaveButton" runat="server" Text="Save" Width="384px" OnClick="TourSaveButton_Click" />
        <br />
        <br />
        <asp:Button ID="ReturnButton" runat="server" CausesValidation="False" OnClick="ReturnButton_Click" Text="Return To Portal" />
    </form>
</body>
</html>
