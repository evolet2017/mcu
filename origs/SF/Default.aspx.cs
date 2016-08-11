using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        var chararray = System.IO.Path.GetInvalidPathChars();
        Response.Cookies[Session.SessionID].Value = "True";
        Response.Cookies[Session.SessionID].Expires = DateTime.Now.AddHours(3);
    }
}