<%@ WebService Language="C#"
Class="mbphilsvr.jsonservice" %>

using System.Web.Services;

using System.Data;
using System.Data.SqlClient;

using System.Runtime.Serialization;

using System.Web;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
//using System.Web.Script.Services.ScriptService;

using System.Collections.Generic;
using System.IO;

//[System.Web.Script.Services.ScriptService]

namespace mbphilsvr
{
  [WebService(Namespace = "http://mbphilsvr/")]
  public class jsonservice: WebService 
  {
  
    private string readserver()
	{
		string inputString;
		//resultLabel.Text = "";
		using (StreamReader streamReader = File.OpenText(@"C:\Users\IT Support\Desktop\www\sample\aspx\settings.txt"))
		{
			inputString = streamReader.ReadLine();
			while (inputString != null)
			{
				//resultLabel.Text += inputString + "<br />";
				inputString = streamReader.ReadLine();
			}
		}
		return inputString;
	}

    private string SQLCon
	{
		//string SSS = 
		get {
			//return @"Server=CRT-002\MCUDB;Database=MBv8Ledger;User Id=sa;Password=microbanker;";
			return @"Server=MBTESTSERVER\MCUDB;Database=MBv8Ledger;User Id=sa;Password=microbanker;";
			//return @"Server=QASERVER\MCUDB;Database=MBv8Ledger;User Id=sa;Password=microbanker;";
			//return @readserver();
		}
	}
	
	private void EnableCrossDomainAjaxCall()
	{
	  HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", "*");

	  if (HttpContext.Current.Request.HttpMethod == "OPTIONS")
	  {
	   HttpContext.Current.Response.AddHeader("Access-Control-Allow-Methods", "GET, POST");
	   HttpContext.Current.Response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Accept");
	   HttpContext.Current.Response.AddHeader("Access-Control-Max-Age", "1728000");
	   HttpContext.Current.Response.End();
	  }
	}

	
    [WebMethod]
    public string About()
    {
      return "Copyright (c) 2014 - MBPhil Incorporated..";
    }
	
	[WebMethod]
	[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
	public void Exec(string SQLStatement)
	{

		//ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString
		//@"Data Source=.\MSSQL2012;Initial Catalog=MBv8Ledger;User ID=sa;Password=1"
		SqlConnection con = new SqlConnection(@SQLCon);
		SqlDataAdapter daCust = new SqlDataAdapter(SQLStatement, con);
		DataTable dt = new DataTable();
		daCust.Fill(dt);
		JavaScriptSerializer serializer = new JavaScriptSerializer();
		List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
		Dictionary<string, object> row;
		foreach (DataRow dr in dt.Rows)
		{
			row = new Dictionary<string, object>();
			foreach (DataColumn col in dt.Columns)
			{
				row.Add(col.ColumnName, dr[col]);
			}
			rows.Add(row);
		}
		//EnableCrossDomainAjaxCall();
		Context.Response.Output.Write( serializer.Serialize(rows) );
		
	}
	[WebMethod(EnableSession=true)]
	[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
	public void jExec(string SQLStatement)
	{
		//ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString
		//@"Data Source=.\MSSQL2012;Initial Catalog=MBv8Ledger;User ID=sa;Password=1"
	  // string SQLStatement = "select BankID,BankName,BankAccountNum,BankAccountType,BankAcctStatus,Left(DateAdded,12) as DateAdded from BankAccounts where 1=1";
		SqlConnection con = new SqlConnection(@SQLCon);
		SqlDataAdapter daCust = new SqlDataAdapter(SQLStatement, con);
		DataTable dt = new DataTable();
		daCust.Fill(dt);
		JavaScriptSerializer serializer = new JavaScriptSerializer();
	   
		List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
		Dictionary<string, object> row;
		
		string SSS = "[";
		string SS = string.Empty;
		int i=0;
		foreach (DataRow dr in dt.Rows)
		{
			row = new Dictionary<string, object>();
			SS = "[";
			//nlist = new List<string>();
			foreach (DataColumn col in dt.Columns)
			{
				row.Add(col.ColumnName, dr[col]);
				//nlist.Add(dr[col].ToString());
				SS = SS+"\""+dr[col].ToString()+"\",";
			}
			rows.Add(row);
			SSS = SSS+SS+"],";
		   // mlist.Add(nlist.ToString());
			i++;
		}
		SSS = SSS + "]";
		//string rets = "{\"sEcho\": 1, \"iTotalRecords\": \""+i.ToString()+"\", \"iTotalDisplayRecords\": \""+i.ToString()+"\", \"aaData\": "+serializer.Serialize(rows).Replace("{","[").Replace("}","]")+"}";
		//Context.Response.Output.Write( serializer.Serialize(rows) );
		//string tt = string.Join(",", mlist.Select(n => n.ToString()).toArray());
		//EnableCrossDomainAjaxCall();
		Context.Response.Output.Write( SSS.Replace(",]","]"));
		
		//Context.Response.Output.Write(rets);
		
	}
        
  }
}