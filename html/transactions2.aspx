<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Debug ="true"
    ViewStateEncryptionMode="Always" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <title>MBv8 Accounting | Transactions for the day</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
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
        <!-- link href="/html/css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" / -->
	<link href="/html/css/datatables/jquery.dataTables.css" rel="stylesheet" type="text/css" />
           <script src="/html/js/jquery.min.js"></script>
                <script src="/html/js/mbphillib.js"></script>
 
		
		

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="/html/js/html5shiv.js"></script>
          <script src="/html/js/respond.min.js"></script>
        <![endif]-->
         <script runat="server">

             protected void Page_Load(object sender, EventArgs e)
             {
                 if (Request.Cookies["isactive"] != null)
                 {
                     if (Request.Cookies["isactive"].Value != "1")
                     {
                         Response.Redirect("/Main");
                     }
                 }
                 else
                 {
                     Response.Redirect("/Main");
                 }
             }


             protected void signout(object sender, System.EventArgs e)
             {
                // Response.Cookies["isactive"].Value = "0";
                // Response.Cookies["activeuser"].Value = "";
                 // Response.Redirect("/Default.aspx");
             }

        </script>

        <style type="text/css">
            .auto-style1 {
                position: relative;
                min-height: 1px;
                float: left;
                width: 64%;
                left: 0px;
                top: 0px;
                padding-left: 15px;
                padding-right: 15px;
            }
        </style>
     

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
                    <!-- search form -->
                  <!--  <form action="#" method="get" class="sidebar-form">
                        <div class="input-group">
                            <input type="text" name="q" class="form-control" placeholder="Search..."/>
                            <span class="input-group-btn">
                                <button type='submit' name='seach' id='search-btn' class="btn btn-flat"><i class="fa fa-search"></i></button>
                            </span>
                        </div>
                    </form>-->
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
                        Posted Transactions ( <%=Request.Cookies["activedate"].Value %> )
                        
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="/Main"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">View Transactions</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">
                
                    <!-- Small boxes (Stat box) -->
                       <div class="row">
                      
                      
                           
						   <div class="col-xs-12">
                        
                            
                               <div class="box">
							    <div class="box-header">
                                    <h3 class="box-title">Chronological Order</h3>                                    
                                </div><!-- /.box-header -->
                                <form id="MBPhil_transout1" runat="server">
                                <div class="box-body table-responsive">
                                    <div role="grid" class="dataTables_wrapper form-inline" id="example1_wrapper">

                                        <table class="display" cellspacing="0" width="100%" id="example1" >
                                            <thead>
                                            <tr>
											<th class="sorting" role="columnheader" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" style="width: 20px;" aria-label="Browser: activate to sort column ascending">Transaction Number</th>
											<th class="sorting_asc" role="columnheader" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" style="width: 190px;" aria-sort="ascending" aria-label="Rendering engine: activate to sort column descending">Transaction Type</th>
											<th class="sorting" role="columnheader" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" style="width: 280px;" aria-label="Browser: activate to sort column ascending">Particulars</th>
											<th class="sorting" role="columnheader" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" style="width: 160px;" aria-label="Platform(s): activate to sort column ascending">Amount</th>
											<th class="sorting" role="columnheader" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" style="width: 161px;" aria-label="Engine version: activate to sort column ascending">Status</th>
											<th class="sorting" role="columnheader" tabindex="0" aria-controls="example1" rowspan="1" colspan="1" style="width: 200px;" aria-label="Engine version: activate to sort column ascending">Reference</th>		
                                                </tr>
                                            </thead>
                
                                            <tbody role="alert" aria-live="polite" aria-relevant="all">
                                               

                                            </tbody>
										</table>
                                        <div class="col-xs-6"></div>

                                    </div>
                                    </div>
                                    <div style="display: none;">
                                    <asp:Button runat="server" ID="testme" OnClick="signout" />
                                    </div>
                                </form>
                               </div><!-- /.box-body -->
                                    
                              
                            </div><!-- /.box -->
      
                        </div>

                       <!-- ./col --> <!-- end of data-->
                        
                    <!-- Main row -->
					
               
                   
                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->


        <!-- jQuery 2.0.2 -->
        <script src="/html/js/accounting.min.js"></script>
        <script src="/html/js/bootbox.js"></script>
   
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>
        
		  <!-- DATA TABES SCRIPT -->
        <script src="/html/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <!-- script src="/html/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script -->
		
		
		
        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
        
    

        <!-- page script -->
        <script type="text/javascript">


            function loadtrans() {


                var sql = "SELECT * FROM (SELECT " +
                        "A.TrnID," +
                        "B.Description," +
                        "C.Explanation," +
                        "A.amount," +
                        "A.status," +
                        "Cast(A.v8RunDate as DateTime)  TrnDate," +
                        "A.v8RunDate, " +
                        "A.CheckNumber," +
                        "A.Reference, " +
                        "CASE A.ModuleID " +
                        "WHEN 'BK001' THEN (SELECT BankAccountNum FROM BankAccounts WHERE GLACC=A.DebitAcct) " +
                        "WHEN 'BK002' THEN (SELECT BankAccountNum FROM BankAccounts WHERE GLACC=A.DebitAcct) " +
                        "END BankDesc " +
                        "FROM MasterTRN A " +
                        "LEFT JOIN Modules B on A.ModuleID=B.ModuleID " +
                        "LEFT JOIN GLEntry C on A.GLTrnType=C.GLtrntype AND A.ModuleID=C.ModuleID " +
                        "WHERE 1=1 and A.v8RunDate=(select mbvalue from appconfig where mbfield1='sysdate') AND C.Status = 1) X " +
                        "WHERE X.status IN ('1','99') ";


                //console.log(sql);

                $.ajax({
                    type: "post",
                    url: MB.URLPoster(),
                    data: { SQLStatement: sql },
                    success: function (result) {
                        //console.log(result);
                        $.each(JSON.parse(result), function (key, value) {
                            var tr = "<tr>";
                            var bnk = "";
                            if (value.BankDesc != null) {
                                bnk = ' - #' + value.BankDesc;
                            }


                            tr += "<td class=' '>" + value.TrnID + "</td>";
                            tr += "<td class=' sorting_1'>" + value.Description + "</td>";
                            tr += "<td class=' '>" + value.Explanation + bnk + "</td>";
                            tr += "<td class=' '>" + accounting.formatMoney(value.amount) + "</td>";
                            if (value.status == 1) {
                                tr += "<td><a href='#' onclick=checkid('" + value.TrnID + "')><span class='label label-success'>Posted</span></a></td>";
                            } else {
                                tr += "<td><a href='#' onclick=checkid('" + value.TrnID + "')><span class='label label-warning'>Canceled</span></a></td>";
                            }
                            if (value.CheckNumber == 0) {
                                tr += "<td class=' '>" + value.Reference + "</td>";
                            } else {
                                tr += "<td class=' '> Check# " + value.CheckNumber + "</td>";
                            }
                            tr += " </tr>";
                            $('#example1').append(tr);



                        });
                        $(function () {
                            $("#example1").dataTable( {
        "scrollY":        "200px",
        "scrollCollapse": true,
        "paging":         false
    });
                            
			    //$('#example2').dataTable({
                            //    "bPaginate": true,
                            //    "bLengthChange": false,
                            //    "bFilter": false,
                            //    "bSort": true,
                            //    "bInfo": true,
                            //    "bAutoWidth": false
                            //});
                        });
                    }
                });
            }

            function checkid(T) {
                console.log(T);
                $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
                    {
                        SQLStatement : "SELECT Status as VS,Remarks FROM MasterTRN WHERE TrnID="+T
                    }, function (data) {
                        // var Y = eval('(' + data+ ')');
                        var S = data.replace("[", "").replace("]", "");
                        var Y = $.parseJSON(S);


                        switch (($.parseJSON(S)).VS) {
                            case 99: bootbox.alert("Transaction already canceled with [Remarks]<br><h3>"+Y.Remarks+"</h3>"); break;
                            case 1: { var vhtml = '<input type=text id="remarks1" placeholder="Remarks here.." size=70 /><br>';
                                    bootbox.dialog({
                                        message: vhtml,
                                        title: "Action - Reason for cancel transaction?",
                                        buttons: {
                                            danger: {
                                                label: "Cancel Entry",
                                                className: "btn-danger",
                                                callback: function () {
                                                    //console.log("UPDATE MasterTRN SET Status=99,Remarks='" + $('#remarks1').val() + "' WHERE TrnID=" + T);
                                                    var sv = "select CreditAcct,CheckNumber from MasterTRN WHERE TrnID=" + T;
                                                    var rets = $.post(MB.URLPoster(), { SQLStatement: sv });
                                                    rets.done(function (data) {
                                                       // console.log(data);
                                                        var res = JSON.parse(data);
                                                        //console.log(res[0].CheckNumber);
                                                        if (res[0].CheckNumber > 0) {
                                                            console.log("UPDATE BankChecks SET v8RunDate=NULL,TAG=0,Amount=NULL,IssuedTo=NULL,Userid=NULL,Particulars=NULL,TransDesc=NULL,CheckDate=NULL WHERE GLACC='" + res[0].CreditAcct + "' AND CheckID='" + res[0].CheckNumber + "'");
                                                            MB.push("UPDATE MasterTRN SET Status=99, Remarks='" + $('#remarks1').val() + "' WHERE CheckNumber='" + res[0].CheckNumber + "' AND CreditAcct='" + res[0].CreditAcct + "' AND TrnID=" + T);
                                                            MB.push("UPDATE BankChecks SET v8RunDate=NULL,TAG=0,Amount=NULL,IssuedTo=NULL,Userid=NULL,Particulars=NULL,TransDesc=NULL,CheckDate=NULL WHERE GLACC='" + res[0].CreditAcct + "' AND CheckID='" + res[0].CheckNumber + "'");
                                                            MB.push("UPDATE BankPayables SET status=0 WHERE MasterTrnID=" + T);
                                                        } else {
                                                            MB.push("UPDATE MasterTRN SET Status=99,Remarks='" + $('#remarks1').val() + "' WHERE TrnID=" + T);
                                                            //MB.push("UPDATE BankPayables SET status=0 WHERE MasterTrnID=" + T);
                                                        }
                                                        $('#example1').dataTable().fnClearTable();
                                                        $('#example1').dataTable().fnDestroy();
                                                        
                                                        $('#example1 > tbody').html('');

                                                        loadtrans();
                                                        //window.location = "/Transaction";
                                                        //MB.push("UPDATE BankChecks SET v8RunDate=NULL,TAG=0,Amount=NULL,IssuedTo=NULL,Userid=NULL,Particulars=NULL,TransDesc=NULL,CheckDate=NULL WHERE GLACC= (SELECT CreditAcct FROM INSERTED) AND CheckID='" + res[0].CheckNumber + "'");

                                                        

                                                    }
                                                        );
                                                    

                                                    //$.post(MB.URLPoster(),  
                                                    //    {
                                                    //        SQLStatement: "UPDATE MasterTRN SET Status=99,Remarks='" + $('#remarks1').val() + "' WHERE TrnID=" + T
                                                    //    }, function () { }).done(function () { window.location = "/Transaction"; }).fail(function () { alert("error"); });
                                                }
                                            },
                                            main: {
                                                label: "Exit",
                                                className: "btn-primary",
                                                callback: function () {
                                                    console.log("Primary button");
                                                }
                                            }
                                        }
                                    });

                                }
                        }
                       
                        
                    });
                
            }

            loadtrans();

            
        </script>


        
		
   
    </body>
    
</html>