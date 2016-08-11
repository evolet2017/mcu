<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Debug="true"
    Inherits="bankingdeposit"
    ViewStateEncryptionMode="Always" CodeFile="banking-deposit.aspx.cs" %>
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

        <!-- Theme style -->
        <link href="/html/css/AdminLTE.css" rel="stylesheet" type="text/css" />

        <!-- Theme style -->
        <link href="/html/css/alertify.bootstrap.css" rel="stylesheet" type="text/css" />


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
          <script src="/html/js/html5shiv.js"></script>
          <script src="/html/js/respond.min.js"></script>
        <![endif]-->

       <!-- jQuery 2.0.2 -->
        <script src="/html/js/jquery.js"></script>
        <script src="/html/js/mbphillib.js"></script> 
        <script src="/html/js/bootbox.js"></script>
         

           

              <!-- DATA TABES SCRIPT -->
        <script src="/html/js/plugins/datatables/jquery.dataTables.js" type="text/javascript"></script>
        <script src="/html/js/plugins/datatables/dataTables.bootstrap.js" type="text/javascript"></script>
        <script src="/html/js/accounting.min.js" type="text/javascript"></script>
      <script src="/html/js/banklibrary.js"></script>
        
    
     
      
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
            <a href="#"><i class="fa fa-circle text-success"></i>  Online</a>
          </div>
        </div>
     <ul class="sidebar-menu">
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
        <h1>Bank Deposit</h1>
        <ol class="breadcrumb">
          <li>
            <a href="/Main"><i class="fa fa-dashboard"></i> Home</a>
          </li>
          <li class="active">Bank Deposit</li>
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
			  
			
			      <div class="box-body">
            
                 
                  <div class="form-group">
                 
                  <script>
                      if (MB.getParameterByName("pass_type") !== "") {
                      } else {
                         document.write('<label for="">Bank Account</label>');
                      }

                  </script>
                   
                  <select id="frmSelect" class="form-control input-lg" onchange="BankDeposit.bankinfo(this.value)">
                  <%
                      string connStr = GenericDB.GetXML("mcu", "connectionstring"); // ConfigurationManager.ConnectionStrings["SQLTest"].ConnectionString;
                     SqlDataReader dr = GenericDB.ExecSQL(connStr,@"select A.GLACC,A.BankName,B.accounttype,A.BankAccountNum,(SELECT 'selected' from appconfig where mbfield1='Deposit' and mbvalue=a.GLACC) as vselect from BankAccounts A LEFT JOIN accounttype B on A.BankAccountType=B.id WHERE 1=1 AND BankAcctStatus=1 AND A.GLACC<>''");
                     var _BankName = string.Empty;
                     var _GLACC = string.Empty;
                     var _vSelect = string.Empty;
                       
                   //  var ii = 0;
                      while(dr.Read())
                      {
                          _BankName = dr["BankName"].ToString();
                          _GLACC = dr["GLACC"].ToString();
                          _vSelect = dr["vselect"].ToString();
                          %>
                            <option value="<%=_GLACC%>" <%=_vSelect%>><%=_BankName %></option>
                          <%
                          //Response.Write("<option value='" + _GLACC + "' " + _vSelect + " >" + _BankName + "</option>");
                      }
                      dr.Close();
                  %>
                  </select>

                      <script>
                          if (MB.getParameterByName("pass_type") !== "") {
                              $('#frmSelect').hide();
                          }

                      </script>
                      <div id="infodisplay" class="box box-info">
                                <div class="box-header">
                                    <h3 class="box-title">Information</h3>
                                    <div class="box-tools pull-right">
                                        <div>
                                             <button class="btn btn-primary btn-xs" data-widget="collapse"><i class="fa fa-minus"></i></button>
                                       
                                        </div>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <table>
                                        <tr>
                                            <td width="150px">Account Type</td>
                                            <td>:</td>
                                            <td><div id="accttype"></div></td>
                                        </tr>
                                         <tr>
                                            <td width="150px">Account number</td>
                                             <td>:</td>
                                            <td><div id="acctnum"></div></td>
                                        </tr>
                                        <tr>
                                            <td width="150px">General Ledger Code</td>
                                            <td>:</td>
                                            <td><div id="glcode"></div></td>
                                        </tr>
                                        <tr>
                                            <td width="150px">Balance</td>
                                            <td>:</td>
                                            <td><div id="glbalance"></div></td>
                                        </tr>
                                    
                                    </table>
                                   
                                    
                                </div><!-- /.box-body -->
                                <div class="box-footer" >

                                </div><!-- /.box-footer-->
                      </div><!-- /.box -->

                       <div id="chequedeposit" class="box box-info">
                                <div class="box-header">
                                    <h3 class="box-title">Check Savings</h3>
                                    <div class="box-tools pull-right">
                                        <div>
                                             <button class="btn btn-primary btn-xs" data-widget="collapse"><i class="fa fa-minus"></i></button>
                                       
                                        </div>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <table>
                                        <tr>
                                            <td width="150px">Account Type</td>
                                            <td>:</td>
                                            <td><div id="Div2"></div></td>
                                        </tr>
                                         <tr>
                                            <td width="150px">Account number</td>
                                             <td>:</td>
                                            <td><div id="Div3"></div></td>
                                        </tr>
                                        <tr>
                                            <td width="150px">General Ledger Code</td>
                                            <td>:</td>
                                            <td><div id="Div4"></div></td>
                                        </tr>
                                    
                                    </table>
                                   
                                    
                                </div><!-- /.box-body -->
                                
                      </div><!-- /.box -->

                      <script>
                          $('#chequedeposit').hide();

                      </script>

                  </div>
                  <!-- form-group-->
                    <br />
                    <script>
                        if (MB.getParameterByName("pass_type") !== "") {
                            document.write('<label for="">Check Posting</label>');
                            $('#infodisplay').css('display', 'none');
                        } else {
                            if (MB.getParameterByName("pass_amt") !== "") {
                                document.write('<label for="">Cash Posting</label>');
                            } else {
                                document.write('<label for="">Transaction Type</label>');
                            }
                        }
                    </script>
                    
                    <br />
                  <div class="form-group">
                      <ul class="nav nav-tabs" id="trntab">
                          <script>
                              if (MB.getParameterByName("pass_amt") === "") {
                                  $('#trntab').append('<li class="active"><a data-toggle="tab" id="tab1" href="#tab_1">Cash</a></li>' +
                                                       '<li class=" "><a data-toggle="tab" id="tab2" href="#tab_2">Checks</a></li>');
                              }
                          </script>
                          			  
					  </ul>

                      <div class="tab-content">	
                          <div id="tab_1"  class="tab-pane active">
                               <!-- form group-- reyj -->
                              <br />
                              <div class="form-group">
                                  <label class="">Amount</label> 
                                  <script>
                                      if (MB.getParameterByName('pass_amt') != "") {
                                          document.write('<input class="form-control input-lg currency numbersOnly" type="text" id="frmBankDepoAmt" placeholder="$0.00" readonly="true" />');
                                      } else {
                                          document.write('<input class="form-control input-lg currency numbersOnly" type="text" id="frmBankDepoAmt" placeholder="$0.00" required />');
                                      }
                                  </script>
                                  <!-- input class="form-control input-lg currency numbersOnly" type="text" id="frmBankDepoAmt" placeholder="$0.00" required / -->                  
                                  <label class="">Transaction Reference</label> 
                                  <input class="form-control input-lg" type="text" id="frmReference" placeholder="" required />
                                  <script>
                                      if(MB.getParameterByName('pass_amt') === ""){
                                          document.write('<div class="box-footer">');
                                          document.write('<Button class="btn btn-primary" ID="BankSave" onclick="BankDeposit.postcash(this)" >POST</Button>&nbsp;&nbsp;' +
                                            '<Button class="btn btn-danger" onclick="BankDeposit.BAIL();">Cancel</Button>');
                                          document.write('</div>');
                                          
                                      }
                                  </script>
                                 
                              </div>
                              
                              <!-- form group-->
                          </div>

                          <div id="tab_2"  class="tab-pane">
                                  <br />
                                  <div class="form-group">
                                      <label class="">Issuing Bank</label> 
                                      <input class="form-control input-lg" type="text" id="chkIssuingBank" placeholder="" />  
                                      <label class="">Issued By</label> 
                                      <input class="form-control input-lg" type="text" id="chkIssuedBy" placeholder="" />                 
                                      <label class="">Check Number</label> 
                                      <input class="form-control input-lg currency numbersOnly" type="text" id="chkNumber" placeholder="" />  
                                      <label class="">Date</label> 
                                      <input class="form-control input-lg" type="date" id="chkDate"  />
                                      <label class="">Check Amount</label> 
                                      <input class="form-control input-lg currency numbersOnly" type="text" id="chkAmount" placeholder="$0.00" />                 
                                      <label class="">Transaction Reference</label> 
                                      <input class="form-control input-lg" type="text" id="chkReference" placeholder="" />
                                      <label class="">Particulars</label> 
                                      <input class="form-control input-lg" type="text" id="chkParticular" placeholder="" />

                                      <script>
                                          if (MB.getParameterByName('pass_amt') === "") {
                                              document.write('<div class="box-footer">');
                                              document.write('<Button class="btn btn-primary" ID="BankSave" onclick="BankDeposit.postcheck(this)" >POST</Button>&nbsp;&nbsp;' +
                                                '<Button class="btn btn-danger" onclick="BankDeposit.BAIL();">Cancel</Button>');
                                              document.write('</div>');
                                          }
                                  </script>
                                  </div>
                              
                          </div>

                           <div id="tab_3"  class="tab-pane">
                                  <br />
                                  <div class="form-group">
