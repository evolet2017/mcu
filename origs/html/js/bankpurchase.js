var BankPurchase = {

	bankpurchasebanklist: function() {

		var ss = "select A.GLACC,A.BankName,B.accounttype,A.BankAccountNum,";
			ss+= "(SELECT 'selected' from appconfig where mbfield1='Deposit' and mbvalue=a.GLACC) as vselect ";
			ss+= "from BankAccounts A LEFT JOIN accounttype B on A.BankAccountType=B.id WHERE 1=1 AND A.GLACC in (select GLACC FROM CheckBooks)";
		console.log(ss);
		//console.log(MB.push(ss));
		$.ajax({
			type: "POST",
			url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
			data: { SQLStatement: ss }
		}).done(function (msg) {
			//var x = '';
			$.each(JSON.parse(msg), function (id, value) {
				$('#frmShareSelect').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.BankName + "</option>");
			});
			BankPurchase.bankpurchaseinfo($('#frmShareSelect').val());

			//console.log(msg);
			//    alert(2);


		});
	},

	bankpurchasesave : function() {	
	    //bootbox.alert("banksharesave");	

	    var ok = 0;

	    if (MB.isEmpty($('#clientName').val())) {
	        bootbox.alert("Empty Client Name not allowed!!");
	        return
	    }
	    if (MB.isEmpty($('#checkAmount').val())) {
	        bootbox.alert("Empty Amount not allowed!!");
	        return
	    }
	    if (MB.isEmpty($('#checkNumber').val())) {
	        bootbox.alert("Empty Check Number not allowed!!");
	        return
	    }
	    if (MB.isEmpty($('#checkReference').val())) {
	        bootbox.alert("Empty Reference not allowed!!");
	        return
	    }
        ///////////////////////////////////////////////////////////////////////////////////

	    var SQL = "SELECT SUM(Amount) amount FROM BankAccTrn WHERE GLACC='" + $('#frmShareSelect').val() + "' ";
	    var retval = $.post(MB.jURLPoster(), { SQLStatement: SQL });
	    // = false;

	    retval.success(function (result) {
	        var value = parseFloat(result.replace('[["', '').replace('"]]', ''));
	        var v1 = parseFloat($('#checkAmount').val());
	        //console.log('pass');
	        if (v1.toFixed(4) > value) {
	            bootbox.alert("Not enough fund for purchase..", function () { return; });
	        } else {

	            // Check Validation	          
	            var SQL = "SELECT TAG FROM BankChecks WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmShareSelect').val() + $('#checkNumber').val() + "') ";
	            //console.log(SQL);
	            var retval = $.post(MB.jURLPoster(), { SQLStatement: SQL });
	            retval.success(function (result) {
	                // console.log(result);
	                var value = result.replace('[["', '').replace('"]]', '');
	                //console.log(value);
	                if (value == 0) {

	                    bootbox.confirm("Save Entry?", function (result) {
	                        // console.log(result);
	                        if (result) {
	                            //alert("true");
	                            var SQL = "UpdateMaster '" + $('#checkid').val() + "|" + $('#frmShareSelect').val() + "','" + accounting.unformat($('#checkAmount').val()) + "','7','" + $('#checkid').val() + "','" + $('#checkNumber').val() + "','" + MB.getCookie('activeid') + "'";	                            
	                            //console.log(SQL);
	                            MB.push(SQL);
	                            var SQL = "Update BankChecks SET CheckDate='" + $('#checkDate').val() + "',TransDesc='Bank-Purchase',Particulars='" + $('#checkParticular').val() + "',IssuedTo='" + $('#clientName').val() + "',Amount=" + accounting.unformat($('#checkAmount').val()) + ",TAG=1,v8RunDate=" + MB.getCookie('sysdate') + ",UserID='" + MB.getCookie('activeid') + "' WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmShareSelect').val() + $('#checkNumber').val() + "') ";
                                    //"Update BankChecks SET Amount=" + accounting.unformat($('#checkAmount').val()) + ",TAG=1,v8RunDate=" + MB.getCookie('sysdate') + ",UserID='" + MB.getCookie('activeid') + "' WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmShareSelect').val() + $('#checkNumber').val() + "') ";
	                            MB.push(SQL);
	                            MB.push("UPDATE BankAsset SET Status=1 WHERE id=" + $('#checkid').val());
	                            //var retv = $.post(MB.URLPoster(), {SQLStatement : SQL }); //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
	                            //retv.success(function(result) {
	                            bootbox.alert("Entry Saved..", function () { location.reload(); });
	                            //});                                                                 
	                        }
	                    });

	                } else {
	                    //console.log(value);
	                    if (value == 1) {
	                        bootbox.alert("Check Number is already in used..");
	                    } else {
	                        bootbox.alert("Check Number does not exists..");
	                    }
	                }
	            });
	        }
	    });

        /////////////////////////////////////////////////////////////////////////////////
	    //ok = 1;

	    //var SQL = "SELECT SUM(Amount) amount FROM BankAccTrn WHERE GLACC='" + $('#frmShareSelect').val() + "' ";
	    //$.ajax({
	    //    type: "POST",
	    //    url: MB.URLPoster(),
	    //    data: { SQLStatement: SQL },
	    //    success: function (data) {
	    //        console.log(data);
	    //        $.each(JSON.parse(data), function (key, value) {
	    //            if (value.amount < $('#checkAmount').val()) {
	    //                ok = 0;
	    //                bootbox.alert("Not enough fund for payment purchase", function () { location.reload(); });
	    //            }
	    //        });
	    //    }
	    //});
	    //// Check Validation
	    //var SQL = "SELECT IIF (CHARINDEX('" + $('#frmShareSelect').val() + "', DebitAcct+'|'+CreditAcct) > 0, 1, 0) TAG FROM MasterTRN WHERE CheckNumber=" + $('#checkNumber').val();
	    //$.ajax({
	    //    type: "POST",
	    //    url: MB.URLPoster(),
	    //    data: { SQLStatement: SQL },
	    //    success: function (data) {
	    //        console.log(data);
	    //        $.each(JSON.parse(data), function (key, value) {
	    //            if (value.TAG == 1) {
	    //                ok = 0;
	    //                bootbox.alert("Check Number is already in used..", function () { location.reload(); });

	    //            }
	    //        });
	    //    }
	    //});

	    //$(document).ready(function () {
	    //    if (ok = 1) {
	    //        bootbox.confirm("Save Entry?", function (result) {
	    //            if (result) {
	    //                //var ss = "UpdateMaster '" + $('#GLACC1').val() + "'," + $('#pur_cost').val() + ",6,'" + $('#checkid').val() + "','','" + MB.getCookie("activeid") + "'";

	    //                //MB.push(ss);

	    //                var sv = "UpdateMaster '" + $('#checkid').val() + "|" + $('#frmShareSelect').val() + "','" + $('#checkAmount').val() + "','7','" + $('#checkid').val() + "','" + $('#checkNumber').val() + "','" + MB.getCookie('activeid') + "'";
	    //                console.log(sv);
	    //                $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
        //                {
        //                    SQLStatement: sv
        //                }).done(function () {
        //                    bootbox.alert("Entry Saved..", function () {
        //                        MB.push("UPDATE BankAsset SET Status=1 WHERE id=" + $('#checkid').val());

        //                        location.reload();
        //                    });
        //                });
	    //            }
	    //        });
	    //    }
	    //});

	   
	},
	
	bankpurchaseload : function() {
	    //var sql =  "SELECT CAST(pur_date AS VARCHAR) pur_date,pur_desc,pur_cost,glacc,asset_code,id,IIF (tag <= 1,'Pending','Paid') tag FROM BankAsset WHERE tag=0 ";
	    var sql = "SELECT ";
	    sql += "CAST(pur_date AS VARCHAR) pur_date,";
	    sql += "(SELECT CompanyName FROM Vendors WHERE VendorID = VendorLink) pur_desc,";
	    sql += "pur_cost - ISNULL((SELECT SUM(amount) FROM BankAssetTrans WHERE assetid=BankAsset.asset_code),0) pur_cost,";
	    sql += "glacc,";
	    sql += "asset_code,";
	    sql += "id,";
	    sql += "IIF (pur_cost - ISNULL((SELECT SUM(amount) FROM BankAssetTrans WHERE assetid=BankAsset.asset_code),0) > 0,'Disburse Payment','1') tag ";
	    sql += "FROM BankAsset ";
	    console.log(sql);
	        //sql += "WHERE v8RunDate = (SELECT mbvalue FROM appconfig WHERE mbfield1='sysdate') AND status=0 AND trntype='22'";
	    $.ajax({
	        type: "POST",
	        url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
	        data: { SQLStatement: sql },
	        success: function (data) {
	            var grtot = 0;
	            $('#tblsharewith > tbody').html('');
	            $.each(JSON.parse(data), function (id, value) {
	                //console.log('Def bank: ' + value.mbvalue);
	                //.setCookie("defbank", value.mbvalue, 1
	                if(value.tag != "1"){
	                    var tr = "<tr>";
	                    tr += "<td>" + value.pur_date + "</td>";
	                    tr += "<td>" + value.pur_desc + "</td>";

	                   
	                    tr += "<td align='right'>" + accounting.formatMoney(value.pur_cost) + "</td>";
	                    tr += "<td><input id='"+value.id+"' type='checkbox' name='checkbox[]' value='" + value.asset_code + "::"+accounting.unformat(value.pur_cost)+"' onclick=pushpo('" + value.id + "','" + value.pur_cost + "')></td>";
	                    tr += "<td>" + value.glacc + "</td>";
	                    //tr += "<td onclick='BankPurchase.initValue("+value.id+");'><a class='label label-warning' data-toggle='modal' data-target='#swmanager'>" + value.tag + "</a></td></tr>";
	                    $('#tblsharewith').append(tr);
	                    grtot += value.pur_cost;
	                }
	            });
	            $('#tblsharewith').dataTable();
	            $('#total').append(accounting.formatMoney(grtot));
	        }
	    });
	
	},

	initValue: function (Id) {
	    //alert(Id);
	    $('#checkid').val(Id);
		
	    $.ajax({
	        type: "POST",
	        url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
	        data: { SQLStatement: "SELECT (SELECT CompanyName FROM Vendors WHERE VendorID = VendorLink) pur_desc, pur_cost - ISNULL((SELECT SUM(amount) FROM BankAssetTrans WHERE assetid=BankAsset.asset_code),0) pur_cost FROM BankAsset WHERE id=" + Id },
	        success: function (data) {
	            //console.log(data);
	            $.each(JSON.parse(data), function (id, value) {
	                $('#clientName').val(value.pur_desc);
	                $('#checkAmount').val(accounting.formatMoney(value.pur_cost));
	            });
	        }
	    });

	  
	},


	getDefBank: function () {
	    
	        $.ajax({
	            type 	: "POST",
	            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
	            data    : { SQLStatement: "select mbvalue from appconfig where mbfield1='Deposit'" },
	            success: function (data) {
	                $.each(JSON.parse(data), function (id, value) {
	                    //console.log('Def bank: ' + value.mbvalue);
	                    MB.setCookie("defbank", value.mbvalue, 1);
	                });
	            }
	        });
	  
	},

	bankpurchaseinfo: function(glcode) {
	    var s='';
	    if (MB.isEmpty(glcode))
	    {
	        BankPurchase.getDefBank();
	        glcode = MB.getCookie('defbank');
	    }
	    
        
	    var sv = "SELECT A.BankName,A.BankAccountNum,B.accounttype,C.EXPACC,C.TITLE,(SELECT SUM(amount) FROM BankAccTrn WHERE GLACC='" + glcode + "') glbalance ";
	    sv += "FROM BankAccounts A left join accounttype b on a.BankAccountType=B.id left join GLAC C ON A.GLACC=C.GLACC WHERE A.GLACC='" + glcode + "'";
		//console.log(sv);
		$.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
		{
		  SQLStatement: sv
		}, function (data) {
			//console.log(data);
			$.each($.parseJSON(data),function(id,value) {
				document.getElementById('accttype').innerHTML = value.accounttype;
				document.getElementById('acctnum').innerHTML = value.BankAccountNum;
				document.getElementById('glcode').innerHTML = value.EXPACC + ' (' + value.TITLE + ') ';
				document.getElementById('glBalance').innerHTML = accounting.formatMoney(value.glbalance);
				//$('#accttype').innerHTML = value.BankAccountType;
				//console.log(value.accounttype);
			});
		});
		
	}

}
