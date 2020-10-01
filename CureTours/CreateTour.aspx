<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateTour.aspx.cs" Inherits="CureTours.CreateTour" %>

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
            <asp:TextBox ID="TourTitle" runat="server" style="margin-left: 22px"></asp:TextBox>
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
            Date<asp:TextBox ID="DateFromBox" runat="server" style="margin-left: 24px">DD-MM-YYYY</asp:TextBox>
            <asp:CompareValidator ID="FromDateValidator" 
                    runat="server"
                    ControlToValidate="DateFromBox" ErrorMessage="Invalid Date Format"
                    Operator="DataTypeCheck" Type="Date" ForeColor="Red"></asp:CompareValidator>
            &nbsp;To
            <asp:TextBox ID="DateToBox" runat="server">DD-MM-YYYY</asp:TextBox>
            <asp:CompareValidator ID="ToDateValidator" 
                    runat="server"
                    ControlToValidate="DateToBox" ErrorMessage="Invalid Date Format"
                    Operator="DataTypeCheck" Type="Date" ForeColor="Red"></asp:CompareValidator>
        </p>

        <p> Plan
            <asp:TextBox ID="PlanBox" runat="server" Height="164px" style="margin-left: 21px" Width="322px"></asp:TextBox>
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

        <asp:Button ID="TourSaveButton" runat="server" Text="Save" Width="384px" OnClick="TourSaveButton_Click" />
    </form>
</body>
</html>
