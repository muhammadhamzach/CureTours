<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TourDetailsPage.aspx.cs" Inherits="CureTours.TourDetailsPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="style/TourDetailsPageStyle.css" rel="stylesheet" />
    <title>Tour Details (admin)</title>
</head>
<body>
    <form id="form1"  class="forms" runat="server">
        <h1 class ="title">Admin Portal</h1>

        <div class="info">
            <h3 class="infoHeading">Tour Details</h3>
            <p class="tourtitle">Tour Title:
                <asp:Label ID="TourTitleTag" runat="server" Text="" Font-Size="20pt"></asp:Label>
            </p>
        </div>
        

        <div class="approved">
            <p class="approvedListButton">
                <asp:Button ID="FinalListViewer" runat="server" OnClick="FinalListViewer_Click" Text="Show Accepted Users" Height="25px" Width="170px" />
            </p>
            <p class="approvedList">
                <asp:GridView ID="FinalizedUserViewer" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
            </p>
        </div>
        
        <div class="pending">
            <h3 class="pendingTitle">Pending for Approval</h3>
            <p class="pendingError">
                <asp:Label ID="DetailsMessageLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>
            <div class="pendingGrid">
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
            </div>
            
        </div>

        <p class="returnButton">
            <asp:Button ID="ReturnButton" runat="server" OnClick="ReturnButton_Click" Text="Return to Portal"  Height="25px" Width="170px" />
        </p>
        
    </form>
</body>
</html>
