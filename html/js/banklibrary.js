var BankDeposit = {

	BAIL: function() {
				window.location = "/Main";
	},

	postcash: function (s) {
	    console.log(s);

	    if ($('#frmBankDepoAmt').val() === "") {
	        bootbox.alert("Invalid amount!!");
	        return
	    }
	    if ($('#frmReference').val() === "") {
	        bootbox.alert("Invalid reference!!");
	        return
	    }

	    if (s == "BankSaveMe2") {
	    	//bootbox.alert("Update Complete1!!");
	        var sql = "SELECT ISNULL(SUM(amount),0) amt FROM MasterTRN WHERE Remarks='DBDEPO' AND v8RunDate=" + MB.getCookie('sysdate') + " AND ModuleID = 'BK001' AND Status = 1";
	        console.log('>> ' + sql);
	        $.ajax({
	            type: "post",
	            url: MB.URLPoster(),
	            data: { SQLStatement: sql },
	            success: function (result) {
	                console.log('RES ' + result);
	                $.each(JSON.parse(result), function (key, value) {
	                    //if (value.amt <= 0) {
	                    //$('#frmBankDepoAmt').val() = $('#frmBankDepoAmt').val() - value.amt;

	                    //if ($('#frmBankDepoAmt').val() < 0) {
	                    //    $('#frmBankDepoAmt').val() = "";
	                    // }
	                    //}
	                    $('#frmBankDepoAmt').val(accounting.unformat($('#frmBankDepoAmt').val()));
	                    //console.log("amt : " + value.amt);
	                    //console.log("frm : " + $('#frmBankDepoAmt').val());

	                    if (value.amt.toFixed(2) == 0) {
	                    } else {
	                        //console.log("pass");
	                        $('#frmBankDepoAmt').val($('#frmBankDepoAmt').val() - value.amt);
	                    }

	                    if ($('#frmBankDepoAmt').val() <= 0) {
	                        // if ($('#frmBankDepoAmt').val() === "") {
	                        bootbox.alert("The deposit amount does not match your cash deposit transaction!");
	                        return
	                        // }
	                    } else {
	                        var sv = "EXEC UpdateMaster '" + $('#frmSelect').val() + "','" + accounting.unformat($('#frmBankDepoAmt').val()) + "',1,'" + $('#frmReference').val() + "','DBDEPO','" + MB.getCookie('activeid') + "'";
	                        //console.log($('#frmReference').val() + ":"+ sv);
	                        MB.push(sv);
	                        bootbox.alert("Save Complete..", function () { window.location = "/Transaction"; });
	                    }
	                    //console.log("amt2-> " + $('#frmBankDepoAmt').val());
	                    //bootbox.alert("Update Complete!!");
	                });

	            },
	        });
	    } else {
	    	//bootbox.alert("Save Complete..", function () { window.location = "/Transaction"; });
	        // var sv = "EXEC UpdateMaster '" + $('#frmSelect').val() + "','" + accounting.unformat($('#frmBankDepoAmt').val()) + "',1,'" + $('#frmReference').val() + "',' ','" + MB.getCookie('activeid') + "'";
	        //  console.log(sv);

	        // $.post(MB.URLPoster(), { SQLStatement: sv }, 
         //    function () { }).done(function () { bootbox.alert("Save Complete..", function () { window.location = "/Transaction"; }); }).complete(function () { 


         	var sv = "EXEC UpdateMaster '" + $('#frmSelect').val() + "','" + accounting.unformat($('#frmBankDepoAmt').val()) + "',1,'" + $('#frmReference').val() + "',' ','" + MB.getCookie('activeid') + "'";
	        
	        console.log	(sv);
	        //var sv = "Select * from appconfig";

	        $.ajax({
	        	type: 'post',
	        	url: MB.URLPoster(),
	        	data: { SQLStatement: sv },
	        	//datatype: JSON,
	        	beforeSend: function() {

	        		NProgress.start();

	        		bootbox.dialog({
	        			closeButton: false,
	        			message: "Loading Data!",
	        			title: "Please wait!"
	        		});
	        	},
	        	success: function(xresult) {
	        		console.log('res:' + xresult);
	        		bootbox.hideAll();

	        		NProgress.done();

	        		bootbox.alert("Save Complete..", function () { 

	        			//NProgress.start();

		        		bootbox.dialog({
		        			closeButton: false,
		        			message: "Loading Transactions!",
		        			title: "Please wait!"
		        		});

	        			window.location.href = "/Transaction"; 

	        		});
	        	},
	        });


	    }

	},

	postcheck : function() {
	
			  if ($('#chkNumber').val() == "") {
                  bootbox.alert("Invalid Check Number!!");
                  return
              }
			  
              if ($('#chkAmount').val() == "") {
                  bootbox.alert("Invalid Amount!!");
                  return
              }
              if ($('#chkReference').val() == "") {
                  bootbox.alert("Invalid Reference!!");
                  return
              }
           
              var SQL = "INSERT INTO BankCheckTrn (v8RunDate,TrnType,Amount,GLCode,CheckNumber,IssuingBank,IssuedBy,Tag,Particulars,CheckDate) VALUES ('" + MB.getCookie("sysdate") + "',2," + accounting.unformat($('#chkAmount').val()) + ",'" + $('#frmSelect').val() + "'," + $('#chkNumber').val() + ",'" + $('#chkIssuingBank').val() + "','" + $('#chkIssuedBy').val() + "',1,'" + $('#chkParticular').val() + "','" + $('#chkDate').val() + "')";
              console.log(SQL);
              MB.push(SQL);
				
				 
				var sv = "EXEC UpdateMaster '" + $('#frmSelect').val() + "','" + parseFloat($('#chkAmount').val()) + "',2,'" + $('#chkReference').val() + "','" + parseInt($('#chkNumber').val()) + "','" + MB.getCookie('activeid') + "'";
				
				$.post(MB.URLPoster(),{ SQLStatement: sv })
				bootbox.alert("Save Complete..", function () { window.location = "/Transaction"; });
				

	    // 		$.post(MB.URLPoster(),  //
     //            {
     //                SQLStatement: sv
     //            }, function () { }).done(function () { bootbox.alert("Save Complete..", function(){
     //                MB.push("EXEC ");
					// window.location = "/Transaction";
					// } ); });
       
	},
	
	CheckEntry : function() {
	      var vhtml  = 'Check#<br><input class="form-control input-lg currency" type=text id="Check" placeholder="Check#" size=70 />';
              vhtml += 'Amount<br><input class="form-control input-lg currency" type=text id="Amount" placeholder="$0.00" size=70 />';
              vhtml += 'Bank Account<br><select class="form-control" id="frmSelect2">' + $('#frmSelect').html() + '</select>';
              vhtml += 'Reference<br><input class="form-control input-lg" type=text id="Reference" placeholder="Reference" size=70 /><br>'

				bootbox.dialog({
					message: vhtml,
					title: "Action - Check Transaction?",
					buttons: {
                      danger: {
                          label: "Add Entry",
                          className: "btn-danger",
                          callback: function () 
							{
						  
								if( $('#Check').val() != "") {
									if( $('#Amount').val() != "") {
										if( $('#Reference').val() != "") {
								  
										    $.post(MB.URLPoster(),  //
											{
												  SQLStatement: "SELECT ModuleID FROM MODULES WHERE 1=1 AND Description LIKE '%check%' AND STATUS=1"
											}, function (data) 
											{
												  var S = JSON.parse(data.replace("[", "").replace("]", ""));
												  var sv = "INSERT INTO MasterTRN (TrnDate,DebitAcct,CreditAcct,Amount,GLTrnType,ModuleID,Reference,Remarks,Status,CheckNumber,UserID) VALUES (" +
															 "getdate()," + // trndata
															 "'" + $('#frmSelect2').val() + "'," + //debitAcct
															 "(SELECT CreditGLAcct FROM GLEntry WHERE ModuleID='" + S.ModuleID + "')," + //CreditAcct
															 $('#Amount').val() + "," + //Amount
															 "(SELECT GLtrntype FROM GLEntry WHERE ModuleID='" + S.ModuleID + "')," + //GLTrnType
															 "'" + S.ModuleID + "'," + //ModuleID
															 "'" + $('#Reference').val() + "'," + //Reference
															 "''," + //Remarks
															 "'1'," + // status
															 "'" + $('#Check').val() + "',"+
															 "'" + MB.getCookie('activeid') + "')"; //Active User
															//console.log(sv);

											    $.post(MB.URLPoster(),  //
												  {
													  SQLStatement: sv
												  }, function () { }).done(function () { bootbox.alert("Save Complete..",function(){
												   // $('#example2').dataTable().fnAddData(["", $('#Check').val(), accounting.formatMoney($('#Amount').val()), $('#frmSelect2').val(), $('#Reference').val(), "status"]);
												  })}).error(function () {bootbox.alert("<h3>Saving Error..</h3><br><br>Check for any missing values..") });
												  $('#example2').dataTable().fnAddData([
												  "", $('#Check').val(), accounting.formatMoney($('#Amount').val()), $('#frmSelect2').val(), $('#Reference').val(), "status"]);

											});
										}
									}
								}
							}

						},
						main: {
                          label: "Exit",
                          className: "btn-primary",
                          callback: function () {
                              console.log("Primary button");
							}
						}
					}
				});

	},
	bankinfo : function(glcode) {
	    var sv = "SELECT A.BankName,A.BankAccountNum,B.accounttype,C.EXPACC,C.TITLE,(SELECT SUM(amount) FROM BankAccTrn WHERE GLACC='" + glcode + "') glbalance ";
	        sv += "FROM BankAccounts A left join accounttype b on a.BankAccountType=B.id left join GLAC C ON A.GLACC=C.GLACC WHERE A.GLACC='"+glcode+"'";
		//console.log(sv);
		$.post(MB.URLPoster(),  //
		{
		  SQLStatement: sv
		}, function (data) {
			//console.log(data);
			$.each($.parseJSON(data),function(id,value) {
				document.getElementById('accttype').innerHTML = value.accounttype;
				document.getElementById('acctnum').innerHTML = value.BankAccountNum;
				document.getElementById('glcode').innerHTML = value.EXPACC + ' (' + value.TITLE + ') ';
				document.getElementById('glbalance').innerHTML = accounting.formatMoney(value.glbalance);
				//$('#accttype').innerHTML = value.BankAccountType;
				//console.log(value.accounttype);
			});
		});
		//alert(glcode);
	},

	bankcashinfoload: function () {
	    var sv = "SELECT acc account,ISNULL(fname+' '+lname,'') fullname,trnamt/100 amount FROM dashboard WHERE trntype IN ('01','21','23','93','13','31') and trnnonc=0 and trndate=" + MB.getCookie("sysdate");
	    console.log(sv);
	    $.post(MB.URLPoster(),  //
		{
		    SQLStatement: sv
		}, function (data) {
		    //console.log(data);
		    var svtot = 0;
		    $.each($.parseJSON(data), function (id, value) {

		        var tr = '<tr>';
		        tr += '<td>' + value.account + '</td>';
		        tr += '<td>' + value.fullname+ '</td>';
		        tr += '<td>' + accounting.formatMoney(value.amount) + '</td>';
		        tr += '</tr>';
		        svtot += value.amount;
		        $('#tbllisting tbody').append(tr);

		    });
		    $('#totinfocash').append(accounting.formatMoney(svtot));
		    //$(function () {
		    $('#tbllisting').dataTable();
		    //});

		});
	},
	bankinfo2 : function(glcode) {
		var sv = "SELECT A.BankName,A.BankAccountNum,B.accounttype,C.EXPACC,C.TITLE FROM BankAccounts A left join accounttype b on a.BankAccountType=B.id left join GLAC C ON A.GLACC=C.GLACC WHERE A.GLACC='"+glcode+"'";
		//console.log(sv);
		$.post(MB.URLPoster(),  //
		{
		  SQLStatement: sv
		}, function (data) {
			//console.log(data);
			$.each($.parseJSON(data),function(id,value) {
				document.getElementById('chktype').innerHTML = value.accounttype;
				document.getElementById('chkacct').innerHTML = value.BankAccountNum;
				document.getElementById('chkgl').innerHTML = value.EXPACC+' ('+value.TITLE+') ';
				//$('#accttype').innerHTML = value.BankAccountType;
				//console.log(value.accounttype);
			});
		});
		//alert(glcode);
	},
	bankcheckload: function() {
	    //var sv = "SELECT A.id,A.CHQNUM,A.DEPAMT/100 DEPAMT,B.debitacct, ISNULL(C.BankAccountNum,'') BANKACCT,ISNULL(B.REFERENCE,'') REFERENCE,A.STATUS FROM SVUCDEP A LEFT JOIN MASTERTRN B ON A.MasterID=B.TrnID LEFT JOIN BankAccounts C ON B.debitacct=C.GLACC WHERE A.TRNDATE=" + MB.getCookie("sysdate");
	    //console.log(sv);
	    // var sv = "SELECT * FROM ";
	    // sv += "( SELECT A.id,A.CHQNUM,A.DEPAMT/100 DEPAMT,B.debitacct, ISNULL(C.BankAccountNum,'') BANKACCT,ISNULL(B.REFERENCE,'') REFERENCE,A.STATUS,A.TRNDATE FROM SVUCDEP A LEFT JOIN MASTERTRN B ON A.MasterID=B.TrnID LEFT JOIN BankAccounts C ON B.debitacct=C.GLACC  ";
	    // sv += "  UNION ";
	    // sv += "  SELECT TRN id,'' CHQNUM,trnamt/100 DEPAMT,null debitacct,'' BANKACCT,'' REFERENCE,0 STATUS,TRNDATE FROM dashboard WHERE trnnonc > 0 AND TRNTYPE IN ('01','21','31','95') and TRN not in (select trn from SVUCDEP) ";
	    // sv += ") A WHERE TRNDATE=" + MB.getCookie("sysdate");
	    var sv = "EXEC sp_bankcheckload '" + MB.getCookie("sysdate") + "'";

	    console.log(sv);
	    $.post(MB.URLPoster(),  //
		{
		  SQLStatement: sv
		}, function (data) {
			//console.log(data);
			$.each($.parseJSON(data),function(id,value) {
			
				var tr  = '<tr><td></td>';
				    tr += '<td>'+value.CHQNUM+'</td>';
					tr += '<td>'+accounting.formatMoney(value.DEPAMT.toFixed(2))+'</td>';
					tr += '<td>'+value.BANKACCT+'</td>';
					tr += '<td>'+value.REFERENCE+'</td>';
					//tr += '<td onclick="BankDeposit.processcheck('+value.id+')">'+(value.STATUS==0 ? '<a class="label label-warning">Pending</a>':'<span class="label label-success">Posted</span>')+'</td></tr>';
					tr += '<td onclick=BankDeposit.processcheck("'+value.id+'","'+value.CHQNUM+'","'+value.DEPAMT.toFixed(2)+'")>'+(value.STATUS==0 ? '<a class="label label-warning" data-toggle="modal" data-target="#checkmanager">Pending</a>':'<span class="label label-success">Posted</span>')+'</td></tr>';
					$('#example2 tbody').append(tr);
					
			});
			console.log(sv + '--success--');
			$(function () {
              $('#example2').dataTable();
          });

		});
	},
	processcheck: function (n, chqno, chqamt) {
	    console.log(n);
	    console.log(chqno);
	    console.log(chqamt);
		$('#chkno').val(chqno);
		$('#chkamt').val(accounting.formatMoney(chqamt));
		$('#idptr').val(n);
	},
	postchecking: function () {
	    var sv = "INSERT INTO BankCheckTrn (v8RunDate,TrnType,Amount,GLCode,CheckNumber,IssuingBank,IssuedBy,Tag) VALUES ('" + MB.getCookie("sysdate") + "',2," + accounting.unformat($('#chkamt').val()) + ",'" + $('#Select1').val() + "'," + $('#chkno').val() + ",'" + $('#chkissuebank').val() + "','" + $('#chkissueby').val() + "',1)";

		if ($('#chkissuebank').val() == "") {
                bootbox.alert("Invalid Issuing Bank!!");
                return
        }
		if ($('#chkissueby').val() == "") {
            bootbox.alert("Invalid Issued By!!");
            return
        }
		
		if ($('#chkno').val() == "") {
		  bootbox.alert("Invalid Check Number!!");
		  return
		}
		if (($('#chkamt').val() == "") || ($('#chkamt').val() == "0")) {
		  bootbox.alert("Invalid Amount!!");
		  return
		}
		if ($('#chkref').val() == "") {
		  bootbox.alert("Invalid Reference!!");
		  return
		}

		//MB.push(sv);

		// $.ajax({
		// 	type: 'POST',
		// 	url: MB.URLPoster(),
		// 	data: { SQLStatement: sv },
		// 	beforeSend: function() {
		// 		bootbox.dialog({
	 //        			closeButton: false,
	 //        			message: "Loading Data!",
	 //        			title: "Please wait!"
	 //        	});
		// 	},
		// 	success: function() {
		// 		bootbox.hideAll();
		// 	},
		// });

		$.ajax({
			type: "POST",
			url: MB.URLPoster(),  //
			data: { SQLStatement : "SELECT ModuleID FROM MODULES WHERE 1=1 AND Description LIKE '%check%' AND STATUS=1" },
			beforeSend: function() {

	        		bootbox.dialog({
	        			closeButton: false,
	        			message: "Loading Data!",
	        			title: "Please wait!"
	        		});
	        }
		}).done(function(msg){
			bootbox.hideAll();
			S = JSON.parse(msg.replace("[", "").replace("]", ""));
			//console.log('1');
			sv =  "INSERT INTO MasterTRN (TrnDate,v8RunDate,DebitAcct,CreditAcct,Amount,GLTrnType,ModuleID,Reference,Remarks,Status,CheckNumber,UserID) VALUES (" +
						 "getdate()," + // trndata
						 "(SELECT mbvalue from appconfig where mbfield1='sysdate'),"+
						 "'" + $('#Select1').val() + "'," + //debitAcct
						 "(SELECT CreditGLAcct FROM GLEntry WHERE ModuleID='" + S.ModuleID + "')," + //CreditAcct
						 accounting.unformat($('#chkamt').val()) + "," + //Amount
						 "(SELECT GLtrntype FROM GLEntry WHERE ModuleID='" + S.ModuleID + "')," + //GLTrnType
						 "'" + S.ModuleID + "'," + //ModuleID
						 "'" + $('#chkref').val() + "'," + //Reference
						 "''," + //Remarks
						 "'1'," + // status
						 "'" + $('#chkno').val() + "',"+
						 "'" + MB.getCookie('activeid') + "')";
						 //console.log(sv);
						$.ajax({
							type: "POST",
							url: MB.URLPoster(),  //
							data: { SQLStatement : sv },
							beforeSend: function() {

					        		bootbox.dialog({
					        			closeButton: false,
					        			message: "Loading Data!",
					        			title: "Please wait!"
					        		});
					        }
						}).done(function(msg){
							bootbox.hideAll();
						//	console.log(2);
						  // bootbox.alert("Save complete..", function() {});	
							$.ajax({
								type: "POST",
								url: MB.URLPoster(),  //
								data: { SQLStatement : "UPDATE SVUCDEP SET MasterID=(SELECT MAX(trnID) FROM MasterTRN),STATUS=1 WHERE id="+$('#idptr').val() },
								beforeSend: function() {

					        		bootbox.dialog({
					        			closeButton: false,
					        			message: "Loading Data!",
					        			title: "Please wait!"
					        		});
					        }
							}).done(function(msg){
								bootbox.hideAll();
							    //$.ajax({
								//	type: "POST",
								//	url: 
								//	data: {SQLStatement : "UPDATE "}
								//}).done(function(msg){
									//bootbox.alert("Save complete..", function() { location.reload(true); });
									bootbox.alert("Save Complete..", function () { location.reload(true); });
								//});

							});
						  
						});
						
		});
		
	}
}

