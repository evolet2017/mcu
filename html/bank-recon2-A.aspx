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
                For Start Period <input type="date" class="form-control input-sm" id="recondate1" onblur="valid_date1(this)"/>
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
              Beginning Balance <input type="text" style="text-align:right" id="beg_balance" class="form-control input-sm" value="0.00" onkeyup="return isNumber(this)"   />
            </div>
            <div class="col-sm-3">
              Ending Balance <input type="text" style="text-align:right" id="end_balance" class="form-control input-sm" value="0.00" onkeypress="return isNumber(event)" />  
            </div>
            <div class="col-sm-3">
              <div class="input-group input-group-sm">
              Service Charge -&nbsp;<small><span id="gl1">()</span></small><input type="text" style="text-align:right" id="service_charge" onblur="btnCompute()" class="form-control input-sm" value="0.00" onkeyup="return isNumber(event)" />
              <span class="input-group-btn">
                <br />
                <button type="button" class="btn btn-default btn-flat" id="btnSC">GL Code</button>
              </span>              
              </div>
            </div>                    
            <div class="col-sm-3">
              <div class="input-group input-group-sm">
              Interest Earned <span id="gl2">()</span><input type="text" style="text-align:right" id="interest_earned" onblur="btnCompute()" class="form-control input-sm" value="0.00" onkeyup="return isNumber(event)" />
              <span class="input-group-btn">
                <br />
                <button type="button" class="btn btn-default btn-flat" id="btnIE">GL Code</button>
              </span>              
              </div>
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
            <div class="col-xs-6">
                <label>Checks and Payments</label>
                <table id="checkspayments" cellspacing="0" width="100%">
                    <thead>
                        
                            <td width="10"/></td>
                            <!-- th width="10"><button id="btnAll1" class="button btn-sm">A</button></th -->
                            <td>Date</td>
                            <td>Chk#</td>
                            <td>Payee</td>
                            <td>Amount</td>
                       
                       
                    </thead>
                    <tbody>
                        <!-- tr>
                            <td>1</td>
                            <td>01/01/2015</td>
                            <td>CH2234</td>
                            <td>Nemo</td>
                            <td>$1,500.00</td>
                        </tr -->

                    </tbody>
                </table>
                <input type="button" onclick="SelectButton('chkAllCP','ckbox')" id="chkAllCP" class="btn btn-xs" value="Select All" />
                <hr />
                

            </div>
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
                <label>Service Charge</label>
                <table class="display" id="svctblcharge" cellspacing="0" width="100%">                 
                  <thead>
                            <td width="10"></td>
                            <td>Date</td>
                            <td>GL Reference</td>
                            <td>Amount</td>                                                
                  </thead>
                  <tbody></tbody>
                </table>
                <input type="button" class="btn btn-xs" value="Select All" />
                <input type="button" class="btn btn-xs" value="Add" />
                <input type="button" class="btn btn-xs" value="Delete" />
                
                <hr />
            </div>
            <div class="col-xs-6">
                <label>Interest Earned</label>
                <table class="display" id="inttblearned" cellspacing="0" width="100%">                 
                  <thead>
                        
                            <td width="10"></td>
                            <td>Date</td>
                            <td>GL Reference</td>
                            <td>Amount</td>                                                

                  </thead>
                  <tbody></tbody> 
                </table>
                <input type="button"  class="btn btn-xs" value="Select All" />
                <hr />
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
		
		
        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>
        <script src="/html/js/bootbox.js" type="text/javascript"></script>
        
        <script src="/html/js/accounting.min.js" type="text/javascript"></script>
        <script src="/html/js/bankrecon2.js" type="text/javascript"></script>

        
      <script>
          
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
          
          
          $('#btnSC').on('click',function(){
                
                var retval  = $.post(MB.URLPoster(), { SQLStatement: "SELECT glacc,title FROM glac" });
                retval.success(function(data){
                 // console.log(data);
                  var picklist = "SELECT GL <select id='pickgl' class='form-control'>";
                  $.each(JSON.parse(data), function(key,value){
                    picklist += "<option value='"+value.glacc+"'>"+value.title;                    
                  }); 
                  picklist += "</select>";
                  bootbox.dialog({
                    title: "Service Charge Account Ledger.",
                    message: picklist,
                    buttons: {
                        success: {
                            label: "Save",
                            className: "btn-success",
                            callback: function () {
                                var name = $('#pickgl').val();                               
                                $('#gl1').text(name);
                            }
                        }
                    }
                  });       
                });
                
            
              
                   
            
            
          });
          
           $('#btnIE').on('click',function(){
            alert('IE');            
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
              
              console.log('inittbl');
             
         }  

       
              
         ///     $('#othercredits').dataTable();
          //    $('#checkspayments').dataTable();


          //function init() {
          $(document).ready(function () {
              
         initTbl('othercredits');
         initTbl('checkspayments');
         initTbl('svctblcharge');
         initTbl('inttblearned');
             
              
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
                

              // }
          });
          
          
          function btnleave()
          {
            window.location = '/Main';
            
            
          }
          
          function btnCompute()
          {
                console.log('btnleave');
              
                
                var checkboxes = document.getElementsByName('ckbox[]');
                var chkpay = 0, chkcnt = 0;
                
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
                
                
                var cb = accounting.unformat($('#beg_balance').val()),
                    cp = accounting.unformat($('#chkpay').val()),
                    doc = accounting.unformat($('#depoc').val()),
                    diff = accounting.unformat($('#end_balance').val()),
                    sc = accounting.unformat($('#service_charge').val()),
                    ie = accounting.unformat($('#interest_earned').val());
                    
                    cb += (doc + ie);
                    cb -= (cp + sc);
                    
                    diff -= cb;
                    
                    $('#cleared_balance').val(accounting.formatMoney(cb));                    
                    $('#diff_rence').val(accounting.formatMoney(diff));
                
               
                   
                
          }
          
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
                     /*
                       var tdval = '<tr>'; 
                       tdval += '<td><input type="checkbox" name="ckboxothers[]" onclick="btnCompute()"> </td>';                     
                       tdval += '<td>'+value.col1+'</td>';
                       tdval += '<td>'+value.CheckNumber+'</td>';
                       tdval += '<td>'+value.reference+'</td>';
                       tdval += '<td>'+value.trntype+'</td>';
                       tdval += '<td>'+value.Amt+'</td>';
                       tdval += '</tr>';  
                     
                        $('#othercredits tbody').append(tdval);        
                        */
                        //
                        //console.log(value.trntyp)
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
                     /*
                       var tdval = '<tr>'; 
                       tdval += '<td><input type="checkbox" name="ckbox[]" onclick="btnCompute()"> </td>';                     
                       tdval += '<td>'+value.col1+'</td>';
                       tdval += '<td>'+value.CheckNumber+'</td>';
                       tdval += '<td>'+value.reference+'</td>';                  
                       tdval += '<td>'+value.Amt+'</td>';
                       tdval += '</tr>';                                              
                      $('#checkspayments tbody').append(tdval);    
                      */
                      //                      
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
                     /*
                       var tdval = '<tr>'; 
                       tdval += '<td><input type="checkbox" name="ckbox[]" onclick="btnCompute()"> </td>';                     
                       tdval += '<td>'+value.col1+'</td>';
                       tdval += '<td>'+value.checkid+'</td>';
                       tdval += '<td>'+value.IssuedTo+'</td>';
                       tdval += '<td>'+value.Amt+'</td>';
                       tdval += '</tr>';  
                       //console.log(tdval);        
                        $('#checkspayments tbody').append(tdval);         
                        */
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
          
          function populateDebitCredit(dt1,dt2,GLCODE)
          {
            var sv = "SELECT * FROM ( ";
                sv += "SELECT X.TrnID,X.v8RunDate,dbo.NUM2DATE(v8runDate) TransDate,X.ModuleID,";
                sv += "(SELECT Description FROM Modules WHERE ModuleID= X.ModuleID) TransType,";
                sv += "X.CheckNumber,X.Amount,X.Amount Debit,0 Credit,X.Reference,";
                sv += "(SELECT COALESCE(Balance,0) FROM BankAccTrn WHERE MasterID=X.TrnID AND GLACC='" + GLCODE + "') Balance, Status ";
                sv += "FROM MasterTRN X ";
                sv += "WHERE X.DebitAcct='" + GLCODE + "' ";
                sv += "UNION ";
                sv += "SELECT A.TrnID,A.v8RunDate,dbo.NUM2DATE(v8runDate) TransDate,A.ModuleID,";
                sv += "(SELECT Description FROM Modules WHERE ModuleID= A.ModuleID) TransType,";
                sv += "A.CheckNumber,A.Amount,0 Debit,A.Amount Credit,A.Reference,";
                sv += "(SELECT COALESCE(Balance,0) FROM BankAccTrn WHERE MasterID=A.TrnID AND GLACC='" + GLCODE + "') Balance, Status ";
                sv += "FROM MasterTRN A ";
                sv += "WHERE A.CreditAcct='" + GLCODE + "' ) C ";
                sv += "Where LEFT(C.ModuleID,2) <> 'BR' AND C.[Status]=1 AND C.v8RunDate >= "+dt1+" and C.v8RunDate <= "+dt2;
                console.log(sv);
                var ll = $.post(MB.URLPoster(), { SQLStatement: sv });
                ll.success(function(data){
                    console.log(data);
                     var t = $('#checkpayments').DataTable();
                     var v =  $('#othercredits').DataTable();
                     $.each(JSON.parse(data), function (key, value) {
                       console.log(value.Debit);
                       var Amount = accounting.formatMoney(value.Amount);
                       if(parseFloat(value.Credit) > 0)
                       { 
                          t.row.add( [
                          '<input type="checkbox" name="ckbox[]" onclick="btnCompute()">',
                          value.TransDate,
                          value.CheckNumber,
                          value.Reference,
                          Amount                          
                          ]).draw(false);
                         
                       } 
                       else 
                       {
                          v.row.add( [
                          '<input type="checkbox" name="ckboxothers[]" onclick="btnCompute()">',
                          value.TransDate,
                          value.CheckNumber,
                          value.Reference,
                          value.TransType,
                          Amount
                          ] ).draw( false );
                                      
                         
                       }
                       
                       
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
              
             // populateDebitCredit(dt1,dt2,$('#acctglacc').val());
               
                                     
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
            // get SOA        
            var sql = "SELECT beginning,ending FROM ( ";
                sql +="SELECT ( ";
                sql +="SELECT COALESCE(SUM(AMOUNT),";
                sql +="(SELECT TOP 1 Balance FROM BankAccTrn WHERE glacc= '"+$('#acctglacc').val()+"' AND v8Rundate >= "+date2num($('#recondate1').val())+")) ";
                sql +="FROM BankAccTrn WHERE glacc= '"+$('#acctglacc').val()+"' AND v8Rundate < "+date2num($('#recondate1').val())+") beginning, ( ";
                sql +="SELECT COALESCE(SUM(AMOUNT),(SELECT TOP 1 Balance FROM BankAccTrn WHERE glacc= '"+$('#acctglacc').val()+"')) ";
                sql +="FROM BankAccTrn WHERE v8Rundate <= "+date2num($('#recondate2').val())+" AND glacc= '"+$('#acctglacc').val()+"' ) ending ) A";
            /*                              
             var sql = "SELECT beginning,ending FROM ";
                    sql +=    "( SELECT ";
                    sql +=    "(SELECT top 1 balance FROM BankAccTrn WHERE "; 
                    sql +=    "v8Rundate >= "+date2num($('#recondate1').val())+" AND glacc= '"+$('#acctglacc').val()+"' AND Balance is NOT NULL) beginning,";
                    sql +=    "( ";
                    sql +=    "SELECT top 1 balance FROM BankAccTrn WHERE "; 
                    sql +=    "v8Rundate <= "+date2num($('#recondate2').val())+" AND glacc= '"+$('#acctglacc').val()+"' AND Balance is NOT NULL  ORDER BY id DESC ) ending ";
                    sql +=    ") A ";  
              */      
              console.log(sql);
              
              var tbl = $('#checkspayments').DataTable();
              tbl.rows().remove().draw();
              
              tbl = $('#othercredits').DataTable();
              tbl.rows().remove().draw();     
              
              
              
              var ll = $.post(MB.URLPoster(), { SQLStatement: sql });
              ll.success(function(data){
                    $.each(JSON.parse(data), function (key, value) {
                    $('#beg_balance').val(accounting.formatMoney(value.beginning));
                    $('#end_balance').val(accounting.formatMoney(value.ending));
                    $('#cleared_balance').val(accounting.formatMoney(value.beginning));
                    $('#diff_rence').val(accounting.formatMoney(value.ending - value.beginning));
                    });
                
              });
              ll.done(function(){
                populateDebitCredit(dt1,dt2,$('#acctglacc').val());
                //console.log('checking');                      
                //populatecheckpayments($('#recondate1').val(),$('#recondate2').val());                      
                // set difference for ending balance and cleared balance..                                            
              });    
                                   
              /*  
              if(parseInt(vstr)==2)
              {              
                    var ll = $.post(MB.URLPoster(), { SQLStatement: sql });
                    ll.success(function(data){
                         $.each(JSON.parse(data), function (key, value) {
                          $('#beg_balance').val(accounting.formatMoney(value.beginning));
                          $('#end_balance').val(accounting.formatMoney(value.ending));
                          $('#cleared_balance').val(accounting.formatMoney(value.beginning));
                          $('#diff_rence').val(accounting.formatMoney(value.ending - value.beginning));
                         });
                      
                    });
                    ll.done(function(){
                      //console.log('checking');                      
                      populatecheckpayments($('#recondate1').val(),$('#recondate2').val());                      
                      // set difference for ending balance and cleared balance..                                            
                    });                                
              } else {
                   var ll = $.post(MB.URLPoster(), { SQLStatement: sql });
                    ll.success(function(data){
                         $.each(JSON.parse(data), function (key, value) {
                          $('#beg_balance').val(accounting.formatMoney(value.beginning));
                          $('#end_balance').val(accounting.formatMoney(value.ending));
                          $('#cleared_balance').val(accounting.formatMoney(value.beginning));
                          $('#diff_rence').val(accounting.formatMoney(value.ending - value.beginning));
                         });
                      
                    });
                    ll.done(function(){
                        populatecashpayments($('#recondate1').val(),$('#recondate2').val());
                    });                              
                  //console.log('cash');
              }   
              populatecpdoc($('#recondate1').val(),$('#recondate2').val());     
              
              */   
              
            //  initTbl('othercredits');
            //  initTbl('checkspayments');
              
              
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
                    
          function saveintcharge()
          {
            var v8RunDate = MB.getCookie('sysdate'),
            userid = MB.getCookie('activeid'),
            GLACC = $('#acctglacc').val(),
            
            IntAmount = accounting.unformat( $('#interest_earned').val() ),
            SvcAmount = accounting.unformat( $('#service_charge').val() ),
            sqlstmt = "";
            //sqlstmt =  "INSERT INTO MasterTRN (v8RunDate,TrnDate,DebitAcct,CreditAcct,Amount,GLTrnType,ModuleID,Reference,Remarks,Status,UserID,CheckNumber) VALUES ";
            //sqlstmt += "('"+v8RunDate+"',now(),'','',0,'','','','',1,'"+userid+"','0')";
            if(!isNaN(IntAmount))
            {
            sqlstmt = "UpdateMaster "+GLACC+","+IntAmount+",'BR001','@trnRef','@trnRem',"+userid;
            }
            if(!isNaN(SvcAmount))
            {
            sqlstmt = "UpdateMaster "+GLACC+","+SvcAmount+",'BR002','@trnRef','@trnRem',"+userid;
            }
            
            
            
            
                                    
          }
          
          
          function btnReconcile()
          {
            btnCompute();
            var cb = $('#cleared_balance').val(),
                eb = $('#end_balance').val();
                
                if(cb==eb)
                {
                  console.log('proceed with item recon'); 
                } else {
                  alert('unable to reconcile items');
                }
          }
          
         function changecheck1()
         {
           console.log('?checked?');                     
         }

         

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
      
      



  </body>
</html>
