<%@ Page Language="C#" AutoEventWireup="true"  Debug="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register TagPrefix="CR" Namespace="CrystalDecisions.Web" Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Report Viewer</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Button" 
            Visible="False" />
        <asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="Button" 
            Visible="False" />
        <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
    <br />
    <br />
    </div>
    <div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="True"
            Height="1202px" ReportSourceID="CrystalReportSource1" Width="903px" 
            BestFitPage="False" HasCrystalLogo="False" ToolPanelView="None" EnableDatabaseLogonPrompt="False" PrintMode="ActiveX" />

        <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
            <Report FileName="CrystalReport1.rpt">
            </Report>
        </CR:CrystalReportSource>
    
    </div>
    </form>
</body>
</html>
