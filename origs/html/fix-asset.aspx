<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Debug="true"
    ViewStateEncryptionMode="Always" %>


<!DOCTYPE html>
<html>
 <head>
    <meta charset="UTF-8" />
    <title>MBv8 Accounting | Transactions for the day</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport' />
    <!-- bootstrap 3.0.2 -->
        <link href="/html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="/html/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="/html/css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <link href="/html/css/AdminLTE.css" rel="stylesheet" type="text/css" />
	     <!-- DATA TABLES -->
        <link href="/html/css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
      <%--  <link href="/html/css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />--%>
        <link href="/html/css/jQueryUI/jquery-ui-1.10.4.custom.css" rel="stylesheet" type="text/css" />

      <%--  <link rel="stylesheet" type="text/css" href="/html/js/plugins/datepick/jquery.datepick.css"> --%>


        <script src="/html/js/jquery.js"></script>

        <script src="/html/js/mbphillib.js"></script>
        <script src="/html/js/bootbox.js"></script>

        <%--<script type="text/javascript" src="/html/js/plugins/datepick/jquery.plugin.js"></script> 
        <script type="text/javascript" src="/html/js/plugins/datepick/jquery.datepick.js"></script>--%>

        <script src="/html/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="/html/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>

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
                                  <%--<div class="pull-left image">
                            <img src="/html/img/img.img" class="img-circle" alt="User Image" />
                        </div>--%>
          <div class="pull-left info">
            <p><% Response.Write("Todays Date : " + Request.Cookies["activedate"].Value); %></p>
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
        <h1>Fixed Asset</h1>
        <ol class="breadcrumb">
          <li>
            <a href="/Main">Home</a>
          </li>
          <li class="active">Fixed Asset</li>
        </ol>
      </section>
      <!-- Main content -->
      <section class="content">
        <div class="row" id="listofasset">
            <div class="col-md-12">
                <div class="box box-solid">
                    <div class="box-header">
                        <h2 class="box-title">List of Assets</h2>
                        <div class="box-tools pull-right no-print">
                            <!-- button id="btnFA" class="btn btn-default btn-sm" data-widget="collapse"><i class="fa fa-minus"></i></!-->
                            <button type='button' class='btn btn-success btn-sm' onclick="add_new();">New Asset</button>
                            <!-- button id="Button1" class="btn btn-print btn-sm" onclick="window.print();"><i class="fa fa-print"></i></!-->
                        </div>
                    </div>
                    <div class="box-body">
                        <table id="assetlisting" class="table table-bordered">
                            <thead>
                                <tr>
                               
                                    <th>Asset Code</th>
                                    <th>Description</th>
                                    <th>Date Purchased</th>
                                    <th>Vendor ID</th>
                                    <th>Cost</th>
                                    <th class="no-print">Action</th>
                                
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
  
        <div class="row no-print" id="add_asset" hidden>
            <!-- left column -->
          
            <div class="col-md-6">

                           <div class="box box-success">

                                <div class="box-header">
                                    <h3 class="box-title">Details</h3>
                                </div>
                                <div class="box-body">
                                    <label>Asset Name/Number</label>
                                    <input id="assetnum" class="form-control input-sm" type="text" placeholder="">
                                    <label>Asset Account</label>
                                    <select class="form-control" id="assetacct" onchange="BankAsset.bankassetinfo(this.value)">                                                
                                    </select>                                          
                                    <label>Accumulated</label>
                                    <select class="form-control" id="SelectAccu">                                                
                                    </select>                                          
                                    <label>Expense</label>
                                    <select class="form-control" id="SelectExp">                                                
                                    </select>                                          
                              
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->

                            <div class="box box-success">
                                <div class="box-header">
                                    <h3 class="box-title">Asset Information</h3>
                                </div>
                                <div class="box-body">
                                    <label>Description</label>
                                    <input id="asset_desc" class="form-control input-sm" type="text" placeholder="">
                                    <label>PO Number</label>
                                    <input id="asset_po" class="form-control input-sm" type="text" placeholder="">
                                    <label>Serial Number</label>
                                    <input id="asset_serial" class="form-control input-sm" type="text" placeholder="">
                                    <label>Warranty Expires</label>
                                    <div class="input-group">
                                    <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                    
                                    <input id="asset_warranty" class="form-control" type="date">
                                    </div>
                                         
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->

                            

                </div> 
              <!-- right column -->
               <div class="col-md-6">

                           <div class="box box-success">
                                <div class="box-header">
                                    <h3 class="box-title">Purchase Information</h3>
                                </div>
                                <div class="box-body">

