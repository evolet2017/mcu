<%@ Page Language="C#" Debug="true" CodeFile="mcuservjs.aspx.cs" Inherits="MBv8Web.html.pages.mcuservjs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

    

   

    

    <div>
        Nothing really in here..<br />
        <br />
        <a href="http://mbphil.com/index.html">http://mbphil.com/index.html</a><br />
        <br />
        <br />
       
    </div>
    <input type="button" value="click" onclick="yo2()" /><p>
        &nbsp;</p>
    <p>
        &nbsp;</p>

    
 <form id="form1" runat="server">
        <asp:Label ID="lbl2" runat="server" Text="Label1111"></asp:Label>
&nbsp;<div id="tm">
        </div>

    
        <p>
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </p>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        </p>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label></p>
        <p>
            &nbsp;</p>
    </form>

    <script src="/html/js/jquery.js"></script>
    <script src="/html/js/mbphillib.js"></script>
  
    <script>
        function yo2() {
            alert(MB.URLPoster());           
        }
        var d = new Date();
            
        $('#Label2').text(Date.parse(d.toDateString()));
        $('#Label3').text(d.toDateString());
        
    </script>
</body>
</html>
