var BankTransfer = {

	BAIL: function() {
				window.location = "/Main";
	},

	transferbanklist: function () {

	    var ss = "select A.GLACC,A.BankName,B.accounttype,A.BankAccountNum,";
	    ss += "(SELECT 'selected' from appconfig where mbfield1='Deposit' and mbvalue=a.GLACC) as vselect ";
	    ss += "from BankAccounts A LEFT JOIN accounttype B on A.BankAccountType=B.id WHERE 1=1 ";
	    $.ajax({
	        type: "POST",
	        url: MB.URLPoster(), 
	        data: { SQLStatement: ss }
	    }).done(function (msg) {
	        //var x = '';
	        $.each(JSON.parse(msg), function (id, value) {
	            $('#trncredit').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.BankName + "</option>");
	            $('#trndebit').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.BankName + "</option>");
	        });


	    });
	},


	posttransfer: function () {
	    //famount
	    var famount = $('#trnAmount').val();
	 //   console.log(famount);
	   
	    if ($('#trnAmount').val() === "") {
                bootbox.alert("Invalid amount!!");
                return
	    }

        if ($('#trnReference').val() === "") {
                bootbox.alert("Invalid reference!!");
                return
        }
	    if ($('#trndebit').val() == $('#trncredit').val())
	    {
		    bootbox.alert("The same bank account not allowed!!");
            return
	    }

	    if ($('#trnWithCharge').is(':checked')) {
	        if ($('#trnCharges').val() === "") {
	            bootbox.alert("Invalid value for bank charges!!");
	            return
	        }
	        famount = parseFloat(famount) + parseFloat($('#trnCharges').val());
	    }
	 //   console.log(famount);

	    var SQL = "SELECT (SUM(Amount)-" + famount + ") amount FROM BankAccTrn WHERE GLACC='" + $('#trncredit').val() + "' ";
	//    console.log(SQL);
	    //var rets = $.post(MB.URLPoster(), { SQLStatement: SQL });
	    rets = MB.post(SQL);
	    rets.success(function (data) {
	        
	        var ss = JSON.parse(data);
	   //     console.log('value of data: ' + data);
	        if (ss[0].amount < 1) {
	            bootbox.alert("Not enough fund to transfer..");
	            return;
	        } else {
	            var sv = "EXEC UpdateMaster '" + $('#trndebit').val() + ":" + $('#trncredit').val() + "[1','" + $('#trnAmount').val() + "',3,'" + $('#trnReference').val() + "','" + $('#trnParticulars').val() + "','" + MB.getCookie('activeid') + "'";
	            MB.push(sv);
	            if ($('#trnWithCharge').is(':checked')) {
	                var SQL = "INSERT INTO MasterTRN (v8RunDate,TrnDate,DebitAcct,CreditAcct,Amount,GLTrnType,ModuleID,Reference,Remarks,Status,UserID) ";
	                SQL += "SELECT ";
	                SQL += "(SELECT mbvalue FROM appconfig WHERE mbfield1='sysdate'), GETDATE(),";
	                SQL += "(SELECT GLACC FROM GLAC WHERE TITLE like '%bank% %fee%' AND ALIAS LIKE '%BANKI%'),";
	                SQL += "'" + $('#trncredit').val() + "',";
	                SQL += $('#trnCharges').val() + ",";
	                SQL += "(SELECT GLtrntype FROM GLEntry WHERE ModuleID='BR002') GLtrntype,";
	                SQL += "'BR002' ModuleID,";
	                SQL += "(SELECT MAX(TrnID) FROM MasterTRN) Reference,";
	                SQL += "'Bank Charge for Transfer' Remarks,";
	                SQL += "1 status,";
	                SQL += "'" + MB.getCookie('activeid') + "' UserID";
	                MB.push(SQL);
	                MB.push("EXEC sp_UpdateSOA " + MB.getCookie('sysdate'));
	            }
	            bootbox.alert("Save Complete..", function () { window.location = "/Main"; });

	        }
	    });


	    //$.ajax({
	    //    type: "POST",
	    //    url: MB.URLPoster(),
	    //    data: { SQLStatement: SQL },
	    //    success: function (data) {
	    //        // console.log(data);
	    //        $.each(JSON.parse(data), function (key, value) {
	    //            if (value.amount < famount) {
	    //                bootbox.alert("Not enough fund to transfer..");
	    //                return
	    //            }
	    //        });
	    //    }
	    //});
			
	    //var sv = "EXEC UpdateMaster '" + $('#trndebit').val() + ":" + $('#trncredit').val() + "[1','" + $('#trnAmount').val() + "',3,'" + $('#trnReference').val() + "','" + $('#trnParticulars').val() + "','" + MB.getCookie('activeid') + "'";
		//	console.log(sv);
	    //$.post(MB.URLPoster(), 
        //        {
        //            SQLStatement : sv
        //        }, function () { }).done(function () { bootbox.alert("Save Complete..", function () { window.location = "/Main"; }); }).complete(function () {
        //            if ($('#trnWithCharge').is(':checked')) {
        //                var SQL = "INSERT INTO MasterTRN (v8RunDate,TrnDate,DebitAcct,CreditAcct,Amount,GLTrnType,ModuleID,Reference,Remarks,Status,UserID) ";
        //                SQL += "SELECT ";
        //                SQL += "(SELECT mbvalue FROM appconfig WHERE mbfield1='sysdate'), GETDATE(),";
        //                SQL += "(SELECT GLACC FROM GLAC WHERE TITLE like '%bank% %fee%' AND ALIAS LIKE '%BANKI%'),";
        //                SQL += "'" + $('#trncredit').val() + "',";
        //                SQL += $('#trnCharges').val() + ",";
        //                SQL += "(SELECT GLtrntype FROM GLEntry WHERE ModuleID='BR002') GLtrntype,";
        //                SQL += "'BR002' ModuleID,";
        //                SQL += "(SELECT MAX(TrnID) FROM MasterTRN) Reference,";
        //                SQL += "'Bank Charge for Transfer' Remarks,";
        //                SQL += "1 status,";
        //                SQL += "'" + MB.getCookie('activeid') + "' UserID";
        //                MB.post(SQL);
        //                MB.post("EXEC sp_UpdateSOA " + MB.getCookie('sysdate'));
        //            }
        //        });



	}
}