<%--                                     
                                      <input class="form-control input-lg" type="text" placeholder="Reference" id="Reference" size="20" />
                                      <hr />
                                      <select class="form-control" id="frmSelect2">
                                          <script> document.write($('#frmSelect').html()) </script>
                                      </select><br />
                                      <input class="form-control input-lg currency" type="text" placeholder="Check#" id="Check" size="20" /><br />
                                      <input class="form-control input-lg currency" type="text" placeholder="Amount" id="Amount" size="20" /><br />--%>
                                      <!-- input type="text" value="" placeholder="Account number" size="20" / -->
                                      <!--
                                      <button type="button" class="btn btn-primary" onclick="BankDeposit.CheckEntry()">Post Entry</button><br /><br />
                                      -->
                                      <table id="example2" class="table table-bordered">
                                          <thead><tr>
                                              <th></th>
                                              <th>Check#</th>
                                              <th>Amount</th>
                                              <th>Bank Account</th>
                                              <th>Reference</th>
                                              <th>Status</th></tr>
                                          </thead>
                                          <tbody>
                                             
                                             <%-- <tr>
                                              <td width=10px></td>
                                              <td id="Tb0"><input type="text" value="" placeholder="Check#" size="20" /></td>
                                              <td id="Tc0"><input type="text" value="" placeholder="Amount" size="20" /></td>
                                              <td id="Td0"><input type="text" value="" placeholder="Account number" size="20" /></td>
                                              <td id="Te0"><input type="text" value="" placeholder="Reference" size="20" /></td>
                                              <td><button type="button" id="post" value="INSERT INTO 1,772839-12382,[$72,000.00]" class="btn btn-primary" onclick="PostDeposit(this);">Post</button></td>
                                              </tr> --%>      
                                          </tbody>
                                      </table>

                                  </div>
                              
                          </div>
                      </div>

                      <script>
                          function checkme(t) {
                              var html_txt = '<h2>Select Transaction type</h2><br><h3><select>';
                              html_txt += '<option>Cash Deposit</option>';
                              html_txt += '<option>Check Deposit</option>';
                              html_txt += '<option>Accounts Payables</option>';
                              html_txt += '</select></h3>';
                              bootbox.confirm(html_txt, function (result) {
                                  this.value += $('select.option').val();
                                  bootbox.alert(this.value);

                              });


                          }
                         
                          if (MB.getParameterByName("pass_type") !== "") {
                              $('#tab_1').hide();
                              $('#tab_2').hide();
                              $('#tab_3').show();
                              BankDeposit.bankcheckload();

                          }
                      </script>


                  </div>
                  <!-- -->
                 
             
                </div>
				<div class="box-footer">
                                
		            <script>
		                if (MB.getParameterByName("pass_amt") !== "") {
		                    if (MB.getParameterByName("pass_type") === "") {
		                        document.write('<Button class="btn btn-primary" ID="BankSave2" onclick=BankDeposit.postcash("BankSaveMe2") >POST</Button>&nbsp;&nbsp;' +
                                             '<Button class="btn btn-danger" onclick="BankDeposit.BAIL()">Cancel</Button>');
		                        
		                      
		                    }

		                }
		            </script>
                    <br />
                    <br />
                            <div class="box-footer" id="infocashdeposit" style="display:none">
                                    <label><h4>Received Transaction</h4></label>
                                    <table id="tbllisting" class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                           
                                            <th>Account</th>
                                            <th>Name</th>
                                            <th>Amount</th>
                                            </tr>

                                        </thead>
                                        <tbody>

                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td></td>
                                                <td><strong>Total</strong></td>
                                                <td><strong><div id="totinfocash"></div></strong></td>
                                            </tr>
                                        </tfoot>

                                    </table>

                                </div>
                </div>
               

            </div>
          </div>
          <!-- end of row-->
        </div>
        <!-- wrapper -->
      </section>
    </aside>
  </div>
      <form id="Form1" role="form" runat="server">
                    <div style="display: none;">
                                    <asp:Button runat="server" ID="testme" OnClick="signout" />
                                    </div>
                    </form>
      <input type="hidden" id="tmpxx" size="200"/>
   
      <div class="modal fade" id="checkmanager" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title"><i class="fa fa-dollar"></i> Post Check</h4>
                    </div>
                   
                        <div class="modal-body">
                            <div class="form-group">
                                <div class="input-group">
                                    <table class="table">
    
                                            <tr>
                                                <td></td>
                                                <td style="width: 100px">Issuing Bank</td>
                                                <td style="width: 400px"><input id="chkissuebank" type="text" class="form-control" placeholder=""></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>Issued By</td>
                                                <td><input id="chkissueby" type="text" class="form-control" placeholder=""></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>Check#</td>
                                                <td><input id="chkno" type="text" class="numbersOnly form-control" placeholder=""></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>Amount</td>
                                                <td><input id="chkamt" type="text" class="numbersOnly form-control" placeholder=""></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>Reference</td>
                                                <td><input id="chkref" type="text" class="form-control" placeholder=""></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td>Deposit To</td>
                                                <td><select id="Select1" class="form-control" onchange="BankDeposit.bankinfo2(this.value)">
                                                                       <script> document.write($('#frmSelect').html());
                                                                           BankDeposit.bankinfo2($('#Select1').val());
                                                                       </script>
                                                    </select>

                                                </td>
                                            </tr>
                                        <tbody></tbody>
                                    </table>
                                </div>
                            </div>

                            <div class="form-group">                                
                                <div class="input-group">
                                    <table>
                                        <tr>
                                            <td width="150px">Account Type</td>
                                            <td>:</td>
                                            <td><div id="chktype"></div></td>
                                        </tr>
                                         <tr>
                                            <td width="150px">Account number</td>
                                             <td>:</td>
                                            <td><div id="chkacct"></div></td>
                                        </tr>
                                        <tr>
                                            <td width="150px">General Ledger Code</td>
                                            <td>:</td>
                                            <td><div id="chkgl"></div></td>
                                        </tr>
                                    
                                    </table>
             
                                   
                                </div>
                             
                            </div>

                        </div>
                        <div class="modal-footer clearfix">
                            <input type="hidden" id="idptr"/>
                            <button type="button" id="discard" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-times"></i> Discard</button>

                            <button type="button" id="postit" class="btn btn-primary pull-left" onclick="BankDeposit.postchecking()"><i class="fa  fa-thumbs-o-up"></i> Post Entry</button>
                        </div>
                 
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
 
  <!-- Main row -->
  <!-- /.content -->
  <!-- /.right-side -->
  <!-- ./wrapper -->
  <!-- add new calendar event modal -->

        <!-- jQuery UI 1.10.3 -->
        <script src="/html/js/jquery-ui-1.10.4.custom.js" type="text/javascript"></script>
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>

        <!-- iCheck -->
        <!-- script src="/html/js/plugins/iCheck/icheck.min.js" type="text/javascript"></script -->

        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"> </script>

      


      <script>
         
          document.getElementById('frmBankDepoAmt').value = (MB.getParameterByName('pass_amt') == '') ? '' : accounting.formatMoney(MB.getParameterByName('pass_amt'));

          BankDeposit.bankinfo(document.getElementById('frmSelect').value);


          $('.numbersOnly').keyup(function () {
              if (this.value != this.value.replace(/[^0-9\.\$]/g, '')) {
                  this.value = this.value.replace(/[^0-9\.\$]/g, '');
              }
          });

          if (MB.getParameterByName("pass_amt") !== "") {
              if (MB.getParameterByName("pass_type") === "") {
                  $('#infocashdeposit').show();
                  BankDeposit.bankcashinfoload();
                 
              }
          }

      </script>

   

 

  </body>
</html>
