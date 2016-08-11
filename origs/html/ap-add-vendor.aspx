<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Inherits="apaddvendor"
    ViewStateEncryptionMode="Always" CodeFile="ap-add-vendor.aspx.cs" %>

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
        <link href="/html/css/datatables/jquery.dataTables.css" rel="stylesheet" type="text/css" />

        <script src="/html/js/jquery.js"></script>

        <script src="/html/js/mbphillib.js"></script>
       <script src="/html/js/bootbox.js" type="text/javascript"></script>
       <script src="/html/js/msgbox.js" type="text/javascript"></script>
       <script src="/html/js/bankvendor.js" type="text/javascript"></script>
		

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
                        <% Response.WriteFile("~/html/useraccount.htt"); %>
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
                                               
                        <div class="pull-left info">
                            <p><% Response.Write("Todays Date : " + Request.Cookies["activedate"].Value); %></p>

                            <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                        </div>
                    </div>
                    <!-- search form -->
            
                    <!-- /.search form -->
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                    <ul class="sidebar-menu">
                        
                        <% Response.WriteFile("~/html/menu.htt"); %>
						
                        
                    </ul> 
                </section>
                <!-- /.sidebar -->
            </aside>

    <!-- Right side column. Contains the navbar and content of the page -->
    <aside class="right-side">
      <!-- Content Header (Page header) -->
      <section class="content-header">
        <h1>Vendor Management</h1>
        <ol class="breadcrumb">
          <li>
            <a href="/Main">Dashboard</a>
          </li>
          <li class="active">Vendor Management</li>
        </ol>
      </section>
      <!-- Main content -->
      <section class="content">
        
		<div class="row">
		
			   <div class="col-md-12">
			   
			   
					<div class="nav-tabs-custom">
			   
						    <ul class="nav nav-tabs">
											  <li class="active"><a data-toggle="tab" href="#tab_1">List of Vendors</a></li>
											  <li class=" "><a data-toggle="tab" href="#tab_2">Add New Vendor Information</a></li>
							</ul>
			       
					  
			   
							<div class="tab-content">	
			   
	
							<div id="tab_1" class="tab-pane active">
									<div class="panel box box-success">
													<div class="box-header">
													<h3 class="box-title">Vendor Information</h3>
													</div><!-- /.box-header -->
													
													
													<div class="box-body">
														<table id="tblVendor" class="table table-bordered">
															<thead><tr>
																<!-- th>#</!-->
																<th>Company Name</th>
																<th>Contact Name</th>
																<th>Address</th>
																<th>Phone Number</th>
																<th>Email</th>
																<th>Action</th>
																<th>Date Added</th>
															</tr></thead>
															<tbody>

                                                            <!--

                                                            <tr>
																<td>1.</td>
																<td>Micro PC Solution</td>
																<td>Mike Mignolia</td>
																<td>Vector St. Hit Road view</td>
																<td>565-4545</td>
																<td>bigmike@gmail.com</td>
																<td>Active</td>
																<td>12-12-2001</td>
																
															</tr>
															<tr>
																<td>2.</td>
																 <td>Ace Hardware</td>
																<td>ACE Hardware</td>
																<td>Wall St. Downtown</td>
																<td>678-8900</td>
																<td>info@acehardware.com</td>
																<td>Active</td>
																<td>4-8-2006</td>
															</tr>
															<tr>
																<td>3.</td>
																  <td>Xerox, Inc.</td>
																<td>David Ryan</td>
																<td>Park Square 1</td>
																<td>888-8888</td>
																<td>heydave@yahoo.com</td>
																<td>Active</td>
																<td>12-12-2009</td>
															</tr>
														   -->
														</tbody></table>
                                                        <script>
                                                            BankVendor.vendorlist();
                                                        </script>
													</div><!-- /.box-body -->
													
												</div><!-- /.box -->
							</div><!-- end of tab 1-->
								
											
											
											
							<div id="tab_2" class="tab-pane">
											<div class="panel box box-primary">
													<div class="box-header">
													<h3 class="box-title">Add New..</h3>
													
													</div><!-- /.box-header -->
                                
														<!-- form start -->
													        <div class="form-group">
																	<label>Vendor ID</label>
																	<input id="coyvendor" type="text" placeholder="" class="form-control">
															</div>
																
																															
															<div class="form-group">
																	<label>Company Name</label>
																	<input id="coyname" type="text" placeholder="" class="form-control">
															</div>
															
															<div class="form-group">
																	<label>Contact Name</label>
																	<input id="coycontact" type="text" placeholder="" class="form-control">
															</div>
																
																
															<div class="form-group">
																	<label>Address</label>
																	<input id="coyaddress" type="text" placeholder="" class="form-control">
															</div>

                                                            <div class="form-group">
																	<label>eMail Address</label>
																	<input id="coyemail" type="text" placeholder="" class="form-control">
															</div>

															<div class="form-group">
																	<label>Phone</label>
																	<input id="coyphone" type="text" placeholder="" class="form-control">
															</div>

													
															<div class="form-group">
																	<label>Remarks</label>
																	<textarea id="coyremarks" placeholder="Enter ..." rows="3" class="form-control"></textarea>
														    </div>
														   
														     
														   
														   <div class="box-footer">
                                                            <button class="btn btn-primary" id="btnvendor" type="submit" onclick="BankVendor.vendorsave();">Save</button>
                                                            <button class="btn btn-danger" id="btnReset" type="button" onclick="BankVendor.vendorreset();">Reset</button>

                                    </div>
					   
							
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
  <div class="modal face" id="edit-vendor" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog">
          <div class="modal-content">
              <div class="modal-header">
                  <h3>Edit Vendor</h3>

              </div>
              <div class="modal-body">
                  <label>Vendor ID</label>
                  <input id="vend_id" type="text" class="form-control" placeholder="Vendor ID" readonly="true" />
                  <label>Company Name</label>
                  <input id="vend_coy" type="text" class="form-control" placeholder="Company Name"  />
                  <label>Contact Name</label>
                  <input id="vend_con" type="text" class="form-control" placeholder="Contact Name"  />
                  <label>Address</label>
                  <input id="vend_add" type="text" class="form-control" placeholder="Address"  />
                  <label>Email Address</label>
                  <input id="vend_mail" type="text" class="form-control" placeholder="Email"  />
                  <label>Phone Number</label>
                  <input id="vend_phone" type="text" class="form-control" placeholder="Phone Number"  />

              </div>
              <div class="modal-footer clearfix">
                  <button type="button" class="btn btn-primary" onclick="BankVendor.vendorsave2();"> Save</button>
                  <button type="submit" class="btn btn-danger" data-dismiss="modal"> Close</button>
                  

              </div>
          </div>
      </div>
  </div>
       <form id="Form1" runat="server">
                <div style="display: none;">
                <asp:Button runat="server" ID="testme" OnClick="signout" />
                
                </div>
                   
                </form>
  <!-- Main row -->
  <!-- /.content -->
  <!-- /.right-side -->
  <!-- ./wrapper -->
  <!-- add new calendar event modal -->
 <!-- Bootstrap -->
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
       

      
      <script>
         
         // $(document).ready(function () {
          //    $('#tblVendor').dataTable().fnDraw();;
         // });
         
      </script>

  </body>
</html>
