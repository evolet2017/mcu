using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.IO;
using System.Data;


namespace MBv8Web
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
         
            if (Request.Browser.Cookies)
            {                          
                Response.Redirect("/Main");
            }
            else
            {
                
                Label1.Text = "Please Enable Cookie.. THE BROWSER COOKIE OKAY???";
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
           

        }
        protected void Button2_Click(object sender, EventArgs e)
        {
           

        }
}
}