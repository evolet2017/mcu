using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Web;
using MBv8Web;
using System.IO;

public partial class _Default : System.Web.UI.Page 
{
    ReportDocument crypt1= new ReportDocument();
    ConnectionInfo crConnectionInfo = new ConnectionInfo();
    TableLogOnInfos crtableLogoninfos = new TableLogOnInfos();
    TableLogOnInfo crtableLogoninfo = new TableLogOnInfo();
    Tables CrTables;

    private void LogInfo()
    {
       // Response.Write("<Script> alert('Pumasok2')  </Script>");
        string x;
        x = GenericDB.GetXML("mcu", "connectionstring");

        SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(x);

        var p = this.crConnectionInfo;
       
            p.ServerName = builder.DataSource;
            p.DatabaseName = builder.InitialCatalog;
            p.UserID = builder.UserID;
            p.Password = builder.Password;
    }

    private void LogReport()
    {
       // Response.Write("<Script> alert('Pumasok1')  </Script>");
        //CrystalDecisions.CrystalReports.Engine.Table CrTable;

        CrTables = crypt1.Database.Tables;

        foreach(CrystalDecisions.CrystalReports.Engine.Table CrTable in CrTables)
        {
           // Response.Write("<Script> alert('" + CrTable.LogOnInfo + "')  </Script>");
            crtableLogoninfo = CrTable.LogOnInfo;
            crtableLogoninfo.ConnectionInfo = crConnectionInfo;
            CrTable.ApplyLogOnInfo(crtableLogoninfo);
        }

       //Dim CrTable As Table
       // CrTables = vReport.Database.Tables

       // For Each CrTable In CrTables
       //     crtableLogoninfo = CrTable.LogOnInfo
       //     crtableLogoninfo.ConnectionInfo = crConnectionInfo
       //     CrTable.ApplyLogOnInfo(crtableLogoninfo)
       // Next

    }


    // Dim crConnectionInfo As New ConnectionInfo()
    //Dim crtableLogoninfos As New TableLogOnInfos()
    //Dim crtableLogoninfo As New TableLogOnInfo()
     //Dim CrTables As Tables
   // [EnableCors("*", "*", "*")]
    //protected void Page_Load(object sender, EventArgs e)
    //{
    //    if (Request["rpt"] != null)
    //    {
    //        crypt1 = new ReportDocument();
    //        Label1.Text = Request["rpt"];
    //        if ((Label1.Text) == "1")
    //        {
    //            crypt1.Load(Server.MapPath("") + "\\crystalreport1.rpt");
    //        }
    //        if ((Label1.Text) == "2")
    //        {
    //            crypt1.Load(Server.MapPath("") + "\\crystalreport2.rpt");
    //        }
    //        CrystalReportViewer1.ReportSource = crypt1;
    //        CrystalReportViewer1.RefreshReport();           
    //        Response.Clear();
    //        Response.Buffer = true;
    //        Response.ContentType = ("Access-Control-Allow-Origin");
    //        Response.ContentType = ("Access-Control-Allow-Method");
    //        Response.ContentType = ("Access-Control-Allow-Headers");
    //        Response.ContentType = "application/pdf";
    //        crypt1.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "report" + Label1.Text);
    //    }
    //    if (Request["view"] != null)
    //    {
            
    //        Label1.Text = Request["view"];
    //        if ((Label1.Text) == "1")
    //        {
    //            string path = Server.MapPath("") + "\\" + Request["report"];
    //            if (File.Exists(path))
    //            {
    //                crypt1 = new ReportDocument();
    //                string x ;
    //                x = GenericDB.GetXML("mcu","connectionstring");

    //                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(x);

    //                crypt1.Load(path);
                    
    //                CrystalReportViewer1.ReportSource = crypt1;
    //                CrystalReportViewer1.RefreshReport();
    //                crypt1.SetDatabaseLogon(builder.UserID, builder.Password, builder.DataSource, builder.InitialCatalog,false);
 
    //            }
    //            else {
    //                Response.Redirect("~/404/F404.html");
    //            }
    //        }
    //        else { 
    //            //view not found / report not found 
    //            Response.Redirect("~/404/F404.html");        
    //        }
    //    }
    //}

    protected void Page_init(object sender, EventArgs e)
    {
        if (Request["rpt"] != null)
        {
            crypt1 = new ReportDocument();
            Label1.Text = Request["rpt"];
            if ((Label1.Text) == "1")
            {
                crypt1.Load(Server.MapPath("") + "\\crystalreport1.rpt");
            }
            if ((Label1.Text) == "2")
            {
                crypt1.Load(Server.MapPath("") + "\\crystalreport2.rpt");
            }
            CrystalReportViewer1.ReportSource = crypt1;
            CrystalReportViewer1.RefreshReport();
            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = ("Access-Control-Allow-Origin");
            Response.ContentType = ("Access-Control-Allow-Method");
            Response.ContentType = ("Access-Control-Allow-Headers");
            Response.ContentType = "application/pdf";
            crypt1.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "report" + Label1.Text);
        }
        if (Request["view"] != null)
        {

            Label1.Text = Request["view"];
            if ((Label1.Text) == "1")
            {
                string path = Server.MapPath("") + "\\" + Request["report"];
                if (File.Exists(path))
                {
                    LogInfo();
                    crypt1 = new ReportDocument();
                    //string x;
                    //x = GenericDB.GetXML("mcu", "connectionstring");

                    //SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(x);

                                        
                    crypt1.Load(path);
                    LogReport();
                    crypt1.VerifyDatabase();
                    
                    CrystalReportViewer1.ReportSource = crypt1;
                    
                    //crypt1.SetDatabaseLogon(builder.UserID, builder.Password, builder.DataSource, builder.InitialCatalog, true);
                  //  crypt1.VerifyDatabase();
                   
                    CrystalReportViewer1.RefreshReport();
                    //Response.Write(builder.UserID + builder.Password + builder.DataSource + builder.InitialCatalog);
                    

                }
                else
                {
                    Response.Redirect("~/404/F404.html");
                }
            }
            else
            {
                //view not found / report not found 
                Response.Redirect("~/404/F404.html");
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        crypt1 = new ReportDocument();
        crypt1.Load(Server.MapPath("")+"\\crystalreport1.rpt");
        CrystalReportViewer1.ReportSource = crypt1;
        CrystalReportViewer1.RefreshReport();

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        crypt1 = new ReportDocument();
        crypt1.Load(Server.MapPath("") + "\\crystalreport2.rpt");
     
        CrystalReportViewer1.ReportSource = crypt1;
        CrystalReportViewer1.RefreshReport();
        
    }
}