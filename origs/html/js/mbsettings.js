// -- settings --

$('#lblConStr').val($('#constr').val());

var cmd = "Select mbvalue from appconfig WHERE mbfield1 ='npath'";
              

$.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":" + "8080" + "/Default.asmx/Exec",
    {
        SQLStatement: cmd
    },
    function (data) {
        $.each($.parseJSON(data), function (key, value) {                           
            $('#lblv8Path').val(value.mbvalue);
        });
    });

$('#lblServer').val(MB.getCookie("dbserver"));
$('#lblPort').val(MB.getCookie("dbport"));


function RefreshTabUser() {
    $('#syssettings').dataTable().fnDestroy();
    $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
    {
        //SQLStatement: "Select username, firstname, lastname, email, (case when tag = 1 then 'Active' else 'Inactive' end) Status from usertable"
        SQLStatement: "Select username, firstname, lastname, email, tag as Status from usertable"
    }, function (data) {
        var i = 0;
                      
        $.each($.parseJSON(data), function (key, value) {

            i++;
            //var tr = "<tr id= '" + value.username + "' onclick = syssettings_onclick('" + value.username + "','" + value.Status + "')> ";
            var tr = "<tr >";
                         
                           

            tr += "<td id =" + i + ">" + i + "</td>";
            tr += "<td >" + value.username + "</td>";
            tr += "<td >" + value.firstname + "</td>";
            tr += "<td >" + value.lastname + "</td>";
            tr += "<td >" + value.email + "</td>";
                           
            if (value.Status == 0) {
                tr += "<td id=" + value.username + " name = '" + value.username + "' onclick = syssettings_onclick('" + value.username + "','" + value.Status + "')><span class='label label-warning'>inactive</span></td>";
            } else {
                tr += "<td id=" + value.username + " name = '" + value.username + "' onclick = syssettings_onclick('" + value.username + "','" + value.Status + "')><span class='label label-success'>active</span></td>";
            }
                          
            tr += "</tr>";
                          
            $('#syssettings > tbody:last').append(tr);
        }
        );

        $('#syssettings').dataTable();

    });

}
                              
function RefreshTabApp()
{
                                               
    $.post(MB.URLPoster(),  
    {
        SQLStatement: "Select id , mbfield1, mbvalue from appconfig where id > 4"
    }, function (data) {
    var i = 0;
                   
    $.each($.parseJSON(data), function (key, value) {
        // console.log(value.mbvalue);
        var s = value.mbvalue;
        s = s.replace("\\" + "\\", "|");
        s = s.replace(/:\\/g, ":|").replace("\\", "|");
        s = s.replace(":|", ":\\" + "\\").replace("|", "\\" + "\\");
                      
        var tr = "<tr id= '" + value.id + "' onclick = TblAppconfig_onclick('" + value.id + "','" + value.mbfield1 + "','" + s + "')> ";
                       
        i++;
                      
                      
        tr += "<td id =" + value.id + ">" + value.id + "</td>";
        tr += "<td id =" + value.mbfield1 + ">" + value.mbfield1 + "</td>";
        tr += "<td id =" + value.mbvalue  + ">" + value.mbvalue + "</td>";


        tr += "</tr>";
                     
        $('#TblAppconfig > tbody:last').append(tr);
    }
    );

    $('#TblAppconfig').dataTable();

    });
                                     
}

function TblAppconfig_onclick(x, xx, xxx) {
    var s = xxx;
    // s = s.replace("\:\",":"+"|").replace("|","\\"+"\\");
    //s = s.replace("\\" + "\\", "|");
    s = s.replace(/:\\/g, ":|").replace("\\","|");
    s = s.replace(":|", ":\\"+"\\").replace("|","\\"+"\\");

    //console.log(s);
    $('#lblFieldName').val(xx);
    $('#lblFieldValues').val(s);
    $('#field_id').val(x);
                                                 
    //document.cookie="FeildIDval= " + x + "";
}

