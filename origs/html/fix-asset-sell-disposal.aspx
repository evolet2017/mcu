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
        <link href="/html/css/datatables/jquery.dataTables.css" rel="stylesheet" type="text/css" />  
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
     <style>
         td.details-control {
             background: url('../resources/details_open.png') no-repeat center center;
             cursor: pointer;
         }
         tr.shown td.details-control {
             background: url('../resources/details_close.png') no-repeat center center;
             
         }
     </style>

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
        <!-- h1>Fixed Asset</!-->
        <ol class="breadcrumb">
          <li>
            <a href="/Main">Home</a>
          </li>
          <li class="active">Fixed Asset</li>
        </ol>
      </section>
      <!-- Main content -->
      <section class="content">
        
        <div class="row" id="tbl_slideme">
            <div class="col-md-12">
            <div class="box box-solid">
                <div class="box-header">
                    <h2 class="box-title">Sales and Disposal</h2>
                    <%--<div class="box-tools pull-right no-print">                        
                        <button id="Button1" class="btn btn-print btn-sm" onclick="window.print();"><i class="fa fa-print"></i></button>
                    </div>--%>
                </div>
                <div class="box-body">
                    <table id="assetlisting" class="table table-condensed table-responsive table-hover">
                        <thead>
                            <tr>
                                
                                <th>Asset Code</th>
                                <th>Description</th>
                                <th>Date Purchased</th>
                                <th>Vendor</th>
                                <th>Purchase Cost</th>
                                <th>Est. Salvage Value</th>
                                <th>Current Value</th>
                                <th>Action</th>
                             <%--   <tr><th></th></tr>--%>
                               
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>
            </div>
        </div>

          <%--<div class="row" id="sell_frame">
            <div class="col-md-12">
                <div class="box box-solid">
                    <div class="box-header">
                        <h2 class="box-title">Sell Asset</h2>                    
                    </div>
                    <div class="box-body">

                    </div>
                    <div class="box-footer">
                        <button type="button" class="btn btn-danger" onclick="btn_close();">Close</button>
                    </div>
                </div>
            </div>
          </div>--%>

          <div class="row" id="dispose_frame">
            <div class="col-md-12">
                <div class="box box-solid">
                    <div class="box-header">
                        <h2 class="box-title">Dispose Asset</h2>                    
                    </div>
                    <div class="box-body">

                    </div>
                    <div class="box-footer">
                        <button type="button" class="btn btn-danger" onclick="btn_close2();">Close</button>
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
  <!-- jQuery 2.0.2 -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>

        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>


       <script src="/html/js/bootbox.js" type="text/javascript"></script>
       <script src="/html/js/msgbox.js" type="text/javascript"></script>
       <script src="/html/js/bankasset.js" type="text/javascript"></script>
       <script src="/html/js/accounting.min.js"></script>
       <script>
         
          // GL Entry - Debit Asset - Credit AP --
          // 

           BankAsset.bankassetload3(2);
          // $('#sell_frame').slideToggle();
           $('#dispose_frame').slideToggle();

           function btn_close() {

               $('#sell_frame').slideToggle();
               $('#tbl_slideme').slideToggle();

           }

           function btn_close2() {

               $('#dispose_frame').slideToggle();
               $('#tbl_slideme').slideToggle();

           }

         



      </script>
      
      
  </body>
</html>