<%--                                        <label>Description</label> --%>
                                        <input id="po_desc" class="form-control input-sm" type="hidden">

                                        <label>Vendor Link</label>
           
                                        <select class="form-control" id="po_vendorlist">                                                
                                        </select> 
                                                            
                                        <label>Date</label>
                                        <div class="input-group">
                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                        <input id="po_date" class="form-control" type="date"  data-inputmask="'alias': 'mm/dd/yyyy'" data-mask="infodate"/>
                                        </div>

                                        
                                   
                                        <label>Cost</label>
                                        <div class="input-group">
                                        <div class="input-group-addon"><i class="fa fa-dollar"></i></div>
                                        <input id="po_cost" class="form-control input-sm numbersOnly" type="text" placeholder="0.00">
                                        </div>

                                        

                                        <label>Salvage Value</label>
                                        <div class="input-group">
                                        <div class="input-group-addon"><i class="fa fa-dollar"></i></div>
                                        <input id="po_salvagevalue" class="form-control input-sm numbersOnly" type="text" placeholder="0.00">
                                        </div>

                                         <label>Depreciable Value</label>
                                        <div class="input-group">
                                        <div class="input-group-addon"><i class="fa fa-dollar"></i></div>
                                        <input id="po_depreciablevalue" class="form-control input-sm" readonly="true" type="text" placeholder="0.00">
                                        </div>

                                        <label>Life (in years)</label>
                                        <div class="input-group">
                                        <div class="input-group-addon"><i class="fa fa-tag"></i></div>
                                        <input id="po_lifeinyears" class="form-control input-sm numbersOnly"  type="text" placeholder="5" value="5">
                                        </div>

                                        <label>Annual Depreciation Expense</label>
                                        <div class="input-group">
                                        <div class="input-group-addon"><i class="fa fa-dollar"></i></div>
                                        <input id="po_depreciationexpense" class="form-control input-sm" readonly="true" type="text" placeholder="0.00">
                                        </div>

                                        <label>Monthly Depreciation Expense</label>
                                        <div class="input-group">
                                        <div class="input-group-addon"><i class="fa fa-dollar"></i></div>
                                        <input id="po_monthlydep" class="form-control input-sm" readonly="true" type="text" placeholder="0.00">
                                        </div>

                                       
                             
                                    <%--<div class="form-group"> 
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="optionsRadios" id="po_new" value="option1" checked>
                                                New Item
                                            </label>
                                        </div>
                                        <div class="radio">
                                            <label>
                                                <input type="radio" name="optionsRadios" id="po_used" value="option2">
                                                Used Item
                                            </label>
                                        </div>
                                       
                                    </div>--%>


                                </div><!-- /.box-body -->
                            </div><!-- /.box -->

                            <div class="box box-success">
                                <div class="box-body">
                                    <button id="btnpost" class="btn btn-primary btn-flat" style="width:80px" onclick="assetcheck();">Post</button>
                                    <button id="btnupdate" class="btn btn-primary btn-flat" style="width:80px" onclick="BankAsset.bankassetupdate();">Update</button>
                                    <button id="btnSell" class="btn btn-primary btn-flat" style="width:80px" data-toggle="modal" data-target="#sell" onclick="BankAsset.bankassetsell(1);">Sell</button>
                                    <button id="btnDispose" class="btn btn-warning btn-flat" style="width:80px" data-toggle="modal" data-target="#asset_final_dispose" onclick="BankAsset.bankassetsell(2);">Dispose</button>
                                    <button id="btnreset" class="btn btn-warning btn-flat" style="width:80px" onclick="resetthis();">Reset</button>
                                    <button class="btn btn-danger btn-flat" style="width:80px" onclick="closethis();">Close</button>                                         
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->
              

                          <%--  <div class="box box-success">
                                <div class="box-header">
                                    <h3 class="box-title">Sales Information</h3>
                                </div>
                                <div class="box-body">
                                    <label>Description</label>
                                    <input id="si_desc" class="form-control input-sm" type="text" placeholder="">
                                    <label>Date</label>
                                    <input id="si_date" class="form-control input-sm" type="text" placeholder="">
                                    <label>Cost</label>
                                    <input id="si_cost" class="form-control input-sm" type="text" placeholder="">
                                    <label>Price</label>
                                    <input id="si_price" class="form-control input-sm" type="text" placeholder="">
                                    <label>Expense</label>
                                    <input id="si_expense" class="form-control input-sm" type="text" placeholder=""><br />
                                    <label>
                                         <input type="checkbox"/>
                                                   Item is sold?
                                    </label>          
                                </div>
                            </div>--%>

                </div>
            </div>
 
       
      </section>
     </aside>
   
  </div>

    <input type="hidden"  id="ptr_id" />

      <div class="modal fade" id="sell" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-dollar"></i> Sell Asset</h4>
                    </div>                   
                        <div class="modal-body">	
                                    <div id="chkheader" style="display:none">	
                                        <%--<label>Issuing Bank</label>
							            <input type="text" id="checkBank" placeholder="" class="form-control input-sm">
                                        <label>Issued By</label>
							            <input type="text" id="checkBy" placeholder="" class="form-control input-sm">		   --%>     				        					        
							            <label>Check Number</label>
							            <input type="text" id="checkNumber" placeholder="" class="form-control numbersOnly input-sm">	                                    				        
							            <label>Date</label>
							            <input type="date" id="checkDate" class="form-control input-sm">	
                                    </div>					        
							        <label>Amount</label>
							        <input type="text" id="checkAmount" placeholder="0.00" class="form-control  numbersOnly input-sm">					        
							        <label>Reference</label>
							        <input type="text" id="checkReference" placeholder="" class="form-control input-sm">		
                                    <div id="chkheader2" style="display:none">	
							            <%--<label>Particulars</label>
							            <input type="text" id="checkParticular" placeholder="" class="form-control input-sm">	--%>
                                     </div>			        
                                    <br />
                                    <input type="button" class="btn btn-sm btn-primary" value="Cash  (change to check?)" onclick="testclk()" id="testbtn"/>	        
                                    <input type="hidden" id="checkid"/>
                        </div>
                        <div class="modal-footer clearfix">
                            <input type="hidden" id="idptr"/>
                            <button type="button" id="discard" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>
                            <button type="submit" id="postit" class="btn btn-primary pull-left" onclick="BankAsset.bankassetsell(3);"><i class="fa  fa-thumbs-o-up"></i> Post Entry</button>
                        </div>
                 
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

      <div class="modal fade" id="asset_final_dispose" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-dollar"></i> Dispose Asset</h4>
                    </div>                   
                        <div class="modal-body">	
                                    				        
							        <label>Book Value</label>
							        <input type="text" id="bookvalue" placeholder="0.00" class="form-control input-sm" readonly="true">					        
							        <label>Accumulated Depreciation</label>
							        <input type="text" id="accumudepreciation" placeholder="0.00" class="form-control input-sm"  readonly="true">		
                                    <label>Loss In Sale</label>
							        <input type="text" id="lossinsale" placeholder="0.00" class="form-control input-sm"  readonly="true">		
                                    
                                    <input type="hidden" id="Hidden1"/>
                        </div>
                        <div class="modal-footer clearfix">
                            <input type="hidden" id="Hidden2"/>
                            <button type="button" id="Button2" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>
                            <button type="submit" id="Button3" class="btn btn-primary pull-left" onclick="BankAsset.bankassetsell(4);"><i class="fa  fa-thumbs-o-up"></i> Post Entry</button>
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

        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>


       <script src="/html/js/bootbox.js" type="text/javascript"></script>
       <script src="/html/js/msgbox.js" type="text/javascript"></script>
      <script src="/html/js/accounting.min.js"></script>
       <script src="/html/js/bankasset.js" type="text/javascript"></script>
       
       <script>
         
          // GL Entry - Debit Asset - Credit AP --
          // 
         

          
        
          $('.numbersOnly').keyup(function () {
              if (this.value != this.value.replace(/[^0-9\.\$]/g, '')) {
                  this.value = this.value.replace(/[^0-9\.\$]/g, '');
              }
          });


          function assetcheck() {
              BankAsset.bankassetsave();
          }

          function resetthis() {
              $('#assetnum').val("");
             // $('#assetacct').val("");
              $('#asset_desc').val("");
              $('#asset_po').val("");
              $('#asset_serial').val("");
              $('#asset_warranty').val("");
              $('#po_desc').val("");
              $('#po_date').val("01/01/1900").prop('readOnly',false);
              $('#po_cost').val("").prop('readOnly', false);
              $('#po_new').val("");
              $('#po_salvagevalue').val("");
              $('#po_depreciablevalue').val("");
              $('#po_depreciationexpense').val("");
              $('#po_lifeinyears').val(5);
              

          }

          //console.log($('#chkischeck').is(':checked'));

          $(function () {
              $('#chkischeck').click(function () {
                      $('#chkheader').slideToggle();
                      //console.log('clicked132');
                     
              });
          });

          function testclk() {
              if ($('#testbtn').val() == 'Check (change to cash?)') {
                  $('#testbtn').val('Cash  (change to check?)');
              } else {
                  $('#testbtn').val('Check (change to cash?)');
              }
              
              $('#chkheader').slideToggle();
              $('#chkheader2').slideToggle();
          }


          BankAsset.bankassetload();
          BankAsset.bankassetinfo($('#assetacct').val())
          BankAsset.bankfixasset();

          $('document').ready(function () {
              var ll = location.href.split("?");
              //  console.log(ll);
              ll = ll[1].split("&");
              //  console.log(ll);
              if (ll[0] == null) {
                  console.log('value is null');
              } else {
                  var ll = '{"' + ll.toString().replace(/=/g, '":"') + '"}';
                  ll = JSON.parse(ll.replace(',', '","'));
                  console.log(ll.status);
                  console.log(ll.id);
                  //if (ll.status == 'sell') {
                  console.log('sell asset?');
                  sellasset(ll.id, ll.status);
                  //}
              }
          });
         

      </script>
      
      
  </body>
</html>
