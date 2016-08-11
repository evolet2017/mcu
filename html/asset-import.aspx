<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="MBv8Web" %>
<%@ Import Namespace="MBFunc" %>


<!DOCTYPE html>

<script runat="server">

    //SqlConnection con;

    //string connStr;
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

    // private void connection() {

    //     connStr = GenericDB.GetXML("mcu", "connectionstring");
    //     con = new SqlConnection(connStr);
    // }

    // private void InsertCSVRecords(DataTable csvdt) {

    //     connection();
    //     //creating object of SqlBulkCopy
    //     SqlBulkCopy objbulk = new SqlBulkCopy(con);
    //     //assigning destination table name
    //     objbulk.DestinationTableName = "BankAsset2";
    //     //mapping table column

    //     objbulk.ColumnMappings.Add("asset_code", "asset_code");
    //     objbulk.ColumnMappings.Add("asset_desc", "asset_desc");
    //     objbulk.ColumnMappings.Add("asset_expire", "asset_expire");
    //     objbulk.ColumnMappings.Add("asset_serial", "asset_serial");
    //     objbulk.ColumnMappings.Add("asset_po", "asset_po");
    //     objbulk.ColumnMappings.Add("pur_isnew", "pur_isnew");
    //     objbulk.ColumnMappings.Add("pur_desc", "pur_desc");
    //     objbulk.ColumnMappings.Add("pur_date", "pur_date");
    //     objbulk.ColumnMappings.Add("pur_cost", "pur_cost");
    //     objbulk.ColumnMappings.Add("pur_salvagevalue", "pur_salvagevalue");
    //     objbulk.ColumnMappings.Add("pur_deprevalue", "pur_deprevalue");
    //     objbulk.ColumnMappings.Add("pur_lifeinyears", "pur_lifeinyears");
    //     objbulk.ColumnMappings.Add("pur_annualexpense", "pur_annualexpense");
    //     objbulk.ColumnMappings.Add("GLACC", "GLACC");
    //     objbulk.ColumnMappings.Add("userid", "userid");
    //     objbulk.ColumnMappings.Add("tag", "tag");
    //     objbulk.ColumnMappings.Add("MasterID", "MasterID");
    //     objbulk.ColumnMappings.Add("DebitGLAcct", "DebitGLAcct");
    //     objbulk.ColumnMappings.Add("CreditGLAcct", "CreditGLAcct");
    //     objbulk.ColumnMappings.Add("VendorLink", "VendorLink");
    //     objbulk.ColumnMappings.Add("Sold_Amount", "Sold_Amount");
    //     objbulk.ColumnMappings.Add("NoOfInstallment", "NoOfInstallment");

    //     //inserting datatable records to database
    //     con.Open();
    //     objbulk.WriteToServer(csvdt);

    //     // SqlDataReader rd;

    //     // rd = GenericDB.ExecSQL(connStr, @"SELECT MAX(id) ID FROM BankAsset2");
                                
    //     // GenericDB.ExecSQL(connStr,@"UpdateMaster '" + pieces[0] + "'," + pieces[7]  + ",6,'" + rd["ID"].ToString() + "','','" + pieces[10] + "'");   

    //     con.Close();

    // }

    protected void UploadBtn_Click(object sender, EventArgs e)
    {
        // Specify the path on the server to
        // save the uploaded file to.
        string savePath = Server.MapPath(".") + "\\import\\";

        // Before attempting to save the file, verify
        // that the FileUpload control contains a file.
        if (FileUpload1.HasFile)
        {
            // Get the name of the file to upload.
            string fileName = Server.HtmlEncode(FileUpload1.FileName);

            // Get the extension of the uploaded file.
            string extension = System.IO.Path.GetExtension(fileName);

            // Allow only files with .doc or .xls extensions
            // to be uploaded.
            if ((extension == ".csv") || (extension == ".tpl"))
            //if ((extension == ".doc") || (extension == ".log"))
            {
                // Append the name of the file to upload to the path.
                savePath += fileName;

                // Call the SaveAs method to save the  
                // uploaded file to the specified path.
                // This example does not perform all
                // the necessary error checking.               
                // If a file with the same name
                // already exists in the specified path,  
                // the uploaded file overwrites it.
                FileUpload1.SaveAs(savePath);

                // Notify the user that their file was successfully uploaded.

                try
                {   
                    //Creating object of datatable
                    //DataTable tblcsv = new DataTable();
                    //creating columns

                    // tblcsv.Columns.Add("asset_code");
                    // tblcsv.Columns.Add("asset_desc");
                    // tblcsv.Columns.Add("asset_expire");
                    // tblcsv.Columns.Add("asset_serial");
                    // tblcsv.Columns.Add("asset_po");
                    // tblcsv.Columns.Add("pur_isnew");
                    // tblcsv.Columns.Add("pur_desc");
                    // tblcsv.Columns.Add("pur_date");
                    // tblcsv.Columns.Add("pur_cost");
                    // tblcsv.Columns.Add("pur_salvagevalue");
                    // tblcsv.Columns.Add("pur_deprevalue");
                    // tblcsv.Columns.Add("pur_lifeinyears");
                    // tblcsv.Columns.Add("pur_annualexpense");
                    // tblcsv.Columns.Add("GLACC");
                    // tblcsv.Columns.Add("userid");
                    // tblcsv.Columns.Add("tag");
                    // tblcsv.Columns.Add("MasterID");
                    // tblcsv.Columns.Add("DebitGLAcct");
                    // tblcsv.Columns.Add("CreditGLAcct");
                    // tblcsv.Columns.Add("VendorLink");
                    // tblcsv.Columns.Add("Sold_Amount");
                    // tblcsv.Columns.Add("NoOfInstallment");

                    // //get the full path of the uploaded csv file

                    // string CSVFilePath = savePath;

                    // //Reading all text

                    // string ReadCSV = File.ReadAllText(CSVFilePath);

                    // foreach (string csvRow in ReadCSV.Split('\n')) {

                    //     if(!string.IsNullOrEmpty(csvRow)) {

                    //         //Adding each row into datatable
                    //         tblcsv.Rows.Add();
                    //         int count = 0;
                    //         foreach(string FileRec in csvRow.Split(',')) {

                    //             tblcsv.Rows[tblcsv.Rows.Count - 1][count] = FileRec;
                    //             count++;
                    //         }
                    //     }

                    // }
                    // //Calling insert Functions
                    // InsertCSVRecords(tblcsv);
                    // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Your file was uploaded successfully.'); window.location='/Import-Asset';", true);
                    //UploadStatusLabel.Text = "Your file was uploaded successfully.";

                    //Response.Redirect("/Import-Asset");

                    //Open the text file using a stream reader.
                     using (System.IO.StreamReader sr = System.IO.File.OpenText(savePath))
                     {
                         // Read the stream to a string, and write the string to the console.
                         String line = sr.ReadLine();
                         //UploadStatusLabel.Text = line;

                         String sqlstmt = "INSERT INTO BankAsset (asset_code,asset_desc,asset_expire,asset_serial,asset_po,pur_isnew,pur_desc,pur_date,pur_cost,pur_salvagevalue,pur_deprevalue,pur_lifeinyears,pur_annualexpense,GLACC,userid,tag,DebitGLAcct,CreditGLAcct,VendorLink,assacc,tag2) VALUES (";
                         // String sqlstmt = "INSERT INTO BankAsset (asset_code,asset_desc,asset_expire,asset_serial,asset_po,pur_desc,pur_date,pur_cost,pur_isnew,GLACC,userid,pur_salvagevalue,pur_deprevalue,pur_lifeinyears,pur_annualexpense,DebitGLAcct,CreditGLAcct,VendorLink) VALUES (";
                         //22
                        string connStr = GenericDB.GetXML("mcu", "connectionstring");

                        //UploadStatusLabel.Text += connStr;
                        SqlDataReader rd;
                        
                            while ((line = sr.ReadLine()) != null)
                            {
                                // string[] pieces = line.Split(',');
                                // string  sqlinsert = sqlstmt + pieces[1] + ",";
                                //         sqlinsert = sqlinsert + pieces[2] + ",";
                                //         sqlinsert = sqlinsert + pieces[3] + ",";
                                //         sqlinsert = sqlinsert + pieces[4] + ",";
                                //         sqlinsert = sqlinsert + pieces[5] + ",";
                                //         sqlinsert = sqlinsert + pieces[6] + ",";
                                //         sqlinsert = sqlinsert + pieces[7] + ",";
                                //         sqlinsert = sqlinsert + pieces[8] + ",";
                                //         sqlinsert = sqlinsert + pieces[9] + ",";
                                //         sqlinsert = sqlinsert + pieces[10] + ",";
                                //         sqlinsert = sqlinsert + pieces[11] + ",";
                                //         sqlinsert = sqlinsert + pieces[12] + ",";
                                //         sqlinsert = sqlinsert + pieces[13] + ",";
                                //         sqlinsert = sqlinsert + pieces[14] + ",";
                                //         sqlinsert = sqlinsert + pieces[15] + ",";
                                //         sqlinsert = sqlinsert + pieces[16] + ",";
                                //         sqlinsert = sqlinsert + pieces[17] + ",";
                                //         sqlinsert = sqlinsert + pieces[18] + ")";
                                string[] pieces = line.Split(',');
                                string  sqlinsert = sqlstmt + pieces[0] + ",";
                                        sqlinsert = sqlinsert + pieces[1] + ",";
                                        sqlinsert = sqlinsert + pieces[2] + ",";
                                        sqlinsert = sqlinsert + pieces[3] + ",";
                                        sqlinsert = sqlinsert + pieces[4] + ",";
                                        sqlinsert = sqlinsert + pieces[5] + ",";
                                        sqlinsert = sqlinsert + pieces[6] + ",";
                                        sqlinsert = sqlinsert + pieces[7] + ",";
                                        sqlinsert = sqlinsert + pieces[8] + ",";
                                        sqlinsert = sqlinsert + pieces[9] + ",";
                                        sqlinsert = sqlinsert + pieces[10] + ",";
                                        sqlinsert = sqlinsert + pieces[11] + ",";
                                        sqlinsert = sqlinsert + pieces[12] + ",";
                                        sqlinsert = sqlinsert + pieces[13] + ",";
                                        sqlinsert = sqlinsert + pieces[14] + ",";
                                        sqlinsert = sqlinsert + pieces[15] + ",";
                     
                                        sqlinsert = sqlinsert + pieces[16] + ",";
                                        sqlinsert = sqlinsert + pieces[17] + ",";
                                        sqlinsert = sqlinsert + pieces[18] + ",";
                                        sqlinsert = sqlinsert + pieces[19] + ",";
                                        sqlinsert = sqlinsert + pieces[20] + ")";

                                        //GenericDB.ExecSQL(connStr, @"sp_newAsset '" + sqlinsert + "'");
                                     //UploadStatusLabel.Text += sqlstmt + line + ")<br /><br >";
                                     //UploadStatusLabel.Text += line + ")<br /><br>";
                                     //UploadStatusLabel.Text += sqlstmt + line;
                                     // foreach (string piece in pieces) {
                                     //    UploadStatusLabel.Text += piece + ")<br /><br >";
                                     // }
                                     

                                        //Console.WriteLine(sqlinsert);
                                    
                                        GenericDB.ExecSQL(connStr, @sqlinsert);
                                        // SqlDataReader rd2;
                                        // rd2 = GenericDB.ExecSQL(connStr, @"SELECT MAX(id) as ID FROM BankAsset2");
                                        // try
                                        // {
                                        //     SqlConnection sqlConn = null;
                                        //     string myid="";
                                        //     string querystring = "SELECT MAX(id) ID FROM BankAsset2";

                                        //     sqlConn = new SqlConnection(connStr);
                                        //     SqlCommand cmd = new SqlCommand(querystring, sqlConn);
                                        //     sqlConn.Open();

                                        //     SqlDataReader reader = cmd.ExecuteReader();

                                        //     if (reader.HasRows)
                                        //     {
                                        //         while (reader.Read())
                                        //         {
                                        //             myid = reader.GetSqlValue(0).ToString();
                                        //         }
                                        //     }
                                        //     //reader.close();
                                        //     //sqlConn.close();
                                        //     GenericDB.ExecSQL(connStr,@"UpdateMaster '" + pieces[1] + "'," + pieces[7]  + ",6,'" + myid + "','','" + pieces[10] + "'");  
                                        //    //rd = GenericDB.ExecSQL(connStr, @"SELECT MAX(id) ID FROM BankAsset2");


                                        // }
                                        // catch (SqlException ex)
                                        // {
                                        //     UploadStatusLabel.Text = "The file could not be read: "+ex.Message;
                                        // }
                                        
                                
                               //GenericDB.ExecSQL(connStr,@"UpdateMaster '" + pieces[1] + "'," + pieces[7]  + ",6,'" + myid + "','','" + pieces[10] + "'");                                                                

                                       //  UploadStatusLabel.Text += sqlinsert + "<br />";
                                 //UploadStatusLabel.Text += sqlstmt + line + ")<br /><br >";
                                 //UploadStatusLabel.Text = rd2["ID"].ToString();
                                 UploadStatusLabel.Text = "Your file was uploaded successfully.";
                                
                           } 
                           //UploadStatusLabel.Text = rd["ID"].ToString();
                           //rd = GenericDB.ExecSQL(connStr, @"SELECT MAX(id) ID FROM BankAsset2");

                        
                     }

                }
                catch (Exception ex)
                {
                    UploadStatusLabel.Text = "The file could not be read: "+ex.Message;
                    //Console.WriteLine(e.Message);
                }
                    
                //UploadStatusLabel.Text = "Your file was uploaded successfully.";
            }
            else
            {
                // Notify the user why their file was not uploaded.
                UploadStatusLabel.Text = "Your file was not uploaded because " + 
                                         "it does not have a .csv or .tpl extension.";
            }

        }
        else
        {
            // Notify the user why their file was not uploaded.
                UploadStatusLabel.Text = "No file to upload " + 
                                         "please select a file from youre directory.";
        }

    }

