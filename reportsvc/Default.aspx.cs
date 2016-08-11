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


        CrTables = crypt1.Database.Tables;

        foreach(CrystalDecisions.CrystalReports.Engine.Table CrTable in CrTables)
        {

            crtableLogoninfo = CrTable.LogOnInfo;
            crtableLogoninfo.ConnectionInfo = crConnectionInfo;
            CrTable.ApplyLogOnInfo(crtableLogoninfo);
        }

   

    }



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
				string param1 = Request["param1"];
				string param2 = Request["param2"];
                if (File.Exists(path))
                {
				
                    LogInfo();
                    crypt1 = new ReportDocument();                   
                    crypt1.Load(path);				
                    LogReport();
					if(param1 != null) {
						crypt1.SetParameterValue("tbal",param1);
					}
					if(param2 != null) {
						crypt1.SetParameterValue("tbal2",param2);
					}
                    CrystalReportViewer1.ReportSource = crypt1;
                    CrystalReportViewer1.RefreshReport();
					
					//MemoryStream mem = (MemoryStream)crypt1.ExportToStream(ExportFormatType.PortableDocFormat);
					System.IO.Stream oStream = null;
                    byte[] byteArray = null;
                    oStream = crypt1.ExportToStream(ExportFormatType.PortableDocFormat);
                    byteArray = new byte[oStream.Length]; 
                    oStream.Read(byteArray, 0, Convert.ToInt32(oStream.Length - 1));

					Response.Clear();
					Response.Buffer = true;
					Response.ContentType = "application/pdf";
					//Response.BinaryWrite(mem.ToArray());
                    Response.BinaryWrite(byteArray);
                    Response.Flush();
                    Response.Close();
					Response.End();
   

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
		
		//
		if (Request["export"] != null)
		{
			Label1.Text = Request["export"];
			string path = Server.MapPath("") + "\\" + Request["report"];
			string param1 = Request["param1"];
			string param2 = Request["param2"];
			if (File.Exists(path))
			{
			
				LogInfo();
				crypt1 = new ReportDocument();                   
				crypt1.Load(path);				
				LogReport();
				
				if(param1 != null) {
					crypt1.SetParameterValue("tbal",param1);
				}
				if(param2 != null) {
					crypt1.SetParameterValue("tbal2",param2);
				}
				if (Label1.Text == "excel") {
					crypt1.ExportToHttpResponse(ExportFormatType.ExcelRecord, Response, true, Path.GetFileNameWithoutExtension(path)+"-"+DateTime.Now.ToString("MMddyyyy"));
				}
				if (Label1.Text == "pdf") {
					crypt1.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, Path.GetFileNameWithoutExtension(path)+"-"+DateTime.Now.ToString("MMddyyyy"));
				}
				if (Label1.Text == "doc") {
					crypt1.ExportToHttpResponse(ExportFormatType.WordForWindows, Response, true, Path.GetFileNameWithoutExtension(path)+"-"+DateTime.Now.ToString("MMddyyyy"));
				}
				
			}
			else
			{
				Response.Redirect("~/404/F404.html");
			}
			
			
		}
		
		if (Request["recon"] != null)
        {

            Label1.Text = Request["recon"];
            if ((Label1.Text) == "1")
            {
                string path = Server.MapPath("") + "\\" + Request["report"];
				string param0 = Request["param0"];
				string param1 = Request["param1"];
				string param2 = Request["param2"];
                if (File.Exists(path))
                {
				
                    LogInfo();
                    crypt1 = new ReportDocument();                   
                    crypt1.Load(path);				
                    LogReport();
					if(param0 != null) {
						crypt1.SetParameterValue("@GLCODE",param0);
						crypt1.SetParameterValue("@arr1",param1);
						crypt1.SetParameterValue("@arr2",param2);
					}
                    //CrystalReportViewer1.ReportSource = crypt1;
                    //CrystalReportViewer1.RefreshReport();
					
					//MemoryStream mem = (MemoryStream)crypt1.ExportToStream(ExportFormatType.PortableDocFormat);
					System.IO.Stream oStream = null;
                    byte[] byteArray = null;
                    oStream = crypt1.ExportToStream(ExportFormatType.PortableDocFormat);
                    byteArray = new byte[oStream.Length]; 
                    oStream.Read(byteArray, 0, Convert.ToInt32(oStream.Length - 1));

					Response.Clear();
					Response.Buffer = true;
					Response.ContentType = "application/pdf";
					//Response.BinaryWrite(mem.ToArray());
                    Response.BinaryWrite(byteArray);
                    Response.Flush();
                    Response.Close();
					Response.End();
			
   

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
        
        if (Request["recon2"] != null)
        {

            Label1.Text = Request["recon2"];
            if ((Label1.Text) == "1")
            {
                string path = Server.MapPath("") + "\\" + Request["report"];
				string param0 = Request["param0"];
				string param1 = Request["param1"];
				string param2 = Request["param2"];
                if (File.Exists(path))
                {
				
                    LogInfo();
                    crypt1 = new ReportDocument();                   
                    crypt1.Load(path);				
                    LogReport();
					
						crypt1.SetParameterValue("@date1",param0);
						crypt1.SetParameterValue("@date2",param1);
						crypt1.SetParameterValue("@glacct",param2);
					
                    //CrystalReportViewer1.ReportSource = crypt1;
                    //CrystalReportViewer1.RefreshReport();
					
					//MemoryStream mem = (MemoryStream)crypt1.ExportToStream(ExportFormatType.PortableDocFormat);
					System.IO.Stream oStream = null;
                    byte[] byteArray = null;
                    oStream = crypt1.ExportToStream(ExportFormatType.PortableDocFormat);
                    byteArray = new byte[oStream.Length]; 
                    oStream.Read(byteArray, 0, Convert.ToInt32(oStream.Length - 1));

					Response.Clear();
					Response.Buffer = true;
					Response.ContentType = "application/pdf";
					//Response.BinaryWrite(mem.ToArray());
                    Response.BinaryWrite(byteArray);
                    Response.Flush();
                    Response.Close();
					Response.End();
			
   

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