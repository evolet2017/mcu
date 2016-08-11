using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MBv8Web;

public partial class appsettings : Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        constr.Text = GenericDB.GetXML("mcu", "connectionstring");
        timeout.Text = GenericDB.GetXML("mcu", "timeout");
                
    }
    
    protected void signout(object sender, System.EventArgs e)
    {

    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        GenericDB.WriteXML(2, @constr.Text);
    }

    void set_value()
    {
        //javaExec.Text = "HHHH";
    }
}