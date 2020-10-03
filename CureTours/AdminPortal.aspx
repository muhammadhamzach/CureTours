﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPortal.aspx.cs" Inherits="CureTours.AdminPortal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="style/AdminPortalStyle.css" rel="stylesheet" />
    <title>Cure Tours (admin)</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1 class="Title"> Admin Portal</h1>

            <div class="userRoleTag">
                <p> 
                    <asp:Label ID="AdminPortalNameTag" runat="server" Text="Name: "></asp:Label>
                    <asp:Label ID="AdminName" runat="server" Text="Admin" Font-Bold="False"></asp:Label>
                </p>
                <p class="roleTag1"> 
                    <asp:Label ID="AdminRoleLabelTag" runat="server" Text="Role: "></asp:Label>
                    <asp:Label ID="AdminRoleLabel" runat="server" Text="admin" Font-Bold="False"></asp:Label>
                </p>
            </div>
        </div>
       
        <div class="details">
            <h3 class="detailsTitle"> Tours</h3>

            <p class ="newTour"><asp:Button ID="NewTourCreationButton" runat="server" OnClick="NewTourCreationButton_Click" Text="Create New Tour" Height="25px" Width="170px" /></p>
            
            <div class="infoGrid">
                <asp:GridView ID="TourGrid" runat="server" BackColor="White" BorderColor="#CCCCCC" 
                    BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" Width="90%" ShowHeaderWhenEmpty="True" OnRowDataBound="TourGrid_RowDataBound">
                    <EditRowStyle HorizontalAlign="Center" />
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
                            <p class="detailsButton"><asp:Button ID="InterestedButton" Text="Details" runat="server" OnClick="DetailsButton_Click" Height="20px" Width="120px" /> </p>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
         </div>

            <p class="logOut"> <asp:Button ID="LogOutButton" runat="server" OnClick="LogOutButton_Click" Text="Log Out" Height="25px" Width="170px" /> </p>
            </div>
        

    </form>
</body>
</html>
