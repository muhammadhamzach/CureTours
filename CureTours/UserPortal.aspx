<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserPortal.aspx.cs" Inherits="CureTours.UserPortal" Culture = "en-GB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="style/AdminPortalStyle.css" rel="stylesheet" />
    <link href="style/UserPortalStyle.css" rel="stylesheet" />
    <title>User Portal</title>
</head>
<body>
    <form id="form1" class="forms" runat="server">
        <div>
            <h1 class="Title">User Tour Portal</h1>
            <div class="userRoleTag">
                <p>
                    <asp:Label ID="NameLabelTag" runat="server" Text="Name:"></asp:Label>
                    <asp:Label ID="NameLabel" runat="server" Font-Bold="False"></asp:Label>
                </p>
                <p class="roleTag1">
                    <asp:Label ID="RoleLabelTag" runat="server" Text="Role:"></asp:Label>
                    <asp:Label ID="UserRoleLabel" runat="server" Font-Bold="False"></asp:Label>
            </p>
            </div>
        </div>
        
        <div class="details">
            <h3 class="detailsTitle">Tours</h3>
            <p class="message">
                <asp:Label ID="TourInterestLabel" runat="server" ForeColor="Red"></asp:Label>
            </p>

            <div class="infoGrid">
                <asp:GridView ID="TourGrid" runat="server"  BorderColor="#CCCCCC"  BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" Width="90%" ShowHeaderWhenEmpty="True" OnRowDataBound="TourGrid_RowDataBound">
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
                            <asp:Button ID="InterestedButton" Text="Interested" Width="100px" runat="server" OnClick="InterestedButton_Click" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            </div>
            
        </div>
        <p class="logOut">
            
        <asp:Button ID="LogOutButton" runat="server" OnClick="LogOutButton_Click" Text="Log Out" Height="25px" Width="170px" />
        </p>
    </form>
</body>
</html>
