<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Inherits="checkinventory"
    ViewStateEncryptionMode="Always" CodeFile="check-inventory.aspx.cs" %>



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
        <!-- Theme style -->
        <link href="/html/css/AdminLTE.css" rel="stylesheet" type="text/css" />
	     <!-- DATA TABLES -->
        <link href="/html/css/jQueryUI/jquery-ui-1.10.4.custom.css" rel="stylesheet" type="text/css" />

        <link href="/html/css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="/html/css/datatables/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    
    
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
        <h1>Checkbook Inventory</h1>
        <ol class="breadcrumb">
          <li>
            <a href="/Main">Home</a>
          </li>
          <li class="active">Checkbook Inventory</li>
        </ol>
      </section>
      <!-- Main content -->
      <section class="content">

        <div class="row" id="mainchkinv">
          <div  class="col-md-12">
           
		   <div class="nav-tabs-custom">
			   
						   <ul class="nav nav-tabs">
											  <li class="active"><a data-toggle="tab" href="#tab_1">List of Checks Books</a></li>
											  <li class=" "><a data-toggle="tab" href="#tab_2">New Checkbook</a></li>
							</ul>			   
							<div class="tab-content">	
			   
	
							<div id="tab_1" class="tab-pane active">
									<div class="panel box box-success">
													<div class="box-header">
													<%--<h3 class="box-title">Checkbook Inventory</h3>--%>
													</div><!-- /.box-header -->
													
													
													<div class="box-body">
														<table id="chkinv" class="table table-bordered table-striped">
                                                            <thead>
															<tr>
															
																<th>Bank Account</th>
																<th>Bank Name</th>
																<th>Series</th>
																<th>Total Checks</th>
																<th>Issued</th>
																<th>Remaining</th>
																<th>Date Created</th>
																<th>Status</th>
																<th>Encoded by</th>
																
																</tr>
                                                            </thead>
                                                            <tbody>
															
														    </tbody>
														</table>
                                                         
													</div><!-- /.box-body -->
													
									 </div><!-- /.box -->
							</div><!-- end of tab 1-->
									
							<div id="tab_2" class="tab-pane">
											<div class="panel box box-primary">
													<div class="box-header">
													<h3 class="box-title">Checkbook Details</h3>
													
													</div><!-- /.box-header -->
                                
														<!-- form start -->
                                                            
										
																															
															<div class="form-group">
															  <label for="">Bank Account</label> 
															  <select id="frmCheckBank" class="form-control input-lg" onclick="BankChecks.bankcheckinfo(this.value)">
                                                         
                                                              </select>
                                                                <br />
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
                                    
                                                                    </table>
                                   
                                    
                                                            </div><!-- /.box-body -->

                                                            
																
															<br />
																	<label>Start Of Series</label>
																	<input type="text" id="StartSeries" placeholder="" class="form-control numbersOnly">
															<br />
																	<label>End Of Series</label>
																	<input type="text" id="EndSeries" placeholder="" class="form-control numbersOnly">
														



														   
														   <div class="box-footer">
                                        <button class="btn btn-primary" type="button" onclick="BankChecks.bankchecksave()">Save</button>
                                    </div>
					   
								
									        </div> <!-- panel box primary -->
							</div><!-- end of tab 2-->
															
									
							</div><!-- tab content -->
							
		   </div> <!-- nav tabs -->
		      
           </div>
          <!-- end of row-->
        </div>

        </div>


        <div class="row" id="checkinvlist" style="display:none;">
            <div class="col-md-12">
                <div class="box box-solid">
                    <div class="box-header">
                          <h4>&nbsp;&nbsp;Check Used Listing</h4> 
                    </div>
                </div>
                <div class="box-body">
                    <table class="table table-condensed">
                        <tr>
                            <td width="20%">Bank Account</td>
                            <td><span id="tbl_account"></span></td>
                        </tr>
                        <tr>
                            <td>Description</td>
                            <td><span id="tbl_description"></span></td>
                        </tr>
                        <tr>
                            <td>Series</td>
                            <td><span id="tbl_series"></span></td>
                        </tr>
                        <tr>
                            <td>Balance</td>
                            <td><span id="tbl_balance"></span></td>
                        </tr>
                    </table>
                    <br />
                 
                    <table id="tbl_chklisting" class="table table-condensed" width="100%" cellspacing="0" >
                        <thead>
	                        <tr>
                                <th>#</th>
		                        <th>Check No</th>
		                        <th>Issued to</th>
		                        <th>Check Date</th>
		                        <th>Particulars</th>
		                        <th>Description</th>
		                        <th>Amount</th>
		                        <th>Process By</th>                                  
	                        </tr>
                        </thead>
                        <tfoot></tfoot>
                    <tbody></tbody>

                    </table>
                    <input type="hidden" id="chkidd" />
         
                    
                </div>
                <br /><br />
                
                
                <div class="box-footer">
		<button id="btnchklisting" class="btn btn-primary" type="button" onclick="BankChecks.bankcheckdisplaylist();">Close</button>
                <button id="btncancelselect" class="btn btn-warning" type="button"  >Cancel/Recall Selection</button>
		        </div>
            </div>

          
        </div>

       

	
        <!-- wrapper -->
      </section>
     </aside>
   
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
  <!-- jQuery 2.0.2 -->
        <script src="/html/js/jquery.js"></script>
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>

        
        <script src="/html/js/bootbox.js"></script>
        <script src="/html/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="/html/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
        
      

     
        

        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>

      <!-- jQuery Knob -->
        <script src="/html/js/plugins/jqueryKnob/jquery.knob.js" type="text/javascript"></script>
       

       <script src="/html/js/bootbox.js" type="text/javascript"></script>
       <script src="/html/js/msgbox.js" type="text/javascript"></script>
      <script src="/html/js/bankchecks.js" type="text/javascript"></script>
       <script src="/html/js/accounting.min.js" type="text/javascript"></script>
      <script src="/html/js/jquery.peity.min.js" type="text/javascript"></script>

      <script>
          BankChecks.bankcheckload();
          BankChecks.bankchecklist();
         $('#tbl_chklisting').dataTable();
          
          $('.numbersOnly').keyup(function () {
              if (this.value != this.value.replace(/[^0-9\.\$]/g, '')) {
                  this.value = this.value.replace(/[^0-9\.\$]/g, '');
              }
          });

         
          $('#btncancelselect').click(function () {
              //;
              bootbox.alert('Updating of check status is per active page only!', function () {

                  var checkboxes = document.getElementsByName('checkbox[]');
                  console.log(checkboxes);
                  var nn = 0;
                  for (var i = 0, n = checkboxes.length; i < n; i++) {
                      if (checkboxes[i].checked) {
                          console.log(checkboxes[i].value);
                          var vals = checkboxes[i].value;
                          var arr = vals.split("::");
                          if (arr[2] == 0) {
                              MB.push("UPDATE BankChecks SET Tag=2 WHERE GLACC='" + arr[0] + "' AND CheckID='" + arr[1] + "'");
                          } else {
                              MB.push("UPDATE BankChecks SET Tag=0 WHERE GLACC='" + arr[0] + "' AND CheckID='" + arr[1] + "'");
                          }

                      }
                  }
                  location.reload();

              });
              
              
              
          });
          

      </script>
      
  </body>
</html>
