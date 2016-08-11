<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Inherits="checkinventory"
    ViewStateEncryptionMode="Always" CodeFile="check-inventory.aspx.cs" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="DashBoard" %>
<%@ Import Namespace="MBPhil" %>

<!DOCTYPE html>
<html>
  <head>
    <meta name="generator"
    content="HTML Tidy for HTML5 (experimental) for Windows https://github.com/w3c/tidy-html5/tree/c63cc39" />
    <meta charset="UTF-8" />
    <title>MBv8 Accounting | Transactions for the day</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport' />
    <!-- bootstrap 3.0.2 -->
        <link href="/html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="/html/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="/html/css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Morris chart -->
        <link href="/html/css/morris/morris.css" rel="stylesheet" type="text/css" />
        <!-- jvectormap -->
        <link href="/html/css/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
        <!-- fullCalendar -->
        <link href="/html/css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" />
        <!-- Daterange picker -->
        <link href="/html/css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
        <!-- bootstrap wysihtml5 - text editor -->
        <link href="/html/css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <link href="/html/css/AdminLTE.css" rel="stylesheet" type="text/css" />
	     <!-- DATA TABLES -->
        <link href="/html/css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
		
		

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="/html/js/html5shiv.js"></script>
          <script src="/html/js/respond.min.js"></script>
        <![endif]-->
        <script runat="server">

            

        </script>
  </head>
  <body class="skin-black">
  <!-- header logo: style can be found in header.less -->
  <header class="header">
  <a href="/Main" class="logo">
  <!-- Add the class icon to your logo image or logo icon to add the margining -->
  MBv8 Accounting</a> 
  <!-- Header Navbar: style can be found in header.less -->

	
	   	   <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="navbar-right">
                    <ul class="nav navbar-nav">
                        <!-- Messages: style can be found in dropdown.less-->
                        
                            
                        <!-- User Account: style can be found in dropdown.less -->

                        <!--#include file="/html/useraccount.htt"-->
                    </ul>
                </div>
        </nav>

  </header>
  <div class="wrapper row-offcanvas row-offcanvas-left">
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="left-side sidebar-offcanvas">
      <!-- sidebar: style can be found in sidebar.less -->
      <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
          <div class="pull-left image">
            <img src=<!--#include file="/html/img/img.img"--> class="img-circle" alt="User Image" />
          </div>
          <div class="pull-left info">
            <p>Hello, <%  Response.Write(Request.Cookies["activeuser"].Value); %></p>

                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
          </div>
        </div>
     <ul class="sidebar-menu">
                                 <!--#include file="/html/menu.htt"-->     
                            </ul>

      </section>
      <!-- /.sidebar -->
    </aside>
    <!-- Right side column. Contains the navbar and content of the page -->
    <aside class="right-side">
      <!-- Content Header (Page header) -->
      <section class="content-header">
        <h1>Checkbook Inventory</h1>
        <ol class="breadcrumb">
          <li>
             <a href="/Main"><i class="fa fa-dashboard"></i> Home</a>
          </li>
          <li class="active">Checkbook Inventory</li>
        </ol>
      </section>
      <!-- Main content -->
      <section class="content">
        <div class="row">
          <div class="col-lg-10">
            <div class="box box-primary">
              <div class="box box-primary">
                <!--<div class="box-header">
                  <h3 class="box-title">Post Deposit Transaction</h3>
                </div>-->
              </div>
			  
			    <form id="ciform" runat="server">
			    <!-- form role="form" -->
			      <div class="box-body">
            
            
                  <div class="form-group">
                  <label for="" class="text-blue">FROM Bank Account</label> 
                  <select class="form-control input-lg">
                  <%
                     string connStr = ConfigurationManager.ConnectionStrings["SQLTest"].ConnectionString;
                     SqlDataReader dr = GenericDB.ExecSQL(connStr,@"SELECT * FROM [bankreference]");

                      while(dr.Read())
                      {
                      Response.Write("<option>"+dr["bankname"].ToString()+" - "+dr["accounttype"].ToString()+"#"+dr["bankaccount"].ToString()+"</option>");
                      }
                  %>
                    <!--option>Bank of Guam - Savings Acct#111111-11111-111</option>
                    <option>Bank of FSM - Current Acct# 33345-6675-3455</option>
                    <option>Bank of FSM Time Deposit Acct# 234-567-4222</option -->
                  </select></div>
                  <!-- form-group-->
                   <div class="form-group">
                  <label for="" class="text-green">TO Bank Account</label> 
                  <select class="form-control input-lg">
                    <%
                      dr = GenericDB.ExecSQL(connStr,@"SELECT * FROM [bankreference]");
                      while(dr.Read())
                      {
                      Response.Write("<option>"+dr["bankname"].ToString()+" - "+dr["accounttype"].ToString()+"#"+dr["bankaccount"].ToString()+"</option>");
                      }
                      dr.Close();
                  %>
                    <!-- option>Bank of Guam - Savings Acct#111111-11111-111</option>
                    <option>Bank of FSM - Current Acct# 33345-6675-3455</option>
                    <option>Bank of FSM Time Deposit Acct# 234-567-4222</option -->
                  </select></div>
                  <!-- form-group-->
                  <div class="form-group">
                  <label class="">Amount</label> 
                  <input class="form-control input-lg" type="text" placeholder="$0.00" /></div>
                  <!-- form group-->
                  <div class="form-group">
                  <label class="">Reference</label> 
                  <input class="form-control input-lg" type="text" placeholder="" /></div>
                  <!-- form group-->
                  
				
                </div>
				
				<div class="box-footer">
				  <button class="btn btn-primary ">Post</button>	
                  <button class="btn btn-danger  ">Cancel</button> </div>

                            <div style="display: none;">
                                    <asp:Button runat="server" ID="testme" OnClick="signout" />
                                    </div>
               
                </form>
            </div>
          </div>
          <!-- end of row-->
        </div>
		</div>
        <!-- wrapper -->
      </section>
    </aside>
  </div>
  <!-- Main row -->
  <!-- /.content -->
  <!-- /.right-side -->
  <!-- ./wrapper -->
  <!-- add new calendar event modal -->
  <!-- jQuery 2.0.2 -->
        <script src="/html/js/jquery.min.js"></script>
        <!-- jQuery UI 1.10.3 -->
        <script src="/html/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>
        <!-- Morris.js charts -->
        <script src="/html/js/raphael-min.js"></script>
        <script src="/html/js/plugins/morris/morris.min.js" type="text/javascript"></script>
        <!-- Sparkline -->
        <script src="/html/js/plugins/sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
        <!-- jvectormap -->
        <script src="/html/js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" type="text/javascript"></script>
        <script src="/html/js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js" type="text/javascript"></script>
        <!-- fullCalendar -->
        <script src="/html/js/plugins/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
        <!-- jQuery Knob Chart -->
        <script src="/html/js/plugins/jqueryKnob/jquery.knob.js" type="text/javascript"></script>
        <!-- daterangepicker -->
        <script src="/html/js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <!-- Bootstrap WYSIHTML5 -->
        <script src="/html/js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
        <!-- iCheck -->
        <script src="/html/js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>

        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
        
        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <script src="/html/js/AdminLTE/dashboard.js" type="text/javascript"></script>  

  </body>
</html>
