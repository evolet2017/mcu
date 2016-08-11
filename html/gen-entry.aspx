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
       
        <link href="/html/css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <link href="/html/css/AdminLTE.css" rel="stylesheet" type="text/css" />
	     <!-- DATA TABLES -->
        <link href="/html/css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="/html/js/plugins/chosen/chosen.css" rel="stylesheet" type="text/css" />
        <script src="/html/js/jquery.js"></script>
        <script src="/html/js/jquery-ui-1.10.3.js"></script>
           <script src="/html/js/typeahead.jquery.js" type="text/javascript"></script>
           
                <script src="/html/js/mbphillib.js"></script>
        <script src="/html/js/jquery.autocomplete.min.js" type="text/javascript"></script>
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
         <!-- page script -->
        
     

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
                        <%--<h3>Custom GL Entry</h3>--%>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="/Main"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">Custom GL Entry</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">
                
                    <!-- Small boxes (Stat box) -->
                     
						   <div class="col-md-12">
                               
                               <div class="box">
                                    <div class="box-header">
                                        
                                    </div>

                                    <div class="box-body">

                                        <blockquote>
                                            <h4>Custom GL Entry</h4>
                                        </blockquote>

                                       <%-- <div id="the-basics">
                                          <input class="typeahead" type="text" placeholder="States of USA">
                                        </div>--%>

                                        <label>Debit</label>
                                        <!-- input type="text" id="gDebit" placeholder="" class="form-control" -->
                                        <select class="form-control chosen-select" id="gDebit">
                                           
                                        </select>
    
                                        <label>Credit</label>
                                        <!-- input type="text" id="gCredit" placeholder="" class="form-control" -->
                                        <select class="form-control  chosen-select" id="gCredit">
                                           

                                        </select>
                                        <label>Amount</label>
                                        <input type="text" id="amount" placeholder="" class="form-control numbersOnly">
                                        <label>Reference</label>
                                        <input type="text" id="reference" placeholder="" class="form-control">
                                        <label>Particulars</label>
                                        <input type="text" id="particular" placeholder="" class="form-control">
                                        <br />
                                        <button id="btnsv" class="btn btn-primary">Save</button>
                                    </div>
                                    
                               </div>     

                            </div><!-- /.box -->
      
                        

                       <!-- ./col --> <!-- end of data-->
                        
                    <!-- Main row -->
					
               
                
                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->



        <!-- jQuery 2.0.2 -->
        
        <script src="/html/js/bootbox.js"></script>
   
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>
        
		  <!-- DATA TABES SCRIPT -->
        <script src="/html/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="/html/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
		
		
		
        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
        <script src="/html/js/plugins/chosen/chosen.jquery.min.js"></script>
     
        
        
    

       
        <script>

           



            $('.numbersOnly').keyup(function () {
                if (this.value != this.value.replace(/[^0-9\.\$]/g, '')) {
                    this.value = this.value.replace(/[^0-9\.\$]/g, '');
                }
            });


            var substringMatcher = function (strs) {
                return function findMatches(q, cb) {
                    var matches, substringRegex;

                    // an array that will be populated with substring matches
                    matches = [];

                    // regex used to determine if a string contains the substring `q`
                    substrRegex = new RegExp(q, 'i');

                    // iterate through the pool of strings and for any string that
                    // contains the substring `q`, add it to the `matches` array
                    $.each(strs, function (i, str) {
                        if (substrRegex.test(str)) {
                            // the typeahead jQuery plugin expects suggestions to a
                            // JavaScript object, refer to typeahead docs for more info
                            matches.push({ value: str });
                        }
                    });

                    cb(matches);
                };
            };

           

            function escapeRegExp(string) {
                return string.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1");
            }

            function replaceAll(string, find, replace) {
                return string.replace(new RegExp(escapeRegExp(find), 'g'), replace);
            }


            var ll = $.post(MB.URLPoster(), { SQLStatement: "SELECT GLACC,TITLE,'' vselect FROM GLAC" });
            ll.success(function (data) {
                $.each(JSON.parse(data), function (key, value) {
                    $('#gDebit').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.TITLE + "</option>");
                    $('#gCredit').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.TITLE + "</option>");
                });
                $('#gDebit').chosen({width: "99%"});
                $('#gCredit').chosen({ width: "99%" });
            });


            $('#btnsv').click( function () {
                if (MB.isEmpty( $('#reference').val() ) )
                {
                    bootbox.alert("Blank reference not allowed!");
                        return;
                }

                if (MB.isEmpty($('#particular').val())) {
                    bootbox.alert("Blank particulars not allowed!");
                        return;
                   
                }

                if (MB.isEmpty($('#amount').val())) {
                    bootbox.alert("ERROR: Check the value for the amount..");
                    return;

                }

                var SQL = "INSERT INTO BankCustomGLEntry (DebitAcct,CreditAcct,Amount,Reference,Particulars,Tag) VALUES ";
                SQL += "('" + $('#gDebit').val() + "','" + $('#gCredit').val() + "'," + $('#amount').val() + ",'" + $('#reference').val() + "','" + $('#particular').val() + "',1)";

                var ExecSQL = $.post(MB.URLPoster(), {SQLStatement: SQL} );
                
                ExecSQL.success(function () {
                    //bootbox.alert("Entry Saved...");
                    var SQL = "INSERT INTO MasterTRN (v8RunDate,TrnDate,DebitAcct,CreditAcct,Amount,GLTrnType,ModuleID,Reference,Remarks,Status,UserID)  ";
                    SQL += "SELECT ";
                    SQL += "(SELECT mbvalue FROM appconfig WHERE mbfield1='sysdate'),";
                    SQL += "GETDATE(),";
                    SQL += "'" + $('#gDebit').val() + "',";
                    SQL += "'" + $('#gCredit').val() + "',";
                    SQL += accounting.unformat($('#amount').val())+","
                    SQL += "(SELECT GLTrnType FROM GLEntry WHERE ModuleID='CT001'),";
                    SQL += "'CT001',";
                    SQL += "'"+$('#reference').val()+"',";
                    SQL += "'"+$('#particular').val()+"',";
                    SQL += "1,";
                    SQL += "'" + MB.getCookie("activeid") + "'";
                    MB.push(SQL);

                    SQL = "UPDATE BankCustomGLEntry SET MasterID=(SELECT MAX(TrnID) FROM MasterTRN) WHERE id=(SELECT MAX(id) FROM BankCustomGLEntry)";
                    MB.push(SQL);

                    bootbox.alert("Entry Saved..", function () { window.location = "/Transaction"});

                    //console.log(SQL);
                });
                

               

            });


         
          
            //var config = {
            //    '.chosen-select': {},
            //    '.chosen-select-deselect': { allow_single_deselect: true },
            //    '.chosen-select-no-single': { disable_search_threshold: 10 },
            //    '.chosen-select-no-results': { no_results_text: 'Oops, nothing found!' },
            //    '.chosen-select-width': { width: "95%" }
            //}
            //$("select:first").addClass('chosen-select');
            //for (var selector in config) {
            //    $(selector).chosen(config[selector]);
            //}
            //$("#gCredit").addClass('chosen-select');
           
                
       
        </script>

        
		
   
    </body>
    
</html>