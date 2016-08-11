<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Inherits ="appsettings"
    ViewStateEncryptionMode ="Always" CodeFile="app-settings.aspx.cs" %>
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
        
        <link href="/html/css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
        <!-- Theme style -->
        <link href="/html/css/AdminLTE.css" rel="stylesheet" type="text/css" />

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->

        <!-- jQuery 2.0.2 -->
        <script src="/html/js/jquery.min.js"></script>
        <script src="/html/js/bootbox.js"></script>
        <script src="/html/js/mbphillib.js"></script>

    </head>
    <body class="skin-black">
        <!-- header logo: style can be found in header.less -->
       <!-- header logo: style can be found in header.less -->
  <header class="header">
  <a href="/Main" class="logo">
  <!-- Add the class icon to your logo image or logo icon to add the margining -->
  MBv8 Accounting</a> 
  <!-- Header Navbar: style can be found in header.less -->

	
	   	   <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button" id="atclick">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="navbar-right">
                    <ul class="nav navbar-nav">
                        <!-- Messages: style can be found in dropdown.less-->
                        
                            
                        <!-- User Account: style can be found in dropdown.less -->

                       
                    </ul>
                </div>
        </nav>

  </header>

        

  <div class="wrapper row-offcanvas row-offcanvas-left">
    <!-- Left side column. contains the logo and sidebar -->
     
            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="center-block">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        Application Settings
                        <small>MCU-Web</small>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li><a href="#">UI</a></li>
                        <li class="active">Timeline</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">

                    <!-- row -->
                    <div class="row">                        
                        <div class="col-md-12">
                            <!-- The time line -->
                            <ul class="timeline">
                                <!-- timeline time label -->
                                <li class="time-label">
                                    <span class="bg-red">
                                        Database Service
                                    </span>
                                </li>
                                <!-- /.timeline-label -->
                                <!-- timeline item -->
                                <li>
                                    <i class="fa fa-building-o bg-blue"></i>
                                    <div class="timeline-item">
                                       
                                        <h3 class="timeline-header"><a href="#">Connection</a></h3>
                                        <div class="timeline-body">
                                            <label> Server </label> <br>                                            
                                            <input class="form-control input-lg" type="text" placeholder="Server" id="lblServer">
                                            
                                            
                                            <label> Port </label> <br>
                                            <input class="form-control input-lg" type="text" placeholder="Port" id="lblPort">

                                            <label> TimeOut </label> <br>
                                            <input class="form-control input-lg" type="text" placeholder="10" id="lblTimeOut">

                                            <label> Connection String </label> <br>
                                            <input class="form-control input-lg" type="text" placeholder="Connection String" id="lblConStr">


                                            										                                    
                                        </div>
                                        <div class='timeline-footer'>
                                           
                                             <button type="button" class="btn btn-primary" id="btnSaveConnection" onclick = "btnSaveConnection()">Save</button>
                                            <input type="hidden" id="_dt" value="not yet complete.."/>
                                        </div>
                                    </div>
                                </li>
                                <!-- END timeline item -->
                                <!-- timeline item -->
                                <li>
                                    <i class="fa fa-truck bg-aqua"></i>
                                    <div class="timeline-item">
                                   

                                        <%--<h3 class="timeline-header no-border"><a href="#"> V8 Path </a>&nbsp;&nbsp;<input type="text" size=50></h3>--%>

                                          <label> V8 Path </label> <br>
                                            <input class="form-control input-lg" type="text" placeholder="V8 Path" id="lblv8Path">

										<div class='timeline-footer'>
										 <%--<a class="btn btn-primary btn-xs">Save</a>--%>
                                            <button type="button" class="btn btn-primary" id="btnSavePath" onclick = "btnSavePath()">Save</button>
										 </div>
                                    </div>
                                </li>
                                <!-- END timeline item -->
                                <!-- timeline item -->
								<!-- 
                                <li>
                                    <i class="fa fa-comments bg-yellow"></i>
                                    <div class="timeline-item">
                                        <span class="time"><i class="fa fa-clock-o"></i> 27 mins ago</span>
                                        <h3 class="timeline-header"><a href="#">Jay White</a> commented on your post</h3>
                                        <div class="timeline-body">
                                            Take me to your leader!
                                            Switzerland is small and neutral!
                                            We are more like Germany, ambitious and misunderstood!
                                        </div>
                                        <div class='timeline-footer'>
                                            <a class="btn btn-warning btn-flat btn-xs">View comment</a>
                                        </div>
                                    </div>
                                </li>
								-->
                                <!-- END timeline item -->
                                <!-- timeline time label -->
                                <li class="time-label">
                                    <span class="bg-green">
                                        System Settings
                                    </span>
                                </li>
								
								 <li>
                                    <i class="fa fa-book bg-maroon"></i>
                                    <div class="timeline-item">
                                       
                                        <h3 class="timeline-header"><a href="#">Application Constant</a></h3>
                                        <div class="timeline-body">

                                            <label> Field Name </label> <br>
                                            <input class="form-control input-lg" type="text" placeholder="" id="lblFieldName">
                                            <label> Value </label> <br>
                                            <input class="form-control input-lg" type="text" placeholder="" id="lblFieldValues">
                                            <br>
                                            <button type="button" class="btn btn-primary" id="btnSaveAppConstant" onclick = "btnSaveAppConstant()">Save</button>
                                            <button type="button" class="btn btn-primary" id="btnClearAppConstant" onclick = "btnClearAppConstant()">Clear</button>
                                            <input type="hidden" id="field_id" />
                                            <br>
                                             <br>

                                            <table id="TblAppconfig" class="table table-bordered table-hover">
											   <thead>
                                                   <tr>
											            <th width =" 15">#</th>
											            <th>Field Name</th>
											            <th>Value</th>
											       </tr>
                                                  
											    </thead>
                                                 <tbody>
                                                 </tbody>
											 </table>
                                                                                                                               
                                        </div>
                                        <div class="timeline-footer">
                                           
                                        </div>
                                    </div>
                                </li>
                                <!-- /.timeline-label -->
                                <!-- timeline item -->
                                <li>
                                    <i class="fa fa-users bg-purple"></i>
                                    <div class="timeline-item">
                                        <h3 class="timeline-header"><a href="#">User List</a></h3>
                                        <div class="timeline-body">
                                            
                                            <button type="button" class="btn btn-primary" id="btnFetchUser" onclick = "btnFetchUser()">Populate User</button>
                                            <br>
                                            <br>
										<table id="syssettings" class="table table-bordered table-hover">
											<thead>
                                                <tr>
											        <th width =" 15">#</th>
											        <th>User ID</th>
											        <th>First Name</th>
                                                    <th>Last Name</th>us
											        <th>Email</th>
											        <th>Status/Action</th>
											    </tr>
											</thead>
											<tbody>
											</tbody>
										</table>
                                            
                                        </div>
                                    </div>
                                </li>
                                <!-- END timeline item -->
                                <!-- timeline item -->
                                <li class="time-label">
                                    <span class="bg-green">
                                        GL Maintenance
                                    </span>
                                </li>
                                <li>
                                    <i class="fa fa-pencil bg-maroon"></i>
                                    <div class="timeline-item">
                                       
                                        <h3 class="timeline-header"><a href="#">GL Editor</a></h3>
                                        <div class="timeline-body">
                                            <div class="form-group">
                                            <label>Transaction Type</label>
                                            <input type="text" class="form-control" id="gl_trn"/>
                                            <label>Debit Account</label>
                                            <input type="text" class="form-control" id="gl_debit"/>
                                            <label>Credit Account</label>
                                            <input type="text" class="form-control" id="gl_credit"/>
                                            <label>Debit Full Description</label>
                                            <input type="text" class="form-control" id="gl_debitfull"/>
                                            <label>Credit Full Description</label>
                                            <input type="text" class="form-control" id="gl_creditfull"/>
                                            <label>Explanation</label>
                                            <input type="text" class="form-control" id="gl_explanation"/>
                                            <label>Status</label>
                                            <input type="text" class="form-control" id="gl_status"/>
                                            <label>Module ID</label>
                                            <input type="text" class="form-control" id="gl_moduleid"/>
                                            <input type="hidden" id="gl_entryid" />
                                            </div>
                                            <div class="form-group">
                                                <button class="btn btn-primary" type="button" id="btnglupdate">Update</button>
                                                <button class="btn btn-primary" type="button" id="btnglsave" style="display:none">Save</button>
                                                <button class="btn btn-warning" type="button" id="btnglnew">Add New</button>
                                                <button class="btn btn-danger" type="button" id="btnglcancel" style="display:none">Cancel</button>
                                                
                                            </div>
                                            <table id="tblglentry" class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>Type</th>
                                                        <th>Debit Acct</th>
                                                        <th>Credit Acct</th>
                                                        <th>Debit Full Description</th>
                                                        <th>Credit Full Description</th>
                                                        <th>Status</th>
                                                        <th>Module ID</th>
                                                    </tr>
                                                </thead>
                                            </table>
                                        </div>
                                        <div class="timeline-footer">
                                           
                                        </div>
                                    </div>
                                </li>

                                <li>
                                    <i class="fa fa-pencil-square bg-red"></i>
                                    <div class="timeline-item">
                                       
                                        <h3 class="timeline-header"><a href="#">Module Editor</a></h3>
                                        <div class="timeline-body">
                                            <div class="form-group">
                                            <label>Module Id</label>
                                            <input type="text" class="form-control" id="mdl_moduleid"/>
                                            <label>Description</label>
                                            <input type="text" class="form-control" id="mdl_description"/>
                                            <label>Status</label>
                                            <input type="text" class="form-control" id="mdl_status"/>
                                            </div>
                                            <div class="form-group">
                                                <button class="btn btn-primary" type="button" id="btnUpdate">Update</button>
                                            </div>
                                            
                                            <table id="tblmodule" class="table table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>Module ID</th>
                                                        <th>Description</th> 
                                                        <th>Status</th>
                                                       
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="timeline-footer">
                                           
                                        </div>
                                    </div>
                                </li>
                                
                                <li>
                                    <i class="fa fa-clock-o"></i>
                                </li>
                            </ul>
                        </div><!-- /.col -->
                    </div><!-- /.row -->

                    <div class="row" style="margin-top: 10px;">
                        <div class="col-md-12">
                            <div class="box">
                                <div class="box-header">
                                    <h3 class="box-title"><i class="fa fa-code"></i>Patch Code</h3>
                                </div>
                                <div class="box-body pad">
                                    <!-- pre style="font-weight: 600;" -->
                       
                                        <textarea id="PatchTxt"  class="textarea" style="width: 100%; height:200px;"></textarea>
                                        <br />
                                    <br />
                                    <br />
                                        <input type="button" class="btn btn-danger" value="Patch Up!" onclick="PatchUp();" />
                                    <!-- pre!-->                                    
                                </div><!-- /.box-body -->
                            </div><!-- /.box -->
                        </div><!-- /.col -->
                    </div><!-- /.row -->

                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->

        
                
                <form id="Form1" runat="server">
                    <div style="display: none;">
                        <asp:Button runat="server" ID="testme" OnClick="signout" />
                        <asp:TextBox runat="server" ID="constr" Value="test" />
                        <asp:TextBox runat="server" ID="timeout" Value="test" />
                        <asp:Button runat="server" ID="Button1" OnClick="Button1_Click"  />
                        <asp:Label ID="javaExec" runat="server" Text="TTT"></asp:Label>  
                    </div>
                    
                </form>
        
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>
        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
	    <script src="/html/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="/html/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
        <script src="/html/js/base64.js" type="text/javascript"></script>
        <script src="/html/js/mbsettings.js" type="text/javascript"></script>
        <script src="/html/js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.js"></script>
        <script src="/html/js/base64.js"></script>
        <script>
            $('#lblTimeOut').val($('#timeout').val());
            // $('#testme').click();
            $(function () {
                $('.textarea').Wysihtml5();
            });

            function PatchUp()
            {
                    //btnPatch
                // alert('test');
               // alert(B64.decode($('#PatchTxt').val()));
                try
                {
                    MB.post(B64.decode($('#PatchTxt').val()));
                    bootbox.alert("Patch Up! Success");
                } catch(e)
                {
                    bootbox.alert("Patch Up! Error : "+e.message);
                }
            };

            function displayinfo3(x, y, z) {
                $('#mdl_moduleid').val(x);
                $('#mdl_description').val(y);
                $('#mdl_status').val(z);

            }

            function displayinfo1(x) {
                if (!$('#btnglcancel').is(':hidden')) {
                    bootbox.alert('Unable to display information, The form is in Add mode');
                    return
                }
                var SQL = "SELECT * FROM GLEntry WHERE EntryID=" + x;
                var rets = $.post(MB.URLPoster(), { SQLStatement: SQL });
                rets.success(function (msg) {
                    var rr = JSON.parse(msg);
                    $('#gl_trn').val(rr[0].GLtrntype);
                    $('#gl_debit').val(rr[0].DebitGLAcct);
                    $('#gl_credit').val(rr[0].CreditGLAcct);
                    $('#gl_debitfull').val(rr[0].DrFullName);
                    $('#gl_creditfull').val(rr[0].CrFullName);
                    $('#gl_explanation').val(rr[0].Explanation);
                    $('#gl_status').val(rr[0].Status);
                    $('#gl_moduleid').val(rr[0].ModuleID);
                    $('#gl_entryid').val(rr[0].EntryID);
                });
               

            }

            function updatemodules() {
                var SQL = "SELECT * FROM Modules";
                var rets = $.post(MB.URLPoster(), { SQLStatement: SQL });
                rets.success(function (msg) {
                    $('#tblmodule').dataTable().fnClearTable();
                    $('#tblmodule').dataTable().fnDestroy();
                    $('#tblmodule').html();
                    //console.log(msg);
                    $.each(JSON.parse(msg), function (id, value) {
                        var tr = "<tr onclick=\"displayinfo3('" + value.ModuleID + "','" + value.Description + "','" + value.Status + "')\" >";
                        tr += "<td>" + value.ModuleID + "</td>";
                        tr += "<td>" + value.Description + "</td>";
                        tr += "<td>" + value.Status + "</td>";
                        tr += "</tr>";
                        $('#tblmodule').append(tr);

                    });
                    $('#tblmodule').dataTable();
                });
            }


            function updateglentry() {
                
                var SQL = "SELECT * FROM GLEntry";
                var rets = $.post(MB.URLPoster(), { SQLStatement: SQL });
                rets.success(function (msg) {
                    $('#tblglentry').dataTable().fnClearTable();
                    $('#tblglentry').dataTable().fnDestroy();
                    $('#tblglentry').html();
                    //console.log(msg);
                    $.each(JSON.parse(msg), function (id, value) {
                        var tr = "<tr onclick=\"displayinfo1('" + value.EntryID + "');\">";
                        tr += "<td>" + value.GLtrntype + "</td>";
                        tr += "<td>" + value.DebitGLAcct + "</td>";
                        tr += "<td>" + value.CreditGLAcct + "</td>";
                        tr += "<td>" + value.DrFullName + "</td>";
                        tr += "<td>" + value.CrFullName + "</td>";
                        tr += "<td>" + value.Status + "</td>";
                        tr += "<td>" + value.ModuleID + "</td>";
                        tr += "</tr>";
                        $('#tblglentry').append(tr);

                    });
                    $('#tblglentry').dataTable();
                });
            }

            $('#btnglupdate').click(function () {
                if (MB.isEmpty($('#gl_trn').val())) {
                    bootbox.alert('Empty GLtrntype is not allowed');
                    return
                }
                if (MB.isEmpty($('#gl_debit').val())) {
                    bootbox.alert('Empty Debit Entry is not allowed, value <blank> is allowed');
                    return
                }
                if (MB.isEmpty($('#gl_credit').val())) {
                    bootbox.alert('Empty Credit Entry is not allowed, value <blank> is allowed');
                    return
                }
                if (MB.isEmpty($('#gl_debitfull').val())) {
                    bootbox.alert('Empty Debit Description Entry is not allowed, value <blank> is allowed');
                    return
                }
                if (MB.isEmpty($('#gl_creditfull').val())) {
                    bootbox.alert('Empty Credit Description Entry is not allowed, value <blank> is allowed');
                    return
                }
                if (MB.isEmpty($('#gl_explanation').val())) {
                    bootbox.alert('Empty Explanation is not allowed, value <blank> is allowed');
                    return
                }
                if (MB.isEmpty($('#gl_status').val())) {
                    $('#gl_status').val('01');
                }
                if (MB.isEmpty($('#gl_moduleid').val())) {
                    bootbox.alert('Empty ModuleID is not allowed, value <blank> is allowed');
                    return
                }

                var SQL = "UPDATE GLEntry SET ";
                    
                   // (GLtrntype,DebitGLAcct,CreditGLAcct,DrFullName,CrFullName,Explation,Status,ModuleID) VALUES ";
                    SQL += "GLtrntype = '" + $('#gl_trn').val().trim() + "',";
                    SQL += "DebitGLAcct = '" + $('#gl_debit').val().trim() + "',";
                    SQL += "CreditGLAcct = '" + $('#gl_credit').val().trim() + "',";
                    SQL += "DrFullName = '" + $('#gl_debitfull').val().trim() + "',";
                    SQL += "CrFullName = '" + $('#gl_creditfull').val().trim() + "',";
                    SQL += "Explanation = '" + $('#gl_explanation').val().trim() + "',";
                    SQL += "Status = '" + $('#gl_status').val().trim() + "',";
                    SQL += "ModuleID = '" + $('#gl_moduleid').val().trim() + "' ";
                    SQL += "WHERE EntryID = '" + $('#gl_entryid').val().trim() + "'";
                  //  console.log(SQL);
                MB.push(SQL);
                bootbox.alert('Entry Saved!');
                updateglentry();
            });

            $('#btnglnew').click(function () {
                $('#btnglupdate').slideToggle();
                $('#btnglnew').slideToggle();
                $('#btnglsave').slideToggle();
                $('#btnglcancel').slideToggle();
                $('#gl_trn').val('');
                $('#gl_debit').val('');
                $('#gl_credit').val('');
                $('#gl_debitfull').val('');
                $('#gl_creditfull').val('');
                $('#gl_explanation').val('');
                $('#gl_status').val('01');
                $('#gl_moduleid').val('');
            });

            $('#btnglcancel').click(function () {
                $('#btnglupdate').slideToggle();
                $('#btnglnew').slideToggle();
                $('#btnglsave').slideToggle();
                $('#btnglcancel').slideToggle();
            });

            $('#btnglsave').click(function () {
                //alert('save gl entry');
                if (MB.isEmpty($('#gl_trn').val())) {
                    bootbox.alert('Empty GLtrntype is not allowed');
                    return
                }
                if (MB.isEmpty($('#gl_debit').val())) {
                    bootbox.alert('Empty Debit Entry is not allowed, value <blank> is allowed');
                    return
                }
                if (MB.isEmpty($('#gl_credit').val())) {
                    bootbox.alert('Empty Credit Entry is not allowed, value <blank> is allowed');
                    return
                }
                if (MB.isEmpty($('#gl_debitfull').val())) {
                    bootbox.alert('Empty Debit Description Entry is not allowed, value <blank> is allowed');
                    return
                }
                if (MB.isEmpty($('#gl_creditfull').val())) {
                    bootbox.alert('Empty Credit Description Entry is not allowed, value <blank> is allowed');
                    return
                }
                if (MB.isEmpty($('#gl_explanation').val())) {
                    bootbox.alert('Empty Explanation is not allowed, value <blank> is allowed');
                    return
                }
                if (MB.isEmpty($('#gl_status').val())) {
                    $('#gl_status').val('01');
                }
                if (MB.isEmpty($('#gl_moduleid').val())) {
                    bootbox.alert('Empty ModuleID is not allowed, value <blank> is allowed');
                    return
                }
                      
                var SQL = "INSERT INTO GLEntry (GLtrntype,DebitGLAcct,CreditGLAcct,DrFullName,CrFullName,Explanation,Status,ModuleID) VALUES ";
                SQL += "('" + $('#gl_trn').val() + "',";
                SQL += "'" + $('#gl_debit').val() + "',";
                SQL += "'" + $('#gl_credit').val() + "',";
                SQL += "'" + $('#gl_debitfull').val() + "',";
                SQL += "'" + $('#gl_creditfull').val() + "',";
                SQL += "'" + $('#gl_explanation').val() + "',";
                SQL += "'" + $('#gl_status').val() + "',";
                SQL += "'" + $('#gl_moduleid').val() + "')";
                MB.push(SQL);
                bootbox.alert('Entry Saved!');

                $('#btnglupdate').slideToggle();
                $('#btnglnew').slideToggle();
                $('#btnglsave').slideToggle();
                $('#btnglcancel').slideToggle();
                updateglentry();
            });

            $('#btnUpdate').click(function () {
                if (MB.isEmpty($('#mdl_description').val())) {
                    bootbox.alert("Empty Description is not allowed");
                    return
                }
                if (MB.isEmpty($('#mdl_status').val())) {
                    $('#mdl_status').val('01');
                }
                if (MB.isEmpty($('#mdl_moduleid').val())) {
                    bootbox.alert("Empty Module ID is not allowed");
                    return
                }

                var SQL = "SELECT COUNT(*) cnt FROM Modules WHERE ModuleID='" + $('#mdl_moduleid').val() + "'";
                var rets = $.post(MB.URLPoster(), { SQLStatement: SQL });
                rets.success(function (msg) {
                    //console.log(msg);
                    var rr = JSON.parse(msg);
                    if (rr[0].cnt == 0) {
                        var SQL = "INSERT INTO Modules (ModuleID, Description, Status) VALUES ('" + $('#mdl_moduleid').val() + "','" + $('#mdl_description').val() + "','" + $('#mdl_status').val() + "')";
                    } else {
                        var SQL = "UPDATE Modules SET Description='" + $('#mdl_description').val() + "',Status='" + $('#mdl_status').val() + "' WHERE ModuleID='" + $('#mdl_moduleid').val() + "'"
                    }
                    MB.push(SQL);
                    bootbox.alert("Entry Saved..");
                    updatemodules()
                });


            });

            updatemodules();
            updateglentry();

           

        </script>

    </body>
</html>