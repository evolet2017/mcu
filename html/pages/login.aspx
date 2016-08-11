<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    ViewStateEncryptionMode="Always"%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="MBv8Web" %>
<%@ Import Namespace="MBFunc" %>

<!DOCTYPE html>

<html class="bg-black">
    <head>
        <meta charset="UTF-8">
        <title>MBv8 Accounting | Log in</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <!-- bootstrap 3.0.2 -->
        <link href="/html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="/html/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <link href="/html/css/AdminLTE.css" rel="stylesheet" type="text/css" />

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="/html/js/html5shiv.js"></script>
          <script src="/html/js/respond.min.js"></script>
        <![endif]-->

         <!--[if IE]>
            <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
          <![endif]-->
        <style>
            img {
                   
                   top: 38%;
                   left: 50%;
                   width: 500px;
                   height: 100px;
                   margin-top: -250px; /* Half the height */
                   margin-left: -250px; /* Half the width */
                   position: absolute;
                 
                }
        </style>
        <script runat="server">
        
           

            void Page_Load()
            {
                
                string path = System.AppDomain.CurrentDomain.BaseDirectory;
                path = path + "appconfig.xml";

                if (!File.Exists(path))
                {
                    XmlDocument _xmlDoc = new XmlDocument();
                    XmlNode _xmlNode = _xmlDoc.CreateXmlDeclaration("1.0", "utf-8", "yes");
                    XmlNode _rootNode = _xmlDoc.CreateElement("MCUweb-Accounting");
                    XmlNode _DBNode = _xmlDoc.CreateElement("mcu");
                    
                    XmlAttribute _NameAt = _xmlDoc.CreateAttribute("dbserver");
                    _NameAt.InnerText = System.Net.Dns.GetHostName();
                    _DBNode.Attributes.Append(_NameAt);

                    XmlAttribute _portAt = _xmlDoc.CreateAttribute("port");
                    _portAt.InnerText = "8080";
                    _DBNode.Attributes.Append(_portAt);

                    XmlAttribute _timeOut = _xmlDoc.CreateAttribute("timeout");
                    _timeOut.InnerText = "10";
                    _DBNode.Attributes.Append(_timeOut);

                    XmlAttribute _ConstrAt = _xmlDoc.CreateAttribute("connectionstring");
                    //value to be set
                    _ConstrAt.InnerText = "Server=CRD-003\\MSSQL2012;Database=MBv8Ledger;User Id=sa;Password=1;";
                    _DBNode.Attributes.Append(_ConstrAt);

                    _rootNode.AppendChild(_DBNode);
                    _xmlDoc.AppendChild(_xmlNode);
                    _xmlDoc.AppendChild(_rootNode);

                    _xmlDoc.Save(path);

                    Response.Cookies["dbserver"].Value = System.Net.Dns.GetHostName();
                    Response.Cookies["dbport"].Value = "8080";
                    Response.Cookies["timeout"].Value = "10";

                    Response.Redirect("/appconfig");

                }
            }
           
            protected string GetIPAddress()
            {
                System.Web.HttpContext context = System.Web.HttpContext.Current;
                string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

                if (!string.IsNullOrEmpty(ipAddress))
                {
                    string[] addresses = ipAddress.Split(',');
                    if (addresses.Length != 0)
                    {
                        return addresses[0];
                    }
                }

                return context.Request.ServerVariables["REMOTE_ADDR"];
            }
        

            public void subme(object sender, System.EventArgs e)
            {
                // Retrieve Connection string from Web.config and save in connStr   
                bool WithUser = false;
                bool isActive = false;
                bool isLog = false;
                string DTS = string.Empty;

                //get the appconfig.xml // this is the connection string
                string connStr = GenericDB.GetXML("mcu", "connectionstring");//ConfigurationManager.ConnectionStrings["SQLTest"].ConnectionString;

                SqlDataReader dr = GenericDB.ExecSQL(connStr,@"SELECT * FROM [usertable] WHERE username='" + userid.Text + "'");
                while(dr.Read())
                {

                    if (dr["log"].ToString() != "0")
                    {
                        //user is log in
                        isLog = true;
                    }
                    else
                    {
                        //else user not log in
                        Response.Cookies["activeid"].Value = userid.Text;
                        Response.Cookies["activeuser"].Value = dr["firstname"].ToString();
                        Response.Cookies["activelast"].Value = dr["lastname"].ToString();
                        Response.Cookies["activeposition"].Value = dr["userlevel"].ToString();
                        Response.Cookies["activeemail"].Value = dr["email"].ToString();
                        Response.Cookies["isactive"].Value = "1";

                        System.IO.File.WriteAllText(Request.PhysicalApplicationPath + "/html/img/img.img", dr["image"].ToString());


                        WithUser = dr["password"].ToString() == GenericFunc.md5(password.Text);
                        isActive = dr["tag"].ToString() == "1";
                        //Response.Cookies["isactive"].Expires = DateTime.Now.AddMinutes(10); // add expiry time
                    }
                   
                }
                dr.Close();

                if (isLog == true)
                {
                    lbl1.Text = "User is already login. Try another user.";
                    //log = log+1 to determine later on if the user click the btn 3 times
                    GenericDB.ExecSQL(connStr, @"UPDATE usertable SET log=log+1,ipaddress='" + GetIPAddress() + "' WHERE username='" + userid.Text + "'");
                    
                    SqlDataReader rd0 = GenericDB.ExecSQL(connStr, @"SELECT log FROM usertable WHERE username='"+userid.Text+"'");
                    while (rd0.Read())
                    {
                        //if user already log for 3 times reset the log = 0 to login again
                        if (Convert.ToInt32(rd0["log"].ToString()) > 3)
                        {
                            lbl1.Text = "Automatic user reset confirmed.";
                            GenericDB.ExecSQL(connStr, @"UPDATE usertable SET log=0,ipaddress='" + GetIPAddress() + "' WHERE username='" + userid.Text + "'");
                        }
                    }
                    
                }
                else
                {

                    //if there is an existing data
                    if (WithUser == true)
                    {
                        //check uf the use is active or not
                        if (isActive == true)
                        {
                            //call the sp_GetDBF and pass the parameter query to @sqlcmd to get the latest sysdate
                            SqlDataReader rd = GenericDB.ExecSQL(connStr, @"sp_GetDBF 'select dolastact from sysparms'");
                            while (rd.Read())
                            {
                                //DTS = string.empty
                                //get the latest dolastact(sysdate) and store it on DTS string
                                DTS = rd["dolastact"].ToString();


                                GenericDB.ExecSQL(connStr, @"UPDATE appconfig SET mbvalue='" + DTS + "' WHERE mbfield1='sysdate'");
                                //create cookie named "sysdate" and store and the value of DTS(dolastact)
                                Response.Cookies["sysdate"].Value  = DTS; 
                            }
                            rd.Close();

                            //convert DTS to date e.q 06-21-2016
                            rd = GenericDB.ExecSQL(connStr, @"SELECT CAST(CAST(CAST(" + DTS + " AS DATETIME) AS DATE) AS VARCHAR) AS DT");

                            while (rd.Read())
                            {
                                //change value of DTS from 45420 to working date  format 06-21-2016
                                DTS = rd["DT"].ToString();
                                //DateTime _DTS = DateTime.Now;
                                //_DTS = DateTime.Now();

                                //create activedate cookie and pass the new DTS
                                Response.Cookies["activedate"].Value = DTS; // _DTS.ToString("mm-dd-yyyy");
                            }
                            rd.Close();

                            GenericDB.ExecSQL(connStr, @"UPDATE usertable SET log=1,ipaddress='" + GetIPAddress ()+ "' WHERE username='" + userid.Text + "'");
                            //Response.Cookies["mbzd001"].Value = (int.Parse(DateTime.Now.ToString("HH"))*60) + DateTime.Now.ToString("mm");

                            //<<<<<<<<<<<<<<FILL THE SQL TABLES>>>>>>>>>>>>>>>>

                            //build the dashboard reports run sp_pitchtransaction
                            //will be stored in dashboard table
                            GenericDB.Exec(connStr, @"exec sp_PitchTransaction");

                            //get the Uncleared savings deposit file
                            GenericDB.Exec(connStr, @"exec sp_GETSVUCDEP");

                            //UPDATE BANK PAYABALES
                            //GET WITHDRAWAL, LOAD DISBURSEMENT AND WITHDRAWAL TO CLOSE
                            GenericDB.Exec(connStr, @"exec sp_GetPayables");

                            //GET LATEST TRANSACTION FROM BANKACCTRN TABLE
                            //IF BANKACCTRN NOT UPDATED GET THE LATEST FROM APPCONFIG
                            GenericDB.Exec(connStr, @"exec sp_SOABalanceForward");

                            //GET ASSET DEPRECIATION
                            //THIS STORED PROC IS USING CURSORS WHICH MAKES IT A PRIMARY CANDIDATE AS TO WHY THE LOGIN RUNS SLOW
                            //remove 6302016
                            //GenericDB.Exec(connStr, @"exec sp_MonthlyDepre");
                            //GenericDB.Exec(connStr, @"exec sp_MonthlyDepre2");
                            

                            //create cookie mbzd001 and store Hours(HH) * 60 + minutes(mm)
                            Response.Cookies["mbzd001"].Value = ((int.Parse(DateTime.Now.ToString("HH")) * 60) + int.Parse(DateTime.Now.ToString("mm"))).ToString();

                            Response.Redirect("/Main");

                        }
                        else { lbl1.Text = "Inactive Account. User is not allowed to login!"; }
                    }
                    else
                    {
                        if (isActive == false)
                        {
                            lbl1.Text = "Inactive Account. User is not allowed to login!";
                        }
                        else
                        {
                            lbl1.Text = "Invalid Login. Please Try Again!";
                        }
                    }
                }

                
            }
        </script>
    </head>
    <body class="bg-black">
        <form id="MBPhil_loginFrm" runat="server">
            <br /><br />
        <img src="/html/img/mbv8-accounting-w.png" />

        <div class="form-box" id="login-box">
            <div class="header">Sign In</div>

                <div class="body bg-gray">
                    Welcome to the MBv8 Accounting System. To continue, please login using your user id and password below.<br /><br />
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-user"></i></span>
                        <asp:Textbox runat="server" ID="userid" class="form-control" placeholder="User ID"/>
                    </div>
                    <br />
        
                    <div class="input-group">
                        <span class="input-group-addon"><i class="fa fa-key"></i></span>
                        <asp:Textbox runat="server" ID="password" type=password class="form-control" placeholder="Password"/>
                    </div>          
                </div>
                <div class="footer">                                                               
         
                    <asp:Button id="b1" text="Sign me in" runat="server" onclick="subme" class="btn bg-olive btn-block"  />
                    <asp:Label ID="lbl1" runat="server" Width="88%" />
                  
                </div>
        </div>

    </form>

        <!-- jQuery 2.0.2 -->
        <script src="/html/js/jquery.js"></script>
        <script src="/html/js/md5.min.js"></script>
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>        
        <script>
            var tt = new Date();
            document.cookie = 'mbzz001234=' + Date.parse(tt.toDateString());
        </script>

    </body>
</html>