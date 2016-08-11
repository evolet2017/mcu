<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Inherits ="appsettings"
    ViewStateEncryptionMode ="Always" CodeFile="app-settings.aspx.cs" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="DashBoard" %>
<%@ Import Namespace="MBPhil" %>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>AdminLTE | Timeline</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <!-- bootstrap 3.0.2 -->
        <link href="/html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="/html/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="/html/css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <link href="/html/css/AdminLTE.css" rel="stylesheet" type="text/css" />

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
    </head>
    <body class="skin-black">
        <!-- header logo: style can be found in header.less -->
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
            <img src='<!--#include file="/html/img/img.img"-->' class="img-circle" alt="User Image"/>
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
                    <h1>
                        Application Settings
                        <small>MCU-Web</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li><a href="#">UI</a></li>
                        <li class="active">Timeline</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">

                    <!-- row -->
                    <div class="row">                        
                        <div class="col-md-12">
                            <!-- The time line -->
                            <ul class="timeline">
                                <!-- timeline time label -->
                                <li class="time-label">
                                    <span class="bg-red">
                                        Database Service
                                    </span>
                                </li>
                                <!-- /.timeline-label -->
                                <!-- timeline item -->
                                <li>
                                    <i class="fa fa-building-o bg-blue"></i>
                                    <div class="timeline-item">
                                       
                                        <h3 class="timeline-header"><a href="#">Connection</a></h3>
                                        <div class="timeline-body">
                                            Server<br>
											Port<br>
											DB User<br>
                                        </div>
                                        <div class='timeline-footer'>
                                            <a class="btn btn-primary btn-xs">Save</a>
                                            <!-- a class="btn btn-danger btn-xs">Delete</a -->
                                        </div>
                                    </div>
                                </li>
                                <!-- END timeline item -->
                                <!-- timeline item -->
                                <li>
                                    <i class="fa fa-truck bg-aqua"></i>
                                    <div class="timeline-item">
                                   
                                        <h3 class="timeline-header no-border"><a href="#">V8 Path</a>&nbsp;&nbsp;<input type="text" size=50></h3>
										<div class='timeline-footer'>
										 <a class="btn btn-primary btn-xs">Save</a>
										 </div>
                                    </div>
                                </li>
                                <!-- END timeline item -->
                                <!-- timeline item -->
								<!-- 
                                <li>
                                    <i class="fa fa-comments bg-yellow"></i>
                                    <div class="timeline-item">
                                        <span class="time"><i class="fa fa-clock-o"></i> 27 mins ago</span>
                                        <h3 class="timeline-header"><a href="#">Jay White</a> commented on your post</h3>
                                        <div class="timeline-body">
                                            Take me to your leader!
                                            Switzerland is small and neutral!
                                            We are more like Germany, ambitious and misunderstood!
                                        </div>
                                        <div class='timeline-footer'>
                                            <a class="btn btn-warning btn-flat btn-xs">View comment</a>
                                        </div>
                                    </div>
                                </li>
								-->
                                <!-- END timeline item -->
                                <!-- timeline time label -->
                                <li class="time-label">
                                    <span class="bg-green">
                                        System Settings
                                    </span>
                                </li>
								
								 <li>
                                    <i class="fa fa-book bg-maroon"></i>
                                    <div class="timeline-item">
                                       
                                        <h3 class="timeline-header"><a href="#">Application Constant</a></h3>
                                        <div class="timeline-body">
                                            Cash Tag<br>
											Check Tag<br>
											AP Tag<br>
                                        </div>
                                        <div class="timeline-footer">
                                           
                                        </div>
                                    </div>
                                </li>
                                <!-- /.timeline-label -->
                                <!-- timeline item -->
                                <li>
                                    <i class="fa fa-users bg-purple"></i>
                                    <div class="timeline-item">
                                        <h3 class="timeline-header"><a href="#">User List</a></h3>
                                        <div class="timeline-body">
										<table id="syssettings" class="table table-bordered">
											<thead><tr>
											<th>#</th>
											<th>User ID</th>
											<th>Username</th>
											<th>Password</th>
											<th>Email</th>
											</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
                                            
                                        </div>
                                    </div>
                                </li>
                                <!-- END timeline item -->
                                <!-- timeline item -->
                                <li>
                                    <i class="fa fa-book bg-maroon"></i>
                                    <div class="timeline-item">
                                       
                                        <h3 class="timeline-header"><a href="#">System Logs</a></h3>
                                        <div class="timeline-body">
                                            Test
                                        </div>
                                        <div class="timeline-footer">
                                           
                                        </div>
                                    </div>
                                </li>
                                <!-- END timeline item -->
                                <li>
                                    <i class="fa fa-clock-o"></i>
                                </li>
                            </ul>
                        </div><!-- /.col -->
                    </div><!-- /.row -->

                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-12">
                            <div class="box box-primary">
                                <div class="box-header">
                                    <h3 class="box-title"><i class="fa fa-code"></i>Another</h3>
                                </div>
                                <div class="box-body">
                                    <pre style="font-weight: 600;">

                                    </pre>                                    
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->
                        </div><!-- /.col -->
                    </div><!-- /.row -->

                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->

        <!-- jQuery 2.0.2 -->
        <script src="/html/js/jquery.min.js"></script>
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>
        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
		
		<script src="/html/js/bootbox.js"></script>

        <script src="/html/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="/html/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
		
		<script>
		  $('#syssettings').dataTable(
                         {
                            // aaData: $.parseJSON(data),
                             "bScrollInfinite": true,
                             "sScrollY": "365px",
                             "bPaginate": false
                         });
		</script>
		

    </body>
</html>