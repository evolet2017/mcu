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


        <!-- Daterange picker -->
        <link href="/html/css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />

        <!-- Theme style -->
        <link href="/html/css/AdminLTE.css" rel="stylesheet" type="text/css" />
	     <!-- DATA TABLES -->
        <link href="/html/css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="/html/css/datatables/jquery.dataTables.css" rel="stylesheet" type="text/css" />

        <script src="/html/js/jquery.js"></script>

        <script src="/html/js/mbphillib.js"></script>
        <script src="/html/js/bootbox.js"></script>

        <script src="/html/js/bankoperation.js"></script>
		<script src="/html/js/accounting.min.js"></script>

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
                      Response.Redirect("/Login");
                  }
              }
              else
              {
                  Response.Redirect("/Login");
              }
          }
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
          <div class="pull-left image">
           
          </div>
          <div class="pull-left info">
           <p><% Response.Write("Todays Date : " + Request.Cookies["activedate"].Value); %></p>
            <a href="#"><i class="fa fa-circle text-success"></i>  Online</a>
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
        <h1>Operations</h1>
        <ol class="breadcrumb">
          <li>
            <a href="/Main">Dashboard</a>
          </li>
          <li class="active">Operations</li>
        </ol>
      </section>
      <!-- Main content -->
        <!-- payroll group -->
        <section class="content" id="payrollgrp"   style="display:none">
        
            <div class="row" id="payscr1">
			        <div class="col-md-12">

				        <div class="panel box box-primary">
					        <div class="box-header">
						        <h3 class="box-title">Payroll Disbursement</h3>
                                <div class="box-tools pull-right">
                                    <button type="button" class="btn btn-success btn-xs" onclick="BankOperations.toggleopen(1);">Payroll Reference</button>&nbsp;&nbsp;
                                    <button type="button" class="btn btn-success btn-xs" onclick="BankOperations.toggleopen(2);">Payroll Posting</button>
                                </div>
					        </div><!-- /.box-header -->							
					        <div class="box-body">
						        <table class="table table-bordered" id="tblpayment">
							        <thead><tr>
								      
								        <th>ID</th>
								        <th>Name</th>
								        <th>Amount</th>
								        <th>Action</th>
								        
								        </tr>
                                    </thead>
							        <tbody>
							        </tbody>
                                    <tfoot>
                                    </tfoot>
						        </table>
					        </div><!-- /.box-body -->
				        </div><!-- /.box -->
		
			        </div> <!-- col -->				
            </div> <!-- row -->
            <div class="row" id="payscr2">
                <div class="col-md-12">
                    <div class="panel box box-success">
					            <div class="box-header">
						            <h3 class="box-title">Payroll Reference</h3>
					            </div><!-- /.box-header -->	
                               
                                <div class="box-body">
                                    <div class="box-body table-responsive">
                                    <table class="table table-bordered table-hover" id="emptable">
                                        <thead>
                                            <tr>
                                                <th>Employee ID</th>
                                                <th>Name</th>
                                                <th>Tax(%)</th>
                                                <th>Basic</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                        <tfoot>
                                            
                                        </tfoot>
                                    </table>
                                    </div>    
                                        <br />
                                    <input type="hidden" id="hiddenid"/>
                                    <div class="input-group">
                                        <span class="input-group-addon"><div style="float;width:120px">Employee ID</div></span>
                                        <input id="emp_id" class="form-control" type="text" placeholder="" readonly="true" />
                                    </div>
                                    <br />
                                    <div class="input-group">
                                        <span class="input-group-addon"><div style="float;width:120px">Name</div></span>
                                        <input id="emp_name" class="form-control" type="text" placeholder="" readonly="true" />
                                    </div>
                                    <br />
                                    <div class="input-group">
                                        <span class="input-group-addon"><div style="float;width:120px">Tax</div></span>
                                        <input id="emp_tax" class="form-control numbersOnly" type="text" placeholder="Tax (%)" />
                                    </div>
                                    <br />
                                    <div class="input-group">
                                        <span class="input-group-addon"><div style="float;width:120px">Basic Salary</div></span>
                                        <input id="emp_basic" class="form-control numbersOnly" type="text" placeholder="0.00" />
                                    </div>
                                    <br />
                                    <%--<label>Expense GL Link</label>
                                    <select class="form-control" id="billerGL">
                                    </select>--%>

                                </div>
                                <div class="box-footer">
                                    <button type="button" class="btn btn-primary" style="width:100px" onclick="BankOperations.bankemplinfosave();">Post</button>
                                    <!-- button type="reset" class="btn btn-warning"  style="width:100px" onclick="BankOperations.resetValue();">Reset</!-->
                                    <button type="reset" class="btn btn-danger"  style="width:100px" onclick="BankOperations.toggleclose(1);">Return</button>
                                </div>
                                
                    </div>
                </div>
            </div>

            <div class="row" id="payscr3">
                <div class="col-md-12">
                    <div class="panel box box-danger">
					            <div class="box-header">
						            <h3 class="box-title">Payroll Posting</h3>
					            </div><!-- /.box-header -->	
                                <div class="box-body">
                                    <table class="table table-bordered" id="paylist">
                                        <thead>
                                            <tr>
                                                <th style='display:none'></th>
                                                <th>Employee ID</th>
                                                <th>Net Pay</th>
                                                <th style='display:none'></th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                        <tfoot>
                                            
                                        </tfoot>
                                    </table><br />
                                    <input type="hidden" id="hidden_id" />
                                    <input type="hidden" id="isEdit" />

                                  

                                    <label>Description</label>
                                    <input id="emp_designation" class="form-control" type="text" placeholder="Description" readonly="true" />
                                    <label">Net Pay</label>
                                    <input id="emp_pay" class="form-control numbersOnly" type="text" required />
                                    <br />
                                    <div class="box-footer">
                                        <button type="button" class="btn btn-primary" style="width:100px" onclick="BankOperations.bankemplpay();">Post</button>
                                        
                                        <button type="reset" class="btn btn-danger"  style="width:100px" onclick="BankOperations.toggleclose(2);">Return</button>
                                    </div>
                                </div>
                    </div>
                </div>
            </div>

            <!-- wrapper -->
        </section>
        <!-- end payroll -->
        <!-- cash advance -->
        <section class="content" id="cashadvancegrp"   style="display:none">
           <div class="row" id="cashadv1">
               <div class="col-md-12">
                   <div class="panel box box-primary">
					        <div class="box-header">
						        <h3 class="box-title">Cash Advance</h3>
                                <div class="box-tools pull-right">
                                    <button type="button" class="btn btn-success btn-xs" onclick="BankOperations.cashadvopen(1);">Cash Advance Request</button>
                                   
                                </div>
					        </div><!-- /.box-header -->
                            <div class="box-body">
                                <table class="table table-bordered" id="cashadvlist">
							        <thead><tr>
								       
								        <th>Request #</th>
								        <th>Name</th>
								        <th>Amount</th>
								        <th>Action</th>
								        
								        </tr>
                                    </thead>
							        <tbody>
							        </tbody>
                                    <tfoot>
                                    </tfoot>
						        </table>
                            </div>

                    </div>
               </div>
           </div>
            <div class="row" id="cashadv2">
               <div class="col-md-12">
                   <div class="panel box box-primary">
					        <div class="box-header">
						        <h3 class="box-title">Cash Advance Request </h3>
                                
					        </div><!-- /.box-header -->
                            <div class="box-body">
                                <div class="form-group">
                                        <%--<span class="input-group-addon"><div style="float;width:120px">Cash TO</div></span>--%>
                                        <label>Cash TO</label>
                                        <input id="ca_name" class="form-control" type="text" placeholder=""/>
						        </div>
   
                                <div class="form-group">
                                        <%--<span class="input-group-addon"><div style="float;width:120px">Amount</div></span>--%>
                                    <label>Amount</label>
                                        <input id="ca_amt" class="form-control numbersOnly" type="text" placeholder=""/>
						        </div>
    
                                
                                <div class="form-group">
                                        <%--<span class="input-group-addon"><div style="float;width:120px">Voucher</div></span>--%>
                                    <label>Voucher</label>
                                        <input id="ca_vouch" class="form-control" type="text" placeholder=""/>
						        </div>
                          
                                <div class="box-footer">
                                        <button type="button" class="btn btn-primary" style="width:100px" onclick="BankOperations.cashadvancepost();">Post</button>
                                        
                                        <button type="reset" class="btn btn-danger"  style="width:100px" onclick="BankOperations.cashadvclose(1);">Cancel</button>
                                </div>
                                
                            </div>

                    </div>
               </div>
           </div>
        </section>
        <!-- end cash advance -->

        <!-- petty cash -->
        <section class="content" id="pettycashgrp"   style="display:none">
            <div class="row" id="petty1" >
			        <div class="col-md-12">

				        <div class="panel box box-primary">
					        <div class="box-header">
						        <h3 class="box-title">Petty Cash Disbursement</h3>
                                <div class="box-tools pull-right">
                                    <button type="button" class="btn btn-success btn-xs" onclick="BankOperations.pettycashopen(1);">Petty Cash Request</button>
                                   
                                </div>
					        </div><!-- /.box-header -->							
					        <div class="box-body">
						        <table class="table table-bordered" id="pettytbl">
							        <thead><tr>
								       
								        <th>Request #</th>
								        <th>Description</th>
								        <th>Amount</th>
								        <th>Action</th>
								        
								        </tr>
                                    </thead>
							        <tbody>
							        </tbody>
                                    <tfoot>
                                    </tfoot>
						        </table>
					        </div><!-- /.box-body -->
				        </div><!-- /.box -->
		
			        </div> <!-- col -->				
            </div> <!-- row -->
            <div class="row" id="petty2" >
			        <div class="col-md-12">

				        <div class="panel box box-primary">
					        <div class="box-header">
						        <h3 class="box-title">Petty Cash Request</h3>
                                
					        </div><!-- /.box-header -->							
					        <div class="box-body">
                                
                                <div class="form-group">
                                       <%-- <span class="input-group-addon"><div style="float;width:120px">Amount $</div></span>--%>
                                        <label>Amount</label>
                                        <input id="pettyamt" class="form-control numbersOnly" type="text" placeholder=""/>
						        </div>
                          
                                <div class="form-group">
                                        <%--<span class="input-group-addon"><div style="float;width:120px">Reference</div></span>--%>
                                    <label>Reference</label>
                                        <input id="pettyref" class="form-control" type="text" placeholder=""/>
						        </div>
                          
                                
                                <div class="form-group">
                                        <%--<span class="input-group-addon"><div style="float;width:120px">Particular</div></span>--%>
                                    <label>Remarks</label>
                                        <input id="pettypart" class="form-control" type="text" placeholder=""/>
						        </div>
                         
                                <div class="box-footer">
                                        <button type="button" class="btn btn-primary" style="width:100px" onclick="BankOperations.postpettycash();">Post</button>
                                        
                                        <button type="reset" class="btn btn-danger"  style="width:100px" onclick="BankOperations.pettycashclose(1);">Cancel</button>
                                </div>
                                <br />
					        </div><!-- /.box-body -->
				        </div><!-- /.box -->
		
			        </div> <!-- col -->				
            </div> <!-- row -->
        </section>
        <!-- end petty cash -->


    </aside>
  </div>

      <div class="modal fade" id="payrolldisburse" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-dollar"></i> Payroll</h4>
                    </div>
                   
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="" class="text-blue">Select Bank Account</label> 
                                <select class="form-control input-lg text-green" id="frmShareSelect2"  onchange="BankOperations.payrollcashinfo(this.value)">                                                                  
                                </select>

                                    <div class="box-body">
                                        <table>
                                            <tr>
                                                <td width="150px">Account Type</td>
                                                <td>:</td>
                                                <td><div id="accttype2"></div></td>
                                            </tr>
                                                <tr>
                                                <td width="150px">Account number</td>
                                                    <td>:</td>
                                                <td><div id="acctnum2"></div></td>
                                            </tr>
                                            <tr>
                                                <td width="150px">General Ledger Code</td>
                                                <td>:</td>
                                                <td><div id="glcode2"></div></td>
                                            </tr>
                                    
                                        </table>
                                   
                                    
                                    </div>

                            </div>
																															
					        <div class="form-group">
							        <label>Check Number</label>
							        <input type="text" id="payrollcheck" placeholder="" class="form-control numbersOnly">
					        </div>																								

                            <div class="form-group">
							        <label>Reference</label>
							        <input type="text" id="payrollreference" placeholder="" class="form-control">
					        </div>
                            <div class="form-group">
							        <label>Remarks</label>
							        <input type="text" id="payrollremarks" placeholder="" class="form-control">
					        </div>
                            <input type="hidden" id="checkid"/>
                            
                        </div>
                        <div class="modal-footer clearfix">
                            <input type="hidden" id="idptr"/>
                            <button type="button" id="discard" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="submit" id="postit" class="btn btn-primary pull-left" onclick="BankOperations.bankempldisbursemaster()"><i class="fa  fa-thumbs-o-up"></i> Post Entry</button>
                        </div>
                 
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

      <div class="modal fade" id="pettydisburse" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-dollar"></i> Petty Cash</h4>
                    </div>
                   
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="" class="text-blue">Select Bank Account</label> 
                                <select class="form-control input-lg text-green" id="frmShareSelect1"  onchange="BankOperations.pettycashinfo(this.value)">                                                                  
                                </select>

                                    <div class="box-body">
                                        <table>
                                            <tr>
                                                <td width="150px">Account Type</td>
                                                <td>:</td>
                                                <td><div id="paccttype"></div></td>
                                            </tr>
                                                <tr>
                                                <td width="150px">Account number</td>
                                                    <td>:</td>
                                                <td><div id="pacctnum"></div></td>
                                            </tr>
                                            <tr>
                                                <td width="150px">General Ledger Code</td>
                                                <td>:</td>
                                                <td><div id="pglcode"></div></td>
                                            </tr>
                                            <tr>
                                                <td width="150px">Balance</td>
                                                <td>:</td>
                                                <td><div id="pglBalance"></div></td>
                                            </tr>
                                    
                                        </table>
                                   
                                    
                                    </div>

                            </div>
							<div class="form-group">
							        <label>Check Number</label>
							        <input type="text" id="pettychecks" placeholder="" class="form-control numbersOnly">
					        </div>		
                            <div class="form-group">
							        <label>Date</label>
							        <input type="date" id="checkDate" class="form-control">
					        </div>																						

                            <div class="form-group">
							        <label>Reference</label>
							        <input type="text" id="pettyference" placeholder="" class="form-control">
					        </div>
                            <div class="form-group">
							        <label>Particulars</label>
							        <input type="text" id="pettyparticular" placeholder="" class="form-control">
					        </div>
                            <input type="hidden" id="checkid1"/>
                            
                            
                        </div>
                        <div class="modal-footer clearfix">
                            <input type="hidden" id="pettyptr"/>
                            <button type="button" id="discard1" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="submit" id="postit1" class="btn btn-primary pull-left" onclick="BankOperations.pettycashsave()"><i class="fa  fa-thumbs-o-up"></i> Post Entry</button>
                        </div>
                 
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <div class="modal fade" id="cash_advance" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-dollar"></i> Cash Advance</h4>
                    </div>
                   
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="" class="text-blue">Select Bank Account</label> 
                                <select class="form-control input-lg text-green" id="frmSelect001"  onchange="BankOperations.cacashinfo(this.value)">                                                                  
                                </select>

                                    <div class="box-body">
                                        <table>
                                            <tr>
                                                <td width="150px">Account Type</td>
                                                <td>:</td>
                                                <td><div id="pt1"></div></td>
                                            </tr>
                                                <tr>
                                                <td width="150px">Account number</td>
                                                    <td>:</td>
                                                <td><div id="pt2"></div></td>
                                            </tr>
                                            <tr>
                                                <td width="150px">General Ledger Code</td>
                                                <td>:</td>
                                                <td><div id="pt3"></div></td>
                                            </tr>
                                            <tr>
                                                <td width="150px">Balance</td>
                                                <td>:</td>
                                                <td><div id="pt4"></div></td>
                                            </tr>
                                    
                                        </table>
                                   
                                    
                                    </div>

                            </div>
							<div class="form-group">
							        <label>Check Number</label>
							        <input type="text" id="CAcheckno" placeholder="" class="form-control numbersOnly">
					        </div>	
                            
                            <div class="form-group">
							        <label>Date</label>
							        <input type="date" id="CAcheckDate" class="form-control">
					        </div>																									

                            <div class="form-group">
							        <label>Reference</label>
							        <input type="text" id="CAreference" placeholder="" class="form-control">
					        </div>
                            <div class="form-group">
							        <label>Particulars</label>
							        <input type="text" id="CAremarks" placeholder="" class="form-control">
					        </div>
                            <input type="hidden" id="Hidden1"/>
                            
                        </div>
                        <div class="modal-footer clearfix">
                            <input type="hidden" id="CAptr"/>
                            <button type="button" id="cancelit" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="submit" id="Button2" class="btn btn-primary pull-left" onclick="BankOperations.cacashsave()"><i class="fa  fa-thumbs-o-up"></i> Post Entry</button>
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
     <input type="hidden" id="checkAmount" />
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

           

          
           //$('#payrollgrp').hide();
           //$('#pettycashgrp').hide();
           //$('#cashadvancegrp').hide();
         
           var x = location.href.replace('http://', '').split('/', 255)[1];

           if (x == 'Cash-Advance') {
               BankOperations.cashadvancelist();
               BankOperations.cabanklist();
               $('#cashadvancegrp').show();
               $('#cashadv2').hide();

           }
           if (x == 'Petty-Cash') {
               BankOperations.pettycashlist();
               
               BankOperations.pettycashbanklist();
               BankOperations.pettycashinfo($('#frmShareSelect1').val());
               $('#pettycashgrp').show();
               $('#petty2').hide();
           }
           if (x == 'Payroll') {
               BankOperations.bankempldisburse();
               BankOperations.bankempl();
               BankOperations.bankemplpaylist();
               BankOperations.payrollcashbanklist();
               BankOperations.payrollcashinfo();
               $('#payscr2').hide();
               $('#payscr3').hide();
               $('#payrollgrp').show();

           }

           $('.numbersOnly').keyup(function () {
               if (this.value != this.value.replace(/[^0-9\.\$]/g, '')) {
                   this.value = this.value.replace(/[^0-9\.\$]/g, '');
               }
           });


       </script>



 </body>
</html>
