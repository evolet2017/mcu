using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class apaddvendor : Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["isactive"] != null)
        {
            if (Request.Cookies["isactive"].Value != "1")
            {
                Response.Redirect("/Login");
            }
        }
        else
        {
            Response.Redirect("/Login");
        }
    }


    protected void signout(object sender, System.EventArgs e)
    {
        Response.Cookies["isactive"].Value = "0";
        Response.Cookies["activeuser"].Value = "";
        Response.Redirect("/Main");
    }
}