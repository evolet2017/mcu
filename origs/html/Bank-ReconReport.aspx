<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Debug ="true"
    ViewStateEncryptionMode="Always" %>


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

        <!-- Theme style -->
        <link href="/html/css/AdminLTE.css" rel="stylesheet" type="text/css" />
	     <!-- DATA TABLES -->
        <link href="/html/css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
           <script src="/html/js/jquery.min.js"></script>
                <script src="/html/js/mbphillib.js"></script>
 
		
		

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
                        <h3>Reports</h3>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="/Main"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">Bank Reports</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">
                         <div class="row">
                             <div  class="col-md-12">
                                
                                
                                 <div class="box">                        
                                         <div class="box-header">
                                            
                                         </div>
                                         <div class="box-body">
                                              <div class="form-group">
                                                 <label>Select</label>
                                                 <select class="form-control" id="rpttype">
                                                     <%--<option value="1" selected>Balance Sheet</option>
                                                     <option value="2">Income Statement</option>
                                                     <option value="3">Schedule of AP</option>--%>
                                                 </select>
                                             </div>
                                         </div>
                                         <div class="box-footer">
                                             <div id="balanceparameter">
                                                 <label>As of</label>
                                                 <input type="date" class="form-control" id="asofdate"/>
                                             </div>
                                             <div id="balanceparameter2">
                                                 <label>Start Date</label>
                                                 <input type="date" class="form-control" id="dt1"/>
                                                 <label>End Date</label>
                                                 <input type="date" class="form-control" id="dt2"/>
                                             </div>
                                             <div id="incomestatement" style="display:none">

                                             </div>
                                             <div id="scheduleap" style="display:none">

                                             </div>
                                             <br />
                                            <%-- <button type="button" id="rptbutton" class="btn btn-primary"><i class="fa fa-print"></i> Print</button>--%>
                                             <div class="btn-group">
                                             <button type="button" id="rptbutton" class="btn btn-primary"><i class="fa fa-print"></i> Generate</button>
                                             <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                                 <span class="caret"></span>
                                                 <span class="sr-only">Toggle Dropdown</span>
                                             </button>
                                             <ul class="dropdown-menu" role="menu">
                                                 <li><a href="#" id="xportexcel">Export To Excel</a></li>
                                                 <li><a href="#" id="xportpdf">Export To PDF</a></li>
                                                 <li><a href="#" id="xportdoc">Export To Word(DOC)</a></li>
                                             </ul>
                                             </div>
                                           
                                         </div>
                                 </div>
                                 <a id="D4C" style="display:none">Invi TAG</a>
                                 <div class="box" id="printpreview" style="display:none">
                                     <div class="box-header">
                                         <%--<button class="btn btn-sm bg-blue">Export to Excel</button>--%>

                                     </div>
                                     <div class="box-body">
                                         <div id="pdf" style="height:100vh;"></div>
                                     </div>
                                 </div>
                               </div>
                                
                             </div>
                      
                    <!-- Small boxes (Stat box) -->
                        <div class="row" style="display:none">
						   <div class="col-md-10">
                               
                               <div class="box">
                                    <div class="box-header">
                                        
                                    </div>

                                    <div class="box-body">
                                        <%--<blockquote id="bkupmsg">
                                            Report List
                                        </blockquote>--%>

                                        <div class="box-body table-responsive no-padding">
                                                <span id="tbl"></span>
                                               <%-- <table class="table table-hover" id="bankreconrpt">
                                                <thead>
                                                    <tr><th style="height:70px;width:40px;align-content:center;fill-opacity:inherit"></th><th></th></tr>
                                                </thead>
                                                <tbody></tbody>
                                                   
                                                    <tr>
                                                        <td style="height:70px;width:40px;background-color:green;color:white;font-size:35px;align-content:center">B</td>
                                                        <td>Balance Sheet<br />123</td>
                                                        
                                                    </tr>
                                                    <tr>
                                                        <td style="height:70px;width:40px;bgcolor:Blue;color:white;font-size:35px;align-content:center">I</td>
                                                        <td>Peter Parker<br />Batman</td>
                                                        
                                                    </tr>
                                                  
                                                </table>--%>
                                            </div><!-- /.box-body -->
                                         <span id="rptnotfound"></span>
                                       
                                    </div>
                                    
                               </div>     

                            </div><!-- /.box -->
                        </div>                        
                       <!-- ./col --> <!-- end of data-->
                        
                    <!-- Main row -->
					
               
                
                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->

        <input type="hidden" id="rptid"/>
        <input type="hidden" id="dtstart"/>
        <input type="hidden" id="dtend"/>
        <!-- jQuery 2.0.2 -->
        
        <script src="/html/js/bootbox.js"></script>
   
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>
        
		  <!-- DATA TABES SCRIPT -->
        <script src="/html/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="/html/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
		
		
		
        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
        
    

        <!-- page script -->

        <script>
            var ss = $.post(MB.URLPoster(), { SQLStatement: "SELECT * FROM BankReports WHERE TAG=1" });
            ss.success(function (msg) {
                $.each(JSON.parse(msg), function (key, value) {
                    $('#rpttype').append('<option value="'+value.ReportFile+'">'+value.ReportName+'</option>');
                });                
                $('#rptid').val(1);
                $('#dtstart').val(1);
                $('#dtend').val(0);
                $('#balanceparameter2').hide();
            });

            $('#rpttype').on('change', function () {
                $('#balanceparameter').hide();
                $('#balanceparameter2').hide();
                $('#incomestatement').hide();
                $('#scheduleap').hide();
                $('#printpreview').hide();
                var sql = "SELECT id,DateStart,DateEnd FROM BankReports WHERE Tag=1 AND ReportFile='" + this.value + "'";
               // console.log(sql);
                var ss = $.post(MB.URLPoster(), { SQLStatement: sql  });
                ss.success(function (data) {
                  //  console.log(data);
                    var v = JSON.parse(data);
                    //  console.log(v[0].id);
                    $('#rptid').val(v[0].id);
                    $('#dtstart').val(v[0].DateStart);
                    $('#dtend').val(v[0].DateEnd);
                    if (v[0].DateStart == 1) {
                        $('#balanceparameter').slideToggle();
                    }
                    if (v[0].DateEnd == 1) {
                        $('#balanceparameter').hide();
                        $('#balanceparameter2').slideToggle();
                        //$('#dtend').val(1);
                    }
                });                
            });
           

            $('#rptbutton').on('click', function () {
                var rptid = $('#rptid').val();
                if ($('#dtend').val() == 1) {
                    if (MB.isEmpty($('#dt1').val())) {
                        bootbox.alert('You must supply Start of Date for this report!!');
                        return
                    }
                    if (MB.isEmpty($('#dt2').val())) {
                        bootbox.alert('You must supply End of Date for this report!!');
                        return
                    }
                } else {
                    if ($('#dtstart').val() == 1) {
                        if (MB.isEmpty($('#asofdate').val())) {
                            bootbox.alert('You must supply as of Date for this report!!');
                            return
                        }
                    }
                }
                var rpturl = "http://" + location.host + "/reportsvc/default.aspx?"
                $('#printpreview').hide();
                if ($('#dtend').val() == 1) {
                    var ss = '<object width="100%" height="100%" type="application/pdf" data="' + rpturl + 'view=1&report=' + $('#rpttype').val() + '&param1=' + $('#dt1').val() + '&param2=' + $('#dt2').val() + '" id="pdf_content">' +
                            '<p>Pdf Generation Error</p>' +
                            '</object>';
                    // console.log(ss);
                    $('#printpreview').fadeToggle();
                    $('#pdf').html(ss);
                    $('#printpreview').focus();

                } else {

                    if ($('#dtstart').val() == 1) {
                        //alert($('#asofdate').val());
                        var ss = '<object width="100%" height="100%" type="application/pdf" data="' + rpturl + 'view=1&report=' + $('#rpttype').val() + '&param1=' + $('#asofdate').val() + '" id="pdf_content">' +
                            '<p>Pdf Generation Error</p>' +
                            '</object>';
                        // console.log(ss);
                        $('#printpreview').fadeToggle();
                        $('#pdf').html(ss);
                        $('#printpreview').focus();
                    } else {
                        var ss = '<object width="100%" height="100%" type="application/pdf" data="' + rpturl + 'view=1&report=' + $('#rpttype').val() + '" id="pdf_content">' +
                            '<p>Pdf Generation Error</p>' +
                            '</object>';
                        //    console.log(ss);
                        $('#printpreview').fadeToggle();
                        $('#pdf').html(ss);
                    }
                }
            });

            function export2any(dtype)
            {
                var rpturl = "http://" + location.host + "/reportsvc/default.aspx?export=" + dtype;
                rpturl += "&report=" + $('#rpttype').val();

                if ($('#dtstart').val() == 1) {
                    rpturl += "&param1=" + $('#asofdate').val();
                }
                //console.log(rpturl);
                window.open(rpturl);
            }

            $('#xportexcel').on('click', function () {
                var rptid = $('#rptid').val();
                if ($('#dtstart').val() == 1) {
                    if (MB.isEmpty($('#asofdate').val())) {
                        bootbox.alert('You must supply as of Date for this report!!');
                        return
                    }
                }
                export2any('excel');

            });

            $('#xportpdf').on('click', function () {
                var rptid = $('#rptid').val();
                if ($('#dtstart').val() == 1) {
                    if (MB.isEmpty($('#asofdate').val())) {
                        bootbox.alert('You must supply as of Date for this report!!');
                        return
                    }
                }
                export2any('pdf');
            });

            $('#xportdoc').on('click', function () {
                var rptid = $('#rptid').val();
                if ($('#dtstart').val() == 1) {
                    if (MB.isEmpty($('#asofdate').val())) {
                        bootbox.alert('You must supply as of Date for this report!!');
                        return
                    }
                }
                export2any('doc');
            });


      

            function randcolor() {
                return '#'+(0x1000000+(Math.random())*0xffffff).toString(16).substr(1,6);
            }
            $.ajax({
                type: "post",
                url: MB.URLPoster(),
                data: {SQLStatement : "SELECT * FROM BankReports WHERE TAG=1" },
                success: function (result) {
                    $('#bankreconrpt > tbody').html("");
                    console.log(result);
                    var tr = " <table class='table table-hover' id='bankreconrpt'>";
                    $.each(JSON.parse(result), function (key, value) {
                        //var tr = "<tr";
                        tr += "<tr onclick=genrpt('"+value.ReportFile+"','"+value.ResolvePath+"');>";
                        tr += "<td style='height:70px;width:40px;;background-color:"+randcolor()+";color:white;font-size:35px;align-content:center'>" + value.ReportName[0] + "</td>";
                        tr += "<td>&nbsp;" + value.ReportName + "<br />&nbsp;" + value.ReportFile + "</td>";
                        tr += "</tr>";
                        //document.Write(tr);
                        // console.log(tr);
                        //$('#bankreconrpt tbody:last').append(tr);
                        // document.getElementById('bankreconrpt').insertRow(-1).innerHTML = tr;
                    });
                    tr += "</table>";
                    document.getElementById('tbl').innerHTML = tr;
                }
            });


            function genrpt(param1, param2) {
                //alert(location.host);
                var url = "http://"+location.host+"/reportsvc/default.aspx?";
                //var url = "http://localhost:81/w3/default.aspx?";
                //alert("P1 " + param1 + "<br />P2" + param2);
                //window.open("http://localhost:81/w3/default.aspx?rpt=1");
                //window.open("http://localhost:81/w3/default.aspx");
                //document.getElementById('rptnotfound').innerHTML = param1;
                //if (param1 == "balancesheet.rpt") {
                window.open(url+"view=1&report="+param1);
                //}
                //if (param1 == "incomesheet.rpt") {
                //    window.open(url+"view=2");
                //}
            }
            
        </script>
        


        
		
   
    </body>
    
</html>