</script>
<script type="text/javascript">
    function myfunction() {
         bootbox.alert("Hello world!", function () {
         });
     }
</script>


<html>
   <head id="Head1" runat="server">
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
        <link href="/html/css/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
           <script src="/html/js/jquery.min.js"></script>
                <script src="/html/js/mbphillib.js"></script>
 
		
		

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="/html/js/html5shiv.js"></script>
          <script src="/html/js/respond.min.js"></script>
        <![endif]-->
        

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
                        <!--#include file="/html/useraccount.htt"-->
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
                            <p>Hello, <% =Request.Cookies["activeuser"].Value %></p>

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
                         <!--#include file="/html/menu.htt"-->     
                    </ul>
                </section>
                <!-- /.sidebar -->
            </aside>

            <!-- Right side column. Contains the navbar and content of the page -->
            <aside class="right-side">
                <!-- Content Header (Page header) -->
                <section class="content-header">
                    <h1>
                        <h3>Import Asset</h3>
                    </h1>
                    <ol class="breadcrumb">
                        <li><a href="/Main"><i class="fa fa-dashboard"></i> Home</a></li>
                        <li class="active">Import Asset</li>
                    </ol>
                </section>

                <!-- Main content -->
                <section class="content">
                
                    <!-- Small boxes (Stat box) -->
                     
						   <div class="col-md-10">
                               
                               <div class="box">
                                    <div class="box-header">
                                        
                                    </div>
                                    <form id="form1" runat="server">
                                        <div class="box-body">
                                            <blockquote id="bkupmsg">
                                                Select file to import..
                                            </blockquote>
                                             <hr />
                                            <label>Filename</label>
                                            <asp:FileUpload id="FileUpload1"                 
                                                runat="server">
                                            </asp:FileUpload>

                                             <br/><br/>

                                                <asp:Button id="UploadBtn" class="btn btn-primary"
                                                    Text="Upload file"
                                                    OnClick="UploadBtn_Click"
                                                    runat="server">
                                                </asp:Button>    
                                             <hr />
                                               

                                                <asp:Label id="UploadStatusLabel"
                                                    runat="server">
                                                </asp:Label>     

                                            
                                           
                                        </div>
                                    </form>

                                   <div class="box-footer">
                                       <p><b>Note..</b><br />
                                           Import CSV template individual values must be contained in single qoute and separated by comma. (except for numeric and currency value) <br />
                                           <code>
                                               <br />
                                               Example: <br />
                                               code,description,count,price,tag <br />
                                               '00001','New Item',3,1200.00,1 <br />
                                           </code>
                                           <br />
                                           <br />
                                           <a href='template.csv'>Download CSV Template</a>

                                       </p>
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
        
    

        <!-- page script -->
        <script>

            var uploadfile = (function () {

                alert('upload file');
            });
            function xBackMeUp() {
                var cmd = "EXEC sp_dbBackup '" + $('#bkfilename').val() + "'";
                var posting = $.post(MB.URLPoster(), { SQLStatement: cmd });
                posting.fail(function (data, status, xhr) { bootbox.alert("unknown error while performing backup [" + status + " - " + xhr + "]") });
                posting.done(function (data) { bootbox.alert("Back Up,, Complete.."); document.getElementById('bkupmsg').innerHTML = "Done...(Thank you..)!" });
            }
        </script>


        
		
   
    </body>
    
</html>