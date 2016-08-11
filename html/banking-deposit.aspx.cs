using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
//using DashBoard;
using MBv8Web;
using System.Configuration;



public partial class bankingdeposit : Page
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

  
    protected void BankSave_Click(object sender, EventArgs e)
    {


    }
    protected void BankCancel0_Click(object sender, EventArgs e)
    {
        //Label1.Text = "<script>bootbox.alert('hi');</script>";
        ClientScript.RegisterStartupScript(this.GetType(), "myalert", "bootbox.alert('test');", true);
    }

    protected void BankList(object sender, EventArgs e)
    {
        string connStr = GenericDB.GetXML("mcu","connectionstring"); //ConfigurationManager.ConnectionStrings["SQLTest"].ConnectionString;
        SqlDataReader dr = GenericDB.ExecSQL(connStr, @"select A.GLACC,A.BankName,B.accounttype,A.BankAccountNum from BankAccounts A LEFT JOIN accounttype B on A.BankAccountType=B.id WHERE 1=1 AND A.GLACC<>''");

        while (dr.Read())
        {
            Response.Write("<option value='" + dr["GLACC"].ToString().PadRight(10,' ') + "'>" + dr["BankName"].ToString() + " - " + dr["accounttype"].ToString() + "#" + dr["BankAccountNum"].ToString() + "</option>");
        }
        dr.Close();
    }
   
}