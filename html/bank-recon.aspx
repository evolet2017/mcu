<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Inherits="bankrecon"
    ViewStateEncryptionMode="Always" CodeFile="bank-recon.aspx.cs" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="MBv8Web" %>


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
            <!-- iCheck for checkboxes and radio inputs -->
        <link href="/html/css/iCheck/minimal/blue.css" rel="stylesheet" type="text/css" />
		
        <script src="/html/js/jquery.js"></script>
        <script src="/html/js/mbphillib.js" type="text/javascript"></script>
		

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="/html/js/html5shiv.js"></script>
          <script src="/html/js/respond.min.js"></script>
        <![endif]-->
        <script runat="server">

           

        </script>

      <style type="text/css">
            .auto-style2 {
              width: 20px;
          }
        </style>
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
        <h1>Bank Reconciliation</h1>
        <ol class="breadcrumb">
          <li>
            <a href="/Main"><i class="fa fa-dashboard"></i> Home</a>
          </li>
          <li class="active">Bank Reconciliation</li>
        </ol>
      </section>
      <!-- Main content -->
      <section class="content">
        <div class="row no-print" id="recon_mainselect">
          <div class="col-md-12">         
                <ul class="timeline">
                    <li class="time-label">
                        <span class="callout callout-info" style="background:#3e6f93;color:#f8f2f2">
                            Step 1 : Select Bank Account to balance
                        </span>
                    </li>
                    <!-- Start Account Selection -->
                    <li>
                        <div class="timeline-item">
                            <%--<h3 class="timeline-header">Bank Account</h3>--%>
                            <div class="timeline-body">
                                <select class="form-control input-lg text-green" id="frmReconSelect"  onchange="BankRecon.bankinfo(this.value)">                     
                                </select>
                                    <div class="box-body">
                                        <table>
                                            <tr>
                                                <td width="150px">Account Type</td>
                                                <td>:</td>
                                                <td><div id="accttype"></div></td>
                                            </tr>
                                            <tr>
                                                <td width="150px">Account number</td>
                                                <td>:</td>
                                                <td><div id="acctnum"></div></td>
                                            </tr>
                                            <tr>
                                                <td width="150px">General Ledger Code</td>
                                                <td>:</td>
                                                <td><div id="glcode"></div></td>
                                            </tr>
                                            <tr>
                                                <td width="150px">Balance</td>
                                                <td>:</td>
                                                <td><div id="glbalance"></div></td>
                                            </tr>                                    
                                        </table>                                                                       
                                    </div>
                            </div>
                        </div>
                    </li>
                    <!-- End Account Selection -->
                    <!-- Bank Statement Balance -->
                    <li class="time-label">
                        <span class="callout callout-info" style="background:#3e6f93;color:#f8f2f2">
                            Step 2 : Enter Bank Statement Balance (SOA)
                        </span>
                    </li>
                    <li>
                        <div class="timeline-item">
                            <div class="timeline-body">
                                <div class="input-group">                                
                                    <span class="input-group-addon">Ending Balance</span> 
                                    <input type="text" id="soabalance" class="form-control ut-lg numbersOnly" placeholder="0.00"/>                                            
                                </div><!-- /.input group -->
                            </div>
                        </div>
                    </li>

                    <!-- -->

                    <li class="time-label">
                        <span class="callout callout-info" style="background:#3e6f93;color:#f8f2f2">
                            Step 3 : GL Balance - Select Date Range
                        </span>
                    </li>
                    <!-- Start Date Selection -->
                    <li>
                        <div class="timeline-item">
                            <%--<h3 class="timeline-header">Date Range</h3>--%>
                            <div class="timeline-body">
                                <div class="input-group">
                                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                <input type="text" class="form-control pull-right" id="reservation"/>
                                </div>
                            </div>
                        </div>                                  
                    </li> 
                    <!-- End Date Selection -->
                    <li class="time-label">
                        <span class="callout callout-info" style="background:#3e6f93;color:#f8f2f2">
                            Step 4 : Confirm Entry
                        </span>
                    </li>
                    <!-- Confirm Selection -->
                    <li>
                        <div class="timeline-item">
                            <%--<h3 class="timeline-header">Date Range</h3>--%>
                            <div class="timeline-body">
                                <button type="button" class="btn btn-warning" id="btnRefresh" onclick = "btnRefresh()"> <i class="fa fa-refresh"></i>  Confirm</button>
                            </div>
                        </div>                                  
                    </li> 
                    <!-- End Selection-->
                    <li class="time-label">
                        <span class="callout callout-info" style="background:#3e6f93;color:#f8f2f2">
                            Step 5 : Balance Comparison
                        </span>
                    </li>
                    <!-- Display Balance Difference -->
                    <li>
                        <div class="timeline-item">                            
                            <div class="timeline-body">
                                <table class="table table-hover table-responsive">
                                        <thead>
                                        <tr>
                                            <th style="border-top:hidden;border-left:hidden;" width='50%'></th>
                                            <th>Before Reconciliation</th>
                                            <th>After Reconciliation</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td><strong>SOA Ending Balance</strong></td>
                                            <td><strong><span id="soabalance1">$0.00</span></strong></td>
                                            <td><strong><span id="soa_0">$0.00</span></strong></td>
                                        </tr>       
                                        <tr>
                                            <td><strong>On System Account Balance as of</strong></td>
                                            <td><strong><span id="sysbalance">$0.00</span></strong></td>
                                            <td><strong><span id="soa_1">$0.00</span></strong></td>
                                        </tr>            
                                        <tr>
                                            <td><strong>Difference</strong></td>
                                            <td><strong><span id="sysbalance2">$0.00</span</strong></td>
                                            <td><strong><span id="soa_2">$0.00</span></strong></td>
                                        </tr>    
                                        </tbody>             
                                </table>
                            </div>
                        </div>                                  
                    </li> 
                    <li class="time-label">
                        <span class="callout callout-info" style="background:#3e6f93;color:#f8f2f2">
                            Step 6 : Transaction Matching
                        </span>
                    </li>
                    <li id="transmatching" style="display:none">
                        <div class="timeline-item">                            
                            <div class="timeline-body">                                                        
                                <table class="table table-bordered table-responsive" width="100%" id="example2">
                                    <thead>
                                        <tr>
                                        <th>#TrnID</th>
								        <th>Transaction Date</th>
								        <th>Transaction Description</th>
								        <th>Check#</th>
								        <th style="display:none;">Amount</th>
                                        <th>Debit</th>
                                        <th>Credit</th>
                                        <th>Balance</th>
								        <th style="display:none;">Confirm</th>
								        <th>Action</th>		
                                        <th style="display:none;">sss</th>
                                        <th style="display:none;">yyy</th>
                                        </tr>
                                    </thead>          
                                        <tbody>
                                        </tbody>
						        </table>                                                                                                    
                            </div>
                        </div>
                    </li>
                    <li class="time-label">
                        <span class="callout callout-info" style="background:#3e6f93;color:#f8f2f2">
                            Step 7 : Add/Subtract to GL Balance 
                        </span>
                    </li>
                    <li id="marktrans" style="display:none">
                        <div class="timeline-item">                            
                            <div class="timeline-body">
                                <div class="form-group">
                                    <label class="">Amount</label> 
                                    <input class="form-control input-lg currency numbersOnly" type="text" id="frmGLAmt" placeholder="$0.00" required />                  
                                    <label class="">Reference</label> 
                                    <select id="Select1" class="form-control input-lg" onchange="BankRecon.bankreconInfo(this.value)">                                                                                                               
                                    </select>
                                    <label class="">Remarks</label> 
                                    <input class="form-control input-lg currency" type="text" id="GLRemarks" placeholder="Remarks" required />                  
                                    <br />
                                    <Button class="btn btn-warning" ID="GLPost" onclick="BankRecon.bankreconpostGL()" ><i class="fa  fa-thumbs-o-up"></i> Add to GL</Button>                                                     
                                </div>                                
                            </div>
                            <div class="timeline-footer">

                                <div class="box box-primary" id="Div1">
                                    <div class="box box-solid box-header">
                                        <h4>&nbsp;&nbsp;Added to GL</h4>
                                    </div>
                                    <table id="add_gl_sql" class="table table-hover table-responsive">
                                        <thead>
                                            <tr>
                                                <th style="display:none">sql</th>
                                                <th style="display:none">sql2</th>
                                                <th style="display:none" width="10%">Check#</th>
                                                <th width="30%">Amount</th>
                                                <th width="40%">GL Action</th>
                                                <th width="20%">Remarks</th>
                                                <th width="10%">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>                      
                                        </tbody>
                                    </table>
                                </div>
                                <div class="box box-primary" id="Div2">
                                    <div class="box box-solid box-header">
                                        <h4>&nbsp;&nbsp;Added to SOA </h4>
                                    </div>
                                    <table id="add_soa_sql" class="table table-hover table-responsive">
                                        <thead>
                                            <tr>
                                                <th style="display:none">id1</th>
                                                <th style="display:none">id2</th>
                                                <th width="10%">Check#</th>
                                                <th width="20%">Amount</th>
                                                <th width="40%">SOA Action</th>
                                                <th width="20%">Reference</th>
                                                <th width="10%">Action</th>
                                            </tr>
                                        </thead>
                                      <tbody>
                                      </tbody>
                                    </table>
                                </div>

                            </div>
                        </div>
                    </li>
					<%--
                    <li class="time-label">
                        <span class="callout callout-info" style="background:#3e6f93;color:#f8f2f2">
                            Step 8 : Custom GL Entry
                        </span>
                    </li>
                    <li  id="cglentry" style="display:none">
                        <div class="timeline-item">                            
                            <div class="timeline-body">
                            </div>
                        </div>

                    </li>
					--%>
                    <li class="time-label">
                        <span class="callout callout-info" style="background:#3e6f93;color:#f8f2f2">
                            Step 8 : Complete
                        </span>
                    </li>
                    <li id="blance" style="display:none">
                        <div class="timeline-item">                            
                            <div class="timeline-body">
                                 <div class="box box-body">
                                        <button type="button" class="btn btn-warning" id="btnConfirm" onclick = "btnConfirm()"><i class="fa  fa-thumbs-o-up"></i>  Finish</button> 
                                        <button type="button" class="btn btn-danger" id="btnReload" onclick = "window.location='/Bank-Recon';"><i class="fa  fa-undo"></i>  Restart</button> 
                                 </div>
                            </div>
                        </div>
                    </li>

                    <!-- End Display Difference -->
                    <!-- form-group-->
                    <li>
                        <i class="fa fa-clock-o"></i>                           
                    </li>                  
				</ul>




          </div>
        </div>
        <br />
        
                          
   
        <div class="row" id="recon_add" style="display:none">
            <div class="col-md-12">    
                <div class="box box-primary" >

                    <div class="box box-solid box-header no-print">
                        <div class="pull-right box-tools no-print">
                             <%--<button class="btn btb-primary bth-sm" onclick="window.print();"><i class="fa fa-print"></i></button>--%>
                             <button class="btn btb-warning bth-sm" onclick="$('#recon_mainselect').slideToggle();$('#recon_add').slideToggle();"><i class="fa fa-times"></i></button>                            
                        </div>
                        <h4>&nbsp;&nbsp;Reconciliation Report</h4>
                    </div>      
                    <div class="box-body">
                        <div id="pdf" style="height:100vh;"></div>
                    </div> 
                               
                    <%--<div class="box-body"> 
                        <strong>Before</strong>&nbsp;Reconciliation<br /><br />
                        <table class="table table-hover table-responsive" width="100%">
                            <thead>
                            <tr>
                                <td style="width:30%;font-weight:700">SOA</td>
                                <td style="text-align:right;font-weight:700" id="soa_initial">$0.00</td>
                              
                                <td style="width:30%;font-weight:700">GL</td>
                                <td style="text-align:right;font-weight:700" id="gl_initial">$0.00</td>
                            </tr>  
                            </thead>                         
                            <tbody></tbody>
                            <tfoot>
                                <tr>
                                    <td style="width:30%;font-weight:700">Difference</td>
                                    <td style="text-align:right;font-weight:700" id="gl_difference">$0.00</td>
                              
                                    <td></td>
                                    <td></td>

                                </tr>
                            </tfoot>
                        </table>
                        <br />
                        <strong>Adjustments</strong>&nbsp;Reconciling Items
                         <table class="table table-striped" width="100%" id="Table1">
                            <thead>
                            <tr>
                                <td><strong> (Add to SOA)</strong></td>
                                <td></td>
                                <td><strong> (Add to GL)</strong></td>
                                <td></td>
                            </tr>
                            </thead>
                            <tr>
                                <td style="width:30%">Total Deposit in Transit</td>
                                <td id="gldt" style="text-align:right">$0.00</td>
                                <td style="width:30%">Total Charges</td>
                                <td id="glcg" style="text-align:right">($0.00)</td>
                            </tr>
                            <tr>
                                <td style="width:30%">Total Outstanding check</td>
                                <td id="gloc" style="text-align:right">($0.00)</td>
                                <td style="width:30%">Total Interest</td>
                                <td id="glin" style="text-align:right">$0.00</td>
                            </tr>
                            <tr>
                                <td style="width:30%"></td>
                                <td id="totsoa" style="text-align:right;font-weight:700">$0.00</td>
                                <td style="width:30%"></td>
                                <td id="totgl" style="text-align:right;font-weight:700">$0.00</td>
                            </tr>
                                                         
                        </table>
                        <br />
                        <table  class="table table-hover table-responsive" width="100%">
                            <thead>
                                  <tr>
                                        <td style="width:30%;font-weight:700">Ending Balance</td>
                                        <td style="text-align:right;font-weight:700" id="soa_ending">$0.00</td>
                             
                                        <td style="width:30%;font-weight:700">Ending Balance</td>
                                        <td style="text-align:right;font-weight:700" id="gl_ending">$0.00</td>
                                  </tr>    
                            </thead>
                        </table>
                       
                        <hr />
                        <strong>Reconciled</strong> Items
                        <table class="table table-striped" width="100%" id="Table0">
                            <thead>
                                <tr>
                                   
                                    <td>Date</td>
                                    <td>Description</td>
                                    <td>Check#</td>
                                    <td>Debit</td>
                                    <td>Credit</td>
                                 
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                  

                        
                    </div>
                    <div class="box-footer">    
                        <br />                     
                         <strong>Reconciliation</strong> Detail<br />
                         <table class="table table-striped" width="100%" id="Table2">
                             <thead>
                                 <tr>
                                    <th width="40%">GL Adjustments</th>
                                    <th width="30%">Amount</th>                                    
                                    <th width="20%">Remarks</th>                                    
                                 </tr>
                             </thead>
                             <tbody>

                             </tbody>
                         </table>
                        <br />
                        <table class="table table-striped" width="100%" id="Table3">
                             <thead>
                                 <tr>
                                    <th width="40%">Added to SOA</th>                                    
                                    <th width="20%">Amount</th>
                                    <th width="10%">Check#</th>
                                    <th width="20%">Reference</th>                               
                                 </tr>
                             </thead>
                             <tbody>

                             </tbody>
                         </table>
                         <br />
                         

                    </div>--%>

                </div>
            </div>
        </div>


        <!-- /div -->              			
        <!-- end of row-->
        <!-- wrapper -->
      </section>
    </aside>

  </div>
       <input type="hidden" id="tmpxx" size="200"/>
   
      <div class="modal fade" id="checkmanager" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">

                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id ="CheckTitle"><i class="fa fa-dollar"></i> Add to SOA</h4>
                    </div>
                   
                        <div class="modal-body">
                            
                            <div class="form-group">
                                
                                    <label>Amount</label>
                                    <input id="chkamt" type="text" class="form-control input-sm" placeholder="0.00" readonly="true">
                                    <br />
                                    <label>Mark As</label>
                                    <select class="form-control input-sm text-green" id="soa_select">  <!-- onchange="soa_info(this.value)"> -->
                                        <option value="1">Deposit in Transit</option>
                                        <option value="2">Outstanding Checks</option>
                                        <!-- option value="3">For Bank Correction</!-->
                                    </select>
                                
                                <br />
                                <%--<div style="display:none" id="soa_remarks">--%>
                                    <label>Reference</label>
                                    <input id="chkref" type="text" class="form-control input-sm" placeholder="">
                                <%--</div>--%>
                            </div>
                            
                    <%--        <div class="form-group">
                                <div class="input-group">
                                    <span class="input-group-addon">Reference  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                     <select id="chksel" class="form-control" onchange="BankRecon.bankreconInfo(this.value)">

                                     </select>
                                </div>
                            </div>--%>
                       <%--     <div class="form-group">                                
                                <div class="input-group">
                                    <table>
                                    
                                        <tr>
                                            <td width="150px">General Ledger Code</td>
                                            <td>:</td>
                                            <td><div id="chkgl"></div></td>
                                        </tr>
                                    
                                    </table>
             
                                   
                                </div>
                             
                            </div>--%>

                        </div>
                        <div class="modal-footer clearfix">
                            <input type="hidden" id="idptr"/>
                             <input type="hidden" id="soaidd"/>
                            <button type="button" id="discard" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="submit" id="postit" class="btn btn-primary pull-left"  onclick="BankRecon.bankreconpost()"><i class="fa  fa-thumbs-o-up"></i> Add to SOA</button>
                        </div>
                 
                    
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

  <!-- Main row -->
  <!-- /.content -->
  <!-- /.right-side -->
  <!-- ./wrapper -->
  <!-- add new calendar event modal -->
  <!-- jQuery 2.0.2 -->
        
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
		 <!-- Bootstrap WYSIHTML5 -->
        <script src="/html/js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
		
		
        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
        <script src="/html/js/bootbox.js" type="text/javascript"></script>
        
        <script src="/html/js/accounting.min.js" type="text/javascript"></script>
        <script src="/html/js/bankrecon.js" type="text/javascript"></script>

        
      <script>


          function SOAEntry_onclick2(x) {
              document.getElementById('HiddenKo').value = "2"
              bankreconlist(x);                          
          }

          function SOAEntry_onclick(x,y) {
              document.getElementById('HiddenKo').value = "1"
              document.getElementById('soaidd').value = x;
              document.getElementById('idptr').value = y;
              bankreconlist(x);              
          }
          
          function btnConfirm() {          
              //ConfirmRow();

              var checkboxes = document.getElementsByName('checkbox[]');
              var ok2Save = false;
              var nn = 0;
              for (var n = 1; n < document.getElementById("example2").rows.length; n++) {
                  if (checkboxes[n - 1].checked) {
                      ok2Save = true;
                      nn++;
                  }                 
              }
              ok2Save = (nn == document.getElementById("example2").rows.length-1);
              if (ok2Save) {
                  ok2Save = (document.getElementById("soa_2").innerText == "$0.00");
              }
              if (ok2Save) {
                  {
                      bootbox.confirm("Are You Sure ?", function (result) {
                          if (result) {
                              // posting for Add to GL 



                              for (var x = 0; x < document.getElementById("add_gl_sql").rows.length; x++) {
                                  var sqlstmt = document.getElementById("add_gl_sql").rows[x].cells[0].innerHTML;
                                  //console.log(sqlstmt);
                                  MB.push(sqlstmt);
                                  //var sqlstmt = document.getElementById("add_gl_sql").rows[n].cells[1].innerHTML;
                                  //console.log(sqlstmt);
                                  //MB.push(sqlstmt);                         
                              }
                              // posting for Transaction Matching
                              var checkboxes = document.getElementsByName('checkbox[]');
                              for (var n = 1; n < document.getElementById("example2").rows.length; n++) {
                                  if (checkboxes[n - 1].checked) {
                                      var soa_trnid = document.getElementById("example2").rows[n].cells[0].innerHTML;
                                      var sqlstmt = document.getElementById("example2").rows[n].cells[10].innerText;


                                      //   console.log('trnid    : ' + soa_trnid);
                                      //   console.log('amount   : ' + document.getElementById("example2").rows[n].cells[4].innerHTML);
                                      //   console.log('credit   : ' + document.getElementById("example2").rows[n].cells[6].innerHTML);
                                      //   console.log('Balance  : ' + document.getElementById("example2").rows[n].cells[7].innerHTML);
                                      //   console.log('sqlrecon : ' + soa_sql);
                                      //   console.log('sqlrecon1: ' + soa_Rec);
                                      if (!MB.isEmpty(sqlstmt)) {
                                          var sqlstmt = document.getElementById("example2").rows[n].cells[11].innerText;
                                          MB.push(sqlstmt);
                                          //console.log(sqlstmt);
                                      }
                                      MB.push("update masterTrn set [status] = 2 where trnid=" + soa_trnid);

                                  }
                              }
                              // post bankrecon summary for this recon procedure

                              var sqlstmt = "INSERT INTO BankRecon (SOABalance,GLBalance,EndSOA,EndGL,DateRange,v8RunDate,GLACC,Tag) ";
                              sqlstmt += "SELECT " + accounting.unformat(document.getElementById('soabalance1').innerHTML) + ",";
                              sqlstmt += accounting.unformat(document.getElementById('sysbalance').innerHTML) + ",";
                              sqlstmt += accounting.unformat(document.getElementById('soa_0').innerHTML) + ",";
                              sqlstmt += accounting.unformat(document.getElementById('soa_1').innerHTML) + ",'";
                              sqlstmt += $('#reservation').val() + "',";
                              sqlstmt += MB.getCookie('sysdate') + ",'";
                              sqlstmt += document.getElementById('frmReconSelect').value + "',1";
                              //console.log(sqlstmt);
                              MB.push(sqlstmt);
                              //
                              var sqlstmt = "SELECT ISNULL((SELECT 1 FROM BankRecon WHERE DateRange+GLACC='" + $('#reservation').val().trim() + document.getElementById('frmReconSelect').value.trim() + "'),0) CNT";
                              var rets = $.post(MB.URLPoster(), { SQLStatement: sqlstmt });
                              rets.success(function (msg) {
                                  var retr = JSON.parse(msg);
                                  if (retr[0].CNT == 1) {
                                      //window.location = '/Bank-Recon';
                                      var rpturl = "http://" + location.host + "/reportsvc/default.aspx?"
                                      var str = $('#reservation').val();
                                      var ss = '<object width="100%" height="100%" type="application/pdf" data="' + rpturl + 'recon=1&report=bankrecon.rpt&param0=' + document.getElementById('frmReconSelect').value.trim() + '&param1=' + str.substring(0, 10) + '&param2=' + str.substring(str.indexOf("- ") + 1).trim() + '" id="pdf_content">' +
                                               '<p>Pdf Generation Error</p>' +
                                               '</object>';
                                      $('#pdf').html(ss);

                                      $('#recon_mainselect').slideToggle();
                                      $('#recon_add').slideToggle();
                                      $('#cglentry').hide();
                                    //  $('#reconstep7').hide();

                                      if (!$('#transmatching').is(':hidden')) {
                                          $('#blance').hide();
                                          $('#transmatching').hide();
                                          $('#marktrans').hide();
                                          $('#addglbutton').hide();
                                      }
                                      //////////////////////////////
                                      //ListGLSOA();
                                      /////////////////////////////                              
                                  }
                              });

                              //
                          } // end - if(result)
                      });
                  }
              } else {
                  bootbox.alert("Unable to reconcile item");
              }
              


         }

          function ConfirmRow() {
              var vals = "";
              var ArrRemove = [];
              var arrAmt = 0;
              bootbox.confirm("Are You Sure ?", function (result) {
                  if (result) {
                      var checkboxes = document.getElementsByName('checkbox[]');
                      var nn = 0;
                      for (var i = 0, n = checkboxes.length; i < n; i++) {
                          if (checkboxes[i].checked) {

                              vals = checkboxes[i].value;
                              var arr;
                              arr = vals.split("-", 2);

                              //BankRecon.PostConfirm(arr[0]);
                             // MB.push("update masterTrn set [status] = 2 where trnid=" + arr[0]);

                              var xx = "#" + arr[0];
                              arrAmt = arrAmt + parseFloat(arr[1]);
                            //  ArrRemove.push(xx);
                         }
                      }

                      if (sysbalance2.value > '') {
                          sysbalance2.value = accounting.formatMoney(parseFloat(accounting.unformat(sysbalance2.value)) + parseFloat(arrAmt));
                      } else {
                          sysbalance2.value = accounting.formatMoney(parseFloat(arrAmt));
                      }
                                              
                      sysbalance.value = accounting.formatMoney(parseFloat(accounting.unformat(sysbalance.value)) - parseFloat(arrAmt));
                      
                     // var index;
                     // for (index = 0; index < ArrRemove.length; ++index) {
                        
                     //     $(ArrRemove[index]).remove();

                     // }
                     
                  } else {

                  }
              });
          }


          function tab1click() {             
              btnRefresh();
          }

          function tab3click() {             
              var b;
              var arr;
              b = reservation.value;
              arr = b.split("-", 2);

              //console.log(arr);
              $('#example3').dataTable().fnClearTable();
              $('#example3').dataTable().fnDestroy();
              BankRecon.bankreconlistAdjGLView(arr[0], arr[1]);
          }
        
          function btnRefresh() {

              var sqlstmt = "SELECT ISNULL((SELECT 1 FROM BankRecon WHERE DateRange+GLACC='" + $('#reservation').val().trim() + document.getElementById('frmReconSelect').value.trim() + "'),0) CNT";
              //console.log('SQL : ' + sqlstmt);
              var rets = $.post(MB.URLPoster(), { SQLStatement: sqlstmt });
              rets.success(function (msg) {
                  //console.log('rets ' + msg);
                  var retr = JSON.parse(msg);
                  if (retr[0].CNT == 1) {
                      bootbox.alert("Reconcilation of records already exists..", function () {
                          //window.location = '/Bank-Recon';

                          var rpturl = "http://" + location.host + "/reportsvc/default.aspx?"
                          var str = $('#reservation').val();
                          var ss = '<object width="100%" height="100%" type="application/pdf" data="' + rpturl + 'recon=1&report=bankrecon.rpt&param0=' + document.getElementById('frmReconSelect').value.trim() + '&param1=' + str.substring(0, 10) + '&param2=' + str.substring(str.indexOf("- ")+1).trim() + '" id="pdf_content">' +
                                   '<p>Pdf Generation Error</p>' +
                                   '</object>';
                          $('#pdf').html(ss);

                          $('#recon_mainselect').slideToggle();
                          $('#recon_add').slideToggle();                         
                          $('#cglentry').hide();
                         // $('#reconstep7').hide();

                          if (!$('#transmatching').is(':hidden')) {
                              $('#blance').hide();
                              $('#transmatching').hide();
                              $('#marktrans').hide();
                              $('#addglbutton').hide();
                          }
                          //////////////////////////////
                         // ListGLSOA();





                          /////////////////////////////
                          return;
                      });
                  } else {

                      var b;
                      var arr;
                      b = reservation.value;
                      arr = b.split("-", 2);

                      $('#add_gl_sql > tbody').html('');
                      $('#add_soa_sql > tbody').html('');

                      //console.log(arr);
                      $('#example2').dataTable().fnClearTable();
                      $('#example2').dataTable().fnDestroy();
                      BankRecon.bankreconlist(arr[0], arr[1]);

                      //bankreconlist(arr[0], arr[1]);
                      if ($('#transmatching').is(':hidden')) {
                          $('#transmatching').slideToggle();
                          $('#blance').slideToggle();
                          $('#addglbutton').slideToggle();
                          $('#marktrans').slideToggle();
                          $('#cglentry').slideToggle();
                          

                      }

                  }
                  //return
              });

             

              
            
         
          }


          function bankreconlist(fTrnId) {
             // console.log("-> "+fTrnId);
              var sv = "Select * from (SELECT TrnID, " +
                  "dbo.NUM2DATE(MasterTRN.v8RunDate) TransDate," +
                  "(SELECT Description FROM Modules WHERE ModuleID=MasterTRN.ModuleID) TransType," +
                  "CheckNumber," +
                  "Amount " +
                  "FROM MasterTRN " +
                   "WHERE  [status] = 1) a " +
                 // "WHERE TrnID NOT IN (SELECT TrnID FROM BankRecon) and [status] = 1) a " +
                  "Where trnID = '" + fTrnId + "'";

              //console.log(sv);
             
              $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
              {
                  SQLStatement: sv

              }, function (data) {
                  var i = 0;
                //i  console.log(data);

                  $.each($.parseJSON(data), function (key, value) {
                                       
                      chkamt.value = accounting.formatMoney(value.Amount);
                      chkref.value = "";
                      HiddenTRNNo.value = fTrnId;
                      
                  }
                  );

                });

          }

        
            BankRecon.bankinfo(document.getElementById('frmReconSelect').value);
            // BankRecon.bankreconInfo(document.getElementById('chksel').value);

            function soa_info(n) {
                if (n == 3) {
                    $('#soa_remarks').slideToggle();
                } else {
                    if (!$('#soa_remarks').is(':hidden')) {
                        $('#soa_remarks').slideToggle();
                    }
                }
            }

            function SOAMark(t, y) {
             //   console.log(y);
            //    console.log(t);
                //console.log(document.getElementById('example2').rows[t+1].cells[10].innerText);
                var s = document.getElementById('example2').rows[t + 1].cells[10].innerText;
               // console.log(s);
                var checkboxes = document.getElementsByName('checkbox[]');
                var tagsets = document.getElementsByName('tagset[]');
                checkboxes[t].checked = !checkboxes[t].checked;
                //document.getElementById(y).style.backgroundColor = '#003F87';
             //   console.log('TT : ' + $('#sqlstmt_' + y).val());
                if (checkboxes[t].checked) {
                   // console.log('ischeck');
                    $('#' + y).css({ "backgroundColor": "#A2CCC6" });
                    if (MB.isEmpty(s)) {
                      //  console.log('isempty1');
                        $('#addsoa' + t).fadeToggle();
                       
                    }
                    tagsets[t].innerText = 'Recall';
                } else {
                   // console.log('ischeck not');
                    $('#' + y).css({ "backgroundColor": "white" });
                    //$('#addsoa' + t).fadeToggle();
                    if (MB.isEmpty(s)) {
                      //  console.log('isempty2');
                        $('#addsoa' + t).fadeToggle();
                       
                    }
                    tagsets[t].innerText = 'Mark as Reconcile';
                }
              
            }


            $(function () {                               
                $("#example1").dataTable();
                // $("#example2").dataTable();              
                //BankRecon.bankreconlist('2014-01-27' , '2014-01-27');
                //Datemask dd/mm/yyyy
                $("#datemask").inputmask("dd/mm/yyyy", { "placeholder": "dd/mm/yyyy" });
                //Datemask2 mm/dd/yyyy
                $("#datemask2").inputmask("mm/dd/yyyy", { "placeholder": "mm/dd/yyyy" });
                //Money Euro
                $("[data-mask]").inputmask();

                //Date range picker
                $('#reservation').daterangepicker();
                //Date range picker with time picker
                $('#reservationtime').daterangepicker({ timePicker: true, timePickerIncrement: 30, format: 'MM/DD/YYYY h:mm A' });
                //Date range as a button
                $('#daterange-btn').daterangepicker(
                        {
                            ranges: {
                                'Today': [moment(), moment()],
                                'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
                                'Last 7 Days': [moment().subtract('days', 6), moment()],
                                'Last 30 Days': [moment().subtract('days', 29), moment()],
                                'This Month': [moment().startOf('month'), moment().endOf('month')],
                                'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
                            },
                            startDate: moment().subtract('days', 29),
                            endDate: moment()
                        },
                function (start, end) {
                    $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
                }
                );

                //iCheck for checkbox and radio inputs
                $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
                    checkboxClass: 'icheckbox_minimal',
                    radioClass: 'iradio_minimal'
                });
                //Red color scheme for iCheck
                $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
                    checkboxClass: 'icheckbox_minimal-red',
                    radioClass: 'iradio_minimal-red'
                });
                //Flat red color scheme for iCheck
                $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
                    checkboxClass: 'icheckbox_flat-red',
                    radioClass: 'iradio_flat-red'
                });

                //Colorpicker
                $(".my-colorpicker1").colorpicker();
                //color picker with addon
                $(".my-colorpicker2").colorpicker();

                //Timepicker
                $(".timepicker").timepicker({
                    showInputs: false
                });
            });



            var ss = "select A.GLACC,A.BankName,B.accounttype,A.BankAccountNum,";
            ss += "(SELECT 'selected' from appconfig where mbfield1='Deposit' and mbvalue=a.GLACC) as vselect ";
            ss += "from BankAccounts A LEFT JOIN accounttype B on A.BankAccountType=B.id WHERE 1=1 ";
            var rets = $.post(MB.URLPoster(), { SQLStatement: ss });
            rets.success(function (msg) {
                $.each(JSON.parse(msg), function (id, value) {
                    $('#frmReconSelect').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.BankName + "</option>");
                    //$('#trndebit').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.BankName + "</option>");
                });
                BankRecon.bankinfo($('#frmReconSelect').val());


            });

            var ss = "Select moduleid, description as vdesc from modules where ModuleID like '%BR00%'";           
            var rets = $.post(MB.URLPoster(), { SQLStatement: ss });
            rets.success(function (msg) {
                $.each(JSON.parse(msg), function (id, value) {
                    //<option value='" + value.GLACC + "'" + value.vselect + ">" + value.BankName + "</option>");
                    $('#Select1').append("<option value='" + value.moduleid + "'>" + value.vdesc + "</option>");
                });
                

            });

            $('.numbersOnly').keyup(function () {
                if (this.value != this.value.replace(/[^0-9\.\$]/g, '')) {
                    this.value = this.value.replace(/[^0-9\.\$]/g, '');
                }
            });

            function gl_cancel(x,n) {
                $('#' + x).remove();

                console.log(n);
                var nn = accounting.unformat(n);
                console.log(nn);


                

                var yy = accounting.unformat(document.getElementById('soa_1').innerText);
                document.getElementById('soa_1').innerText = accounting.formatMoney(yy - nn);

                var yy = accounting.unformat(document.getElementById('soa_0').innerText);
                var zz = accounting.unformat(document.getElementById('soa_1').innerText);
                document.getElementById('soa_2').innerText = accounting.formatMoney(yy - zz);

            }

            function soa_cancel(x, y, z) {
                $('#' + x).slideToggle();
                //document.getElementById(y).innerText = '';
                $('#soacancel_' + x).remove();
                console.log(z);

                var nn = accounting.unformat(z);
                console.log(nn);

                var yy = accounting.unformat(document.getElementById('soa_2').innerText);
                document.getElementById('soa_2').innerText = accounting.formatMoney(yy - nn);

                var yy = accounting.unformat(document.getElementById('soa_0').innerText);
                document.getElementById('soa_0').innerText = accounting.formatMoney(yy - nn);


            }

            
        </script>
      
       <input type ="hidden" id = "HiddenTRNNo" />
       <input type ="hidden" id = "HiddenKo" />



  </body>
</html>
