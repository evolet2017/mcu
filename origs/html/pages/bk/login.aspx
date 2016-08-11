<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    ViewStateEncryptionMode="Always"%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<%@ Import Namespace="DashBoard" %>
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

                string connStr = ConfigurationManager.ConnectionStrings["SQLTest"].ConnectionString;

                SqlDataReader dr = MBPhil.GenericDB.ExecSQL(connStr,@"SELECT * FROM [usertable] WHERE username='" + userid.Text + "'");
                while(dr.Read())
                {

                    if (dr["log"].ToString() != "0")
                    {
                        isLog = true;
                    }
                    else
                    {

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
                    MBPhil.GenericDB.ExecSQL(connStr, @"UPDATE usertable SET log=log+1,ipaddress='" + GetIPAddress() + "' WHERE username='" + userid.Text + "'");
                    
                    SqlDataReader rd0 = MBPhil.GenericDB.ExecSQL(connStr, @"SELECT log FROM usertable WHERE username='"+userid.Text+"'");
                    while (rd0.Read())
                    {
                        if (Convert.ToInt32(rd0["log"].ToString()) > 3)
                        {
                            lbl1.Text = "Automatic user reset confirmed.";
                            MBPhil.GenericDB.ExecSQL(connStr, @"UPDATE usertable SET log=0,ipaddress='" + GetIPAddress() + "' WHERE username='" + userid.Text + "'");
                        }
                    }
                    
                }
                else
                {

                    if (WithUser == true)
                    {

                        if (isActive == true)
                        {
                            SqlDataReader rd = MBPhil.GenericDB.ExecSQL(connStr, @"sp_GetDBF 'select dolastact from sysparms'");
                            while (rd.Read())
                            {
                                DTS = rd["dolastact"].ToString();
                                MBPhil.GenericDB.ExecSQL(connStr, @"UPDATE appconfig SET mbvalue='" + DTS + "' WHERE mbfield1='sysdate'");

                            }
                            rd.Close();

                            rd = MBPhil.GenericDB.ExecSQL(connStr, @"SELECT CAST(CAST(CAST(" + DTS + " AS DATETIME) AS DATE) AS VARCHAR) AS DT");

                            while (rd.Read())
                            {
                                DTS = rd["DT"].ToString();
                                Response.Cookies["activedate"].Value = DTS;
                            }
                            rd.Close();

                            MBPhil.GenericDB.ExecSQL(connStr, @"UPDATE usertable SET log=1,ipaddress='" + GetIPAddress ()+ "' WHERE username='" + userid.Text + "'");


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
        <script src="/html/js/jquery.min.js"></script>
        <script src="/html/js/md5.min.js"></script>
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>        

    </body>
</html>