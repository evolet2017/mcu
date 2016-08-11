using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class bankaccounts : Page
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


}