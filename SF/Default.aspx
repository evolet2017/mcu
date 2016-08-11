<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<iframe frameborder="0" 
        src="FileManager/Default.aspx?sessionid=<%= Session.SessionID %>" 
        style="height: 650px; width: 950px">


</iframe>
</asp:Content>

