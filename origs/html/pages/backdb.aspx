<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Debug ="true"
    ViewStateEncryptionMode="Always" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <title>MBv8 Accounting | Transactions for the day</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
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
           <script src="/html/js/jquery.min.js"></script>
                <script src="/html/js/mbphillib.js"></script>
 
		
		

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="/html/js/html5shiv.js"></script>
          <script src="/html/js/respond.min.js"></script>
        <![endif]-->
         <script runat="server">

  
                void Page_Load()
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


           

        </script>

        <style type="text/css">
            .auto-style1 {
                position: relative;
                min-height: 1px;
                float: left;
                width: 64%;
                left: 0px;
                top: 0px;
                padding-left: 15px;
                padding-right: 15px;
            }
        </style>
     

    </head>
    
    <body class="skin-black">

       
        <!-- header logo: style can be found in header.less -->
        <header class="header">
            <a href="/Main" class="logo">
                <!-- Add the class icon to your logo image or logo icon to add the margining -->
               MBv8 Accounting
            </a>
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
                        <%--<div class="pull-left image">
                            <img src="/html/img/img.img" class="img-circle" alt="User Image" />
                        </div>--%>
                        <div class="pull-left info">
                            <p>Hello, <% =Request.Cookies["activeuser"].Value %></p>

                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>
                    <!-- search form -->
                  <!--  <form action="#" method="get" class="sidebar-form">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search..."/>
                            <span class="input-group-btn">
                                <button type='submit' name='seach' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
                            </span>
                        </div>
                    </form>-->
                    <!-- /.search form -->
                    <!-- sidebar menu: : style can be found in sidebar.less -->
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
                    <h1>
                        <h3>Back-Up Data</h3>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="/Main"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">Back-Up Data</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">
                
                    <!-- Small boxes (Stat box) -->
                     
						   <div class="col-md-10">
                               
                               <div class="box">
                                    <div class="box-header">
                                        
                                    </div>

                                    <div class="box-body">
                                        <blockquote id="bkupmsg">
                                            This will perform a database wide backup, sit back and relax while we finish the task..
                                        </blockquote>
                                        <label>Filename</label>
                                        <input type="text" id="bkfilename" class="form-control" value="<%= "BackUp-"+DateTime.Now.ToString("yyyy-MM-dd-HHMM")+".bak" %>" />
                                        <br />
                                        <button class="btn btn-primary" onclick="BackMeUp();">Back Up</button>
                                    </div>
                                    
                               </div>     

                            </div><!-- /.box -->
      
                        

                       <!-- ./col --> <!-- end of data-->
                        
                    <!-- Main row -->
					
               
                
                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->


        <!-- jQuery 2.0.2 -->
        
        <script src="/html/js/bootbox.js"></script>
   
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>
        
		  <!-- DATA TABES SCRIPT -->
        <script src="/html/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="/html/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
		
		
		
        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
        
    

        <!-- page script -->
        <script>
            function BackMeUp() {
                var cmd = "EXEC sp_dbBackup '" + $('#bkfilename').val() + "'";
                var posting = $.post(MB.URLPoster(), { SQLStatement: cmd });
                posting.fail(function (data,status,xhr) { bootbox.alert("unknown error while performing backup ["+status+ " - " +xhr+"]") });
                posting.done(function (data) { bootbox.alert("Back Up,, Complete.."); document.getElementById('bkupmsg').innerHTML = "Done...(Thank you..)!" });
            }                     
        </script>


        
		
   
    </body>
    
</html>