<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" %>
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
        <h1>Bank Reconciliation Report</h1>
        <ol class="breadcrumb">
          <li>
            <a href="/Main"><i class="fa fa-dashboard"></i> Home</a>
          </li>
          <li class="active">Bank Reconciliation Report</li>
        </ol>
      </section>
      <!-- Main content -->
      <section class="content">
            <div class="row">
                    <div class="col-md-12">
                        <div class="box box-solid">
                            <div class="box-header">
                                
                            </div>
                            <div class="box-body">
                                <table class="table table-bordered" id="reconrpttbl">
                                    <thead>
                                        <th>#</th>
                                        <th>Recon Date</th>
                                        <th>Account</th>
                                        <th style="display:none"></th>
                                        <th></th>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                                
                            </div>
                        </div>
                    </div>
            </div>
          
        


        <!-- /div -->              			
        <!-- end of row-->
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
            function reconprint(x)
            {
                var y=parseInt(x)-1, tblrow = $('#reconrpttbl').dataTable().fnGetNodes(),
                tblitem = $(tblrow[y]).find("td:eq(3)").html(),
                param = tblitem.split(":");
                console.log(param[0]);
                 console.log(param[1]);
                  console.log(param[2]);
        
                console.log('print view? '+x+' with tblitem? '+tblitem);
                
                var rpturl = "http://" + location.host + "/reportsvc/default.aspx?",
                parameter = 'recon2=1&report=recon2.rpt&param0='+param[0]+'&param1='+param[1]+'&param2='+param[2];
                
                
                window.open(rpturl+parameter);
           /*
                document.write('<object width="100%" height="100%" type="application/pdf" data="' + rpturl + 'recon2=1&report=recon2.rpt&param0='+param[0]+'&param1='+param[1]+'&param2='+param[2]+'" id="pdf_content">' +
                                '<p>Pdf Generation Error</p>' +
                                '</object>');
                
           */                            
                
            }
            function recondelete(x)
            {
               // console.log('delete '+x);
                var y=parseInt(x)-1, tblrow = $('#reconrpttbl').dataTable().fnGetNodes(),
                tblitem = $(tblrow[y]).find("td:eq(3)").html(),
                sql = "SELECT id,masterid FROM BankRecon2 WHERE CONCAT(reconsdate,':',reconedate,':',bankgl) = '"+tblitem+"'";
                console.log(sql);
                //return;
                bootbox.confirm("Are you sure?", function(yesdelete){
                    if(yesdelete)
                    {
                        // reverse transaction to mastertrn
                        // perform SOAUpdate based to postdate
                        
                        //console.log('deleted :'+sql);   
                        retval = $.post(MB.URLPoster(), { SQLStatement: sql });
                        retval.success(function(data){
                            $.each(JSON.parse(data), function(key,value) {
                                //
                                
                                 $.ajax({
                                    type: "POST",
                                    url: MB.URLPoster(),
                                    data: { SQLStatement:  "DELETE FROM BankRecon2 WHERE ID = "+value.id },
                                    async : false,
                                    success : function(data) { 
                                        console.log('success exec service charge table');
                                        if(value.masterid)
                                        {
                                            MB.post("UPDATE MasterTRN SET Status = 99 WHERE TrnID = (select MasterID from BankAccTrn where id = "+value.masterid+")");
                                            console.log("UPDATE MasterTRN SET Status = 99 WHERE TrnID = (select MasterID from BankAccTrn where id = "+value.masterid+")");
                                        }
                                
                                    }
                                }).fail(function(){
                                    console.log('error on delete recon : '+sql);
                                });
                
                                // MB.push("DELETE FROM BankRecon2 WHERE ID = "+value.id);
                                //console.log("DELETE FROM BankRecon2 WHERE ID = "+value.id);
                                
                                //$.post(MB.URLPoster(), { SQLStatement: "DELETE FROM BankRecon2 WHERE ID = "+value.id });
                            });
                            //location.reload();
                            
                            
                        });
                        //location.reload();
                        retval.error(function(data){
                            console.log(data);
                        });
                        
                        retval.complete(function(){
                            bootbox.alert("Complete..",function(){location.reload();});
                        });
                    }
                });
                //console.log(sql);
            }

            function loadrecon()
            {
                console.log('loadrecon');
                sql  = "SELECT A.reconsdate,A.reconedate,dbo.NUM2DATE(A.reconsdate) AA,dbo.NUM2DATE(A.reconedate) BB,A.bankgl,A.userid,B.BankName,B.BankAccountNum FROM BankRecon2 A ";
                sql += "LEFT JOIN BankAccounts B ON A.bankgl = B.GLACC ";
                sql += "GROUP BY reconsdate,reconedate,bankgl,A.userid,BankName,BankAccountNum";
               // console.log(sql);    
                retval = $.post(MB.URLPoster(), { SQLStatement: sql });
                
                retval.success(function(data){
                    //console.log(data);
                    //var tt = "1/1/1900",
                   // xx = (new Date(tt)).getTime();
                   $.each(JSON.parse(data), function (key, value) {
                        //reconrpttbl
                        tr = "<tr>";
                        tr += "<td>" + (key+1) + "</td>";
                        tr += "<td>" + value.AA + " - " + value.BB + "</td>";
                        tr += "<td>" + value.BankName + " (" + value.BankAccountNum + ")" + "</td>";
                        tr += "<td style='display:none'>" + value.reconsdate + ":" + value.reconedate + ":" + value.bankgl + "</td>";
                        tr += "<td> <button onclick='reconprint("+ (key+1) +")'>Generate </button> &nbsp;&nbsp; <input type='button' onclick='recondelete("+ (key+1) +")' value='Delete' /></td> ";
                        tr += "</tr>";
                        $('#reconrpttbl tbody').append(tr);
                   });
                });
                
                retval.done(function(){
                    
                    $('#reconrpttbl').dataTable({
                  "sDom": '<"top">rt<"bottom"lp><"clear">',
                  "sScrollY": "220px",
                  "scrollCollapse": true,
                  "bPaginate": false
                        });
                });
                
                retval.error(function(){
                    bootbox.alert('unable to retrive reconciliation data..');
                });
            }
            
            
            
            
          loadrecon();
            
        </script>
     




  </body>
</html>
