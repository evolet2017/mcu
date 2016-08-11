<%@ Page Language   ="C#" 
    AutoEventWireUp ="true" 
    Inherits="profile"
    ViewStateEncryptionMode="Always" CodeFile="profile.aspx.cs" %>


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
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="/html/js/html5shiv.js"></script>
          <script src="/html/js/respond.min.js"></script>
        <![endif]-->

        <!-- jQuery 2.0.2 -->
        <script src="/html/js/jquery.min.js"></script>
        
        <script src="/html/js/mbphillib.js"></script>
        <script src="/html/js/md5.min.js"></script>
        <script src="/html/js/bootbox.js"></script>

        
    </head>
    <body class="skin-black">
        <!-- header logo: style can be found in header.less -->
        <header class="header">
            <a href="/html/index.aspx" class="logo">
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
                                               <%--<div class="pull-left image">
                            <img src="/html/img/img.img" class="img-circle" alt="User Image" />
                        </div>--%>
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
                        Profile Settings
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="Main"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li><a href="#">Profile Settings</a></li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">
                <!-- updatesql(string username,string password, string firstname, string lastname, string email, string picture) -->
                
                    
           
                    <!-- <div class="col-lg-4 col-xs-6">  -->

                <div class="col-md-12">
                    <div class="box box-warning">
                         <div class="box-header">
                        <h3 class="box-title">Current User</h3>
                        </div><!-- /.box-header -->
                         <div class="box-body">
                         
                            <!-- text input -->
                            <div class="form-group">
                                <label>First Name</label>
                                <input type="text" ID="fname"  class="form-control" placeholder="Firstname" />                                
                            </div>
                             <div class="form-group">
                                <label>Last Name</label>
                                <input type="text" ID="lname" class="form-control" placeholder="Lastname"/>
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password"  ID="fpass" class="form-control" placeholder="Password"/>
                            </div>
                             <div class="form-group">
                                <label>Confirm Password</label>
                                <input type="password"  ID="fpass2" class="form-control" placeholder="Password"/>
                            </div>
                            <div class="form-group">
                                <label>Email address</label>
                                <input type="text"  class="form-control" ID="lemail" placeholder="Enter email" />
                            </div>

                            <div class="form-group">
                                <label>Level</label>
                                <!-- select -->
                                <% if (Request.Cookies["activeposition"].Value != "1")
                                   {
                                    Response.Write("<select class=form-control>"+
                                                    "<option>Teller</option>"+
                                                    "<option>Account Manager</option>"+
                                                    "<option>Front Supervisor</option>"+
                                                    "<option>Accountant 1</option>"+
                                                    "<option>Accountant 2</option>"+
                                                    "<option>Accounting Head</option>"+
                                                    "<option>Branch Manager</option>"+
                                                    "</select>");
                                   } else {
                                       Response.Write("<input type=text class=form-control placeholder='Teller' readonly/>");
                                   }
                                %>
                            
                                
                                
                            </div>
                            <div class="box-footer">
                                   
                                <input type="button" value="Save" class="btn btn-primary" onclick="saveme()" />
                                      
                            </div>

                            <form role="form" id="frmprofile" runat="server"> 
                            <div style="display: none;">
                            <asp:Button runat="server" ID="testme" OnClick="signout" />
                            </div>
                            </form> 

                            
                        
                         </div>
                    </div>
                 </div> 
<%--                <div class="col-md-6 col-xs-6">
                    <div class="box box-warning">
                         <div class="box-header">
                            <h3 class="box-title">Picture</h3>
                         </div><!-- /.box-header -->     
                            <div class="box-body">
                                <img ID="avatar" alt="..." class="margin" runat="server" />
                                <br />
                                <br />
                                <input type="file" id="btnupload" value="Upload" class="btn btn-primary" onchange="readURL(this);"/><br />
    &nbsp;<input ID="Text1" type="hidden" class="auto-style1" runat="server"/><br /><input ID="Text2" type="hidden" class="auto-style1" runat="server"/>

                            </div>
                    
                    </div>
                </div>--%>
                    
              
                </section><!-- /.content -->
            </aside><!-- /.right-side -->
        </div><!-- ./wrapper -->


         
    
        <!-- Bootstrap -->
        <script src="/html/js/bootstrap.min.js" type="text/javascript"></script>

		
		
        <!-- AdminLTE App -->
        <script src="/html/js/AdminLTE/app.js" type="text/javascript"></script>

        <script>

           // document.getElementById("avatar").src = document.getElementById('Text1').value;

            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#avatar')
                            .attr('src', e.target.result)
                            .width(150)
                            .height(150);
                        document.getElementById('Text1').value = e.target.result;
                    };

                    reader.readAsDataURL(input.files[0]);
                }
                //var btn = document.getElementById('compressme');
                //btn.click();

       



               
            }



        </script>

        <script type="text/javascript">
            
            function getvalues() {
                document.getElementById('fname').value = MB.getCookie('activeuser');
                document.getElementById('lname').value = MB.getCookie('activelast');
                document.getElementById('lemail').value = MB.getCookie('activeemail');
            }

            function getMD5(str) {
                var s = str;
                $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/md5",
                   {
                       pass_string: str
                   }, function (data) {
                       s = data;
                       return s;
                   });
                // return s;
            }

            function saveme() {
                if ($('#fpass').val() == $('#fpass2').val()) {
                } else {
                    bootbox.alert("Password Mismatch..");
                    return
                }

                if (MB.isEmpty($('#fpass').val())) {
                    bootbox.alert("Password is empty!..");
                    return
                }

                var fname = document.getElementById('fname').value;
                var lname = $('#lname').val();
                var fpass = $('#fpass').val();
               // var fpass2 = $('#fpass2').val();
                var lemail = $('#lemail').val();
                var picture = $('#Text1').val();
                var uname = MB.getCookie('activeid');

                



                fpass = md5(fpass);
                console.log(fpass);

                var cmd = "UPDATE [usertable] SET password='" + fpass + "',firstname='" + fname + "',lastname='" + lname + "',email='" + lemail + "',image='" + picture + "' WHERE username='" + uname + "'";
                console.log(cmd);
                //PageMethods.updatesql(uname, fpass, fname, lname, lemail, picture, saveme_success, saveme_failed);
                //alert('save');
                //alert(cmd);
                $.ajax({
                    type: "post",
                    url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
                    data: { SQLStatement: cmd },
                    success: function (data) {
                        MB.setCookie('activeuser', fname, 1);
                        MB.setCookie('activelast', lname, 1);
                        MB.setCookie('activeemail', lemail, 1);
                       // MB.setCookie('picture', picture, 1);
                        bootbox.alert("Entry Saved..");
                    }

                });
                //$.post("http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
                //    {
                //        SQLStatement: cmd
                //    },
                //    function (data, status) {
                //        //alert('ok');
                //        setCookie('activeuser', fname, 1);
                //        setCookie('activelast', lname, 1);
                //        setCookie('activeemail', lemail, 1);
                //        setCookie('picture', picture, 1);
                //        //location.reload();
                //    });

            }
            getvalues();

                    </script>
        

    </body>
</html>