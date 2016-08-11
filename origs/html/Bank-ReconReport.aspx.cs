using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Web;
using System.Xml;
using System.IO;


public partial class BankReconReport : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.Cookies["isactive"] != null)
        {
            if (Request.Cookies["isactive"].Value != "1")
            {
                Response.Redirect("/");
            }
        }
        else
        {
            Response.Redirect("/");
        }
                    

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       
    }
    protected void btn_print_Click(object sender, EventArgs e)
    {
       // CrystalReportSource1.FileName = "~\Reports\"+rpt_file.Text;

    }
}
