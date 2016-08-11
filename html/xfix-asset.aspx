<%@ Page Language   ="C#" 
    AutoEventWireUp ="true"  %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


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
        <link href="/html/css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="/html/css/daterangepicker/daterangepicker-bs3.css" rel="stylesheet" type="text/css" />
        <link href="/html/css/jQueryUI/jquery-ui-1.10.4.custom.css" rel="stylesheet" type="text/css" />

        <link rel="stylesheet" type="text/css" href="/html/js/plugins/datepick/jquery.datepick.css"> 


        <script src="/html/js/jquery.js"></script>

        <script src="/html/js/mbphillib.js"></script>
        <script src="/html/js/bootbox.js"></script>

     <script type="text/javascript" src="/html/js/plugins/datepick/jquery.plugin.js"></script> 
<script type="text/javascript" src="/html/js/plugins/datepick/jquery.datepick.js"></script>

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
            <p>Hello, <%  Response.Write(Request.Cookies["activeuser"].Value); %></p>
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
  
        <div class="row">
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
                                     <div class="form-group">                                           
                                            <select class="form-control" id="assetacct" onchange="BankAsset.bankassetinfo(this.value)">
                                                
                                            </select>
                                          <div class="box-body">
                                       <%-- <table>
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
                                    
                                        </table>--%>
                                   
                                    
                                    </div>
                                       </div>
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
                                    
                                    <input id="asset_warranty" class="form-control" type="text" placeholder="" >
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
                                    <label>Description</label>
                                    <input id="po_desc" class="form-control input-sm" type="text" placeholder="">
                        
                                    
                                         <label>Date</label>
                                        <div class="input-group">
                                        <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                                        <input id="po_date" class="form-control" data-inputmask="'alias': 'mm/dd/yyyy'" data-mask="infodate"/>
                                        </div>
                            
                                        <label>Cost</label>
                                        <div class="input-group">
                                        <div class="input-group-addon"><i class="fa fa-dollar"></i></div>
                                        <input id="po_cost" class="form-control input-sm numbersOnly" type="text" placeholder="">
                                        </div>
                             
                                    <div class="form-group"> 
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
                                       
                                    </div>


                                </div><!-- /.box-body -->
                            </div><!-- /.box -->

                            <div class="box box-success">
                                <div class="box-body">
                                    <button class="btn btn-primary btn-flat" style="width:80px" onclick="assetcheck();">Post</button>
                                    <button class="btn btn-primary btn-flat" style="width:80px" onclick="resetthis();">Reset</button>
                                    <!-- button class="btn btn-primary btn-flat" style="width:80px"  data-toggle='modal' data-target='#fixmanager'>Browse</!-->
                                         
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

      <div class="modal fade" id="fixmanager" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-dollar"></i>Fix Assets</h4>
                    </div>
                        <div class="box-body">
                            <table class="table table-bordered" id="tblsharewith">
                                <thead>
                                    <tr>
                                    <th>col1</th>
                                    <th>col1</th>
                                    </tr>
                                </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>2</td>
                                </tr>
                                 <tr>
                                    <td>1</td>
                                    <td>2</td>
                                </tr>
                                 <tr>
                                    <td>1</td>
                                    <td>2</td>
                                </tr>
                            </tbody>
                            </table>
                        </div>
                        <div class="modal-footer clearfix">
                            <input type="hidden" id="idptr"/>
                            <button type="button" id="discard" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="submit" id="postit" class="btn btn-primary pull-left" onclick="BankDisburse.bankdisbursesave();"><i class="fa  fa-thumbs-o-up"></i> Post Entry</button>
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
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>

        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>


       <script src="/html/js/bootbox.js" type="text/javascript"></script>
       <script src="/html/js/msgbox.js" type="text/javascript"></script>
      <script src="/html/js/bankasset.js" type="text/javascript"></script>
      <script>
         
          // GL Entry - Debit Asset - Credit AP --
          // 
         
          $('#asset_warranty').datepick();
          $('#po_date').datepick();
          BankAsset.bankassetload();
          BankAsset.bankassetinfo($('#assetacct').val())
        
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
              $('#po_date').val("");
              $('#po_cost').val("");
              $('#po_new').val("");

          }
      </script>
      
      
  </body>
</html>
