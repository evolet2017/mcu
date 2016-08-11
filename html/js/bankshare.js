var BankShare = {

	banksharebanklist: function() {

	    //var ss = "select A.GLACC,A.BankName,B.accounttype,A.BankAccountNum,(SELECT 'selected' from appconfig where mbfield1='Deposit' and mbvalue=a.GLACC) as vselect from BankAccounts A LEFT JOIN accounttype B on A.BankAccountType=B.id WHERE 1=1 AND A.GLACC<>''";

	    var ss = "select A.GLACC,A.BankName,B.accounttype,A.BankAccountNum,";
	    ss += "(SELECT 'selected' from appconfig where mbfield1='Deposit' and mbvalue=a.GLACC) as vselect ";
	    ss += "from BankAccounts A LEFT JOIN accounttype B on A.BankAccountType=B.id WHERE 1=1 AND A.GLACC in (select GLACC FROM CheckBooks)";
		//console.log(ss);
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

			//console.log(msg);
		    //    alert(2);
			BankShare.bankshareinfo($('#frmShareSelect').val());


		});
	},

	banksharesave : function() {	
	//bootbox.alert("banksharesave");	

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

               var SQL = "SELECT SUM(Amount)-" + parseFloat(accounting.unformat($('#checkAmount').val())) + " amount FROM BankAccTrn WHERE GLACC='" + $('#frmShareSelect').val() + "' ";
               //var retval = $.post(MB.URLPoster(), { SQLStatement: SQL });

               $.ajax({
               		type: 'post',
               		url: MB.URLPoster(),
               		data: { SQLStatement: SQL },
               		beforeSend: function(result) {
               			NProgress.start();

		        		bootbox.dialog({
		        			closeButton: false,
		        			message: "Please wait...",
		        			title: "Loading..."
		        		});
               		},
               		success: function(result) {
               			//bootbox.hideAll();

						//NProgress.done();
						var v1 = JSON.parse(result);
	                    if (v1[0].amount < 0 ) {
	                       bootbox.alert("Not enough fund for check withdrawal", function () { return; });
	                    } else {

	                       // Check Validation	          
	                       var SQL = "SELECT TAG FROM BankChecks WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmShareSelect').val() + $('#checkNumber').val() + "') ";
	                       //console.log(SQL);
	                       //var retval = $.post(MB.jURLPoster(), { SQLStatement: SQL });

	                       $.ajax({
	                       		type: 'post',
	                       		url: MB.jURLPoster(),
	                       		data: { SQLStatement: SQL },
	                       		beforeSend: function(result) {
	                       			NProgress.start();

					        		bootbox.dialog({
					        			closeButton: false,
					        			message: "Please wait...",
					        			title: "Loading..."
					        		});
	                       		},
	                       		success: function(result) {
	                       			bootbox.hideAll();

									NProgress.done();
		                       	   	console.log(result);
		                           	var value = result.replace('[["', '').replace('"]]', '');
		                           //console.log(value);
		                           	if (value == 0) {

		                               	bootbox.confirm("Save Entry?", function (result) {
		                                   // console.log(result);
		                                   if (result) {
		                                       //alert("true");
		                                       var SQL = "UpdateMaster '" + $('#checkid').val() + "|" + $('#frmShareSelect').val() + "','" + accounting.unformat($('#checkAmount').val()) + "','4','" + $('#checkReference').val() + "','" + $('#checkNumber').val() + "','" + MB.getCookie('activeid') + "'";
		                                       console.log(SQL);
		                                       //MB.push(SQL);
		                                       var SQL2 = "Update BankChecks SET CheckDate='" + $('#checkDate').val() + "',TransDesc='Share-Withdrawals',Particulars='" + $('#checkParticular').val() + "',IssuedTo='" + $('#clientName').val() + "',Amount=" + accounting.unformat($('#checkAmount').val()) + ",TAG=1,v8RunDate=" + MB.getCookie('sysdate') + ",UserID='" + MB.getCookie('activeid') + "' WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmShareSelect').val() + $('#checkNumber').val() + "') ";
		                                       console.log(SQL2);
		                                       //MB.push(SQL);
		                                       //var retv = $.post(MB.URLPoster(), {SQLStatement : SQL }); //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
		                                       //retv.success(function(result) {
		                                       //bootbox.alert("Entry Saved..", function () { location.reload(); });
		                                       //});

		                                       	$.ajax({
		                                       		type: 'Post',
		                                       		url: MB.URLPoster(),
		                                       		data: { SQLStatement: SQL },
		                                       		beforeSend: function() {
		                                       			NProgress.start();
		                                       			bootbox.hideAll();

		                                       			bootbox.dialog({
										        			closeButton: false,
										        			message: "Please wait...",
			        										title: "Loading..."
										        		});
		                                       		},
		                                       		success: function(result) {

		                                       			$.ajax({
		                                       				type: 'Post',
		                                       				url: MB.URLPoster(),
		                                       				data: { SQLStatement: SQL2 },
		                                       				success: function(result2) {
		                                       					NProgress.done();
		                                       					bootbox.hideAll();
		                                       					bootbox.alert("Entry Saved..", function () { location.reload(); });
		                                       				},

		                                       			});

		                                       		},
		                                       		error: function(xresult) {
														console.log('res:' + xresult);
										        		bootbox.hideAll();

										        		NProgress.done();

										        		bootbox.alert("Failed, please check your network connectivity..");
										        	},

		                                       	});                                                            
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
	                       		},
	                       		error: function(result) {
	                       			console.log('res:' + result);
									bootbox.hideAll();

									NProgress.done();

									bootbox.alert("Failed, please check your network connectivity..");
	                       		},

	                       });
	                   	}
               		},
               		error: function(result) {
						console.log('res:' + result);
						bootbox.hideAll();

						NProgress.done();

						bootbox.alert("Failed, please check your network connectivity..");
               		},

               });

    },
              // = false;

     //           retval.beforeSend(function (result) {
					// NProgress.start();
     //                bootbox.hideAll();

     //                bootbox.dialog({
					// closeButton: false,
					// message: "Please wait...",
	    //     		title: "Loading..."
     //           });

     //           retval.success(function (result) {
     //               //var value = parseFloat(result.replace('[["', '').replace('"]]', ''));
     //               //var v1 = parseFloat($('#checkAmount').val());
     //               //console.log('pass');
     //               var v1 = JSON.parse(result);
     //               if (v1[0].amount < 0 ) {
     //                   bootbox.alert("Not enough fund for check withdrawal", function () { return; });
     //               } else {

     //                   // Check Validation	          
     //                   var SQL = "SELECT TAG FROM BankChecks WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmShareSelect').val() + $('#checkNumber').val() + "') ";
     //                   //console.log(SQL);
     //                   var retval = $.post(MB.jURLPoster(), { SQLStatement: SQL });
     //                   retval.success(function (result) {
     //                       // console.log(result);
     //                       var value = result.replace('[["', '').replace('"]]', '');
     //                       //console.log(value);
     //                       if (value == 0) {

     //                           bootbox.confirm("Save Entry?", function (result) {
     //                               // console.log(result);
     //                               if (result) {
     //                                   //alert("true");
     //                                   var SQL = "UpdateMaster '" + $('#checkid').val() + "|" + $('#frmShareSelect').val() + "','" + accounting.unformat($('#checkAmount').val()) + "','4','" + $('#checkReference').val() + "','" + $('#checkNumber').val() + "','" + MB.getCookie('activeid') + "'";
     //                                   console.log(SQL);
     //                                   //MB.push(SQL);
     //                                   var SQL2 = "Update BankChecks SET CheckDate='" + $('#checkDate').val() + "',TransDesc='Share-Withdrawals',Particulars='" + $('#checkParticular').val() + "',IssuedTo='" + $('#clientName').val() + "',Amount=" + accounting.unformat($('#checkAmount').val()) + ",TAG=1,v8RunDate=" + MB.getCookie('sysdate') + ",UserID='" + MB.getCookie('activeid') + "' WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmShareSelect').val() + $('#checkNumber').val() + "') ";
     //                                   console.log(SQL2);
     //                                   //MB.push(SQL);
     //                                   //var retv = $.post(MB.URLPoster(), {SQLStatement : SQL }); //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
     //                                   //retv.success(function(result) {
     //                                   //bootbox.alert("Entry Saved..", function () { location.reload(); });
     //                                   //});

     //                                   $.ajax({
     //                                   		type: 'Post',
     //                                   		url: MB.URLPoster(),
     //                                   		data: { SQLStatement: SQL },
     //                                   		beforeSend: function() {
     //                                   			NProgress.start();
     //                                   			bootbox.hideAll();

     //                                   			bootbox.dialog({
					// 			        			closeButton: false,
					// 			        			message: "Please wait...",
	    //     										title: "Loading..."
					// 			        		});
     //                                   		},
     //                                   		success: function(result) {

     //                                   			$.ajax({
     //                                   				type: 'Post',
     //                                   				url: MB.URLPoster(),
     //                                   				data: { SQLStatement: SQL2 },
     //                                   				success: function(result2) {
     //                                   					NProgress.done();
     //                                   					bootbox.hideAll();
     //                                   					bootbox.alert("Entry Saved..", function () { location.reload(); });
     //                                   				},

     //                                   			});

     //                                   		},
     //                                   		error: function(xresult) {
					// 							console.log('res:' + xresult);
					// 			        		bootbox.hideAll();

					// 			        		NProgress.done();

					// 			        		bootbox.alert("Failed, please check your network connectivity..");
					// 			        	},

     //                                   });                                                            
     //                               }
     //                           });

     //                       } else {
     //                           //console.log(value);
     //                           if (value == 1) {
     //                               bootbox.alert("Check Number is already in used..");
     //                           } else {
     //                               bootbox.alert("Check Number does not exists..");
     //                           }
     //                       }
     //                   });
     //               }
     //           });
			  //  retval.fail(function (result) {
			  //  		console.log('res:' + result);
					// bootbox.hideAll();

					// NProgress.done();

					// bootbox.alert("Failed, please check your network connectivity..");
			  //  });








	    //// Balance Checker
        //       var SQL = "SELECT SUM(Amount) amount FROM BankAccTrn WHERE GLACC='" + $('#frmShareSelect').val() + "' ";
        //       $.ajax({
        //           type: "POST",
        //           url: MB.URLPoster(),
        //           data: { SQLStatement: SQL },
        //           success: function (data) {
        //               console.log(data);
        //               $.each(JSON.parse(data), function (key, value) {
        //                   if (value.amount < $('#checkAmount').val()) {
        //                       bootbox.alert("Not enough fund for check withdrawal");
        //                       return
        //                   }
        //               });
        //           }
        //       });
	    //// Check Validation
        //       var SQL = "SELECT IIF (CHARINDEX('" + $('#frmShareSelect').val() + "', DebitAcct+'|'+CreditAcct) > 0, 1, 0) TAG FROM MasterTRN WHERE CheckNumber=" + $('#checkNumber').val();
        //       $.ajax({
        //           type: "POST",
        //           url: MB.URLPoster(),
        //           data: { SQLStatement: SQL },
        //           success: function (data) {
        //               console.log(data);
        //               $.each(JSON.parse(data), function (key, value) {
        //                   if (value.TAG == 1) {
        //                       bootbox.alert("Check Number is already in used..", function () { location.reload(); });

        //                   }
        //               });
        //           }
        //       });


        //       bootbox.confirm("Save Entry?", function (result) {
        //           if (result = true) {
        //               //alert("true");
        //               var sv = "UpdateMaster '" + $('#checkid').val() + "|" + $('#frmShareSelect').val() + "','" + $('#checkAmount').val() + "','4','" + $('#checkReference').val() + "','" + $('#checkNumber').val() + "','" + MB.getCookie('activeid') + "'";
        //               $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
		//               {
		//		        SQLStatement: sv
		//               }).done(function () {
		//                   bootbox.alert("Entry Saved..", function () {
		//                       //MB.push("UPDATE BankPayables SET Status=1, CheckNumber = '" + $('#checkNumber').val() + "' WHERE id=" + $('#checkid').val());

		//                       location.reload();
		//                   });
		//               });
        //            }
        //       });

    
	bankshareload : function() {
	    var sql =  "SELECT Id,dbo.NUM2DATE(v8RunDate) numdate,ClientName,CheckAmount,'' checknumber,'Disburse' remarks FROM BankPayables ";
	        sql += "WHERE v8RunDate = (SELECT mbvalue FROM appconfig WHERE mbfield1='sysdate') AND status=0 AND trntype in ('02','14')";
	    $.ajax({
	        type: "POST",
	        url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
	        data: { SQLStatement: sql },
	        success: function (data) {
	            var grtot = 0;
	            $.each(JSON.parse(data), function (id, value) {
	                //console.log('Def bank: ' + value.mbvalue);
	                //.setCookie("defbank", value.mbvalue, 1
	                var tr = "<tr><td></td>";
	                tr += "<td>" + value.numdate + "</td>";
	                tr += "<td>" + value.ClientName + "</td>";
	                tr += "<td align='right'>" + accounting.formatMoney(value.CheckAmount) + "</td>";
	                tr += "<td>" + value.checknumber + "</td>";
	                tr += "<td id='" + value.Id + "' onclick='BankShare.initValue("+value.Id+");'><a class='label label-warning' data-toggle='modal' data-target='#swmanager'>" + value.remarks + "</a></td></tr>";
	                $('#tblsharewith').append(tr);
	                grtot += value.CheckAmount;
	            });
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
	        data: { SQLStatement: "SELECT clientname, checkamount FROM BankPayables WHERE id="+Id },
	        success: function (data) {
	            console.log(data);
	            $.each(JSON.parse(data), function (id, value) {
	                $('#clientName').val(value.clientname);
	                $('#checkAmount').val(accounting.formatMoney(value.checkamount));
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

	bankshareinfo: function(glcode) {
	    var s='';
	    if (MB.isEmpty(glcode))
	    {
	        BankShare.getDefBank();
	        glcode = MB.getCookie('defbank');
	    }
	    
        
	    var sv = "SELECT A.BankName,A.BankAccountNum,B.accounttype,C.EXPACC,C.TITLE,(SELECT SUM(amount) FROM BankAccTrn WHERE GLACC='" + glcode + "') glbalance ";
	    sv += "FROM BankAccounts A left join accounttype b on a.BankAccountType=B.id left join GLAC C ON A.GLACC=C.GLACC WHERE A.GLACC='"+glcode+"'";
		console.log(sv);
		$.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
		{
		  SQLStatement: sv
		}, function (data) {
			console.log(data);
			$.each($.parseJSON(data),function(id,value) {
				document.getElementById('accttype').innerHTML = value.accounttype;
				document.getElementById('acctnum').innerHTML = value.BankAccountNum;
				document.getElementById('glcode').innerHTML = value.EXPACC + ' (' + value.TITLE + ') ';
				document.getElementById('glBalance').innerHTML = accounting.formatMoney(value.glbalance);

			});
		});
		
	}

}
