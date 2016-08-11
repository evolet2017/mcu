<%@ Page Language="C#" AutoEventWireup="true"  Debug="true" CodeFile="recongen.aspx.cs" Inherits="_Default" %>
<%@ Register TagPrefix="CR" Namespace="CrystalDecisions.Web" Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Report Viewer</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Button" 
            Visible="true" />
        <asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="Button" 
            Visible="true" />
		<asp:Button ID="Button3" runat="server" onclick="Button3_Click" Text="recon" 
            Visible="true" />
        <asp:Label ID="Label1" runat="server" Text="1" Visible="true"></asp:Label>
		<asp:Label ID="Label2" runat="server" Text="101011101" Visible="true"></asp:Label>
		<asp:Label ID="Label3" runat="server" Text="01/01/2014" Visible="true"></asp:Label>
		<asp:Label ID="Label4" runat="server" Text="01/31/2014" Visible="true"></asp:Label>
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
