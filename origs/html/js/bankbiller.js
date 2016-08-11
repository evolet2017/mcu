var BankBiller = {

    bankinsert: function (id) {
        //alert(id);
        $('#checkid').val(id + $('#partid').val());
        var ss = "SELECT billid,(SELECT billerdescription FROM BankBiller ";
        ss += "WHERE billerid=BankBillerTrans.billerid) as billerdesc, amount ";        
        ss += "FROM BankBillerTrans WHERE billid='" + id.trim() + "'";
        $('#clientName').val('');
        $('#checkAmount').val(0);
        $('#checkReference').val('');
        $('#checkParticular').val('');
        $('#checkDate').val('');
        $('#checkNumber').val('');
        $('#svid').val(id.trim() + $('#lbl_billid').val());
      //  console.lo
        $.ajax({
            type: "POST",
            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            data: { SQLStatement: ss },
            success: function (msg) {
                $.each(JSON.parse(msg), function (key, value) {
                    $('#clientName').val(value.billerdesc);
                    $('#checkAmount').val(value.amount);
                  
                });
            }
        });
    },

    bankbillerdisburse: function (id) {
       
        var ss =  "SELECT billid,(SELECT billerdescription FROM BankBiller ";
        ss += "WHERE billerid=BankBillerTrans.billerid) as billerdesc,GLACC, ";
        ss += "(SELECT [TITLE] FROM GLAC WHERE GLACC=BankBillerTrans.GLACC) GLACCCTITLE, Reference, amount,ISNuLL(LEFT(DueDate,12),'') DueDate, IIF (DueDate < GETDATE(), 1 , 0) isdue ";
        ss += "FROM BankBillerTrans WHERE tag=0 and billerid='" + id.trim() + "'";
        console.log(ss);
       // $('#billdisburselist > tbody').html('');
        $.ajax({
            type: "POST",
            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            data: { SQLStatement: ss },
            success: function (msg) {
                // $('#billdisburselist').dataTable().fnDestroy();
               // var ex = document.getElementById('billdisburselist');

                //if ($.fn.DataTable.fnIsDataTable('#billdisburselist')) {
                //    $('#billdisburselist').dataTable().fnClearTable();
                //    $('#billdisburselist').dataTable().fnDestroy();
                //}
                $('#billdisburselist > tbody').html('');
              //  $('#billdisburselist > tfoot').html('');
                
                var vtot = 0;
                $.each(JSON.parse(msg), function (key, value) {
                    var tr = "<tr>";
                    tr += "<td>" + value.billid + "</td>";
                    // tr += "<td>" + value.billerdesc + "</td>";
                    if (value.isdue == 1) {
                        tr += "<td>" + value.DueDate + "&nbsp;&nbsp;<span class='badge pull-center bg-red'>Past Due</span></td>";
                    } else {
                        tr += "<td>" + value.DueDate + "</td>";
                    }
                    
                    tr += "<td>" + accounting.formatMoney(value.amount) + "</td>";
                    
                    tr += "<td><input type='checkbox' name='checkbox[]' value='" + value.billid + "::" + value.amount + "::" + value.GLACC + "' onclick=bankpush(this)></td>";
                    tr += "<td>" + value.Reference + "</td>";
                    tr += "<td>" + value.GLACCCTITLE + "</td>";
                   //tr += "<td class='no-print' ><a href='#' data-toggle='modal' data-target='#swmanager' id='" + value.billid + "' onclick=BankBiller.bankinsert(this.id)><span class='badge pull-center bg-green'>Disburse</span></a>";
                   // tr += "<a href='#' id='cancelentries'><span class='badge pull-center bg-red'>Cancel</span></a></td>";
                    tr += "</tr>";
                    vtot += value.amount;
                    $('#billdisburselist tbody').append(tr);
                    $('#lbl_billdesc').val(value.billerdesc);
                    $('#lbl_billid').val(id);
                    //$('#GLACC1').val(value.GLACC1);
                    $('#partid').val(id.trim());
                });
                //$(document).ready(function () {
                $('#totals').html(accounting.formatMoney(vtot));
                $('#subtotals').html('$0.00');
                $('#billdisburselist').dataTable({
                    "pageLength": 50
                });

               // });
            }
        });
        if (!$('#billsdisburse').is('hidden')) {
            BankBiller.toggleopen(3);
        }
        
        //alert('disburse');
    },
	bankbillerbanklist: function() {

		var ss = "select A.GLACC,A.BankName,B.accounttype,A.BankAccountNum,";
			ss+= "(SELECT 'selected' from appconfig where mbfield1='Deposit' and mbvalue=a.GLACC) as vselect ";
			ss+= "from BankAccounts A LEFT JOIN accounttype B on A.BankAccountType=B.id WHERE 1=1 AND A.GLACC in (select GLACC FROM CheckBooks)";
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
			BankBiller.bankbillerinfo($('#frmShareSelect').val());

			//console.log(msg);
			//    alert(2);


		});
	},

	bankbillersave: function () {

	            if (MB.isEmpty($('#checkNumber').val())) {
                   bootbox.alert("Empty Check Number not allowed!!");
                   return
	            }

	            if (MB.isEmpty($('#checkReference').val())) {
	                bootbox.alert("Empty Reference not allowed!!");
                    return
	            }
	    /////////////////////////////////////////////////////

	            var SQL = "SELECT SUM(Amount) amount FROM BankAccTrn WHERE GLACC='" + $('#frmShareSelect').val() + "' ";
	            var retval = $.post(MB.jURLPoster(), { SQLStatement: SQL });
	

	            retval.success(function (result) {
	                var value = parseFloat(result.replace('[["', '').replace('"]]', ''));
	                var v1 = parseFloat($('#checkAmount').val());
	                //console.log('pass');
	                if (v1.toFixed(4) > value) {
	                    bootbox.alert("Not enough fund for bills payment", function () { return; });
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
	                                    

	                                    //var sv = "UpdateMaster '" + ts + "','" + $('#checkAmount').val() + "','8','" + $('#checkReference').val() + "','" + $('#checkNumber').val() + "','" + MB.getCookie('activeid') + "'";	                                
	                                    //MB.push(sv);

	                                    var sv = "Update BankChecks SET CheckDate='" + $('#checkDate').val() + "',TransDesc='Bills-Payment',Particulars='" + $('#checkParticular').val() + "',IssuedTo='" + $('#clientName').val() + "',Amount=" + accounting.unformat($('#checkAmount').val()) + ",TAG=1,v8RunDate=" + MB.getCookie('sysdate') + ",UserID='" + MB.getCookie('activeid') + "' WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmShareSelect').val() + $('#checkNumber').val() + "') ";
	                                    MB.push(sv);

	                                    //var sv = "UPDATE BankBillerTrans SET Remarks='" + $('#checkParticular').val() + "',MasterID=(SELECT MAX(TrnID) FROM MasterTRN),TAG=1 WHERE dbo.TRIM(billid)+dbo.TRIM(billerid) = '" + $('#svid').val().trim() + "'";	                                   
	                                    //MB.push(sv);

	                                    var checkboxes = document.getElementsByName('checkbox[]');
	                                    var nn = 0;
	                                    for (var i = 0, n = checkboxes.length; i < n; i++) {
	                                        if (checkboxes[i].checked) {

	                                            var vals = checkboxes[i].value;
	                                            var arr = vals.split("::");

	                                            var ts = arr[2].trim() + ':' + $('#frmShareSelect').val() + '[' + $('#checkid').val();

	                                           // var sv = "UpdateMaster '" + ts + "','" + arr[1] + "','8','" + $('#checkReference').val() + "','" + $('#checkNumber').val() + "','" + MB.getCookie('activeid') + "'";
	                                            //MB.push(sv);

	                                            var sv = "INSERT INTO MasterTRN (v8RunDate,TrnDate,DebitAcct,CreditAcct,Amount,GLTrnType,ModuleID,Reference,Remarks,Status,UserID,CheckNumber ) " +
	                                                     "SELECT (SELECT mbvalue FROM appconfig WHERE mbfield1='sysdate')," +
                                                         "GETDATE(),'" + arr[2].trim() + "'," +
                                                         "(SELECT CreditGLAcct FROM GLEntry WHERE ModuleID='BP001')," +
                                                         arr[1] +"," +
                                                         "(SELECT GLTrntype FROM GLEntry WHERE ModuleID='BP001')," +
                                                         "'BP001'," +
                                                         "'" + $('#checkReference').val() + "'," +
                                                         "'" + $('#checkParticular').val() + "'," +
                                                         "1 Status," +
                                                         "'" + MB.getCookie('activeid') + "' UserID," +
                                                         "0 CheckNumber";
	                                            MB.push(sv);
	                                            var sv = "INSERT INTO MasterTRN (v8RunDate,TrnDate,DebitAcct,CreditAcct,Amount,GLTrnType,ModuleID,Reference,Remarks,Status,UserID,CheckNumber ) " +
	                                                     "SELECT (SELECT mbvalue FROM appconfig WHERE mbfield1='sysdate')," +
                                                         "GETDATE(),(SELECT DebitGLAcct FROM GLEntry WHERE ModuleID='BP002'),'" +
                                                         $('#frmShareSelect').val()+"'," +
                                                         arr[1] + "," +
                                                         "(SELECT GLTrntype FROM GLEntry WHERE ModuleID='BP002')," +
                                                         "'BP002'," +
                                                         "'" + $('#checkReference').val() + "'," +
                                                         "'" + $('#checkParticular').val() + "'," +
                                                         "1 Status," +
                                                         "'" + MB.getCookie('activeid') + "' UserID," +
                                                         $('#checkNumber').val();
	                                            MB.push(sv);	                                            
                                                // reyjie
	                                            var svid = arr[0].trim() + $('#lbl_billid').val().trim();
	                                            var sv = "UPDATE BankBillerTrans SET CheckNo='" + $('#checkNumber').val() + "',Remarks='" + $('#checkParticular').val() + "',MasterID=(SELECT MAX(TrnID) FROM MasterTRN),TAG=1 WHERE dbo.TRIM(billid)+dbo.TRIM(billerid) = '" + svid + "'";
	                                            MB.push(sv);	                                            
	                                            //  ArrRemove.push(xx);
	                                        }
	                                    }

	                                    document.getElementById('discard').click();
	                                //    BankBiller.bankbillerdisburse($('#lbl_billid').val());

	                                    //var retv = $.post(MB.URLPoster(), {SQLStatement : SQL }); //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
	                                    //retv.success(function(result) {
	                                    bootbox.alert("Entry Saved..", function () {
	                                       // location.reload();
	                                        $('#billdisburselist').dataTable().fnClearTable();
	                                        $('#billdisburselist').dataTable().fnDestroy();
	                                        //BankBiller.bankbillerdisburse($('#checkid').val());
	                                        BankBiller.bankbillerdisburse($('#lbl_billid').val());

	                                    });
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


       	
	},

	bankbilleropen: function (id) {
	    //alert('open111');

	    $("#tblbillerlist > tbody").html("");
	  
	    //alert(id);
	    //alert(xxx);

	    var sql = "select billid,billerid,amount,CONVERT(VARCHAR,duedate) duedate,(SELECT billerdescription FROM BankBiller WHERE BankBiller.billerid=BankBillerTrans.billerid) billdesc ";
	        sql += "FROM BankBillerTrans WHERE billerid='" + id.trim() + "' AND TAG=0";
	    //console.log(sql);
		$.ajax({
			type: "POST",
			url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
			data : { SQLStatement: sql}
		}).done(function(msg) {
			$.each(JSON.parse(msg), function (id, value) {
					//$('#frmShareSelect').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.BankName + "</option>");
				var tr = "<tr>";
				//	tr += "<td></td>";
					tr += "<td>"+value.billid+"</td>";
					tr += "<td>" + accounting.formatMoney(value.amount) + "</td>";
					tr += "<td>" + value.duedate + "</tr>";
					tr += "</tr>";
					$('#tblbillerlist tbody').append(tr);
					//$('#bill_desc1').val(value.billdesc);
					
			});
			$(document).ready(function () {
			  //  $("#tblbillerlist").dataTable().fnClearTable();
			  //  $("#tblbillerlist").dataTable().fnDestroy();
			    $('#tblbillerlist').dataTable();
			});
		});
	    //$('#bill_desc1').val(xxx);
		var rr = $.post(MB.URLPoster(), { SQLStatement: "SELECT billerid,billerdescription,billercontact,billservice FROM BankBiller WHERE billerid='" + id + "'" });
		rr.done(function (data) {
		    $('#bill_desc1').val(JSON.parse(data)[0].billerdescription);
		    $('#bill_id2').val(JSON.parse(data)[0].billerid);
		    $('#bill_contact2').val(JSON.parse(data)[0].billercontact);
		    $('#bill_service2').val(JSON.parse(data)[0].billservice);
		});
		$('#iddd').val(id);
		if (!$('#billspay').is('hidden')) {
		    BankBiller.toggleopen(2);
		}
		
		
	},

	bankbillertrnsave : function(id) {
		if (MB.isEmpty($('#bill_amt').val())) {
			bootbox.alert("Empty Biller Amount not allowed!!");
			return
		}

		if (MB.isEmpty($('#bill_id1').val())) {
		    bootbox.alert("Empty Billing Reference not allowed!!");
		    return
		}

		bootbox.confirm("Save Entry?", function (result) {
		    if (result = true) {
		        //alert("true");
		        var sv  = "INSERT INTO BankBillerTrans (billid,billerid,amount,v8RunDate,tag,DueDate,InvoiceDate,Reference,GLACC) VALUES ";
		        sv += "('" + $('#bill_id1').val() + "','";
		        sv += $('#iddd').val() + "','";
		        sv += $('#bill_amt').val() + "',";
		        sv += MB.getCookie('sysdate') + ",0,'";
		        sv += $('#bill_due').val() + "','";
		        sv += $('#bill_invdate').val() + "','";
		        sv += $('#bill_reference').val() + "','";
		        sv += $('#bill_link').val() + "')";

		        //console.log(sv);
		        $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
                {
                    SQLStatement: sv
                }).done(function () {
                    bootbox.alert("Entry Saved..", function () {
                       // MB.push("UPDATE BankAsset SET Status=1 WHERE id=" + $('#checkid').val());

                        //location.reload();
                     //   $('#bill_desc1').val('');
                        $('#bill_id1').val('');
                        $('#bill_amt').val('');
                        $('#bill_invdate').val('');
                        $('#bill_due').val('');
                        $('#bill_reference').val('');
                        $("#tblbillerlist").dataTable().fnClearTable();
                        $("#tblbillerlist").dataTable().fnDestroy();
                        BankBiller.bankbilleropen($('#iddd').val(), $('#bill_desc1').val());
                    });
                });
		    }
		});

		
		
	
	},
	bankbillerinfosave : function() {	
	//bootbox.alert("banksharesave");	

	        if (MB.isEmpty($('#bill_id').val())) {
                   bootbox.alert("Empty Biller ID not allowed!!");
                   return
                }
                if (MB.isEmpty($('#bill_desc').val())) {
                   bootbox.alert("Empty Biller Description not allowed!!");
                   return
                }

                if (MB.isEmpty($('#bill_contact').val())) {
                    bootbox.alert("Empty Biller Contact not allowed!! <br /> (NA for not available)..");
                    return
                }
               


                bootbox.confirm("Save Entry?", function (result) {
                    if (result) {

                       if ($('#billtitle').html() == 'Add Biller') {
                           var sv = "INSERT INTO BankBiller (billerid,billerdescription,billercontact,GLACC,billservice,userid) VALUES (";
                           sv += "'" + $('#bill_id').val() + "','" + $('#bill_desc').val() + "',";
                           sv += "'" + $('#bill_contact').val() + "','',";
                           sv += "'" + $('#bill_service').val() + "','" + MB.getCookie('activeid') + "')";
                       } else {
                           var sv = "UPDATE BankBiller SET billerdescription='" + $('#bill_desc').val() + "',billercontact='" + $('#bill_contact').val() + "'," +
                                    "billservice='" + $('#bill_service').val() + "' WHERE billerid='" + $('#bill_id').val().trim() + "'";
                       }
			
                      
							MB.push(sv);
							bootbox.alert("Entry Saved..", function () {
							    location.reload();
							});


                    }
				});               
			
	},

	bankbilleredit: function (id) {
	    $('#billtitle').html('Edit Biller');
	    $('#addbilltable').fadeToggle();
	    $('#addbillerscr').fadeToggle();
	    BankBiller.resetValue();
	    $('#bill_id').attr('disabled', 'disabled');
	    $('#bill_id').val(id);
	    $('#biller_reset').hide();

	    //alert($('#billtitle').html());
	    var SQL = "SELECT * FROM BankBiller WHERE billerid='" + id + "'";
	    var rets = $.post(MB.URLPoster(), { SQLStatement: SQL });
	    rets.done(function (data) {
	        var ss = JSON.parse(data);
	        $('#bill_desc').val(ss[0].billerdescription);
	        $('#bill_contact').val(ss[0].billercontact);
	        $('#bill_service').val(ss[0].billservice);
	   

	    });

	},
	
	bankbillerload: function () {

	    var ss = "select GLACC,TITLE,'' vselect FROM GLAC WHERE LEFT(sortcode,3) =501";

	    //SELECT * FROM GLAC WHERE LEFT(sortcode,3) =501
			
		$.ajax({
			type: "POST",
			url: MB.URLPoster(),  // "http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
			data: { SQLStatement: ss }
		}).done(function (msg) {
			//var x = '';
			$.each(JSON.parse(msg), function (id, value) {
			    //$('#billerGL').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.TITLE + "</option>");
			    $('#bill_link').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.TITLE + "</option>");
			});
			//$('#bill_link').append($('#billerGL').html());;

			//console.log(msg);
			//    alert(2);


		});
		
		var sql =  "SELECT A.billerid,A.billerdescription,A.GLACC,A.tag,";
		sql += "(SELECT ISNULL(SUM(B.Amount),0) FROM BankBillerTrans B WHERE B.billerid=A.billerid and B.tag=0) AMT ";
		sql += "FROM BankBiller A ";
		//sql += "FROM BankBiller A WHERE A.tag=1";

		$.ajax({
			type : "POST",
			url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
			data : { SQLStatement: sql }
		}).done(function (msg) {
		   // console.log(msg);
				$.each(JSON.parse(msg), function(key,value) {
				//console.log(msg);
					var tr = "<tr>";
					
					tr += "<td>" + value.billerid + "</td>";
					tr += "<td>" + value.billerdescription + "</td>";
					//tr += "<td>" + value.Address + "</td>";
					//tr += "<td>" + value.PhoneNumber + "</td>";
				    //tr += "<td>" + value.Email + "</td>";
					if (value.tag ==  0) {
					    tr += "<td width=20px><span class='label label-danger'>Enroll Payment</span></a></td>";
					} else {
					    tr += "<td width=20px><a href='#' id='" + value.billerid + "' onclick=BankBiller.bankbilleropen(this.id)><span class='label label-success'>Enroll Payment</span></a></td>";
					}
					if ((value.AMT > 0) && (value.tag > 0)) {
					    tr += "<td td width=30px><a href='#' id='" + value.billerid + "' onclick=BankBiller.bankbillerdisburse(this.id)><span class='label label-success'>Disburse Payment</span></a></td>";
					} else {
					    tr += "<td td width=30px><span class='label label-danger'>Disburse Payment</span></td>";
					}
				    //tr += "<td><a href='#'><span class='label label-success'>Disburse Payment</span></a></td>";
					if (value.tag == 0) {
					    tr += "<td width=20px><span class='label label-danger'>Edit Biller</span><br />";
					    tr += "<a href='#' id='" + value.billerid + "' onclick=BankBiller.banktag(this.id,1)><span class='label label-danger'>Inactive</span></a></td>";
					} else {
					    tr += "<td width=20px>" +
                                   "<a href='#' id='" + value.billerid + "' onclick=BankBiller.bankbilleredit(this.id)><span class='label label-success'>Edit Biller</span></a>" +
                              "<br />";
					    tr += "<a href='#' id='" + value.billerid + "' onclick=BankBiller.banktag(this.id,0)><span class='label label-success'>Active</span></a></td>";
					}
					
					tr += "<td align='right'>"+accounting.formatMoney(value.AMT)+"</td>";
					tr += "</tr>";
					$('#tblpayment tbody').append(tr);
				});
				//$("#tblVendor").dataTable();
				//$(function () {
				//	  $('#tblVendor').dataTable();
				//  });
				$(document).ready(function () {
					$('#tblpayment').dataTable().fnDraw();;
				});

				 
			});
		  
	
	},

	banktag: function (id, tag) {
	   // console.log("UPDATE Bankbiller SET tag=" + tag + " WHERE billerid='" + id.trim() + "'");
	    MB.push("UPDATE Bankbiller SET tag=" + tag + " WHERE billerid='" + id.trim() + "'");
	    //window.location = "/Bills-payment";
	    //location.reload();
	    $('#tblpayment').dataTable().fnClearTable();
	    $('#tblpayment').dataTable().fnDestroy();
	    $('#tblpayment > tbody').html('');

	    BankBiller.bankbillerload();

	},
	
	resetValue: function() {
		$('#bill_id').val("");
		$('#bill_desc').val("");
		$('#bill_contact').val("");
		$('#bill_service').val("");
		$('#bill_amt').val("");
		
	},

	initValue: function (Id) {
	    //alert(Id);
	    $('#checkid').val(Id);
		
	    $.ajax({
	        type: "POST",
	        url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
	        data: { SQLStatement: "SELECT pur_desc, pur_cost FROM BankAsset WHERE id="+Id },
	        success: function (data) {
	            //console.log(data);
	            $.each(JSON.parse(data), function (id, value) {
	                $('#clientName').val(value.pur_desc);
	                $('#checkAmount').val(value.pur_cost);
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

	bankbillerinfo: function(glcode) {
	    var s='';
	    if (MB.isEmpty(glcode))
	    {
	        BankBiller.getDefBank();
	        glcode = MB.getCookie('defbank');
	    }
	    
        
	    //var sv = "SELECT A.BankName,A.BankAccountNum,B.accounttype,C.EXPACC,C.TITLE FROM BankAccounts A left join accounttype b on a.BankAccountType=B.id left join GLAC C ON A.GLACC=C.GLACC WHERE A.GLACC='"+glcode+"'";
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
		
	},
	toggleopen: function(n) {
        if (n == 1) {
            $('#addbillerscr').show();
            $('#billtitle').html('Add Biller');
        }

        if (n == 2) {
            $('#billspay').show();
        }

        if (n == 3) {
            $('#billsdisburse').show();
        }
        $('#addbilltable').hide();

        BankBiller.resetValue();
    },

    toggleclose: function(n) {
        if (n == 1) {          
            $('#addbillerscr').hide();
        }

        if (n == 2) {
            $('#billspay').hide();
        }

        if (n == 3) { 
            $('#billsdisburse').hide();
        }
        $('#addbilltable').show();
        BankBiller.resetValue();
        location.reload();

    }

}