function syssettings_onclick(x, xx) {
                   
    var cell = document.getElementById(x);

    // console.log(cell.innerText);
    var cmd;

    if (cell.innerText == 'inactive') {
        cmd = "UPDATE usertable SET tag ='" + 1 + "' WHERE username = '" + x + "'";

        //$('#').dataTable().fnUpdate(1, '', '', true, true);
        //var Ht = document.getElementById(x);
        //Ht.innerHTML = "<span class='label label-success'>active</span>";

            cell.innerHTML = "<span class='label label-success'>active</span>";
                      


    } else {
        cmd = "UPDATE usertable SET tag ='" + 0 + "' WHERE username = '" + x + "'";
        //var Ht = document.getElementById(x);

        //Ht.innerHTML = "<span class='label label-warning'>inactive</span>";
        cell.innerHTML = "<span class='label label-warning'>inactive</span>";
                        
    }
                    
    //console.log(cmd); //to see the output

    $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":" + "8080" + "/Default.asmx/Exec",
        {
            SQLStatement: cmd
        },
        function (data, status) {
                          
        });
                    
}

function btnClearAppConstant() {
    lblFieldName.value = "";
    lblFieldValues.value = "";
    $('#field_id').val('');

    //document.cookie = "FeildIDval=";

}

function btnSaveAppConstant() {
    //var vFieldId = MB.getCookie("FeildIDval");
    var vFieldId = $('#field_id').val();

    if (vFieldId > "") {
                       
        var cmd = "UPDATE [appconfig] SET mbvalue ='" + lblFieldValues.value + "', mbfield1 ='" + lblFieldName.value + "'  WHERE id = " + vFieldId ;
        //console.log(cmd); //to see the output

        $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":" + "8080" + "/Default.asmx/Exec",
            {
                SQLStatement: cmd
            },
            function (data, status) {
                lblFieldName.value = "";
                lblFieldValues.value = "";
                $('#field_id').val('');

                //document.cookie = "FeildIDval=";
            });
    }
    else {

        var cmd = "INSERT INTO [appconfig] ([mbfield1], [mbvalue]) VALUES ( '"+ lblFieldName.value +"', '"+ lblFieldValues.value +"')";

        //console.log(cmd); //to see the output

        $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":" + "8080" + "/Default.asmx/Exec",
            {
                SQLStatement: cmd
            },
            function (data, status) {
                lblFieldName.value = "";
                lblFieldValues.value = "";

                document.cookie = "FeildIDval=";
            });

    }

    $('#TblAppconfig').dataTable().fnClearTable();
    $('#TblAppconfig').dataTable().fnDestroy();
    RefreshTabApp();

    // $('#TblAppconfig').dataTable().fnAddData([lblFieldName.value, lblFieldValues.value], true);
    //location.reload(true);
                 
}



function btnFetchUser() {

    var cmd2 = "exec sp_FetchUser";
    //console.log(cmd2); //to see the output

    $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":" + "8080" + "/Default.asmx/Exec",
        {
            SQLStatement: cmd2
        },
        function (data, status) {});

    $('#syssettings').dataTable().fnClearTable();
    $('#syssettings').dataTable().fnDestroy();
    RefreshTabUser();
                 
}

function btnSaveConnection() {               
    MB.push("UPDATE [appconfig] SET mbvalue ='" + $('#lblServer').val() + "' WHERE mbfield1 ='dbserver'");
    MB.push("UPDATE [appconfig] SET mbvalue='" + $('#lblPort').val() + "' WHERE mbfield1='port'");

    MB.setCookie("dbserver", $('#lblServer').val(), 1);
    //MB.setCookie("serveraddress", $('#lblServer').val(), 1);
    MB.setCookie("dbport", $('#lblPort').val(), 1);
                
    bootbox.alert("Successfully Save.", function (result) {

        $.ajax({
            type: "post",
            url: "/html/pages/mcuservjs.aspx",
            data: {
                savexml: 1,
                id: 3,
            value : $('#lblConStr').val() }
        });

        $.ajax({
            type: "post",
            url: "/html/pages/mcuservjs.aspx",
            data: {
                savexml: 1,
                id: 2,
                value: $('#lblTimeOut').val()
            }
        });
                    
    });
}





function btnSavePath() {
    var v8Path = document.getElementById('lblv8Path').value;		        
    var cmd = "UPDATE [appconfig] SET mbvalue ='" + v8Path + "' WHERE mbfield1 ='npath'";
    MB.push(cmd);
    bootbox.alert("Successfully Save.");
}

$('#syssettings').dataTable(
            {
            // aaData: $.parseJSON(data),
                "bScrollInfinite": true,
                "sScrollY": "365px",
                "bPaginate": false
            });

RefreshTabApp();
RefreshTabUser();

//  document.getElementById('atclick').click();

$('#lblConStr').on("keyup", function (result) {
$('#constr').val($('#lblConStr').val())
});