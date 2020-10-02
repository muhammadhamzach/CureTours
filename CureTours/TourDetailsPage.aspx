<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TourDetailsPage.aspx.cs" Inherits="CureTours.TourDetailsPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Admin Portal</h1>
        <h3>Tour Details</h3>
        <p>Tour Title:
            <asp:Label ID="TourTitleTag" runat="server" Text=""></asp:Label>
        </p>
        <p>
            <asp:Button ID="FinalListViewer" runat="server" OnClick="FinalListViewer_Click" Text="Show Accepted Users" Width="184px" />
        </p>
        <p>
            <asp:GridView ID="FinalizedUserViewer" runat="server" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="White" />
                <FooterStyle BackColor="#CCCC99" />
                <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                <RowStyle BackColor="#F7F7DE" />
                <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FBFBF2" />
                <SortedAscendingHeaderStyle BackColor="#848384" />
                <SortedDescendingCellStyle BackColor="#EAEAD3" />
                <SortedDescendingHeaderStyle BackColor="#575357" />
            </asp:GridView>
        </p>

        <h3>
            Pending for Approval</h3>
        <p>
            <asp:Label ID="DetailsMessageLabel" runat="server" ForeColor="Red"></asp:Label>
        </p>
      
        <asp:GridView ID="TourInterestedDetailsGrid" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" Width="70%" ShowHeaderWhenEmpty="True">
            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />

            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="AcceptButton" Text="Accept" Width="100px" runat="server" OnClick="AcceptButton_Click" />
                        <br />
                        <asp:Button ID="RejectButton" Text="Reject" Width="100px" runat="server" OnClick="RejectButton_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
      
        <br />
        <asp:Button ID="ReturnButton" runat="server" OnClick="ReturnButton_Click" Text="Return to Portal" Width="136px" />
      
    </form>
</body>
</html>
