<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Inherits="fundtransfer"
    ViewStateEncryptionMode="Always" CodeFile="fund-transfer.aspx.cs" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="DashBoard" %>



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

       <script src="/html/js/jquery.js"></script>

      <script src="/html/js/bootbox.js"></script>
      

        <script src="/html/js/mbphillib.js"></script>
   
       <script src="/html/js/banktransfer.js"></script>
		
		

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="/html/js/html5shiv.js"></script>
          <script src="/html/js/respond.min.js"></script>
        <![endif]-->
        <script runat="server">

           

        </script>
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
        <h1>Fund Transfer</h1>
        <ol class="breadcrumb">
          <li>
            <a href="/Main"><i class="fa fa-dashboard"></i> Home</a>
          </li>
          <li class="active">Fund Transfer</li>
        </ol>
      </section>
      <!-- Main content -->
      <section class="content">
        <div class="row">
          <div class="col-md-12">
            <div class="box box-primary">
              <div class="box box-primary">
                <!--<div class="box-header">
                  <h3 class="box-title">Post Deposit Transaction</h3>
                </div>-->
              </div>
			   
			    <!-- form role="form" -->
			      <div class="box-body">
            
            
                  <div class="form-group">
                  <label for="" class="text-blue">FROM Bank Account</label> 
                  <select class="form-control input-lg" id="trncredit">
               
                    <!--option>Bank of Guam - Savings Acct#111111-11111-111</option>
                    <option>Bank of FSM - Current Acct# 33345-6675-3455</option>
                    <option>Bank of FSM Time Deposit Acct# 234-567-4222</option -->
                  </select></div>
                  <!-- form-group-->
                   <div class="form-group">
                  <label for="" class="text-green">TO Bank Account</label> 
                  <select class="form-control input-lg" id="trndebit">                 
                  </select></div>
                  <!-- form-group-->
                
                  <label class="">Amount</label> 
                  <input class="form-control input-lg numbersOnly" type="text" id="trnAmount" placeholder="$0.00" />
                  <!-- form group-->
               
                  <label class="">Transaction Reference</label> 
                  <input class="form-control input-lg" type="text" id="trnReference" placeholder="" />
                  <!-- form group-->
                  <label class="">Particulars</label> 
                  <input class="form-control input-lg" type="text" id="trnParticulars" placeholder="" />
                  <!-- form group-->
                  <label class="">Bank Charges</label>

                  <span id="WcSW"></span>
                  <input class="form-control input-lg numbersOnly" type="text" id="trnCharges" placeholder="" />
                  
				
                </div>
				
				<div class="box-footer">
				  <button class="btn btn-primary " onclick="BankTransfer.posttransfer();">Post</button>	
                  <button class="btn btn-danger  " onclick="BankTransfer.BAIL();">Cancel</button> </div>

                <form id="ftform" runat="server">
                    <div style="display: none;">
                                    <asp:Button runat="server" ID="testme" OnClick="signout" />
                                    </div>

              </form> 
           
            </div>
          </div>
          <!-- end of row-->
        </div>

        <!-- wrapper -->
      </section>
    </aside>
  </div>
  <!-- Main row -->
  <!-- /.content -->
  <!-- /.right-side -->
  <!-- ./wrapper -->
  <!-- add new calendar event modal -->
  <!-- jQuery 2.0.2 -->
       
        <!-- jQuery UI 1.10.3 -->
        <script src="/html/js/jquery-ui-1.10.3.js" type="text/javascript"></script>
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>

      
        <!-- Bootstrap WYSIHTML5 -->
        <script src="/html/js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>
        <!-- iCheck -->
        <script src="/html/js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>

        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
      <script>
          BankTransfer.transferbanklist();
          $('.numbersOnly').keyup(function () {
              if (this.value != this.value.replace(/[^0-9\.\$]/g, '')) {
                  this.value = this.value.replace(/[^0-9\.\$]/g, '');
              }
          });

          var SQL = "select ";
              SQL += "ISNULL((select mbvalue from appconfig where mbfield1='WTC'),0) WithTransferCharge,";
              SQL += "ISNULL((select mbvalue from appconfig where mbfield1='WTCAMT'),12) WithTransferChargeAmount";
          
              var rets = $.post(MB.URLPoster(), { SQLStatement: SQL });
              rets.success(function (data) {
                  //console.log(data);
                  var value = $.parseJSON(data);
                  //console.log(value[0].WithTransferCharge);
                  //console.log(value[0].WithTransferChargeAmount);
                  $('#trnCharges').val(value[0].WithTransferChargeAmount);
                  //document.getElementById('trnWithCharge').value = value[0].WithTransferCharge;
                  document.getElementById('WcSW').innerHTML = '<input type="checkbox" id="trnWithCharge" />';
                  if (value[0].WithTransferCharge == 1) {
                    
                      document.getElementById('WcSW').innerHTML = '<input type="checkbox" id="trnWithCharge" checked />';
                      console.log('check');
                      //  document.getElementById('trnWithCharge').defaultChecked = true;
                      // $('#trnWithCharge').prop('checked', true);
                     // $("input[type=checkbox]").prop("checked", true);
                  }


              });


 

      </script>

  
  </body>
</html>
