<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Debug="true"
    Inherits="index"
    ViewStateEncryptionMode="Always" CodeFile="index.aspx.cs" EnableSessionState="True" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>MBv8 Accounting | Dashboard</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <!-- bootstrap 3.0.2 -->
        <link href="/html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- font Awesome -->
        <link href="/html/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="/html/css/ionicons.min.css" rel="stylesheet" type="text/css" />
        
  
        <!-- Theme style -->
        <link href="/html/css/AdminLTE.css" rel="stylesheet" type="text/css" />

        <style>
            .panel {
                margin: 0 auto;
                width: 130px;
                height: 130px;  
                position: relative;
                font-size: .8em;
                -webkit-perspective: 600px;
                -moz-perspective: 600px;
            }
            .small-box .front {
                position: absolute;
                top: 0;
                z-index: 900;
                width: inherit;
                height: inherit;
                text-align: center;
            }
            .panel .back {
                position: absolute;
                top: 0;
                z-index: 800;
                width: inherit;
                height: inherit;
            }
        </style>


        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="/html/js/html5shiv.js"></script>
          <script src="/html/js/respond.min.js"></script>
        <![endif]-->

         <!-- jQuery 2.0.2 -->
        <script src="/html/js/jquery.js"></script>
        <script src="/html/js/bootbox.js"></script>
        <script src="/html/js/mbphillib.js"></script>    
        <script src="/html/js/MBv8Index.js" type="text/javascript"></script>    
                  
    </head>
    <body class="skin-black"  runat="server">
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
                        <div class="pull-left image">
                            <!-- img src="/html/img/img.img" class="img-circle" alt="User Image" / -->
                        </div>
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
                    <h1>
                         ( <%=Request.Cookies["activedate"].Value %> ) - Customer Transaction
                        <small>Control panel</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="/Main"><i class="fa fa-dashboard"></i>Home</a></li>
                        <li class="active">Dashboard</li>
                    </ol>
                </section>
             
                  

                <!-- Main content -->
                <section class="content">
                    <!-- Small boxes (Stat box) -->
                    <div class="row">
                        
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            
                            <div  ID="cash"   onmouseover="mover();" onmouseout="mout();" class="hover small-box bg-green"   onclick='processClick(this)'>
                             
                                <div class="inner">
                                    <h2>
                                       <span ID="CASHDP"></span>
                                    </h2>
                                    <p>
                                        <span id="mmsg"></span><br />
                                    </p>
                                </div>
                                <a href="#" class="small-box-footer">
                                    More info <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div><!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div ID="checks" class="small-box bg-yellow" onclick='processClick(this)'>
                                <div class="inner">
                                    <h2>
                                        <span ID="CHECKDP"></span> 
                                    </h2>
                                    <p>
                                        Checks Received
                                    </p>
                                </div>
                             
                                <a href="#" class="small-box-footer">
                                    More info <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div><!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div id="disburse" class="small-box bg-red"  onclick='processClick(this)'>
                                <div class="inner">
                                    <h2>
                                        <span ID="PAYABLESDP"></span> 
                                    </h2>
                                    <p>
                                        Loan Disbursement
                                    </p>
                                </div>
                               
                                <a href="#" class="small-box-footer">
                                    More info <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div><!-- ./col -->
                         <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div ID="shares" class="small-box bg-maroon"  onclick='processClick(this)'>
                                <div class="inner">
                                    <h2>
                                        <span ID="SHAREDP"></span> 
                                    </h2>
                                    <p>
                                        Share Withdrawals
                                    </p>
                                </div>
                               
                                <a href="#" class="small-box-footer">
                                    More info <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div><!-- ./col -->
                    </div><!-- /.row -->
                    <!-- Title for Payable -->
                    <div class="row">
                        <h3 class="box-title"><span>&nbsp;&nbsp; Outstanding Accounts Payable</span></h3>

                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div ID="po-purchases" class="small-box bg-navy" onclick='processClick(this);'>
                                <div class="inner">
                                    <h2>
                                       <span ID="PURCHASE"></span>
                                    </h2>
                                    <p>
                                        Purchase(s)
                                    </p>
                                </div>
                               
                                <a href="#" class="small-box-footer">
                                    More info <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div><!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div ID="bills-payment" class="small-box bg-purple" onclick='processClick(this);'>
                                <div class="inner">
                                    <h2>
                                       <span ID="BILLS"></span>
                                    </h2>
                                    <p>
                                        Bills Payment
                                    </p>
                                </div>
                               
                                <a href="#" class="small-box-footer">
                                    More info <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div><!-- ./col -->
                       
                    </div>

                    <div class="row">
                        <h3 class="box-title"><span>&nbsp;&nbsp; Operations</span></h3>

                    </div>

                     <div class="row">
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div ID="cashadv" class="small-box bg-blue" onclick='processClick(this);'>
                                <div class="inner">
                                    <h2>
                                       <span ID="CADVANCE"></span>
                                    </h2>
                                    <p>
                                        Cash Advance
                                    </p>
                                </div>
                               
                                <a href="#" class="small-box-footer">
                                    More info <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div><!-- ./col -->
                        <div class="col-lg-3 col-xs-6">
                            <!-- small box -->
                            <div ID="pettycash" class="small-box bg-olive" onclick='processClick(this);'>
                                <div class="inner">
                                    <h2>
                                       <span ID="PETTYCASH"></span>
                                    </h2>
                                    <p>
                                        Replenish Petty Cash
                                    </p>
                                </div>
                               
                                <a href="#" class="small-box-footer">
                                    More info <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div><!-- ./col -->
                         <%--<div class="col-lg-3 col-xs-6">
                
                            <div ID="payroll" class="small-box bg-light-blue" onclick='processClick(this);'>
                                <div class="inner">
                                    <h2>
                                       <span ID="PAYROLL"></span>
                                    </h2>
                                    <p>
                                        Payroll
                                    </p>
                                </div>
                               
                                <a href="#" class="small-box-footer">
                                    More info <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>--%>
                       
                    </div>
                    
                    <div class="row">
                       
                    </div>
                </section><!-- /.content -->


                                       
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->



        <input type="hidden" id="depositvalue" value="" />
        <input type="hidden" id="checkvalue" value="" />
        <input type="hidden" id="payablevalue" value="" />
        <input type="hidden" id="sharevalue" value="" />
        <input type="hidden" id="billsvalue" value="" />
        <input type="hidden" id="purchasevalue" value="" />
        <input type="hidden" id="cadvancevalue" value="" />
        <input type="hidden" id="pettycashvalue" value="" />
        <input type="hidden" id="payrollvalue" value="" />
        <input type="hidden" id="totalcashdeposit" value="" />




        <!-- jQuery UI 1.10.3 -->
        <script src="/html/js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>

        <!-- Added Chart outside from AdminLTE framework -->
        <script src="/html/js/d3.min.js"></script>
        <script src="/html/js/Donut.js"></script>

        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
        
        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <!-- script src="/html/js/AdminLTE/dashboard.js" type="text/javascript"></!-->  

        <!-- DATA TABES SCRIPT -->
        <script src="/html/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="/html/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
        <script src="/html/js/accounting.min.js" type="text/javascript"></script>
		
        <script>

            updateDashData("0.00", "0.00", "0.00", "0.00");
            updateDashExpense("0.00", "0.00");
            updateOperation("0.00", "0.00", "0.00");

            window.onload = reloadTrix();


            htl90912788928390();
            //var ss = <///%=Session.Timeout %> +0;
            $.ajax({
                type: "post",
                url: MB.URLPoster(),
                data : { SQLStatement : "SELECT SUM(Amount) amt FROM MasterTRN WHERE Status=1 AND ModuleID='BK001' AND v8RunDate="+MB.getCookie("sysdate") },
                success: function (result) {
                    //console.log(result);
                    $.each(JSON.parse(result), function (key, value) {
                        $('#totalcashdeposit').val(accounting.formatMoney(value.amt));
                    });
                   
                }
            });

            $('#mmsg').append("Cash Received");

            function mover() {
                //var vv = 0;
                var rets = $.post(MB.URLPoster(), { SQLStatement: "SELECT ISNULL(SUM(Amount),0) amt FROM MasterTRN WHERE Status=1 AND ModuleID='BK001' AND v8RunDate=" + MB.getCookie("sysdate") });
                rets.success(function (data) {
                    var ss = JSON.parse(data);
                 //   console.log(ss);
                    if (ss[0].amt > 0) {
                        document.getElementById('mmsg').innerHTML = 'Total Cash Deposited : ' + accounting.formatMoney(ss[0].amt);
                    } else {
                        document.getElementById('mmsg').innerHTML = 'Total Cash Deposited : $0.00';
                    }                    
                });

                //$.ajax({
                //    type: "post",
                //    url: MB.URLPoster(),
                //    data: { SQLStatement: "SELECT SUM(Amount) amt FROM MasterTRN WHERE Status=1 AND ModuleID='BK001' AND v8RunDate=" + MB.getCookie("sysdate") },
                //    success: function (result) {
                        
                //        $.each(JSON.parse(result), function (key, value) {
                //            $('#totalcashdeposit').val(accounting.formatMoney(value.amt));
                //        });

                //    }
                //});
                //document.getElementById('mmsg').innerHTML = 'Total Cash Deposited : '+$('#totalcashdeposit').val();
                //$('#mmsg').append($('#totalcashdeposit').val());
            }

            function mout() {
                document.getElementById('mmsg').innerHTML = 'Cash Received';
            }
            //document.getElementById('cash').title = "test";
            

            //console.log(ss);
            //console.log(cc);
            //console.log(nn);
            //console.log(zz);
            //console.log(nn - cc);
            //console.log(cc);

        </script>
    
        

     

    </body>
</html>