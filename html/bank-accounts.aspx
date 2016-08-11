<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Inherits="bankaccounts"
    ViewStateEncryptionMode="Always" CodeFile="bank-accounts.aspx.cs" %>

<!DOCTYPE html>
<html>
  <head>
    <meta name="generator"
    content="HTML Tidy for HTML5 (experimental) for Windows https://github.com/w3c/tidy-html5/tree/c63cc39" />
    <meta charset="UTF-8" />
    <title>MBv8 Accounting | Transactions for the day</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport' />
    <!-- bootstrap 3.0.2 -->
        <link href="/html/css/bootstrap.css" rel="stylesheet" type="text/css" />
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
        <script src="/html/js/bootbox.js"></script>
       <script src="/html/js/accounting.min.js"></script>
        <script src="/html/js/bankaccount.js"></script>
		

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->

        <!--[if lt IE 9]>
          <script src="/html/js/html5shiv.js"></script>
          <script src="/html/js/respond.min.js"></script>
        <![endif]-->
     

      

  </head>
  <body class="skin-black">
  <div class="bb-alert alert alert-info" style="display:none;"><span></span></div>
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
                                 <%--<div class="pull-left image">
                            <img src="/html/img/img.img" class="img-circle" alt="User Image" />
                        </div>--%>
          <div class="pull-left info">
            <p><% Response.Write("Todays Date : " + Request.Cookies["activedate"].Value); %></p>
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
          </div>
        </div>
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
        <h1>Bank Accounts</h1>
        <ol class="breadcrumb">
          <li>
            <a href="/Main">Dashboard</a>
          </li>
          <li class="active">Bank Accounts</li>
        </ol>
      </section>
      <!-- Main content -->
      <section class="content">
      <div class="row" id="listaccts">

           <div class="col-md-12">
               <div class="box box-solid">
                    <div class="box-header">
                        <!-- h4 class="box-title">All Bank Accounts</!-->
                        <div class="box-tools pull-right">
                            <button type='button' class='btn btn-success btn-sm' onclick="$('#listaccts').slideToggle();$('#newaccount').slideToggle();">New Account</button>
                        </div>
                    </div>
                    <div class="box-body">
                        
                           
					        <table id="example1" class="table table-bordered">
															
                                <thead><tr>
							        <!-- th></!-->
                              
							        <th width="160">Bank</th>
							        <th>Account Number</th>
							        <th>Account Type</th>
							        <th>Status</th>
							        <th>Current Balance</th>
                                    <th>Action</th>
                                    </tr>
						        </thead>
                                <tbody>
                                <!-- Magically, the below datatable will find its way on this area -->
						        </tbody>
                                                            

					        </table><!-- -->
                                                            
				       
                    </div>
                </div>
           </div>
      </div>

      <div class="row" id="newaccount" style="display:none">
           <div class="col-md-12">
                <div class="box box-solid">
                    <div class="box-header">
                        <h4 class="box-title">New Account</h4>
                    </div>
                    <div class="box-body">
                        <div class="form-group">
							<label>GL Link Account</label>
							<select class="form-control" id="glac"></select>
						</div>
															
						<div class="form-group">
							<label>Description</label>
							<input id="acctname" type="text" placeholder="" class="form-control">
						</div>
																
						<div class="form-group">
							<label>Bank Account Number</label>
							<input id="acctbank" type="text" placeholder="" class="form-control">
						</div>	
																
						<div class="form-group">
							<label>Account Type</label>
							<select class="form-control" id="acctselect"></select>
						</div>	

                        <div class="form-group">
							<label>Starting Balance</label>
							<input id="acctbalance" type="text" placeholder="" class="form-control numbersOnly">
						</div>	
																				
						<div class="form-group">
							<label>Remarks</label>
							<textarea id="acctremarks" placeholder="Enter ..." rows="3" class="form-control"></textarea>
						</div>

						<div class="box-footer">
                            <button class="btn btn-primary" onclick="BankAccount.bankacctsave();">Save</button>
                            <button class="btn btn-warning" onclick="$('#newaccount').slideToggle();$('#listaccts').slideToggle();">Cancel</button>
                                                        
                        </div>
                    </div>
                </div>

           </div>
      </div>

      <div class="row" id="bank_details" style="display:none">
           <div class="col-md-12">
                <div class="box box-solid">
                    <div class="box-header">
                        <h4 class="box-title"><span  id="bank_details_header"></span></h4>
                        <div class="box-tools pull-right">
                            <button type='button' class='btn btn-success btn-sm' onclick="$('#listaccts').slideToggle();$('#bank_details').slideToggle();">Close</button>
                        </div>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered" id="bank_tablelist">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Date</th>
                                    <!-- th>GLACC</!-->
                                    <th>Description</th>
                                    <th>Debit</th>
                                    <th>Credit</th>                                                                        
                                    <th>Balance</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                        
                    </div>
                    <input type="hidden" id="bank_tmpid" />
                </div>

           </div>
      </div>
	


        <!-- wrapper -->
          <div class="row" id="bankeditor" style="display:none">
              <div class="col-md-12">
                  <div class="box box-success">
                    <div class="box-header">
					    <h4 class="box-title">Edit Account</h4>
					</div><!-- /.box-header -->
                    <div class="box-body">
                        <div class="form-group">
							<label>GL Link Account</label>
							<input type="text" class="form-control" id="edtSelect1" readonly="true"/>
						</div>
															
						<div class="form-group">
							<label>Description</label>
							<input id="edtBank" type="text" placeholder="Type Bank Name" class="form-control">
						</div>
																
						<div class="form-group">
							<label>Bank Account Number</label>
							<input id="edtAcct" type="text" placeholder="" class="form-control">
						</div>	
																
						<div class="form-group">
							<label>Account Type</label>
							<input type="text" class="form-control" id="edtSelect2" readonly="true" />
						</div>	

                        <div class="form-group">
							<label>Balance Date</label>
							<input type="date" class="form-control" id="edtDate" />
						</div>	

                       

                        <div class="form-group">
							<label>Balance</label>
							<input type="text" class="form-control" id="edtBalance3"  />
						</div>	
									
                        
                        <div class="form-group">
							<label>
                                <span id="edtSW"></span>
							
                            </label>
                       </div>	
                        											
						<div class="form-group">
							<label>Remarks</label>
							<textarea id="edtRemarks" placeholder="Enter ..." rows="3" class="form-control"></textarea>
						</div>

                          <div class="box-footer">
                          <button class="btn btn-primary" onclick="BankAccount.bankacctsave2();">Save</button>
                          <button class="btn btn-warning" onclick="$('#bankeditor').slideToggle();$('#listaccts').slideToggle();">Cancel</button>
                          
                          </div>

                        <input type="hidden" id="tmpbankid" />
                    </div>
                     
                  </div>
              </div>

          </div>
      </section>
    </aside>
  </div>
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


        <!-- page script -->
         <script type="text/javascript">
             
             BankAccount.bankload();
            // $('#bankeditor').hide();
             $('.numbersOnly').keyup(function () {
                 if (this.value != this.value.replace(/[^0-9\.\$]/g, '')) {
                     this.value = this.value.replace(/[^0-9\.\$]/g, '');
                 }
             });


     </script>

     

        

  </body>
</html>
