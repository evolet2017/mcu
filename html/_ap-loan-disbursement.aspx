<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    ViewStateEncryptionMode="Always" EnableSessionState="True" Culture="Auto" %>


<!DOCTYPE html>
<html>
  <head>
    <meta name="generator"
    content="HTML Tidy for HTML5 (experimental) for Windows https://github.com/w3c/tidy-html5/tree/c63cc39" />
    <meta charset="UTF-8" />
    <title>MBv8 Accounting | Transactions for the day</title>
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
        <link href="/html/css/datatables/jquery.dataTables.css" rel="stylesheet" type="text/css" />

        <script src="/html/js/jquery.js"></script>

        <script src="/html/js/mbphillib.js"></script>
		

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="/html/js/html5shiv.js"></script>
          <script src="/html/js/respond.min.js"></script>
        <![endif]-->
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
                        <div class="pull-left image">
                            <img src=<!--#include file="/html/img/img.img"--> class="img-circle" alt="User Image" />
                        </div>
                        <div class="pull-left info">
                            <p>Hello, <% Response.Write(Request.Cookies["activeuser"].Value); %> </p>

                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>
                    <!-- search form -->
            
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
        <h1>Loan Disbursement</h1>
        <ol class="breadcrumb">
          <li>
            <a href="index.html">Dashboard</a>
          </li>
          <li class="active">Loan Disbursement</li>
        </ol>
      </section>
      <!-- Main content -->
      <section class="content">
        
		<div class="row">
		
			   <div class="col-md-10">
			   
			   
					<div class="nav-tabs-custom">
			   
						   <ul class="nav nav-tabs">
											  <li class="active"><a data-toggle="tab" href="#tab_1">List of Checks for Disbursement</a></li>
											  <li class=" "><a data-toggle="tab" href="#tab_2">Loan Disbursement </a></li>
							</ul>
			       
					  
			   
							<div class="tab-content">	
			   
	
							<div id="tab_1" class="tab-pane active">
									<div class="panel box box-success">
													<div class="box-header">
													<h3 class="box-title">Loan Disbursement</h3>
													</div><!-- /.box-header -->
													
													
													<div class="box-body">
														<table class="table table-bordered">
															<tbody><tr>
																<th>#</th>
																<th>Release Date</th>
																<th>Client Name</th>
																<th>Check Amount</th>
																<th>Check Number</th>
																<th>Remarks</th>
																</tr>
															<tr>
																<td>1.</td>
																<td>04/25/2014</td>
																<td>Mike Mignolia</td>
																<td align="right">$10,000.00</td>
																<td>100001</td>
																<td>&nbsp;</td>
																
															</tr>
															<tr>
																<td>2.</td>
																<td>04/25/2014</td>
																<td>Rick James</td>
																<td align="right">$3,000.00</td>
																<td>100020</td>
																<td>&nbsp;</td>
															</tr>
															<tr>
																<td>3.</td>
																 <td>04/25/2014</td>
																<td>David Ryan</td>
																<td align="right">$2,000.00</td>
																<td>100003</td>
															    <td>&nbsp;</td>
															</tr>
															
															
															<tr>
																<td>&nbsp;</td>
																 <td>&nbsp;</td>
																<td><strong>TOTAL</strong></td>
																<td align="right"><strong>$15,000.00</strong></td>
																<td>&nbsp;</td>
															    <td>&nbsp;</td>
															</tr>
															
															
															
														   
														</tbody></table>
													</div><!-- /.box-body -->
													<div class="box-footer clearfix">
														<ul class="pagination pagination-sm no-margin pull-right">
															<li><a href="#">«</a></li>
															<li><a href="#">1</a></li>
															<li><a href="#">2</a></li>
															<li><a href="#">3</a></li>
															<li><a href="#">»</a></li>
														</ul>
													</div>
												</div><!-- /.box -->
							</div><!-- end of tab 1-->
								
											
											
											
							<div id="tab_2" class="tab-pane">
											<div class="panel box box-primary">
													<div class="box-header">
													<h3 class="box-title">Loan Check Details</h3>
													
													</div><!-- /.box-header -->
                                
														<!-- form start -->
														<form role="form">
																
																															
															<div class="form-group">
																	<label>Client Name</label>
																	<input type="text" placeholder="" class="form-control">
															</div>
															
															<div class="form-group">
																	<label>Check Amount</label>
																	<input type="text" placeholder="T" class="form-control">
															</div>
																
																
															<div class="form-group">
																	<label>Check Number</label>
																	<input type="text" placeholder="" class="form-control">
															</div>

															<div class="form-group">
																	<label>Remarks</label>
																	<input type="text" placeholder="" class="form-control">
															</div>

															
																
																
												
					   
																		
															<div class="form-group">
																	<label>Remarks</label>
																	<textarea placeholder="Enter ..." rows="3" class="form-control"></textarea>
																</div>
														   
														     
														   
														   <div class="box-footer">
                                        <button class="btn btn-primary" type="submit">Disburse Check</button>
                                    </div>
					   
									</form>
									     </div> <!-- panel box primary -->
							</div><!-- end of tab 2-->
											
											

		
									
									
							</div><!-- tab content -->
							
					
									
		
								
								
								
					</div> <!-- nav tabs -->
								
								</div> <!-- col -->
								
								
								</div> <!-- row -->
		
        <!-- wrapper -->
      </section>
    </aside>
  </div>
  <!-- Main row -->
  <!-- /.content -->
  <!-- /.right-side -->
  <!-- ./wrapper -->
  <!-- add new calendar event modal -->
  <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>
		<!-- DATA TABES SCRIPT -->
        <script src="/html/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="/html/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
        <!-- InputMask -->
        <script src="/html/js/plugins/input-mask/jquery.inputmask.js" type="text/javascript"></script>
        <script src="/html/js/plugins/input-mask/jquery.inputmask.date.extensions.js" type="text/javascript"></script>
        <script src="/html/js/plugins/input-mask/jquery.inputmask.extensions.js" type="text/javascript"></script>
        <!-- date-range-picker -->
        <script src="/html/js/plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
        <!-- bootstrap color picker -->
        <script src="/html/js/plugins/colorpicker/bootstrap-colorpicker.min.js" type="text/javascript"></script>
        <!-- bootstrap time picker -->
        <script src="/html/js/plugins/timepicker/bootstrap-timepicker.min.js" type="text/javascript"></script>
        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
       

       <script src="/html/js/bootbox.js" type="text/javascript"></script>
       <script src="/html/js/msgbox.js" type="text/javascript"></script>
  </body>
</html>
