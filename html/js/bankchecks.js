var BankChecks = {

    bankcheckdisplaylist: function () {
        $('#checkinvlist').hide();
        $('#mainchkinv').show();

    },
    bankcheckinfolist: function (x, y) {
        
        $('#chkidd').val(y);
        var sql = "SELECT GLACC,";
        sql += "BankAccountNum, ";
        sql += "BankName, ";
        sql += "'" + y + "' CheckID, (SELECT EndSeries FROM CheckBooks WHERE GLACC=BankAccounts.GLACC AND CheckID="+y+") EndSeries, ";
        sql += "(SELECT SUM(Amount) FROM BankAccTrn WHERE GLACC=BankAccounts.GLACC ) Balance ";
        sql += "FROM BankAccounts  ";
        sql += "WHERE BankAccountNum='" + x + "'";
       // console.log(sql);

        var retv = $.post(MB.URLPoster(), { SQLStatement: sql });
        retv.success(function (result) {
            $.each(JSON.parse(result), function (key, value) {
                $('#tbl_account').html(value.BankAccountNum);
                $('#tbl_description').html(value.BankName);
                $('#tbl_series').html(value.CheckID + ' - ' + value.EndSeries);
                $('#tbl_balance').html(accounting.formatMoney(value.Balance));


                var sql = "SELECT CheckID,";
                sql += "ISNULL(IssuedTo,'') IssuedTo,";
                sql += "ISNULL(LEFT(CheckDate,10),'') CheckDate,";
                sql += "ISNULL(Particulars,'') Particulars,";
                sql += "Amount,ISNULL(TransDesc,'') TransDesc,Tag,ISNULL((SELECT firstname + ' ' + lastname UserID FROM usertable WHERE username=BankChecks.UserID ),'') UserID ";
                sql += "FROM BankChecks WHERE GLACC='" + value.GLACC + "'  AND CheckTAG='" + y + "'";
                var _ret = $.post(MB.URLPoster(), { SQLStatement: sql });
                _ret.success(function (msg) {
                  //  $('#tbl_chklisting').dataTable().fnClearTable();
                    $('#tbl_chklisting').dataTable().fnDestroy();
                    $('#tbl_chklisting > tbody').html('');
                    $.each(JSON.parse(msg), function (_key, _value) {
                        var tr = "<tr>";
                        if (_value.Tag == 1) {
                            tr += "<td><input type='checkbox' name='checkbox[]' value='" + value.GLACC + "::" + _value.CheckID + "::" + _value.Tag + "' onclick='' style='display:none'></td>";
                        } else {
                            tr += "<td><input type='checkbox' name='checkbox[]' value='" + value.GLACC + "::" + _value.CheckID + "::" + _value.Tag + "' onclick=''></td>";
                        }
                        if (_value.Tag == 1) {
                            tr += "<td>" + _value.CheckID + "</td>";
                        }
                        if (_value.Tag == 2 ) {
                            tr += "<td>" + _value.CheckID + " <span class='pull-right'><small class='label label-danger'>canceled</small></span></td>";
                        }
                        if (_value.Tag == 0) {
                            tr += "<td>" + _value.CheckID + " <span class='pull-right'><small class='label label-success'>unused</small></span></td>";
                        }
                        tr += "<td>" + _value.IssuedTo + "</td>";
                        tr += "<td>" + _value.CheckDate + "</td>";
                        tr += "<td>" + _value.Particulars + "</td>";
                        tr += "<td>" + _value.TransDesc + "</td>";
                        tr += "<td>" + accounting.formatMoney(_value.Amount) + "</td>";
                        tr += "<td>" + _value.UserID + "</td>";
                        tr += "</tr>";
                        $('#tbl_chklisting').append(tr);

                    });
                    $('#tbl_chklisting').dataTable({
				"sScrollY": "400px",
        				"scrollCollapse": true,
        				"bPaginate":         false
                        //scrollY: 200,
                        //scrollCollapse: true,
                        //paginate: false

                    });

                });


            });
           
            //console.log(result);
            //var ret = JSON.parse(result);
            //console.log(ret.BankAccountNum);

           
        });


        //alert(x);
        //alert(y);
       

    },
	
    bankchecksave: function () {
        // Check for series validities
        if ($('#StartSeries').val() > $('#EndSeries').val()) {
            bootbox.alert("Not Allowed.. <br><br>End Series is Less than Start Series..");
            return
        }
        // Check for usage
        var sql = "SELECT IssuingBank, GLACC FROM CheckBooks WHERE IssuingBank=(SELECT BankID FROM BankAccounts WHERE GLACC='" + $('#frmCheckBank').val() + "') AND " + $('#StartSeries').val() + " >= StartSeries AND " + $('#StartSeries').val() + " <= EndSeries";
        //console.log(sql);
        var _bnk1 = $.post(MB.URLPoster(), { SQLStatement: sql });
        _bnk1.success(function (data) {
            if (data !== '[]') {
                bootbox.alert("Check Series : " + $('#StartSeries').val() + " - " + $('#EndSeries').val() + " - is already used");
                return
            }
        });

		if($('#StartSeries').val() != "")
		{
			if($('#EndSeries').val() != "")
			{
				bootbox.confirm("Save Entry?", function(result) {				
				if(result) 
				{
					var sv = "EXEC UpdateCheckBook '" + $('#frmCheckBank').val() + "','" + $('#StartSeries').val() + "','" + $('#EndSeries').val() + "','" + MB.getCookie('activeid') + "'";
					var _bnk1 = $.post(MB.URLPoster(), { SQLStatement: sv });
					_bnk1.success(function (data) {
					    var sv = "sp_CheckCreate " + $('#StartSeries').val() + "," + $('#EndSeries').val() + "," + $('#frmCheckBank').val();
					    MB.push(sv);
					    bootbox.alert("Save Complete..", function () { window.location = "/Check-Inventory"; });
					});					
				}
				});
		
			} else
			{
				bootbox.alert("Missing Entry (End Series)");
			}
		} else
		{
			bootbox.alert("Missing Entry (Start Series)");
		}
	},
	
	bankcheckload : function() {
	
	    $(document).ready(function () {
	        //var sql = "SELECT  " +
			//				"' '," +
			//				"B.BankAccountNum," +
			//				"B.BankName," +
			//				"A.CheckID," +
			//				"A.EndSeries - (A.StartSeries-1) AS TotalChecks," +
			//				"(SELECT COUNT(CheckNumber) " +
			//				" FROM MasterTRN X " +
			//				" LEFT JOIN Modules Y ON X.ModuleID=Y.ModuleID " +
			//				" WHERE X.ModuleID='AP001' AND X.CheckNumber<>0 AND X.Checknumber >= A.CheckID AND X.CheckNumber <= A.EndSeries) AS Issued," +
			//				"(A.EndSeries - (A.StartSeries-1)) - (SELECT COUNT(CheckNumber) " +
			//				" FROM MasterTRN X  " +
			//				" LEFT JOIN Modules Y ON X.ModuleID=Y.ModuleID " +
			//				" WHERE X.ModuleID='AP001' AND X.CheckNumber<>0 AND X.Checknumber >= A.CheckID AND X.CheckNumber <= A.EndSeries) AS Remaining," +
			//				"CONVERT(VARCHAR(19), A.DateIssued, 120) as DateIssued," +
			//				"IIF (A.BookStatus = 1,'Active','Inactive') BookStatus," +
			//				"A.UserID as EncodedBy " +
			//				"FROM CheckBooks A " +
	        //				"LEFT JOIN BankAccounts B ON A.IssuingBank=B.BankID ";
	        var sql = "SELECT "+
	        "B.BankAccountNum,"+
            "B.BankName,"+
            "A.CheckID,"+
            "(A.EndSeries - A.StartSeries)+1 TotalChecks,"+
            "(SELECT COUNT(CheckTAG) FROM BankChecks WHERE CheckTAG=A.CheckID AND Tag IN (1,2) AND IssuingBank=A.IssuingBank) Issued,"+
            "(SELECT COUNT(CheckTAG) FROM BankChecks WHERE CheckTAG=A.CheckID AND Tag NOT IN (1,2) AND IssuingBank=A.IssuingBank) Remaining,"+
            "CONVERT(VARCHAR(19), A.DateIssued, 120) DateIssued,"+
            "IIF (A.BookStatus = 1, 'Active','InActive') BookStatus," +
           // "(SELECT firstname + ' ' + lastname UserID FROM usertable WHERE username=A.UserID) EC," +
            "(SELECT firstname + ' ' + lastname UserID FROM usertable WHERE username=A.UserID) EncodedBy " +
	        "FROM CheckBooks A "+
	        "LEFT JOIN BankAccounts B ON A.IssuingBank=B.BankID "+
	        "WHERE B.BankAcctStatus=1 "+
	        "ORDER BY BankAccountNum";

	        console.log(sql);
	        $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
			{
			 SQLStatement: 	sql
			}, function (data) {
				//console.log(data);
				$.each($.parseJSON(data), function(idx, obj) {
				    var tr = "<tr>";
				    //$('#mainchkinv').hide();
				    //$('#checkinvlist').show();
				    tr += "<td><a href='#' onclick=$('#mainchkinv').hide();$('#checkinvlist').show();BankChecks.bankcheckinfolist('"+obj.BankAccountNum+"','"+obj.CheckID+"');>" + obj.BankAccountNum + "</a></td>";
					tr += "<td>"+obj.BankName+"</td>";
					tr += "<td>"+obj.CheckID+"</td>";
					tr += "<td>"+obj.TotalChecks+"</td>";
					//tr += "<td><span><input type='text' size=8 class='knob' value='"+obj.TotalChecks+"' data-skin='tron'  data-thickness='0.2' data-width='40' data-height='40' data-fgColor='#3c8dbc' data-readonly='true'/></span></td>";
					
					//tr += "<td><input type='text' size=6 class='knob' value='"+obj.Issued+"' data-skin='tron'  data-thickness='0.2' data-width='40' data-height='40' data-fgColor='#3c8dbc' data-readonly='true'/></td>";
					tr += "<td>"+obj.Issued+"</td>";
					tr += "<td><span class='bar'>"+obj.Remaining+"<span></td>";
					//tr += "<td><input type='text' size=6 class='knob' value='"+obj.Remaining+"' data-skin='tron'  data-thickness='0.2' data-width='40' data-height='40' data-fgColor='#3c8dbc' data-readonly='true'/></td>";
					tr += "<td>"+obj.DateIssued+"</td>";
					tr += "<td>"+obj.BookStatus+"</td>";
					tr += "<td>" + obj.EncodedBy + "</td></tr>";
				//	console.log(obj.CheckID);
					$('#chkinv tbody').append(tr);
				});
				$('#chkinv').dataTable(
				{
					"sScrollY": "400px",
					"scrollCollapse": true,
					"bPaginate": false
				}
				);
				//{
				// aaData: $.parseJSON(data),
				// "bScrollInfinite": true,
				// "sScrollY": "365px",
				// "bPaginate": false
				//});
				//$(".bar").peity("bar");
				
			});	
		});

	},
	bankcheckinfo: function (glcode) {
	    var s = '';
	    if (MB.isEmpty(glcode)) {
	        BankOperations.getDefBank();
	        glcode = MB.getCookie('defbank');
	    }


	    var sv = "SELECT A.BankName,A.BankAccountNum,B.accounttype,C.EXPACC,C.TITLE FROM BankAccounts A left join accounttype b on a.BankAccountType=B.id left join GLAC C ON A.GLACC=C.GLACC WHERE A.GLACC='" + glcode + "'";
	    //console.log(sv);
	    $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
		{
		    SQLStatement: sv
		}, function (data) {
		    //console.log(data);
		    $.each($.parseJSON(data), function (id, value) {
		        document.getElementById('accttype').innerHTML = value.accounttype;
		        document.getElementById('acctnum').innerHTML = value.BankAccountNum;
		        document.getElementById('glcode').innerHTML = value.EXPACC + ' (' + value.TITLE + ') ';
		        //$('#accttype').innerHTML = value.BankAccountType;
		        //console.log(value.accounttype);
		    });
		});

	},
	bankchecklist: function () {
	    var ss = "select A.GLACC,A.BankName,B.accounttype,A.BankAccountNum,";
	    ss += "(SELECT 'selected' from appconfig where mbfield1='Deposit' and mbvalue=a.GLACC) as vselect ";
	    ss += "from BankAccounts A LEFT JOIN accounttype B on A.BankAccountType=B.id WHERE 1=1 AND B.accounttype like '%check%'";
	   // console.log(ss);
	    $.ajax({
	        type: "POST",
	        url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
	        data: { SQLStatement: ss }
	    }).done(function (msg) {
	        //var x = '';
	        $.each(JSON.parse(msg), function (id, value) {
	            $('#frmCheckBank').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.BankName + "</option>");
	        });


	    });
	}
}
