using System;
using System.Data;
using System.Data.SqlClient;

using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

using System.Configuration;
using System.Collections.Generic;
using System.Collections;

using System.Runtime.Serialization;

using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Security.Cryptography;
using System.Text;
using System.Xml;
using System.IO;
using MBv8Web;


namespace MBv8Web.html.pages
{
    
    public partial class mcuservjs : System.Web.UI.Page
    {
           
        

        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder displayValues = new StringBuilder();
            System.Collections.Specialized.NameValueCollection posted = Request.Form;

            try
            {
                Label1.Text = Request.Url.ToString();
                if (Request["savexml"] != null)
                {
                    GenericDB.WriteXML(Convert.ToInt32(Request["id"].ToString()), Request["value"].ToString());
                }

                if (Request["encrypt"] != null)
                {
                    lbl2.Text = encrypt(Request["encrypt"].ToString());
                    Response.Write(lbl2.Text); // = encrypt(Request.QueryString["encrypt"].ToString());
                }
            }
            catch { lbl2.Text = "hit me test"; }

            
        }


        public static string encrypt(string str)
        {

            //Context.Response.Output.Write(MBPROCENC0000001(str));
            return MBPROCENC0000001(str);
        }

        private static string MBPROCDEC0000001(string str)
        {
            return Encoding.UTF8.GetString(Convert.FromBase64String(str)).ToString();
        }

        private static string MBPROCENC0000001(string str)
        {
            return Convert.ToBase64String(Encoding.Unicode.GetBytes(str));
        }
        
    }
}