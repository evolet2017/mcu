using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.IO;





public partial class index : Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string path = System.AppDomain.CurrentDomain.BaseDirectory;
        path = path + "appconfig.xml";

        if (!File.Exists(path))
        {
            XmlDocument _xmlDoc = new XmlDocument();
            XmlNode _xmlNode = _xmlDoc.CreateXmlDeclaration("1.0", "utf-8", "yes");
            XmlNode _rootNode = _xmlDoc.CreateElement("MCUweb-Accounting");
            XmlNode _DBNode = _xmlDoc.CreateElement("mcu");

            XmlAttribute _NameAt = _xmlDoc.CreateAttribute("dbserver");
            _NameAt.InnerText = System.Net.Dns.GetHostName();
            _DBNode.Attributes.Append(_NameAt);

            XmlAttribute _portAt = _xmlDoc.CreateAttribute("port");
            _portAt.InnerText = "8080";
            _DBNode.Attributes.Append(_portAt);

            XmlAttribute _timeout = _xmlDoc.CreateAttribute("timeout");
            _timeout.InnerText = "10";
            _DBNode.Attributes.Append(_timeout);

            XmlAttribute _ConstrAt = _xmlDoc.CreateAttribute("connectionstring");
            _ConstrAt.InnerText = "Server=CRD-003\\MSSQL2012;Database=MBv8Ledger;User Id=sa;Password=1;";
            _DBNode.Attributes.Append(_ConstrAt);

            _rootNode.AppendChild(_DBNode);
            _xmlDoc.AppendChild(_xmlNode);
            _xmlDoc.AppendChild(_rootNode);

            _xmlDoc.Save(path);

            Response.Cookies["dbserver"].Value = System.Net.Dns.GetHostName();
            Response.Cookies["dbport"].Value = "8080";
            Response.Cookies["timeout"].Value = "10";

            Response.Redirect("/appconfig");

        }
        else
        {
            if (File.Exists(path))
            {
                XmlTextReader reader = new XmlTextReader(path);
                reader.MoveToContent();
                reader.ReadToDescendant("mcu");
                Response.Cookies["dbserver"].Value = reader.GetAttribute("dbserver");
                Response.Cookies["dbport"].Value = reader.GetAttribute("port");
                Response.Cookies["timeout"].Value = reader.GetAttribute("timeout");

            }

            //Response.Cookies["serveraddress"].Value = System.Net.Dns.GetHostName();
            if (Request.Cookies["isactive"] != null)
            {
                if (Request.Cookies["isactive"].Value != "1") { Response.Redirect("/Login"); }
            }   else { Response.Redirect("/Login"); }


        }

        
    }
}