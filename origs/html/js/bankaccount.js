var BankAccount = {

	bankacctsave : function() {		
			if($('#acctname').val() != ""){
				if($('#acctbank').val() != ""){
					bootbox.confirm("Post Entry?", function(result){
						if (result == true) {
						    var sql = "insert into BankAccounts (BankName,BankAccountNum,BankAccountType,GLACC,Remarks,DateAdded,UserID,BankAcctStatus,StartingBalance) values ('" + $('#acctname').val() + "','" + $('#acctbank').val() + "'," + $('#acctselect').val() + ",'" + $('#glac').val() + "','" + $('#acctremarks').val() + "',getdate(),'" + MB.getCookie('activeid') + "',1," + $('#acctbalance').val() + ")";
							//console.log(sql);
						    $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
							{
								SQLStatement: sql
							}, function () { }).done(function () {
							    bootbox.alert("Save Complete.", function () {
							        //var sql = "INSERT INTO BankAccTrn (v8RunDate,GLACC,Amount,Balance,Tag) VALUES (" +
                                    //        MB.getCookie('sysdate') + ",'" + $('#glac').val() + "'," + $('#acctbalance').val() + "," + $('#acctbalance').val() + ",1)";
							        //console.log(sql);
							        //MB.push(sql);
							        window.location = '/Bank-Account';
							    });
							}).fail(function () { bootbox.alert("unknown error on saving."); }).complete(function () { });
						}
					});
					//
				} else {
					bootbox.alert("Unable to process request, Account number Required..");
				}
				
			}  else {
					bootbox.alert("Unable to process request, Bank Name Required");
				}
	},
	bankacctsave2: function () {
	   // alert(document.getElementById('edtStat').checked);
	   // return;
	    if ($('#edtBank').val() != "") {
	        if (1==1) {
	            bootbox.confirm("Post Entry?", function (result) {
	                if (result == true) {
	                    var ssqqll = "SELECT COUNT(GLACC) cnt,GLACC,CAST(1*SUM(Amount) AS INT) Amount  FROM BankAccTrn WHERE GLACC=(SELECT GLACC FROM BankAccounts WHERE BankID='" + $('#tmpbankid').val() + "') GROUP BY GLACC";
	                   
	                    //var rett = $.post(MB.URLPoster(), { SQLStatement: "SELECT COUNT(GLACC) cnt,GLACC,CAST(1*SUM(StartingBalance) AS INT) StartingBalance  FROM BankAccTrn WHERE BankID='" + $('#tmpbankid').val() + "' GROUP BY GLACC" });
	                    var rett = $.post(MB.URLPoster(), { SQLStatement: ssqqll });
	                    rett.success(function (data) {
	                       // console.log(data);
                          //  return
	                        //return
	                     //   MB.post("BEGIN TRANSACTION");
	                        var sql = "UPDATE BankAccounts SET  BankAccountNum='" + $('#edtAcct').val() + "',BankName='" + $('#edtBank').val() + "',Remarks='" + $('#edtRemarks').val() + "',UserID='" + MB.getCookie('activeid') + "' WHERE BankID=" + $('#tmpbankid').val();
	                        var rr = JSON.parse(data);
	                        try
	                        {
	                            if ((rr[0].cnt + rr[0].Amount == 1)) {
                                
	                                var sql = "UPDATE BankAccounts SET StartingBalance=" + $('#edtBalance3').val() + ", DateBalance='" + $('#edtDate').val() + "', BankAccountNum='" + $('#edtAcct').val() + "',BankName='" + $('#edtBank').val() + "',Remarks='" + $('#edtRemarks').val() + "',UserID='" + MB.getCookie('activeid') + "' WHERE BankID=" + $('#tmpbankid').val();
	                                MB.post(sql);
	                                MB.post("DELETE FROM BankAccTrn WHERE GLACC='" + rr[0].GLACC + "';");
	                                var sql = "INSERT INTO BankAccTrn (v8RunDate,GLACC,Amount,Balance,Tag) " +
                                            "SELECT " +
                                            "(SELECT mbvalue FROM appconfig WHERE mbfield1='sysdate')," +
                                            "'" + rr[0].GLACC + "'," +
                                            $('#edtBalance3').val() + "," +
                                            $('#edtBalance3').val() + "," +
                                            "1 ";
	                                // console.log('zzzzzzzzzzzzzzzzzzz');
	                                setTimeout(function(){MB.post(sql)}, 1500);
	                                // MB.post("COMMIT TRANSACTION");
	                            } else {
	                                MB.post(sql);
	                            }
	                        } catch (e) {
	                            var sql = "UPDATE BankAccounts SET StartingBalance=" + $('#edtBalance3').val() + ", DateBalance='" + $('#edtDate').val() + "', BankAccountNum='" + $('#edtAcct').val() + "',BankName='" + $('#edtBank').val() + "',Remarks='" + $('#edtRemarks').val() + "',UserID='" + MB.getCookie('activeid') + "' WHERE BankID=" + $('#tmpbankid').val();
	                            MB.post(sql);
	                            var sql = "INSERT INTO BankAccTrn (v8RunDate,GLACC,Amount,Balance,Tag) " +
                                            "SELECT " +
                                            "(SELECT mbvalue FROM appconfig WHERE mbfield1='sysdate')," +
                                            "(SELECT GLACC FROM BankAccounts WHERE BankID='" + $('#tmpbankid').val() + "')," +
                                            $('#edtBalance3').val() + "," +
                                            $('#edtBalance3').val() + "," +
                                            "1 ";
	                            // console.log('zzzzzzzzzzzzzzzzzzz');
	                            setTimeout(function () { MB.post(sql) }, 1500);


	                        }
	                        bootbox.alert("Save Complete.", function () {
	                            //window.location = '/Bank-Account';
	                            if (document.getElementById('edtStat').checked) {
	                                BankAccount.bankUpdateActive($('#tmpbankid').val());
	                            } else {
	                                BankAccount.bankUpdateInActive($('#tmpbankid').val());
	                            }
	                            location.reload();
	                        });

	                       
	                    });
	                    rett.fail(function () { bootbox.alert("unknown error on saving."); }).complete(function () { });	                                                                  
                      //  }).fail(function () { bootbox.alert("unknown error on saving."); }).complete(function () { });
	                }
	            });
	            //
	        } else {
	            bootbox.alert("Unable to process request, Account number Required..");
	        }

	    } else {
	        bootbox.alert("Unable to process request, Bank Name Required");
	    }
	},

	bankUpdateActive: function (n) {
	    MB.push("UPDATE BankAccounts SET BankAcctStatus=1 WHERE BankID=" + n);
	    location.reload();
	},
	bankUpdateInActive: function (n) {
	    MB.push("UPDATE BankAccounts SET BankAcctStatus=0 WHERE BankID=" + n);
	    location.reload();
	},
	bank_display: function (id) {
	    $('#bank_details').slideToggle();
	    $('#listaccts').slideToggle();
	    //if (!$.fn.dataTable.isDataTable('#bank_tablelist')) {
	        $('#bank_tablelist').dataTable().fnDestroy();
	        //$('#bank_tablelist').dataTable().fnClearTable();
	   // }
	   

	    $('#bank_tablelist > tbody').html('');
	    var SQL = "SELECT * FROM BankAccounts WHERE BankID='" + id.trim() + "'";
	    var rets = $.post(MB.URLPoster(), { SQLStatement: SQL });
	    rets.done(function (data) {
	        //console.log(data);
	        var ss = JSON.parse(data);
	        $('#bank_details_header').html('Account Number # ' + ss[0].BankAccountNum + '   -  [ GL Account # ' + ss[0].GLACC + ' ]');
	        $('#bank_tmpid').val(ss[0].GLACC);

	        var SQL = "SELECT * FROM ( ";
	        SQL += " SELECT ";
	        SQL += "A.id,";
	        SQL += "dbo.NUM2DATE(A.v8RunDate) v8RunDate,";
	        SQL += "A.GLACC,";
	        SQL += "B.BankName,";
	        SQL += "ISNULL((SELECT Amount FROM MasterTRN WHERE DebitAcct=A.GLACC AND TrnID=A.MasterID),0) Debit,";
	        SQL += "ISNULL((SELECT Amount FROM MasterTRN WHERE CreditAcct=A.GLACC AND TrnID=A.MasterID),0) Credit,";
	        SQL += "ISNULL((SELECT Explanation FROM GLEntry WHERE ModuleID=(SELECT ModuleID FROM MasterTRN WHERE TrnID=A.MasterID)),'Balance Forward') Explanation,";
	        SQL += "A.Balance ";
	        SQL += "FROM BankAccTrn A ";
	        SQL += "LEFT JOIN BankAccounts B ON A.GLACC=B.GLACC ";
	        SQL += ") X WHERE X.GLACC='" + $('#bank_tmpid').val().trim() + "' ";
	        SQL += "ORDER BY X.GLACC,X.id ";
	       // console.log(SQL);
	        var rety = $.post(MB.URLPoster(), { SQLStatement: SQL });

	        rety.done(function (data) {
	            //console.log(data);
	            $.each(JSON.parse(data), function (id, value) {
	                var tr = "<tr>";
	                tr += "<td>" + value.v8RunDate + "</td>";
	               // tr += "<td>" + value.GLACC + "</td>";
	                tr += "<td>" + value.Explanation + "</td>";
	                tr += "<td align='right'>" + accounting.formatMoney(value.Debit) + "</td>";
	                tr += "<td align='right'>" + accounting.formatMoney(value.Credit) + "</td>";
	                tr += "<td align='right'>" + accounting.formatMoney(value.Balance) + "</td>";
	                tr += "</tr>";
	                $('#bank_tablelist  tbody:last').append(tr);

	            });
	            $('#bank_tablelist').dataTable();
	        });





	    });


	    

	},

	bankload : function() {
				 $(document).ready(function () {
				     $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
                 {
                     SQLStatement: 'SELECT '+
                                   'A.BankID,'+
                                   'A.BankName,'+
                                   'A.BankAccountNum,'+
                                   'B.accounttype AS BankAccountType,'+
                                   "IIF (A.BankAcctStatus=0,'inactive','active') status, " +
                                   "(SELECT SUM(Amount) FROM BankAccTrn WHERE GLACC=A.GLACC) CBalance,"+
                                   'Left(A.DateAdded,12) as DateAdded from '+
                                   'BankAccounts A '+
                                   'LEFT JOIN accounttype B ON A.BankAccountType = B.id ' +
                                   'WHERE 1=1'

                 }, function (data) {
                      $.each($.parseJSON(data), function (key, value) {
                     var tr = "<tr>";
                     //tr += "<td>" + value.BankID + "</td>";
                     tr += "<td><a href='#' onclick=BankAccount.bank_display('" + value.BankID + "')>" + value.BankName + "&nbsp;&nbsp;<span class='label label-warning'> Details</span></a></td>";
                     tr += "<td>" + value.BankAccountNum + "</td>";
                     tr += "<td>" + value.BankAccountType + "</td>";
                     if (value.status == "inactive") {
                         tr += "<td><span class='label label-danger'>" + value.status + "</span></td>";
                     } else {
                         tr += "<td><span class='label label-primary'>" + value.status + "</span></td>";
                     }
                   //  tr += "<td><select name='acctstat'><option value="+value.status+">"+MB.isStatus(value.status)+"</option>";
                  //   tr += "<option value=0>Closed</option><option value=1>Active</option></td>";
                     tr += "<td  align='right'>" + accounting.formatMoney(value.CBalance) + "</td>";
                     
                     tr += "<td><a href=# onclick='BankAccount.bankinfo(" + value.BankID + ")'><span class='label label-warning'>Edit</span></a></td>";

                     tr += "</tr>";
                     $('#example1 > tbody:last').append(tr);
                     });
                    // console.log(data);
                     $('#example1').dataTable(
                         {
                            // aaData: $.parseJSON(data),
                             "bScrollInfinite": true,
                             "sScrollY": "365px",
                             "bPaginate": false
                         });
					 });
				 });
				 
		    $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            {
                SQLStatement: "select glacc,expacc,title from GLAC where 1=1 AND sortcode = (SELECT mbvalue FROM appconfig WHERE mbfield1='CashInBank') AND glacc not in (select glacc from BankAccounts where BankAcctStatus=1 group by glacc)"
            }, function (data) {
                $.each($.parseJSON(data), function (key, value) {
                    $("#glac").append("<option value='" + value.glacc + "'>" + value.expacc + " - " + value.title + "</option>\n");
                   // $("#edtSelect1").append("<option value='" + value.glacc + "'>" + value.expacc + " - " + value.title + "</option>\n");
                });

            });

				 $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            {
                SQLStatement: 'select * from accounttype where tag=1'
            }, function (data) {
                $.each($.parseJSON(data), function (key, value) {
                    $("#acctselect").append("<option value='" + value.id + "'>" + value.accounttype + "</option>\n");
                    //$("#edtSelect2").append("<option value='" + value.id + "'>" + value.accounttype + "</option>\n");
                });

            });
			
	
	},
	bankinfo: function (n) {
	    $('#tmpbankid').val(n);
	    $('#listaccts').slideToggle();
	    $('#bankeditor').slideToggle();
	    var sql = "SELECT (select expacc+' - '+title from GLAC where 1=1 AND glacc = A.GLACC) gltitle," +
                                   'A.BankID,' +
                                   'A.BankName,' +
                                   'A.BankAccountNum,A.StartingBalance,' +
                                   'B.accounttype AS BankAccountType,' +
                                   "IIF (A.BankAcctStatus=0,'inactive','active') status, " +
                                   'Left(A.DateAdded,12) as DateAdded,A.Remarks,A.GLACC from ' +
                                   'BankAccounts A ' +
                                   'LEFT JOIN accounttype B ON A.BankAccountType = B.id ' +
                                   'WHERE 1=1 AND A.BankID=' + n;
           // console.log(sql);
            $.ajax({
                type: "post",
                url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
                data: { SQLStatement:sql },
                success: function (data) {
                   
                    $.each(JSON.parse(data), function (key, value) {
                        $("#edtSelect1").val(value.gltitle);
                        $('#edtBank').val(value.BankName);
                        $('#edtAcct').val(value.BankAccountNum);
                        $('#edtSelect2').val(value.BankAccountType);
                        $('#edtRemarks').val(value.Remarks);
                        $('#edtBalance3').val(value.StartingBalance);
                        document.getElementById('edtSW').innerHTML = '<input type="checkbox" id="edtStat"> Active Account';
                      //  document.getElementById('edtStat').checked = false;
                       // console.log(value.status);
                        if (value.status === 'active') {
                            //document.getElementById("edtStat").checked = true;
                          //  console.log('checked');
                           // $get('checked').checked = true;
                            // $('#edtStat').attr('checked').val('checked');
                            //$('.edtStat').prop('checked', true);
                            //$('#edtStat').val(true);
                            //$('input[name=edtStat]').attr('checked', true);
                           // $('#edtSW').append('<input type="checkbox" id="edtStat" name="edtStat"> Active Account');
                            document.getElementById('edtSW').innerHTML = '<input type="checkbox" id="edtStat" checked> Active Account';
                        }
                    });
                }
            });

            //$('#bankeditor').show();
           // $('#maintbl').hide();

	}
}
