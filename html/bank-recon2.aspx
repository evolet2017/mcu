<%@ Page Language   ="C#" %>
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
        <!-- link href="/html/css/datatables/jquery.dataTables.css" rel="stylesheet" type="text/css" / -->
        <link href="/html/css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
        <link href="/html/js/plugins/datatables/buttons.dataTables.min.css" rel="stylesheet" type="text/css" />
        <link href="/html/js/plugins/chosen/chosen.css" rel="stylesheet" type="text/css" />
         <link rel="stylesheet" href="/html/css/select2.min.css">
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
        
            int mynum = 103;
            
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
        <h1>Bank Reconciliation 2</h1>
        <ol class="breadcrumb">
          <li>
            <a href="/Main"><i class="fa fa-dashboard"></i> Home</a>
          </li>
          <li class="active">Bank Reconciliation 2</li>
        </ol>
            <br />
           <div class="row no-print">
            <div class="col-sm-3">
                Start Period <input type="date" class="form-control input-sm" id="recondate1" onblur="valid_date1(this)"/>
            </div>
            <div class="col-sm-3">
                End Period <input type="date" class="form-control input-sm" id="recondate2" onfocus="if($('#recondate1').val() > this.value){this.value=$('#recondate1').val();}" onblur="valid_date2(this)"/>
            </div>
            <div class="col-sm-6">
                Bank Account <span id="msggl"></span> <select id="glcode" class="form-control input-sm" onchange="selectchange(this.value)">
                <option></option>                   
                </select>                
                <div id="globalholder" style="display:none">
                <input type="text" id="accttype">
                <input type="text" id="acctglacc">
                </div>
            </div>
            <div class="col-sm-3">
              Beginning Balance <input type="text" readonly style="text-align:right" id="beg_balance" class="form-control input-sm" value="$0.00" onkeyup="return isNumber(this)"   />
            </div>
            <div class="col-sm-3">
              Ending Balance <input type="text" readonly style="text-align:right" id="end_balance" class="form-control input-sm" value="$0.00" onkeypress="return isNumber(event)" />  
            </div>
            <div class="col-sm-3">
              
              Service Charge <input type="text" readonly style="text-align:right" id="service_charge" onblur="btnCompute()" class="form-control input-sm" value="$0.00" onkeyup="return isNumber(event)" />
              
            </div>                    
            <div class="col-sm-3">
              
              Interest Earned <input type="text" readonly style="text-align:right" id="interest_earned" onblur="btnCompute()" class="form-control input-sm" value="$0.00" onkeyup="return isNumber(event)" />
              
            </div>
            
                    
        </div>

      </section>
      <!-- Main content -->
       
      <section class="content">
        
        <script type="text/javascript">
          function getRow(n) {
              console.log('getrow');
              var row = n.parentNode.parentNode;
              var cols = row.getElementsByTagName("input");
              var i=0;
              while (i < cols.length) {
                  alert(cols[i].textContent);
                  i++;
              }
          } 
      </script>
        
        
        <div class="row no-print" id="recon_mainselect">
            <div class="col-md-12">
              <div class="col-xs-6">
                  <label>Deposits and Other Credits</label>
                  <table class="display" id="othercredits" cellspacing="0" width="100%">
                      <thead>
                  
                              <td width="10"></td>
                              <td>Date</td>
                              <td>Chk#</td>
                              <td>Memo</td>
                              <td>Type</td>
                              <td>Amount</td>
                              
                      
                      </thead>
                      <tbody>
  
                      </tbody>
                  </table>
                
                  <input type="button" onclick="SelectButton('chkAllDC','ckboxothers')" id="chkAllDC" class="btn btn-xs" value="Select All" />
                  <hr />
              </div>
              <div class="col-xs-6">
                  <label>Checks and Payments</label>
                  <table class="display" id="checkspayments" cellspacing="0" width="100%">
                      <thead>
                          
                              <td width="10"/></td>                           
                              <td>Date</td>
                              <td>Chk#</td>
                              <td>Payee</td>
                              <td>Type</td>
                              <td>Amount</td>
                              <td>Intransit</td>
                        
                        
                      </thead>
                      <tbody>                       
                      </tbody>
                  </table>
                  
                  <input type="button" onclick="SelectButton('chkAllCP','ckbox')" id="chkAllCP" class="btn btn-xs" value="Select All" />
                  <hr />
                  
  
              </div>
            </div>
            <div class="col-md-12">
              
              <div class="col-xs-6">
                  <label>Interest Earned</label>
                  <table class="display" id="inttblearned" cellspacing="0" width="100%">                 
                    <thead>
                          
                              <td width="10"></td>
                              <td>Date</td>
                              <td>GL Reference</td>
                              <td>Amount</td>      
                              <td width="0"></td>                                          
  
                    </thead>
                    <tbody></tbody> 
                  </table>
                  <!-- input type="button"  class="btn btn-xs" value="Select All" / -->
                  <input type="button" id="btnIE" class="btn btn-xs" value="Add" />
                  <input type="button" id="btnDelIE" class="btn btn-xs" value="Delete" />
                  <hr />
              </div>
              
              <div class="col-xs-6">
                  <label>Service Charge</label>
                  <table class="display" id="svctblcharge" cellspacing="0" width="100%">                 
                    <thead>
                              <td width="10"></td>
                              <td>Date</td>
                              <td>GL Reference</td>
                              <td>Amount</td>  
                              <td width="0"></td>                                              
                    </thead>
                    <tbody></tbody>
                  </table>
                  <!-- input type="button" class="btn btn-xs" value="Select All" / -->
                  <input type="button" id="btnSC" class="btn btn-xs" value="Add" />
                  <input type="button" id="btnDelSC" class="btn btn-xs" value="Delete" />
                  
                  <hr />
              </div>
              
            </div>
          
        </div>
        <div class="row no-print" >
            <div class="col-xs-6">
                    
                    <div class="col-sm-12">
                        Item you have marked cleared
                    </div>
                    <div class="col-sm-2">
                        <input type="text" style="text-align:right" id="doc_cnt" class="form-control input-sm" value="0" readonly />
                    </div>
                    <div class="col-sm-6">
                         Deposits and Other Credits
                    </div>
                    <div class="col-sm-4">
                        <input type="text" style="text-align:right" class="form-control input-sm" id="depoc" value="$0.00" readonly />
                    </div>
                    <div class="col-sm-2">
                        <input type="text" style="text-align:right" id="cp_cnt" class="form-control input-sm" value="0" readonly />
                    </div>
                    <div class="col-sm-6">
                         Checks and Payments
                    </div>
                    <div class="col-sm-4">
                        <input type="text" style="text-align:right" class="form-control input-sm" id="chkpay" value="$0.00" readonly />
                    </div>
                    
            </div>

            <div class="col-xs-6">      
                    <div class="col-sm-12">
                      &nbsp;
                    </div> 
                    <div class="col-sm-4"></div>                         
                    <div class="col-sm-4">Cleared Balance</div>
                    <div class="col-sm-4"><input type="text" style="text-align:right" id="cleared_balance" class="form-control input-sm" value="$0.00" onkeypress="return isNumber(event)" readonly/></div>
                    <div class="col-sm-4"></div>
                    <div class="col-sm-4">Difference</div>
                    <div class="col-sm-4"><input type="text" style="text-align:right" id="diff_rence" class="form-control input-sm" value="$0.00"  onkeypress="return isNumber(event)" readonly/></div>


            </div>

        </div>
        <br />
        <div class="row no-print">
            <div class="col-sm-8">
                
            </div>
            <div class="col-sm-4">
                
                <button class="btn btn-info pull-right" onclick="btnleave()">Leave</button>
                <button class="btn btn-info pull-right" id="btnReconcile" onclick="btnReconcile()" >Reconcile Now</button>&nbsp;&nbsp;
            </div>
        </div>
     			
        <!-- end of row-->
        <!-- wrapper -->
      </section>
    </aside>

  </div>
   <% Response.Write(mynum); %>
   
    <div class="example-modal2">
        <div class="modal" id="example-modal">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="modaltitle"></h4>
              </div>
              <div class="modal-body">
                <p>Date</p>
                <input type="date" class="form-control" id="gldate" />
                <p>GL Account</p>
                <select class="form-control" id="glaccnt" />
                </select>
                <p>Amount</p>
                <input type="text" class="form-control" id="glamt" />
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
      </div>
      <!-- /.example-modal -->

       

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
      <!-- script src="/html/js/plugins/datatables/dataTables.buttons.min.js" type="text/javascript"></script -->
      <script src="/html/js/plugins/datatables/buttons.colVis.min.js" type="text/javascript"></script>

        

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
		     <script src="/html/js/plugins/select2.full.min.js" type="text/javascript"></script>
		
        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
        <script src="/html/js/bootbox.js" type="text/javascript"></script>
        <script src="/html/js/plugins/chosen/chosen.jquery.min.js"></script>
        
        <script src="/html/js/accounting.min.js" type="text/javascript"></script>
        

        
      <script>
        
        
        var 
          glb_endbal =0;
          
          function isEmpty(value){
            var isEmptyObject = function(a) {
                if (typeof a.length === 'undefined') { // it's an Object, not an Array
                var hasNonempty = Object.keys(a).some(function nonEmpty(element){
                    return !isEmpty(a[element]);
                });
                return hasNonempty ? false : isEmptyObject(Object.keys(a));
                }
            
                return !a.some(function nonEmpty(element) { // check if array is really not empty as JS thinks
                return !isEmpty(element); // at least one element should be non-empty
                });
            };
            return (
                value == false
                || typeof value === 'undefined'
                || value == null
                || (typeof value === 'object' && isEmptyObject(value))
            );
            }
                    
         


          function isNumber(evt) {
              
              var validItens = [9,8,48,49,50,51,52,53,54,55,67,57,189,190], 
              n = (evt.which) ? evt.which : event.keyCode,
              flnum = evt.srcElement.value;
              console.log(n);
              if (validItens.indexOf(n) == -1)
              {
                console.log('valid?');
                return false;
              }
              
              if(isNaN(parseFloat(flnum)))
              {
                evt.srcElement.value = 0.00;
                 console.log('parse float error?');
                return false;
                
              }
              if(evt.srcElement.value.split('.').length > 2)
              {
                evt.srcElement.value = parseFloat(flnum);
                return false;
              }
              
              if(evt.srcElement.value.split('-').length > 1)
              {     
                console.log('??');         
                if(evt.srcElement.value.indexOf('-') > -1)
                {                
                  if(evt.srcElement.value.indexOf('-') != 0)
                  {
                    evt.srcElement.value = parseFloat(flnum);
                    return false;                
                  }
                }
              }
              //evt.srcElement.value = parseFloat(flnum);
              //console.log(evt.srcElement.value.split('.').length)
             // console.log(evt.srcElement.value);
              
              return true;

          }
          
          $('#btnDelSC').click( function () {
            
                if(checktrans())
                    {
                        return;
                    }
                 var checkboxes = document.getElementsByName('chksc[]');
                 var table = $('#svctblcharge').DataTable();
                 for (var n = checkboxes.length; n != 0; n--) {
                    console.log(n);
                    if (checkboxes[n-1].checked) {
                      table.row(n-1).remove().draw( false );
                      
                    }
                 }
                 
                 btnCompute();

          });
          
          
          
          $('#btnSC').on('click',function(){
                if(checktrans())
                    {
                        return;
                    }
                var today = new Date(), dd = today.getDate(),mm = today.getMonth()+1,yyyy = today.getFullYear();

                    if(dd<10) {
                        dd='0'+dd
                    } 
                    
                    if(mm<10) {
                        mm='0'+mm
                    } 
                    
               //     today = mm+'-'+dd+'-'+yyyy;
                     today = yyyy+'-'+mm+'-'+dd;
                
                //var retval  = $.post(MB.URLPoster(), { SQLStatement: "SELECT glacc,title FROM glac" });
               // retval.success(function(data){
                 // console.log(data);
                  var picklist = "Date <input type='date' id='sc_date' value='"+today+"' class='form-control' />"; 
                 // picklist += "SELECT GL <select id='pickgl' class='form-control select2' style='width:100%'>";
               //   $.each(JSON.parse(data), function(key,value){
               //     picklist += "<option value='"+value.glacc+":"+value.title+"'>"+value.title;                   
               //   }); 
               //   picklist += "</select>";
                  picklist += 'Amount <input type="number" id="sc_amt" step=0.0001 class="form-control" value="0.00"  />';
                  //+ '<script>'
                 // + '$(".select2").select2();'
                //  + '<\/script>';
             

                  bootbox.dialog({
                    title: "Service Charge Account Ledger.",
                    message: picklist,
                    buttons: {
                        success: {
                            label: "Save",
                            className: "btn-success",
                            callback: function () {
                                //var vname = ($('#pickgl').val()).split(':'),
                                var vname = '501000301:Expense - Bank Charges'.split(':'),
                                vdate = $('#sc_date').val(),
                                vAmt = accounting.formatMoney($('#sc_amt').val());
                                
                                t = $('#svctblcharge').DataTable();                              
                                //$('#gl1').text(name);
                                
                                t.row.add( [     
                                  "<input type='checkbox' name='chksc[]' value='"+vname[0]+"' />",                        
                                  vdate,
                                  vname[1],
                                  vAmt,
                                  vname[0]
                              ] ).draw( false );
                               btnCompute(); 
                             
 
                            }
                        }
                    }
                  }); 
                       
                //}); 
          });
          
          $('#btnDelIE').click( function () {
            if(checktrans())
                    {
                        return;
                    }
                
                 var checkboxes = document.getElementsByName('chkIE[]');
                 console.log('cb l :'+checkboxes.length);
                 var table = $('#inttblearned').DataTable();
                 for (var n = checkboxes.length; n != 0; n--) {
                    console.log(n);
                    if (checkboxes[n-1].checked) {
                      table.row(n-1).remove().draw( false );
                      
                    }
                 }
                 
                 
                 btnCompute();

          });
          
           $('#btnIE').on('click',function(){
                    if(checktrans())
                    {
                        return;
                    }
                    var today = new Date(), dd = today.getDate(),mm = today.getMonth()+1,yyyy = today.getFullYear();

                    if(dd<10) {
                        dd='0'+dd
                    } 
                    
                    if(mm<10) {
                        mm='0'+mm
                    } 
                    
                    //today = mm+'-'+dd+'-'+yyyy;
                    
                    today = yyyy+'-'+mm+'-'+dd;
                    
                    console.log(today);
                    
                    //currentDate=new Date().toLocaleString().slice(0,10);
                    
                   //  console.log(currentDate);

            //var retval  = $.post(MB.URLPoster(), { SQLStatement: "SELECT glacc,title FROM glac" });
               // retval.success(function(data){
                 // console.log(data);
                  var picklist = "Date <input type='date' id='sc_date' value='"+today+"' class='form-control' />"; 
               //   picklist += "SELECT GL <select id='pickgl' class='form-control select2'>";
                //  $.each(JSON.parse(data), function(key,value){
              //      picklist += "<option value='"+value.glacc+":"+value.title+"'>"+value.title;                    
             //     }); 
              //    picklist += "</select>";
                      picklist += "Amount <input type='number' id='sc_amt' step=0.0001 class='form-control' value='0.00' onkeyup='return isNumber(this)' />";
            
                 
                  bootbox.dialog({
                    title: "Interest Earned.",
                    message: picklist,
                    buttons: {
                        success: {
                            label: "Save",
                            className: "btn-success",
                            callback: function () {
                                //var vname = ($('#pickgl').val()).split(':'),
                                var vname = '401020001:Interest Income / Cash addition to Bank Deposit'.split(':'),
                                vdate = $('#sc_date').val(),
                                vAmt = accounting.formatMoney($('#sc_amt').val());
                                
                                t = $('#inttblearned').DataTable();                              
                                //$('#gl1').text(name);
                                
                                t.row.add( [  
                                  "<input type='checkbox' name='chkIE[]' value='"+vname[0]+"' />",                           
                                  vdate,
                                  vname[1],
                                  vAmt,
                                  vname[0]
                                  
                              ] ).draw( false );
                               btnCompute();
                              
 
                            }
                        }
                    }
                  });   
             
              //  });           
          });
          
          /*
          $('#chkAllCP').on('click',function() {
           var caption = $('#chkAllCP').val(),                        
            checkboxes = document.getElementsByName('ckbox[]');          
            for (var i = 0, n = checkboxes.length; i < n; i++) {
                 checkboxes[i].checked = caption == 'Select All';
            }
            if(caption == 'Select All')
            {
              $('#chkAllCP').val('Un-select All')
            } else {
              $('#chkAllCP').val('Select All')
            }
            btnCompute();
          });
          */
          
          
          function SelectButton(t,tblID)
          {
            if(checktrans())
            {
                return;
            }
            var ls = tblID+'[]';
            console.log('ls : '+ls);
            var caption = $('#'+t).val(),
            checkboxes = document.getElementsByName(ls);
            for (var i = 0, n = checkboxes.length; i < n; i++) {
                 checkboxes[i].checked = caption == 'Select All';
            }
            if(caption == 'Select All')
            {
              $('#'+t).val('Un-select All')
            } else {
              $('#'+t).val('Select All')
            }
            btnCompute();
            
          }
          /*
          $('#chkAllDC').on('click',function() {
            var caption = $('#chkAllDC').val(),                        
            checkboxes = document.getElementsByName('ckboxothers[]');          
            for (var i = 0, n = checkboxes.length; i < n; i++) {
                 checkboxes[i].checked = caption == 'Select All';
            }
            if(caption == 'Select All')
            {
              $('#chkAllDC').val('Un-select All')
            } else {
              $('#chkAllDC').val('Select All')
            }
            btnCompute();
          });
          
          */
         function initTbl(id)
         {
              $('#'+id).dataTable({
                  "sDom": '<"top">rt<"bottom"lp><"clear">',
                  "sScrollY": "220px",
                  "scrollCollapse": true,
                  "bPaginate": false
              });
              
             // console.log('inittbl');
             
         }  

          function btnleave()
          {
            window.location = '/Main';                        
          }
          
          function btnCompute()
          {
                console.log('btnleave');
              
                
                var checkboxes = document.getElementsByName('ckbox[]');
                var chkpay = 0, chkcnt = 0, chksvcchg = 0, chkiechg = 0;
                // Checks and payments
                $('#chkpay').val(accounting.formatMoney(chkpay));
                $('#cp_cnt').val(chkcnt);
                for (var i = 0, n = checkboxes.length; i < n; i++) {
                    if (checkboxes[i].checked) {
                        chkcnt += 1;
                        //vals = checkboxes[i].value;
                        //console.log('checkboxvas = '+i);   
                        // cells 0 = checkbox
                        // cells 1 = Date
                        // cells 2 = Check#
                        // cells 3 = Payee
                        // cells 4 = Amount                        
                        s = document.getElementById('checkspayments').rows[i + 1].cells[4].innerText;
                        chkpay += parseFloat(accounting.unformat(s));
                        $('#chkpay').val(accounting.formatMoney(chkpay));
                        $('#cp_cnt').val(chkcnt);
                        console.log(s);                                                        
                    }
                }
                // deposits and other credits
                checkboxes = document.getElementsByName('ckboxothers[]');
                chkpay = 0;
                chkcnt = 0;
                $('#depoc').val(accounting.formatMoney(chkpay));
                $('#doc_cnt').val(chkcnt);
                for (var i = 0, n = checkboxes.length; i < n; i++) {
                    if (checkboxes[i].checked) {
                        chkcnt += 1;
                        //vals = checkboxes[i].value;
                        //console.log('checkboxvas = '+i);   
                        // cells 0 = checkbox
                        // cells 1 = Date
                        // cells 2 = Check#
                        // cells 3 = Payee
                        // cells 4 = Amount                        
                        s = document.getElementById('othercredits').rows[i + 1].cells[5].innerText;
                        chkpay += parseFloat(accounting.unformat(s));
                        $('#depoc').val(accounting.formatMoney(chkpay));
                        $('#doc_cnt').val(chkcnt);
                        console.log(s);                                                        
                    }
                }
                
           
                var rows1 = $("#svctblcharge").dataTable().fnGetNodes();
                //console.log(rows.length);
                //console.log(rows);
                //chksvcchg = accounting.unformat($('#service_charge').val());
                for(var i=0;i<rows1.length;i++)
                {
                    // Get HTML of 3rd column (for example)
                    chksvcchg += accounting.unformat($(rows1[i]).find("td:eq(3)").html());
                    //console.log($(rows[i]).find("td:eq(3)").html());
                    console.log(chksvcchg); 
                }
                
                $('#service_charge').val(accounting.formatMoney(chksvcchg));
                
                var rows2 = $("#inttblearned").dataTable().fnGetNodes();
                for(var i=0;i<rows2.length;i++)
                {
                    // Get HTML of 3rd column (for example)
                    chkiechg += accounting.unformat($(rows2[i]).find("td:eq(3)").html());
                    //console.log($(rows[i]).find("td:eq(3)").html());
                    console.log(chkiechg); 
                }
                                
                
                $('#interest_earned').val(accounting.formatMoney(chkiechg));
                //$('#end_balance').val();

                var cb = accounting.unformat($('#beg_balance').val()),
                    cp = accounting.unformat($('#chkpay').val()),
                    doc = accounting.unformat($('#depoc').val()),
                    diff = accounting.unformat($('#end_balance').val()),
                    sc = accounting.unformat($('#service_charge').val()),
                    ie = accounting.unformat($('#interest_earned').val());
                    
                    //diff += ie;
                    //diff -= sc;
                    diff = ((glb_endbal + ie) - sc);
                    
                    $('#end_balance').val(accounting.formatMoney(diff));
                    
                    
                    console.log(glb_endbal);
                    
                    cb += (doc + ie);
                    cb -= (cp + sc);
                    
                   // cb += doc;
                   // cb -= cp;
                    
                    diff -= cb;
                    
                    $('#cleared_balance').val(accounting.formatMoney(cb));                    
                    $('#diff_rence').val(accounting.formatMoney(diff));
                
               
                   
                
          }
          
          
          /*
          
          function populatecpdoc(dt1,dt2)
          {
            console.log('???????????????');
              var sql =  "select dbo.NUM2DATE(v8RunDate) col1,Cast(CONVERT(DECIMAL(10,2),Amount) as nvarchar) Amt,CheckNumber,reference,(select Description from Modules WHERE Modules.ModuleID = MasterTRN.ModuleID) trntype ";
                  sql += "from MasterTRN where status=1 and DebitAcct='"+$('#acctglacc').val()+"' and dbo.NUM2DATE(v8rundate) between '"+dt1+"' and '"+dt2+"'";
              console.log(sql);
              var ll = $.post(MB.URLPoster(), { SQLStatement: sql });
              ll.success(function(data){
                 // var tbl = $('#othercredits').dataTable();
                  console.log(data);
                  if(data == '[]')
                  {
                      //console.log('empty???');
                      $('#msggl').html(' (no data found)');
                  } else {
                  //tbl.fnDestroy();
                  //$('#othercredits tbody').html('');
                  var t = $('#othercredits').DataTable();
                           
                   $.each(JSON.parse(data), function (key, value) {
 
                        t.row.add( [
                          '<input type="checkbox" name="ckboxothers[]" onclick="btnCompute()">',
                          value.col1,
                          value.CheckNumber,
                          value.reference,
                          value.trntype,
                          value.Amt
                      ] ).draw( false );
                                      
                        
                        
                                                                      
                    });  
                   // initTbl('othercredits');
                  }
                    
                  
              });

          }
          
          function populatecashpayments(dt1,dt2)
          {
            var sql =  "select dbo.NUM2DATE(v8RunDate) col1,Cast(CONVERT(DECIMAL(10,2),Amount) as nvarchar) Amt,CheckNumber,reference,(select Description from Modules WHERE Modules.ModuleID = MasterTRN.ModuleID) trntype ";
                  sql += "from MasterTRN where status=1 and CreditAcct='"+$('#acctglacc').val()+"' and dbo.NUM2DATE(v8rundate) between '"+dt1+"' and '"+dt2+"'";
              console.log(sql);
              var ll = $.post(MB.URLPoster(), { SQLStatement: sql });
              ll.success(function(data){
                 // var tbl = $('#othercredits').dataTable();
                  console.log(data);
                  if(data == '[]')
                  {
                      //console.log('empty???');
                     // $('#msggl').html(' (no data found)');
                  } else {
                  //tbl.fnDestroy();
                  //$('#othercredits tbody').html('');
                   //$('#checkspayments tbody').html('');
                   var t = $('#checkpayments').DataTable();
                   $.each(JSON.parse(data), function (key, value) {
                    
                      t.row.add( [
                      '<input type="checkbox" name="ckbox[]" onclick="btnCompute()">',
                      value.col1,
                      value.CheckNumber,
                      value.reference,
                      value.Amt                          
                      ]).draw(false);
                                                                         
                    });  
                   // initTbl('othercredits');
                  }
                    
                  
              });
            
          }
          
          function populatecheckpayments(dt1,dt2)
          {
              var sqlstmt = "select dbo.NUM2DATE(v8rundate) col1,checkid,IssuedTo,Cast(CONVERT(DECIMAL(10,2),Amount) as nvarchar) Amt from BankChecks where GLACC='"+$('#acctglacc').val()+"' and tag=1 and dbo.NUM2DATE(v8rundate) between '"+dt1+"' and '"+dt2+"'";
              console.log(sqlstmt);
              var ll = $.post(MB.URLPoster(), { SQLStatement: sqlstmt });
              ll.success(function(data){
                  
                  if(data == '[]')
                  {
                     // console.log('empty???');
                     // $('#msggl').html(' (no data found)');
                     
                  } else {
                 
                   var t = $('#checkpayments').DataTable();
                   $.each(JSON.parse(data), function (key, value) {

                        t.row.add( [
                      '<input type="checkbox" name="ckbox[]" onclick="btnCompute()">',
                      value.col1,
                      value.CheckNumber,
                      value.reference,
                      value.Amt                          
                      ]).draw(false);
                                                                         
                      });  
                                                                 
                   // });  
                    //initTbl('checkspayments');
                  }
                   
                                      
              });
              //console.log(sqlstmt);
          }
          
          */
          
          function populateDebitCredit(dt1,dt2,GLCODE)
          {
            var sv = "SELECT * FROM ( ";
                sv += "SELECT 'DC' TrnKind,X.TrnID,X.v8RunDate,dbo.NUM2DATE(v8runDate) TransDate,X.ModuleID,";
                sv += "(SELECT Description FROM Modules WHERE ModuleID= X.ModuleID) TransType,";
                sv += "X.CheckNumber,X.Amount,X.Amount Debit,0 Credit,X.Reference,";
                sv += "(SELECT COALESCE(Balance,0) FROM BankAccTrn WHERE MasterID=X.TrnID AND GLACC='" + GLCODE + "') Balance, Status ";
                sv += "FROM MasterTRN X ";
                sv += "WHERE X.DebitAcct='" + GLCODE + "' ";
                sv += "UNION ";
                sv += "SELECT 'CP' TrnKind,A.TrnID,A.v8RunDate,dbo.NUM2DATE(v8runDate) TransDate,A.ModuleID,";
                sv += "(SELECT Description FROM Modules WHERE ModuleID= A.ModuleID) TransType,";
                sv += "A.CheckNumber,A.Amount,0 Debit,A.Amount Credit,A.Reference,";
                sv += "(SELECT COALESCE(Balance,0) FROM BankAccTrn WHERE MasterID=A.TrnID AND GLACC='" + GLCODE + "') Balance, Status ";
                sv += "FROM MasterTRN A ";
                sv += "WHERE A.CreditAcct='" + GLCODE + "' ) C ";
                sv += "Where LEFT(C.ModuleID,2) <> 'BR' AND C.[Status]=1 AND C.v8RunDate >= "+dt1+" and C.v8RunDate <= "+dt2;
                console.log(sv);
                var ll = $.post(MB.URLPoster(), { SQLStatement: sv });
                ll.success(function(data){
                    //console.log(data);
                    //t = $('#othercredits').DataTable();
                    ($('#othercredits').DataTable()).rows().remove().draw();                   
                    //t = $('#checkpayments').DataTable();
                    ($('#checkspayments').DataTable()).rows().remove().draw();
                   // v.rows().remove().draw();
                    
                     
                     $.each(JSON.parse(data), function (key, value) {
                       //console.log(value.Debit);
                       //console.log(value.TrnKind);
                       
                       var Amount = accounting.formatMoney(value.Amount),
                       trnKnd = value.TrnKind.indexOf('CP') == 0,                       
                       td = value.TransDate,
                       cn = value.CheckNumber,
                       rf = value.Reference,
                       tt = value.TransType,
                       cb = '<input type="checkbox" value="'+value.ModuleID+'" name="ckboxothers[]" onclick="btnCompute()">',
                       it = '<input type="checkbox" name="intrans[]" />';
                       console.log(trnKnd); 
                       if(trnKnd)
                       {
                         t = $('#checkspayments').DataTable();
                         cb = '<input type="checkbox" value="'+value.ModuleID+'" name="ckbox[]" onclick="btnCompute()">';
                         //console.log('t row');                         
                       } else {
                         t = $('#othercredits').DataTable();                         
                       }
                      // console.log(MB.isEmpty(t));
                       
                       t.row.add( [
                       cb,
                       td,
                       cn,
                       rf,
                       tt,
                       Amount,
                       it
                       ] ).draw();
                       
                       /*
                       if(trnKnd)
                       { 
                          t = $('#checkpayments').DataTable();
                          console.log('t row');
                          t.row.add( [
                          '<input type="checkbox" name="ckbox[]" onclick="btnCompute()">',
                          td,
                          cn,
                          rf,
                          tt,
                          Amount                          
                          ] ).draw();
                       } 
                       else 
                       {
                          t = $('#othercredits').DataTable();
                          console.log('v row');
                          t.row.add( [
                          '<input type="checkbox" name="ckboxothers[]" onclick="btnCompute()">',
                          td,
                          cn,
                          rf,
                          tt,
                          Amount
                          ] ).draw();
                       }  
                       */
                     });
                 
                });
                

          }
          
          function date2num(thisdate)
          {
              var gt = new Date(thisdate),
              dt = (gt.getMonth()+1) + "/" + (gt.getDate()) + "/" + (gt.getFullYear()),
              tt = "1/1/1900",
              xx = (new Date(dt)).getTime() - (new Date(tt)).getTime();
              return (xx / (24*60*60*1000)) ;            
          }
          
          function selectchange(t)
          {
              console.log(t.value)
              if(!t)
              {
                return false;
              }
              $('#msggl').html('');
              var vstr = (t).split(":"),dt1 = date2num($('#recondate1').val()), dt2 = date2num($('#recondate2').val());
              $('#accttype').val(vstr[0]);
              $('#acctglacc').val(vstr[1]);   
                     
               if(isEmpty($('#recondate1').val()))
                    {
                        console.log('nodate');
                        alert('Date for start period must be supplied..');
                        return false;
                    }
                  if(isEmpty($('#recondate2').val()))
                    {
                        console.log('nodate');
                        alert('Date for end period must be supplied..');
                        return false;
                    }
            // validate recon from previous recon
            
            var sql = "SELECT COUNT(*) cnt FROM BankRecon2 WHERE reconedate > "+dt1+" AND bankgl = '"+$('#acctglacc').val()+"'";
            console.log(sql);
            var ll = $.post(MB.URLPoster(), { SQLStatement: sql });
            ll.success(function(data){
            if(JSON.parse(data)[0].cnt == 0)
            {
                console.log('Zero');
                sql = "SELECT beginning,ending FROM ( ";
                sql +="SELECT ( ";
                sql +="SELECT COALESCE(SUM(AMOUNT),";
                sql +="(SELECT TOP 1 Balance FROM BankAccTrn WHERE glacc= '"+$('#acctglacc').val()+"' AND v8Rundate >= "+date2num($('#recondate1').val())+")) ";
                sql +="FROM BankAccTrn WHERE glacc= '"+$('#acctglacc').val()+"' AND v8Rundate < "+date2num($('#recondate1').val())+") beginning, ( ";
                sql +="SELECT COALESCE(SUM(AMOUNT),(SELECT TOP 1 Balance FROM BankAccTrn WHERE glacc= '"+$('#acctglacc').val()+"')) ";
                sql +="FROM BankAccTrn WHERE v8Rundate <= "+date2num($('#recondate2').val())+" AND glacc= '"+$('#acctglacc').val()+"' ) ending ) A";
                
                console.log(sql);

             
             
                ll = $.post(MB.URLPoster(), { SQLStatement: sql });
                ll.success(function(data){
                      glb_endbal = 0; 
                      $.each(JSON.parse(data), function (key, value) {
                          $('#beg_balance').val(accounting.formatMoney(value.beginning));
                          $('#end_balance').val(accounting.formatMoney(value.ending));
                          glb_endbal = value.ending;
                          $('#cleared_balance').val(accounting.formatMoney(value.beginning));
                          $('#diff_rence').val(accounting.formatMoney(value.ending - value.beginning));
                      });
                      
                     
                  
                });
                ll.done(function(){
                     //if($('#beg_balance').val() == $('#end_balance').val())
                      //{
                     //   bootbox.alert('');
                     // } else {
                        populateDebitCredit(dt1,dt2,$('#acctglacc').val());  
                     // }                                         
                }); 
                
            } else {
              $('#beg_balance').val('$0.00');
              $('#end_balance').val('$0.00');
              ($('#othercredits').DataTable()).rows().remove().draw();     
              ($('#checkspayments').DataTable()).rows().remove().draw();     
              ($('#inttblearned').DataTable()).rows().remove().draw();     
              ($('#svctblcharge').DataTable()).rows().remove().draw();
               $('#cleared_balance').val('$0.00');                    
               $('#diff_rence').val('$0.00');         
              console.log('Recon Exists');
              bootbox.alert('Recon Already Exists!');
            }
              
              
            });
            
            //return;
            

            // get SOA        
                
                   
           
          }
          
          function begbalonkeypress()
          {
            //var ll = accounting.unformat($($).val())
          }
          
          function valid_date1(t)
          {
            console.log(t.value)
          }
          
          function valid_date2(t)
          {
            console.log(t.value)
          }
                 
                 // redo saving
                 // get the inserted ID and save it to bankrecon2 for reversal id   
          function saveintcharge()
          {
            var retval, inssql = [];
            var v8RunDate = MB.getCookie('sysdate'),
            userid = MB.getCookie('activeid'),
            GLACC = $('#acctglacc').val(),
            DT1 = date2num($('#recondate1').val()), DT2 = date2num($('#recondate2').val()),
            //sqlstmt = "insert into BankRecon2 (postdate,reconsdate,reconedate,recontag,transdate,bankgl,contragl,amount,glentry,tag,userid) values (";
            
            //service charge table
            rows1 = $("#svctblcharge").dataTable().fnGetNodes(),
            checks = document.getElementsByName('chksc[]');
            
            //console.log(rows1);
            for(var i=0;i<rows1.length;i++)
            {
                // Get HTML of 3rd column (for example)
                console.log('value of i : '+i);
                svcdate = $(rows1[i]).find("td:eq(1)").html();
                svcamount = accounting.unformat($(rows1[i]).find("td:eq(3)").html());
                svccontra = checks[i].value;

                   
                sql = "EXEC sp_processrecon " + date2num(svcdate)  + "," + DT1 + "," + DT2 + "," + v8RunDate  + ",'"+ GLACC +"','"+svccontra+"',"+svcamount+",'','','','','BR002','"+userid+"',0,1";
                console.log(sql);
                
                $.ajax({
                    type: "POST",
	                url: MB.URLPoster(),
	                data: { SQLStatement: sql },
                    async : false,
                    success : function(data) { 
                        console.log('success exec service charge table');
                    }
                }).fail(function(){
                    console.log('error on post SC : '+sql);
                });
          
            }
            
            //interest earned table
            rows1 = $("#inttblearned").dataTable().fnGetNodes();
            checks = document.getElementsByName('chkIE[]');
            for(var i=0;i<rows1.length;i++)
            {
                iedate = $(rows1[i]).find("td:eq(1)").html();
                ieamount = accounting.unformat($(rows1[i]).find("td:eq(3)").html());
                iecontra = checks[i].value; 
                // Get HTML of 3rd column (for example)
            
            
                    
                sql = "EXEC sp_processrecon " + date2num(iedate) + "," + DT1 + "," + DT2 + "," + v8RunDate + ",'"+ GLACC +"','"+iecontra+"',"+ieamount+",'','','','','BR001','"+userid+"',0,2";
                console.log(sql);

                $.ajax({
                type: "POST",
                url: MB.URLPoster(),
                data: { SQLStatement: sql },
                async : false,
                success : function(data) { 
                    console.log('success exec interest earned table');
                }
                }).fail(function(){
                    console.log('error on post IE : '+sql);
                });
              
             
           
              
             
            }   
           
            
                     
          }
          
          function savedepcred()
          {
            var retval;
            var v8RunDate = MB.getCookie('sysdate'),
            userid = MB.getCookie('activeid'),
            GLACC = $('#acctglacc').val(),
            DT1 = date2num($('#recondate1').val()), DT2 = date2num($('#recondate2').val()),
           // sqlstmt = "insert into BankRecon2 (postdate,reconsdate,reconedate,recontag,transdate,bankgl,amount,glentry,checkno,checkmemo,transtype,tag,userid) values (";

            checkboxes = document.getElementsByName('ckboxothers[]');
            for (var i = 0, n = checkboxes.length; i < n; i++) {
                if (checkboxes[i].checked) {
                    // cells 0 = checkbox
                    // cells 1 = Date
                    // cells 2 = Check#
                    // cells 3 = Memo
                    // cells 4 = Type    
                    // cells 5 = Amount
                                        
                    dpDate = document.getElementById('othercredits').rows[i + 1].cells[1].innerText;
                    dpAmount = accounting.unformat(document.getElementById('othercredits').rows[i + 1].cells[5].innerText);
                    dpCheckno = document.getElementById('othercredits').rows[i + 1].cells[2].innerText;
                    dpCheckmemo = document.getElementById('othercredits').rows[i + 1].cells[3].innerText;
                    dpTrntype = document.getElementById('othercredits').rows[i + 1].cells[4].innerText;
                    dpGlEntry = checkboxes[i].value;
                   
                   // sql = sqlstmt + v8RunDate + "," + DT1 + "," + DT2 + ",'DP'," + date2num(dpDate) + ",'"+GLACC+"',"+dpAmount+",'"+dpGlEntry+"','"+dpCheckno+"','"+dpCheckmemo+"','"+dpTrntype+"',1,'"+userid+"')";
                    //postdate,reconsdate,reconedate,recontag,transdate,bankgl,amount,checkno,checkmemo,transtype,tag,userid
                    //console.log(sql); 
                    
                    sql = "EXEC sp_processrecon " + v8RunDate + "," + DT1 + "," + DT2 + "," + date2num(dpDate) + ",'"+ GLACC +"','',"+dpAmount+",'"+dpCheckno+"','"+dpCheckmemo+"','','"+dpTrntype+"','"+dpGlEntry+"','"+userid+"',0,3";
                    console.log(sql);
                    MB.push(sql);
                    /*
                    setTimeout(function(){
                        $.post(MB.URLPoster(), { SQLStatement: sql }, function(data){
                          console.log('Deposits and Other Credits SQL Post Ok..');          
                        }).fail(function(data){
                        console.log('error on post Deposits and Other Credits : '+data);
                        });    
                        
                    },1000*i);
                    
                    */
                                                                     
                }
            }
            
          }
          
          function savecredpay()
          {
            //var dfrd1 = $.Deferred(); 
            var retval;
            var v8RunDate = MB.getCookie('sysdate'),
            userid = MB.getCookie('activeid'),
            GLACC = $('#acctglacc').val(),
            intransit = 0,
            DT1 = date2num($('#recondate1').val()), DT2 = date2num($('#recondate2').val()),
           // sqlstmt = "insert into BankRecon2 (postdate,reconsdate,reconedate,recontag,transdate,bankgl,amount,glentry,checkno,payee,tag,userid,intransit) values (";

            checkboxes = document.getElementsByName('ckbox[]');
            for (var i = 0, n = checkboxes.length; i < n; i++) {
                if (checkboxes[i].checked) {
                    // cells 0 = checkbox
                    // cells 1 = Date
                    // cells 2 = Check#
                    // cells 3 = Payee
                    // cells 4 = Amount  
                    // cells 5 = Intransit Tag 
                   
                                        
                    cpDate = document.getElementById('checkspayments').rows[i + 1].cells[1].innerText;
                    cpAmount = accounting.unformat(document.getElementById('checkspayments').rows[i + 1].cells[4].innerText);
                    cpCheckno = document.getElementById('checkspayments').rows[i + 1].cells[2].innerText;
                    cpPayee = document.getElementById('checkspayments').rows[i + 1].cells[3].innerText;
                    cpchecktransit = document.getElementsByName('intrans[]');
                    cpGlEntry = checkboxes[i].value;
                    intransit = 0;
                    if(cpchecktransit[i].checked)
                    {
                        intransit = 1;
                    }
                    
                    
                   sql = "EXEC sp_processrecon " + v8RunDate + "," + DT1 + "," + DT2 + "," + date2num(cpDate) + ",'"+ GLACC +"','',"+cpAmount+",'"+cpCheckno+"','','"+cpPayee+"','','"+cpGlEntry+"','"+userid+"',"+intransit+",4";
                   // sql = sqlstmt + v8RunDate + "," + DT1 + "," + DT2 + ",'CP'," + date2num(cpDate) + ",'"+GLACC+"',"+cpAmount+",'"+cpGlEntry+"','"+cpCheckno+"','"+cpPayee+"',1,'"+userid+"',"+intransit+")";
                    //postdate,reconsdate,reconedate,recontag,transdate,bankgl,amount,checkno,payee,tag,userid
                    //console.log(sql); 
                    //return;
                    MB.push(sql);
                    /*
                    setTimeout(function(){
                        $.post(MB.URLPoster(), { SQLStatement: sql }, function(data){
                        console.log('Checks and Other Payments SQL Post Ok..');          
                        }).fail(function(data){
                        console.log('error on post Checks and Other Payments : '+data);
                        });
                    },1000*i);           
                    */                                      
                }
            }
            /*
            if(i >= n)
            {
                dfrd1.resolve();
            }
            
            return dfrd1.promise();
            */
            
          }
          function checktrans()
          {
              return $('#beg_balance').val() == $('#end_balance').val();
          }
          
          // intransit checks & deposits
          
          
          function btnReconcile()
          {
            
            bootbox.confirm("Reconcile Now?", function(result) {

              if(result) {
                  if(checktrans())
                    {
                        bootbox.alert('no transaction');
                        return;
                    }
                    
            btnCompute();
            //saveintcharge();
            //savedepcred();
            //savecredpay();
            //return;
            var sb = $('#beg_balance').val(), 
                cb = $('#cleared_balance').val(),
                eb = $('#end_balance').val();
                if(sb==eb)
                {
                     bootbox.alert('no transaction');
                } else {
                    if(cb==eb)
                    {
                      console.log('proceed with item recon'); 
                      // tables for recon
                      // checkspayments,othercredits
                      // svctblcharge,inttblearned
                      
                      savedepcred();
                      savecredpay();
                      saveintcharge();
                      
                      bootbox.alert('Recon Complete..',function(){
                          window.location = "/Bank-Recon2Report";
                      });
                      
                    } else {
                      bootbox.alert('unable to reconcile items');
                    }
                }
              } else {
                return;
              }

            });
            
          }
          
         function changecheck1()
         {
           console.log('?checked?');                     
         }

         
        /// number to words with decimal - http://www.rgagnon.com/javadetails/java-0426.html 
        /// https://www.youtube.com/watch?v=w_jgEZnhNp4
        /// https://www.youtube.com/watch?v=6eBBzTnGSi8
        
        $('#chk1pay').click(function(){
          console.log('chk1pay');
          
        });
        
        //$('#btnAll1').on('click',function(){          
        //  alert('click');
        //});
        function btnAll1()
        {
          alert('click');
        }
        
        
          

          
        </script>
        
        <script>
          $(document).ready(function () {

            initTbl('othercredits');
            //initTbl('checkspayments');
            //initTbl('svctblcharge');
            //initTbl('inttblearned');
            
            $('#checkspayments').DataTable({
              "sDom": '<"top">rt<"bottom"lp><"clear">',
              "sScrollY": "220px",
              "scrollCollapse": true,
              "bPaginate": false,
              "columnDefs" : [
                { 
                    "targets": [ 4 ],
                    "visible": false,
                    "searchable": false               
                }
                
              ]
              
            });
            
            $('#inttblearned').DataTable({
              "sDom": '<"top">rt<"bottom"lp><"clear">',
              "sScrollY": "220px",
              "scrollCollapse": true,
              "bPaginate": false,
              "columnDefs" : [
                { 
                    "targets": [ 4 ],
                    "visible": false,
                    "searchable": true               
                }
                
              ]
              
            });
            $('#svctblcharge').DataTable({
              "sDom": '<"top">rt<"bottom"lp><"clear">',
              "sScrollY": "220px",
              "scrollCollapse": true,
              "bPaginate": false,
              "columnDefs" : [
                { 
                    "targets": [ 4 ],
                    "visible": false,
                    "searchable": true               
                }
                
              ]
              
            });
         
            var ll = $.post(MB.URLPoster(), { SQLStatement: "select BankName,BankAccountNum,BankAccountType,GLACC,dbo.TRIM(cast(BankAccountType as varchar))+':'+GLACC as idkey  from BankAccounts" });
            
            ll.success(function (data) {
                $.each(JSON.parse(data), function (key, value) {
                    TITLE = value.BankName + ' - (ACCT# '+value.BankAccountNum+')';
                    $('#glcode').append("<option value='" + value.idkey + "'>" + TITLE + "</option>");                   
                });            
            });
            
            ll.done(function(data){                    
                    console.log('done! '+$('#glcode').val());    
                    selectchange($('#glcode').val());
            });

          });
        </script>
      
      



  </body>
</html>
