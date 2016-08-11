<%@ Page Language="C#" AutoEventWireup="true" Debug="true" CodeFile="Default.aspx.cs" Inherits="MBv8Web.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            margin-top: 0px;
        }
    </style>
    <script src="html/js/mbphillib.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
   
        <br />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" CssClass="auto-style1" OnClick="Button1_Click" Text="set cookie" />
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="get cookie" />
        <br />
   
        <br />
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </div>

       

        

    </form>

     <script>
        // document.cookie = "serverip=" + Request.ServerVariables("REMOTE_ADDR");

     </script>

</body>
</html>
