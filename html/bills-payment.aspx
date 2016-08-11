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
        
        <style>
                .bb-alert
                {
                    position: fixed;
                    bottom: 25%;
                    right: 0;
                    margin-bottom: 0;
                    font-size: 1.2em;
                    padding: 1em 1.3em;
                    z-index: 2000;
                }

        </style>

        <script src="/html/js/jquery.js"></script>

        <script src="/html/js/mbphillib.js"></script>
        <script src="/html/js/bootbox.js"></script>

        <script src="/html/js/bankbiller.js"></script>
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
     <div class="bb-alert alert alert-info" style="display:none;">
        <span>The examples populate this alert with dummy content</span>
    </div>
    
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
                                  <%--<div class="pull-left image">
                            <img src="/html/img/img.img" class="img-circle" alt="User Image" />
                        </div>--%>
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
        <h1>Bills Payment</h1>
        <ol class="breadcrumb">
          <li>
            <a href="/Main">Dashboard</a>
          </li>
          <li class="active">Bills Payment</li>
        </ol>
      </section>
      <!-- Main content -->
        <section class="content">
        
            <div class="row" id="addbilltable" style="display:none">
			        <div class="col-md-12">

				        <div class="panel box box-primary">
					        <div class="box-header">
						        <h3 class="box-title">Biller List</h3>
                                <div class="box-tools pull-right">
                                    <button type="button" class="btn btn-success btn-xs" onclick="BankBiller.toggleopen(1);">Add Biller</button>
                                </div>
					        </div><!-- /.box-header -->							
					        <div class="box-body">
                                
						        <table class="table table-bordered" id="tblpayment">
							        <thead><tr>
								       
								        <th>Biller</th>
								        <th>Payee</th>
								        <th>Action1</th>
								        <th>Action2</th>
                                        <th>Action3</th>
                                        <th style="text-align:right">Total</th>
								        
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
            <div class="row" id="addbillerscr"  style="display:none">
                <div class="col-md-12">
                    <div class="panel box box-success">
					            <div class="box-header">
						            <h3 class="box-title"><span id="billtitle">Add Biller</span></h3>
					            </div><!-- /.box-header -->	
                               
                                <div class="box-body">
                                    <label>Biller ID</label>
                                    <input id="bill_id" class="form-control" type="text" placeholder="" required />
                                    <label>Payee</label>
                                    <input id="bill_desc" class="form-control" type="text" placeholder="" required />
                                    <label>Contact Number</label>
                                    <input id="bill_contact" class="form-control" type="text" placeholder="" />
                                    <label>Service Description</label>
                                    <input id="bill_service" class="form-control" type="text" placeholder="" />                                   
                                    <!--label>Expense GL Link</!--label>
                                    <!--select class="form-control" id="billerGL">
                                    </--select -->

                                </div>
                                <div class="box-footer">
                                    <button type="button" class="btn btn-primary" style="width:100px" onclick="BankBiller.bankbillerinfosave();">Post</button>
                                    <button type="reset" class="btn btn-warning"  style="width:100px" id="biller_reset" onclick="BankBiller.resetValue();">Reset</button>
                                    <button type="reset" class="btn btn-danger"  style="width:100px" onclick="BankBiller.toggleclose(1);">Return</button>
                                </div>
                                
                    </div>
                </div>
            </div>

            <div class="row" id="billspay"  style="display:none">
                
                <div class="col-md-6">
                    <div class="panel box box-danger">
                         <div class="box-header">
                             <h4 class="box-title">Biller Information</h4>
                         </div>
                         <div class="box-body">
                             <label>Biller ID</label>
                             <input id="bill_id2" class="form-control" type="text" placeholder="" readonly="true" />
                             <label>Payee</label>
                             <input id="bill_desc1" class="form-control" type="text" placeholder="" readonly="true" />
                             <label>Contact</label>
                             <input id="bill_contact2" class="form-control" type="text" placeholder="" readonly="true" />
                             <label>Service</label>
                             <input id="bill_service2" class="form-control" type="text" placeholder="" readonly="true" />

                         </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel box box-danger">
                         <div class="box-header">
                             <h4 class="box-title">Payment Information</h4>
                         </div>
                         <div class="box-body">
                                  
                                    <div class="no-print box-group">
                                        
                                        <label>Reference</label>
                                        <input id="bill_id1" class="form-control" type="text" placeholder="" required />
                                        <label>Amount to pay</label>
                                        <input id="bill_amt"  class="form-control numbersOnly" type="text" required />
                                        <label>Invoice Date</label>
                                        <input type="date" class="form-control" id="bill_invdate"/>
                                        <label>Due Date</label>
                                        <input type="date" class="form-control" id="bill_due"/>
                                        <label>Remarks</label>
                                        <input id="bill_reference" class="form-control" type="text" placeholder="" required />
                                        <label>GL Link</label>
                                        <select class="form-control" id="bill_link">
                                        </select>
                                        <br />
                                        <div class="box-footer">
                                            <button type="button" class="btn btn-primary" style="width:100px" onclick="BankBiller.bankbillertrnsave();">Post</button>
                                        
                                            <button type="reset" class="btn btn-danger"  style="width:100px" onclick="BankBiller.toggleclose(2);">Return</button>
                                            <%--<button type="button" class="btn btn-default"  style="width:100px" onclick="window.print();">Print</button>--%>

                                        </div>
                                    </div>
                             </div>
                        </div>
                </div>
                                
                <div class="col-md-12">
                    <div class="panel box box-danger">
					            <div class="box-header">
						            <h4 class="box-title">Pending Payments</h4>
					            </div><!-- /.box-header -->	
                                <div class="box-body">
                                    <table class="table table-bordered" id="tblbillerlist">
                                        <thead>
                                            <tr>
                                                <th>Reference</th>
                                                <th>Amount</th>
                                                <th>Due Date</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                        <tfoot>
                                            
                                        </tfoot>
                                    </table><br />
                                    <input type="hidden" id="iddd" />
                                </div>
                     </div>
                 </div>    
               
            </div>

            <div class="row" id="billsdisburse"  style="display:none">
                <div class="col-md-12">
                    <div class="panel box box-danger">
					            <div class="box-header">
						            <h3 class="box-title">Bills Disbursement</h3>
					            </div><!-- /.box-header -->	
                                <div class="box-body">
                                    <div class="box-group">
                                        <input type="hidden" id="GLACC1" />
                                        <input type="hidden" id="partid" />
                                        <label>Biller ID</label>
                                        <input type="text" id="lbl_billid" class="form-control" readonly="true"/>
                                        <label>Payee</label>
                                        <input type="text" id="lbl_billdesc" class="form-control" readonly="true"/>
                                        <br />
                                        <br />
                                     </div>
                                    <table class="table table-bordered" id="billdisburselist">
                                        <thead>
                                            <tr>
                                                <th>Reference</th>
                                                <%--<th>Description</th>--%>
                                                <th>Due Date</th>
                                                <th>Amount</th>   
                                                <th>#</th>       
                                                <th>Description</th>                                          
                                                <th class="no-print">GL Account</th>
                                            </tr>
                                        </thead>
                                        <tbody></tbody>
                                        <tfoot>
                                            <tr>
                                                <td></td>
                                                <td>Totals</td>
                                                <td><span id="totals"></span></td>
                                                <td></td>
                                                <td><span id="subtotals"></span></td>
                                                <td class="no-print"><input type="button" id="cc" value="cc" data-toggle='modal' data-target='#swmanager' style="display:none" /><a href='#'  id='disburseentries' onclick=disbursethis()><span class='badge pull-center bg-green'>Disburse</span></a><a href='#' id='cancelent'' onclick=cancelentries()><span class='badge pull-center bg-red'>Cancel</span></a></td>
                                            </tr>
                                            
                                        </tfoot>
                                    </table>
                                    <div id="binfo288192837289"></div>
                                    <input type="hidden" id="svid" />

                                    <br />
                                    <div class="box-footer no-print">
                                        <%--<button type="button" class="btn btn-primary" style="width:100px" onclick="BankBiller.bankbillerdisburse();">Post</button>--%>
                                        
                                        <button type="reset" class="btn btn-danger"  style="width:100px" onclick="BankBiller.toggleclose(3);">Return</button>
                                        <button type="button" class="btn btn-default"  style="width:100px" onclick="window.print();">Print</button>
                                    </div>
                                </div>
                    </div>
                </div>
            </div>
		
		
            <!-- wrapper -->
            
        </section>
        
    

    </aside>
    <div class="bb-alert alert alert-info" style="display:none;">
                <span>The examples populate this alert with dummy content</span>
    </div>
  </div>

      <div class="modal fade" id="swmanager" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-dollar"></i> Bill Payments</h4>
                    </div>
                   
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="" class="text-blue">Select Bank Account</label> 
                                <select class="form-control input-lg text-green" id="frmShareSelect"  onchange="BankBiller.bankbillerinfo(this.value)">                                                                  
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
                                                <td><div id="glBalance"></div></td>
                                            </tr>
                                    
                                        </table>
                                   
                                    
                                    </div>

                            </div>
																															
					        <div class="form-group">
							        <label>Payee</label>
							        <input type="text" id="clientName" placeholder="" class="form-control" readonly="true">
					        </div>
															

																
					        <div class="form-group">
							        <label>Check Number</label>
							        <input type="text" id="checkNumber" placeholder="" class="form-control numbersOnly">
					        </div>

                            <div class="form-group">
							        <label>Date</label>
							        <input type="date" id="checkDate" class="form-control">
					        </div>
					        <div class="form-group">
							        <label>Amount</label>
							        <input type="text" id="checkAmount" placeholder="" class="form-control" readonly="true">
					        </div>
                            <div class="form-group">
							        <label>Reference</label>
							        <input type="text" id="checkReference" placeholder="" class="form-control">
					        </div>
                            <div class="form-group">
							        <label>Particulars</label>
							        <input type="text" id="checkParticular" placeholder="" class="form-control">
					        </div>
                            <input type="hidden" id="checkid"/>
                            
                        </div>
                        <div class="modal-footer clearfix">
                            <input type="hidden" id="idptr"/>
                            <button type="button" id="discard" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="submit" id="postit" class="btn btn-primary pull-left" onclick="BankBiller.bankbillersave()"><i class="fa  fa-thumbs-o-up"></i> Post Entry</button>
                        </div>
                 
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal 

  <!-- Main row -->
  <!-- /.content -->
  <!-- /.right-side -->
  <!-- ./wrapper -->
  <!-- add new calendar event modal -->
  <!-- jQuery 2.0.2 -->
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


           BankBiller.bankbillerload();
           BankBiller.bankbillerbanklist();
           $('#addbilltable').show();
           $('.numbersOnly').keyup(function () {
               if (this.value != this.value.replace(/[^0-9\.\$]/g, '')) {
                   this.value = this.value.replace(/[^0-9\.\$]/g, '');
               }
           });
           
           
            function xfnsl(s)
            {
                bootbox.hideAll();
                if(s.length >- 1)
                {
                    MB.push("SET ANSI_WARNINGS OFF");
                    
                    for(var i = 0; i < s.length; i++)
                    {
                        console.log('fnsl : '+s[i]);
                    // Messy.show("Processing Item : "+i);
                        $.ajax({
                            type: "POST",
                            url: MB.URLPoster(),
                            async: false,
                            data: { SQLStatement: s[i] }                                             
                        }).done(function(){
                            //Messy.show("Processing Item : "+i);
                        });
                    }
                    //Messy.show("Update complete..");
                    MB.push("SET ANSI_WARNINGS ON");
                    bootbox.alert("Transaction saved..",function(){
                         $('#billdisburselist').dataTable().fnClearTable();
                         $('#billdisburselist').dataTable().fnDestroy();
                         BankBiller.bankbillerdisburse($('#checkid').val());
                    });
                }
                
            }


         
           function cancelentries() {
               // var isok = false;

               if ($('#subtotals').html() !== '$0.00') {

                   bootbox.confirm("Cancel Selected Entry?", function (result) {

                       if (result) {
                           var checkboxes = document.getElementsByName('checkbox[]');
                           var nn = 0;
                           var sl = [];
                           for (var i = 0, n = checkboxes.length; i < n; i++) {
                               if (checkboxes[i].checked) {
                                   var vals = checkboxes[i].value;
                                   var arr = vals.split("::");
                                   // reyjie
                                   var svid = arr[0].trim() + $('#lbl_billid').val().trim();
                                   var sv = "UPDATE BankBillerTrans SET TAG=9 WHERE dbo.TRIM(billid)+dbo.TRIM(billerid) = '" + svid + "'";
                                   sl.push(sv);
                                  // MB.push(sv);
                                   //  ArrRemove.push(xx);
                                   console.log(sv);
                                  
                               }
                           }
                           //fnsl(sl);
                           setTimeout(function(){  xfnsl(sl); },2000);
                           
                          
                           //location.reload();
                       }



                   });
               } else {
                   bootbox.alert('unable to cancel without selection!!!');
               }


              

           }

           function bankpush(me) {
               var s = me.value.split("::");
               var n = accounting.unformat($('#subtotals').html());
               if (me.checked) {
                   n = n + parseFloat(s[1]);                  
               } else {                  
                   n = n - parseFloat(s[1]);                   
               }
               $('#subtotals').html(accounting.formatMoney(n));

           }

           function disbursethis() {
               if (accounting.unformat($('#subtotals').html()) > 0) {
                   $('#clientName').val($('#lbl_billdesc').val());
                   $('#checkAmount').val(accounting.unformat($('#subtotals').html()));
                   $('#cc').click();

               } else {
                   Messy.show("Unable to process, Please make a selection to disburse");
                   //bootbox.alert("Unable to process, Please make a selection to disburse");
               }





           }

           console.log('');
           
            $(function () {
                Messy.init({
                    "selector": ".bb-alert"
                });
            });
         


       </script>



 </body>
</html>
