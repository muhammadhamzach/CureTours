<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPortal.aspx.cs" Inherits="CureTours.AdminPortal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h1> Admin Portal</h1>
        <p> 
            <asp:Label ID="AdminPortalNameTag" runat="server" Text="Name: "></asp:Label>
            <asp:Label ID="AdminName" runat="server" Text="Admin"></asp:Label>
        </p>
        <p> 
            <asp:Label ID="AdminRoleLabelTag" runat="server" Text="Role: "></asp:Label>
            <asp:Label ID="AdminRoleLabel" runat="server" Text="admin"></asp:Label>
        </p>

        <h3> Tours</h3>

        <asp:Button ID="NewTourCreationButton" runat="server" OnClick="NewTourCreationButton_Click" Text="Create New Tour" />

        <br />

        <br />
        <br />
        <asp:GridView ID="TourGrid" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" Width="70%" ShowHeaderWhenEmpty="True" OnRowDataBound="TourGrid_RowDataBound">
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
                        <asp:Button ID="InterestedButton" Text="Details" Width="100px" runat="server" OnClick="DetailsButton_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <br />
        <br />
        <asp:Button ID="LogOutButton" runat="server" OnClick="LogOutButton_Click" Text="Log Out" />

    </form>
</body>
</html>
