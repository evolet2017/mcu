var BankOperations = {
    // cash advance --
    cacashsave: function () {
       // if (MB.isEmpty($('#CAremarks').val())) {
       //     bootbox.alert('Must provide remarks..');
       //     return
       // }
        if (MB.isEmpty($('#CAreference').val())) {
            bootbox.alert('Must provide reference..');
            return
        }
        if (MB.isEmpty($('#CAcheckno').val())) {
            bootbox.alert('Must provide check number for disbursement..');
            return
        }

        var SQL = "SELECT SUM(Amount) amount FROM BankAccTrn WHERE GLACC='" + $('#frmSelect001').val() + "' ";

        $.ajax({
            type: 'POST',
            url: MB.URLPoster(),
            data: { SQLStatement: SQL },
            beforeSend: function() {
                bootbox.dialog({
                        closeButton: false,
                        message: "Loading Data!",
                        title: "Please wait!"
                    });
            },
            success: function(result) {
                //

                var value = parseFloat(result.replace('[["', '').replace('"]]', ''));

                console.log(value);
                var v1 = parseFloat($('#checkAmount').val());
                //console.log('pass');
                if (v1.toFixed(4) > value) {
                    bootbox.hideAll();
                    bootbox.alert("Not enough fund for bills payment", function () { return; });
                } else {

                    // Check Validation           
                    var SQL = "SELECT TAG FROM BankChecks WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmSelect001').val() + $('#CAcheckno').val() + "') ";
                    console.log(SQL);

                    $.ajax({
                        type: 'post',
                        url: MB.URLPoster(),
                        data: { SQLStatement: SQL },
                        beforeSend: function () {
                                bootbox.dialog({
                                closeButton: false,
                                message: "Loading Data!",
                                title: "Please wait!"
                            });
                        },
                        success: function(result) {

                            //var value = result.replace('[["', '').replace('"]]', '');
                            var value = result.replace('[{"TAG":', '').replace('}]', '');
                            console.log(value);
                            if (value == 0) {
                                bootbox.hideAll();
                                bootbox.confirm("Save Entry?", function (result) {
                                    // console.log(result);
                                    if (result) {


                                        var sv = "Update BankChecks SET CheckDate='" + $('#CAcheckDate').val() + "',TransDesc='Cash-Advance',Particulars='" + $('#CAremarks').val() + "',IssuedTo=(SELECT cashto FROM BankCashAdvance WHERE id=" + $('#CAptr').val() + "),Amount=(SELECT Amount FROM BankCashAdvance WHERE id=" + $('#CAptr').val() + "),TAG=1,v8RunDate=" + MB.getCookie('sysdate') + ",UserID='" + MB.getCookie('activeid') + "' WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmSelect001').val() + $('#CAcheckno').val() + "') ";
                                        MB.push(sv);

                                        var ss = "UpdateMaster '" + $('#CAptr').val() + ':' + $('#frmSelect001').val() + "[1'," + parseInt($('#CAcheckno').val()) + ",11,'" + $('#CAreference').val() + "','" + $('#CAremarks').val() + "','" + MB.getCookie('activeid') + "'";
                                        $.ajax({
                                            type: "post",
                                            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
                                            data: { SQLStatement: ss },
                                            beforeSend: function() {
                                                    bootbox.dialog({
                                                    closeButton: false,
                                                    message: "Loading Data!",
                                                    title: "Please wait!"
                                                });
                                            },
                                            success: function (data) {
                                                bootbox.hideAll();
                                                bootbox.alert("Entry Saved..", function (result) {
                                                    //BankOperations.bankempldisburse();
                                                    $('#CAremarks').val('');
                                                    $('#CAreference').val('');
                                                    $('#CAcheckno').val('');
                                                    document.getElementById('cancelit').click();
                                                    window.location = '/Cash-Advance';
                                                    //window.location = '/Transaction';
                                                    //bootbox.alert("Entry Saved..", function () { location.reload(); });
                                                });
                                            }
                                        });
                                    }
                                });

                            } else {
                                //console.log(value);
                                if (value == 1) {
                                    bootbox.hideAll();
                                    bootbox.alert("Check Number is already in used..");
                                } else {
                                    bootbox.hideAll();
                                    bootbox.alert("Check Number does not exists..");
                                }
                            }
                        },
                    });
                    //var retval = $.post(MB.jURLPoster(), { SQLStatement: SQL });
                    //retval.success(function (result) {
                        
                    //});
                }
            },
        });


        // var retval = $.post(MB.jURLPoster(), { SQLStatement: SQL });
        // retval.success(function (result) {
        //     var value = parseFloat(result.replace('[["', '').replace('"]]', ''));
        //     var v1 = parseFloat($('#checkAmount').val());
        //     //console.log('pass');
        //     if (v1.toFixed(4) > value) {
        //         bootbox.alert("Not enough fund for bills payment", function () { return; });
        //     } else {

        //         // Check Validation	          
        //         var SQL = "SELECT TAG FROM BankChecks WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmSelect001').val() + $('#CAcheckno').val() + "') ";
        //         console.log(SQL);
        //         var retval = $.post(MB.jURLPoster(), { SQLStatement: SQL });
        //         retval.success(function (result) {
        //             var value = result.replace('[["', '').replace('"]]', '');
        //             //console.log(value);
        //             if (value == 0) {

        //                 bootbox.confirm("Save Entry?", function (result) {
        //                     // console.log(result);
        //                     if (result) {


        //                         var sv = "Update BankChecks SET CheckDate='" + $('#CAcheckDate').val() + "',TransDesc='Cash-Advance',Particulars='" + $('#CAremarks').val() + "',IssuedTo=(SELECT cashto FROM BankCashAdvance WHERE id=" + $('#CAptr').val() + "),Amount=(SELECT Amount FROM BankCashAdvance WHERE id=" + $('#CAptr').val() + "),TAG=1,v8RunDate=" + MB.getCookie('sysdate') + ",UserID='" + MB.getCookie('activeid') + "' WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmSelect001').val() + $('#CAcheckno').val() + "') ";
        //                         MB.push(sv);

        //                         var ss = "UpdateMaster '" + $('#CAptr').val() + ':' + $('#frmSelect001').val() + "[1'," + parseInt($('#CAcheckno').val()) + ",11,'" + $('#CAreference').val() + "','" + $('#CAremarks').val() + "','" + MB.getCookie('activeid') + "'";
        //                         $.ajax({
        //                             type: "post",
        //                             url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
        //                             data: { SQLStatement: ss },
        //                             success: function (data) {
        //                                 bootbox.alert("Entry Saved..", function (result) {
        //                                     //BankOperations.bankempldisburse();
        //                                     $('#CAremarks').val('');
        //                                     $('#CAreference').val('');
        //                                     $('#CAcheckno').val('');
        //                                     document.getElementById('cancelit').click();
        //                                     window.location = '/Cash-Advance';

        //                                 });
        //                             }
        //                         });
        //                     }
        //                 });

        //             } else {
        //                 //console.log(value);
        //                 if (value == 1) {
        //                     bootbox.alert("Check Number is already in used..");
        //                 } else {
        //                     bootbox.alert("Check Number does not exists..");
        //                 }
        //             }
        //         });
        //     }
        // });
    },
    cashadvancepost: function () {
        if (MB.isEmpty($('#ca_name').val())) {
            bootbox.alert('Must provide cash to value..');
            return
        }
        if (MB.isEmpty($('#ca_amt').val())) {
            bootbox.alert('Must provide amount for cash advance..');
            return
        }
        if (MB.isEmpty($('#ca_vouch').val())) {
            bootbox.alert('Must provide voucher reference for cash advance..');
            return
        }

        var sql = "INSERT INTO BankCashAdvance (cashto,amount,v8RunDate,voucher,transdate,tag) VALUES ";
        sql += "('" + $('#ca_name').val() + "'," + parseFloat($('#ca_amt').val()) + ",(SELECT mbvalue from appconfig where mbfield1='sysdate'),'" + $('#ca_vouch').val() + "',GETDATE(),0)";
        console.log(sql);
        $.ajax({
            type: "post",
            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            data: { SQLStatement: sql },
            success: function (data) {
                bootbox.alert("Entry Saved..", function (result) {
                    //BankOperations.bankempldisburse();
                    $('#ca_name').val('');
                    $('#ca_amt').val('');
                    $('#ca_vouch').val('');
                    //document.getElementById('discard').click();
                    BankOperations.cashadvancelist();
                    window.location = "/Cash-Advance";
                });
            }

        });

    },
    cashcancel: function (n) {
        MB.push("UPDATE BankCashAdvance SET TAG=99 WHERE id=" + n);
        location.reload();
    },
    cashassign: function (n,amt) {
        $('#CAptr').val(n);
        $('#checkAmount').val(amt);

    },
    cashadvancelist: function () {
        var sql = "SELECT ";
        sql += "dbo.BankCashAdvance.id,";
        sql += "dbo.BankCashAdvance.voucher,";
        sql += "dbo.BankCashAdvance.cashto,";
        sql += "dbo.BankCashAdvance.amount,";
        sql += "dbo.BankCashAdvance.tag ";

        sql += "FROM ";
        sql += "dbo.BankCashAdvance  ";

        sql += "WHERE ";
        sql += "dbo.BankCashAdvance.tag=0 ";

        $.ajax({
            type: "post",
            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            data: { SQLStatement: sql },
            success: function (data) {
                $('#cashadvlist > tbody').html('');
               // console.log(data);
                $.each(JSON.parse(data), function (key, value) {
                    var tr = "<tr>";
                    tr += "<td>" + value.voucher + "</td>";
                    tr += "<td>" + value.cashto + "</td>";
                    tr += "<td>" + accounting.formatMoney(value.amount) + "</td>";
                    tr += "<td id='" + value.id + "'><button type='button' data-toggle='modal' data-target='#cash_advance' class='btn btn-success btn-xs' onclick='BankOperations.cashassign(" + value.id + "," + value.amount + ")'>Disburse</button>&nbsp;&nbsp;<button type='button' class='btn btn-warning btn-xs' onclick='BankOperations.cashcancel(" + value.id + ")'>Cancel</button></td>";
                    tr += "</tr>";
                    $('#cashadvlist').append(tr);
                });
                $('#cashadvlist').dataTable({
							"sScrollY": "400px",
							"scrollCollapse": true,
							"bPaginate": false
							
							});
            }
        });

    },
    // payroll --
    payrollcashinfo: function (glcode) {
        var s = '';
        if (MB.isEmpty(glcode)) {
            BankOperations.getDefBank();
            glcode = MB.getCookie('defbank');
        }


        var sv = "SELECT A.BankName,A.BankAccountNum,B.accounttype,C.EXPACC,C.TITLE FROM BankAccounts A left join accounttype b on a.BankAccountType=B.id left join GLAC C ON A.GLACC=C.GLACC WHERE A.GLACC='" + glcode + "'";
       // console.log(sv);
        $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
		{
		    SQLStatement: sv
		}, function (data) {
		    //console.log(data);
		    $.each($.parseJSON(data), function (id, value) {
		        document.getElementById('accttype2').innerHTML = value.accounttype;
		        document.getElementById('acctnum2').innerHTML = value.BankAccountNum;
		        document.getElementById('glcode2').innerHTML = value.EXPACC + ' (' + value.TITLE + ') ';
		        //$('#accttype').innerHTML = value.BankAccountType;
		        //console.log(value.accounttype);
		    });
		});

    },
    payrollcashbanklist: function () {

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
                $('#frmShareSelect2').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.BankName + "</option>");
            });

            //console.log(msg);
            //    alert(2);


        });
    },
    payrollassign: function (id) {
        $('#idptr').val(id);
       // alert($('#frmShareSelect1').html() );
       // $('#frmShareSelect2') = $('#frmShareSelect1');
    },
    bankempldisbursemaster: function () {
        if (MB.isEmpty($('#payrollremarks').val())) {
            bootbox.alert('Must provide remarks..');
            return
        }
        if (MB.isEmpty($('#payrollreference').val())) {
            bootbox.alert('Must provide reference..');
            return
        }
        if (MB.isEmpty($('#payrollcheck').val())) {
            bootbox.alert('Must provide check number for disbursement..');
            return
        }

        var ss = "UpdateMaster '" + $('#idptr').val() + ':' + $('#frmShareSelect2').val() + "[1'," + parseInt($('#payrollcheck').val()) + ",10,'" + $('#payrollreference').val() + "','" + $('#payrollremarks').val() + "','" + MB.getCookie('activeid') + "'";
        $.ajax({
            type: "post",
            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            data: { SQLStatement: ss },
            success: function (data) {
                bootbox.alert("Entry Saved..", function (result) {                    
                    BankOperations.bankempldisburse();
                    $('#payrollremarks').val('');
                    $('#payrollreference').val('');
                    $('#payrollcheck').val('');
                    document.getElementById('discard').click();
                });
            }
        });

    },
    bankempldisburse: function () {
        var sql = "SELECT A.id,";
            sql += "A.EmployeeID, B.firstname+' '+B.lastname Fullname, A.Amount,A.tag FROM BankOpTrans A ";
            sql += "LEFT JOIN usertable B ON A.EmployeeID=B.username ";
            sql += "WHERE A.tag=0";
        $.ajax({
            type : "post",
            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            data : { SQLStatement : sql },
            success: function (data) {
                $('#tblpayment > tbody').html('');
                $.each(JSON.parse(data), function (key,value) {
                    var tr =  "<tr>";
                    tr += "<td>" + value.EmployeeID + "</td>";
                    tr += "<td>" + value.Fullname + "</td>";
                    tr += "<td>" + accounting.formatMoney(value.Amount) + "</td>";
                    tr += "<td id='" + value.id + "'><button type='button' data-toggle='modal' data-target='#payrolldisburse' class='btn btn-success btn-xs' onclick='BankOperations.payrollassign(" + value.id + ")'>Disburse</button>&nbsp;&nbsp;<button type='button' data-toggle='modal' data-target='#payrolldisburse' class='btn btn-warning btn-xs' onclick='BankOperations.bankpaycancel(" + value.id + ")'>Cancel</button></td>";
                    tr += "</tr>";
                    $('#tblpayment').append(tr);
                });
                $('#tblpayment').dataTable({
							"sScrollY": "400px",
							"scrollCollapse": true,
							"bPaginate": false
							
							});
            }
        });

    },
    bankpaycancel: function (n) {
        MB.push("UPDATE BankOpTrans SET TAG=99 WHERE id="+n);
        location.reload();
    },
    bankempl: function () {
        $.ajax({
            type : "post",
            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            data : { SQLStatement : "SELECT A.username,(A.firstname+' '+A.lastname) fullname,A.taxpercent,A.basicsalary FROM usertable A WHERE tag=1" },
            success : function(data) {
                $('#emptable > tbody').html('');
                $.each(JSON.parse(data), function(key,value) {
                    var tr = "<tr id='"+value.username+"' onclick=BankOperations.getval(this);>";
                    tr += "<td>"+value.username+"</td>";
                    tr += "<td>"+value.fullname+"</td>";
                    tr += "<td>"+value.taxpercent+"</td>";
                    tr += "<td>"+accounting.formatMoney(value.basicsalary)+"</td>";
                    tr += "</tr>";
                    $('#emptable tbody').append(tr);
                });
                $('#emptable').dataTable({
                   // "bPaginate": true,
                  ///  "bLengthChange": false,
                   // "bFilter": true,
                  //  "bSort": true,
                //    "bInfo": true,
                 //   "bAutoWidth": false
			//	 {
							"sScrollY": "400px",
							"scrollCollapse": true,
							"bPaginate": false
							
				//			}
                });
            }
        });
    },
    getval: function (T) {
        $('#hiddenid').val(T);
        //	alert(T.innerHTML);

        var S = T.innerHTML.replace(/<(?:.|\n)*?>/gm, ',').replace(/,,/g,':').replace(/,/g,'');
        var ar = S.split(':');
        //for (var i = 0; i < ar.length; i++) {
        //    alert(ar[i]);
        //    	}
        //alert(ar);
	
        //alert( JSON.stringify(array));
        //T.innerHTML = "<td>test</td><td>1</td><td>2</td><td>3</td>";

        //[array.map( function(item) { alert(item); });
	
        $('#emp_id').val(ar[0]);
        $('#emp_name').val(ar[1]);
        $('#emp_tax').val(ar[2]);
        $('#emp_basic').val(ar[3]);

	
	
    },
    bankemplinfosave: function () {
        if (MB.isEmpty($('#emp_tax').val())) {
            bootbox.alert("Empty Tax Rate not allowed!!");
            return
        }
        bootbox.confirm("Save Entry?", function (result) {
            if (result = true) {
                var sv = "UPDATE usertable set basicsalary=" + accounting.unformat($('#emp_basic').val()) + ",taxpercent=" + $('#emp_tax').val() + " WHERE username='" + $('#emp_id').val() + "'";
                $.ajax({
                    type: "POST",
                    url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
                    data: { SQLStatement: sv }
                }).done(function () {
                    bootbox.alert("Entry Saved..", function () {
                        BankOperations.bankempl();
                        $('#emp_id').val("");
                        $('#emp_name').val("");
                        $('#emp_tax').val("");
                        $('#emp_basic').val("");
                    });
                });


            }
        });

    },
    bankemplpaylist: function () {
        //var sql = "select A.username,c.net_pay, B.description FROM usertable A left join userlevel B on A.userlevel=b.level where a.tag=1";
        var sql = "select A.username,";
        sql += "ISNULL((SELECT AMOUNT FROM BankOpTrans WHERE TAG=0 AND EmployeeID=A.username),0) as net_pay, B.description, ";
        sql += "ISNULL((SELECT id FROM BankOpTrans WHERE TAG=0 AND EmployeeID=A.username),0) as id ";
        sql += "FROM usertable A ";
        sql += "left join userlevel B on A.userlevel=b.level ";
        sql += "where  A.tag=1";
        console.log(sql);
        $.ajax({
            type: "post",
            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            data: { SQLStatement: sql },
            success: function (data) {
                $('#paylist > tbody').html('');
                console.log(data);
                $.each(JSON.parse(data), function (key, value) {
                    var tr = "<tr onclick=BankOperations.getthat(this);>";
                    tr += "<td style='display:none'>"+value.id+"</td>";
                    tr += "<td>"+value.username+"</td>";
                    tr += "<td>"+accounting.formatMoney(value.net_pay)+"</td>";
                    tr += "<td style='display:none'>"+value.description+"</td>";
                    tr += "</tr>";
                    $('#paylist tbody').append(tr);
                });
            }
        });
    },
    getthat: function (T) {

        var S = T.innerHTML.replace(/<(?:.|\n)*?>/gm, ',').replace(/,,/g, ':').replace(/,/g, '');
        //    alert(S);
        var ar = S.split(':');
        $('#isEdit').val('');
        $('#emp_designation').val(ar[3]);
        $('#emp_pay').val(ar[2]);
        $('#hidden_id').val(ar[1]);
        if ($('#emp_pay').val() > 0) {
            $('#isEdit').val(ar[0]);
        }

    },

    bankemplpay: function () {
        if (MB.isEmpty($('#emp_pay').val())) {
            bootbox.alert("Empty Pay  not allowed!!");
            return
        }
        bootbox.confirm("Save Entry?", function (result) {
            if (result = true) {
                var sv = "update BankOpTrans Set Amount=" + $('#emp_pay').val() + " WHERE id=" + $('#isEdit').val();
                if (MB.isEmpty($('#isEdit').val())) {
                    sv = "Insert Into BankOpTrans (TrnID,Amount,tag,EmployeeID,v8RunDate) values (1," + $('#emp_pay').val() + ",0," + $('#hidden_id').val() + "," + MB.getCookie('sysdate') + ")";
                    //sv = "update BankOpTrans Set Amount=" + $('#emp_pay').val() + " WHERE id=" + $('#isEdit').val();
                } 
                console.log(sv);
                $.ajax({
                    type: "POST",
                    url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
                    data: { SQLStatement: sv }
                }).done(function () {
                    bootbox.alert("Entry Saved..", function () {
                        //BankOperations.bankempl();
                        $('#emp_designation').val("");
                        $('#emp_pay').val("");
                        $('#isEdit').val("");
                        // $('#emp_basic').val("");
                        MB.push("delete from BankOpTrans Where Amount=0");
                        BankOperations.bankemplpaylist();
                    });
                });


            }
        });

    },
    // -- Petty Cash
    pettyassign: function (id,amt) {
        $('#pettyptr').val(id);
        $('#checkAmount').val(amt);
    },
    pettycancel: function (n) {
        MB.push("UPDATE BankPettyCash SET TAG=99 WHERE id="+n);
        location.reload();
    },
    pettycashlist: function () {
        var sv = "select particulars,amount,remarks,tag,id from BankPettyCash where tag=0";
        $.ajax({
            type: "post",
            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            data: { SQLStatement: sv },
            success: function (data) {
                $('#pettytbl > tbody').html('');
                $.each(JSON.parse(data), function (key, value) {
                    var tr = "<tr>";
                    tr += "<td>" + value.particulars + "</td>";
                    tr += "<td>" + value.remarks + "</td>";
                    tr += "<td>" + accounting.formatMoney(value.amount) + "</td>";
                  //  if (value.tag == 0) {
                    tr += "<td><button type='button' data-toggle='modal' data-target='#pettydisburse' class='btn btn-success btn-xs' onclick='BankOperations.pettyassign(" + value.id + "," + value.amount + ")'>Disburse</button>&nbsp;&nbsp;<button type='button' class='btn btn-warning btn-xs' onclick='BankOperations.pettycancel(" + value.id + ")'>Cancel</button></td>";
                   // } else {
                    //    tr += "<td><button type='button' class='btn btn-warning btn-xs' disable=true>Served.</button></td>"
                   // }
                    //tr += "<td>" + value.tag + "</td>";
                    tr += "</tr>";
                    $('#pettytbl tbody').append(tr);

                });
            
            }

        });
    },
    postpettycash: function () {
        if (MB.isEmpty($('#pettyamt').val())) {
            bootbox.alert('Zero Amount not allowed..');
            return
        }
        if (MB.isEmpty($('#pettyref').val())) {
            bootbox.alert('Reference Required..');
            return
        }
        if (MB.isEmpty($('#pettypart').val())) {
            bootbox.alert('Remarks/Particular Required..');
            return
        }
        bootbox.confirm("Save Entry?", function (result) {
            if (result = true) {
                var sv = "insert into BankPettyCash (particulars,amount,tag,remarks,v8RunDate) values ";
                sv += "('" + $('#pettypart').val() + "',";
                sv += $('#pettyamt').val() + ",";
                sv += "0,'";
                sv += $('#pettyref').val() + "',";
                sv += MB.getCookie('sysdate') + ")";
                $.ajax({
                    type: "post",
                    url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
                    data: { SQLStatement: sv },
                    success: function (data) {
                            bootbox.alert("Entry Saved..", function () {
                                BankOperations.pettycashlist();
                                $('#pettyref').val('');
                                $('#pettypart').val('');
                                $('#pettyamt').val('');
                                window.location = "/Petty-Cash";
                            });
                    }
                });
            }
        });
    },
    pettycashsave: function () {
        if (MB.isEmpty($('#pettyparticular').val())) {
            bootbox.alert('Must provide remarks..');
            return
        }
        if (MB.isEmpty($('#pettyference').val())) {
            bootbox.alert('Must provide reference..');
            return
        }
        if (MB.isEmpty($('#pettychecks').val())) {
            bootbox.alert('Must provide check number for disbursement..');
            return
        }

        var SQL = "SELECT SUM(Amount) amount FROM BankAccTrn WHERE GLACC='" + $('#frmShareSelect1').val() + "' ";

        $.ajax({
            type: 'POST',
            url: MB.URLPoster(),
            data: { SQLStatement: SQL },
            success: function(result) {
                //bootbox.HideAll();
                
                console.log(result);
                var value = parseFloat(result.replace('[["', '').replace('"]]', ''));
                var v1 = parseFloat($('#checkAmount').val());
                //console.log('pass');
                if (v1.toFixed(4) > value) {
                    //bootbox.hideAll();
                    bootbox.alert("Not enough fund for petty cash", function () { return; });
                } else {

                    // Check Validation           
                    var SQL2 = "SELECT TAG FROM BankChecks WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmShareSelect1').val() + $('#pettychecks').val() + "') ";
                    //console.log(SQL);
                    $.ajax({
                        type: 'POST',
                        url: MB.URLPoster(),
                        data: { SQLStatement: SQL2 },
                        success: function(result) {
                            console.log(SQL2);
                            console.log(result);
                            //var value = result.replace('[["', '').replace('"]]', '');
                            //console.log(value);
                            var value = result.replace('[{"TAG":', '').replace('}]', '');
                            console.log(value);
                            if (value == 0) {
                                //bootbox.HideAll();
                                bootbox.confirm("Save Entry?", function (result) {

                                    // console.log(result);
                                    if (result) {

                                        var sv = "Update BankChecks SET CheckDate='" + $('#checkDate').val() + "',TransDesc='Petty-Cash',Particulars='" + $('#pettyparticular').val() + "',IssuedTo='Petty-Cash',Amount=(SELECT Amount FROM BankPettyCash WHERE id=" + $('#pettyptr').val() + "),TAG=1,v8RunDate=" + MB.getCookie('sysdate') + ",UserID='" + MB.getCookie('activeid') + "' WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmShareSelect1').val() + $('#pettychecks').val() + "') ";
                                        MB.push(sv);

                                        var ss = "UpdateMaster '" + $('#pettyptr').val() + ':' + $('#frmShareSelect1').val() + "[1'," + parseInt($('#pettychecks').val()) + ",9,'" + $('#pettyference').val() + "','" + $('#pettyparticular').val() + "','" + MB.getCookie('activeid') + "'";
                                        $.ajax({
                                            type: "post",
                                            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
                                            data: { SQLStatement: ss },
                                            beforeSend: function() {
                                                bootbox.dialog({
                                                                closeButton: false,
                                                                message: "Loading Data!",
                                                                title: "Please wait!"
                                                            });
                                            },
                                            success: function (data) {
                                                bootbox.hideAll;
                                                bootbox.alert("Entry Saved..", function (result) {
                                                    document.getElementById('discard1').click();
                                                    window.location = '/Petty-Cash';
                                                    //window.location = '/Transaction';

                                                });
                                            }
                                        });
                                    }
                                });
                            } else {
                                //console.log(value);
                                if (value == 1) {
                                    //bootbox.HideAll();
                                    bootbox.alert("Check Number is already in used..");
                                } else {
                                    //bootbox.HideAll();
                                    bootbox.alert("Check Number does not exists..");
                                }
                            }
                        },

                    });


                }
            },
        });


        // var retval = $.post(MB.jURLPoster(), { SQLStatement: SQL });
	

        // retval.success(function (result) {
        //     var value = parseFloat(result.replace('[["', '').replace('"]]', ''));
        //     var v1 = parseFloat($('#checkAmount').val());
        //     //console.log('pass');
        //     if (v1.toFixed(4) > value) {
        //         bootbox.alert("Not enough fund for petty cash", function () { return; });
        //     } else {

        //         // Check Validation	          
        //         var SQL = "SELECT TAG FROM BankChecks WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmShareSelect1').val() + $('#pettychecks').val() + "') ";
        //         console.log(SQL);
        //         var retval = $.post(MB.jURLPoster(), { SQLStatement: SQL });
        //         retval.success(function (result) {
        //             console.log(result);
        //             var value = result.replace('[["', '').replace('"]]', '');
        //             console.log(value);
        //             if (value == "0") {

        //                 bootbox.confirm("Save Entry?", function (result) {
        //                     // console.log(result);
        //                     if (result) {


        
        //                         var sv = "Update BankChecks SET CheckDate='" + $('#checkDate').val() + "',TransDesc='Petty-Cash',Particulars='" + $('#pettyparticular').val() + "',IssuedTo='Petty-Cash',Amount=(SELECT Amount FROM BankPettyCash WHERE id=" + $('#pettyptr').val() + "),TAG=1,v8RunDate=" + MB.getCookie('sysdate') + ",UserID='" + MB.getCookie('activeid') + "' WHERE GLACC+CONVERT(VARCHAR,CHECKID)=dbo.TRIM('" + $('#frmShareSelect1').val() + $('#pettychecks').val() + "') ";
        //                         MB.push(sv);

        //                         var ss = "UpdateMaster '" + $('#pettyptr').val() + ':' + $('#frmShareSelect1').val() + "[1'," + parseInt($('#pettychecks').val()) + ",9,'" + $('#pettyference').val() + "','" + $('#pettyparticular').val() + "','" + MB.getCookie('activeid') + "'";
        //                         $.ajax({
        //                             type: "post",
        //                             url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
        //                             data: { SQLStatement: ss },
        //                             success: function (data) {
        //                                 bootbox.alert("Entry Saved..", function (result) {
        //                                     document.getElementById('discard1').click();
        //                                     window.location = '/Petty-Cash';

        //                                 });
        //                             }
        //                         });
        //                     }
        //                 });
        //             } else {
        //                 //console.log(value);
        //                 if (value == 1) {
        //                     bootbox.alert("Check Number is already in used..");
        //                 } else {
        //                     bootbox.alert("Check Number does not exists..");
        //                 }
        //             }
        //         });



        //     }
        // });
        
    },
        bankinsert: function (id) {
        //alert(id);
        $('#checkid').val(id + $('#partid').val());
        var ss = "SELECT billid,(SELECT billerdescription FROM BankBiller ";
        ss += "WHERE billerid=BankBillerTrans.billerid) as billerdesc, amount ";
        
        ss += "FROM BankBillerTrans WHERE billid='" + id.trim() + "'";
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
        ss += "WHERE billerid=BankBillerTrans.billerid) as billerdesc, ";
        ss += "(SELECT GLACC FROM BankBiller WHERE billerid=BankBillerTrans.billerid) as GLACC1, amount ";
        ss += "FROM BankBillerTrans WHERE tag=0 and billerid='" + id.trim() + "'";
        console.log(ss);
        $.ajax({
            type: "POST",
            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            data: { SQLStatement: ss },
            success: function (msg) {
                $('#billdisburselist > tbody').html('');
                $.each(JSON.parse(msg), function (key, value) {
                    var tr = "<tr>";
                    tr += "<td>" + value.billid + "</td>";
                   // tr += "<td>" + value.billerdesc + "</td>";
                    tr += "<td>" + accounting.formatMoney(value.amount) + "</td>";
                    tr += "<td id='" + value.billid + "' onclick=BankBiller.bankinsert(this.id)><a href='#' data-toggle='modal' data-target='#swmanager'><span class='badge pull-center bg-green'>Disburse</span></a></td>"
                    tr += "</tr>";
                    $('#billdisburselist tbody').append(tr);
                    $('#lbl_billdesc').val(value.billerdesc);
                    $('#lbl_billid').val(id);
                    $('#GLACC1').val(value.GLACC1);
                    $('#partid').val(id.trim());
                });
                //$(document).ready(function () {
                $('#billdisburselist').dataTable({
							"sScrollY": "400px",
							"scrollCollapse": true,
							"bPaginate": false
							
							});
               // });
            }
        });
        BankOperations.toggleopen(3);
        //alert('disburse');
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

               bootbox.confirm("Save Entry?", function (result) {
                   if (result = true) {
                       var ts = $('#GLACC1').val() + ':' + $('#frmShareSelect').val() + '[' + $('#checkid').val();
                       var sv = "UpdateMaster '" + ts + "','" + $('#checkAmount').val() + "','8','" + $('#checkReference').val() + "','" + $('#checkNumber').val() + "','" + MB.getCookie('activeid') + "'";
			    	   //console.log(sv);
                       $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
		               {
			            SQLStatement: sv
		               }).done(function () {
		                   bootbox.alert("Entry Saved..", function () {
		                       document.getElementById('discard').click();
		                       MB.push("UPDATE BankBillerTrans SET MasterID=(SELECT MAX(TrnID) FROM MasterTRN),TAG=1 WHERE dbo.TRIM(billid)+dbo.TRIM(billerid) = '" + ts.trim() + "'");
		                       BankOperations.bankbillerdisburse($('#lbl_billid').val());

		                       //location.reload();
		                   });
		               });
                    }
               });	
	},

	bankbilleropen: function (id,xxx) {
	    //alert('open111');

	    $("#tblbillerlist > tbody").html("");
	    //alert(id);
	    //alert(xxx);

	    var sql = "select billid,billerid,amount,(SELECT billerdescription FROM BankBiller WHERE BankBiller.billerid=BankBillerTrans.billerid) billdesc ";
	        sql += "FROM BankBillerTrans WHERE billerid='" + id.trim() + "'";
	   // console.log(sql);
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
					tr += "<td>"+accounting.formatMoney(value.amount)+"</td>";
					tr += "</tr>";
					$('#tblbillerlist tbody').append(tr);
					
			});
			$(document).ready(function () {
			    $('#tblbillerlist').dataTable({
							"sScrollY": "400px",
							"scrollCollapse": true,
							"bPaginate": false
							
							});
			});
		});
		$('#bill_desc1').val(xxx);
		$('#iddd').val(id);
		BankOperations.toggleopen(2);
		
		
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
		        var sv  = "INSERT INTO BankBillerTrans (billid,billerid,amount,v8RunDate,tag) VALUES ";
		        sv += "('" + $('#bill_id1').val() + "','";
		        sv += $('#iddd').val() + "','";
		        sv += $('#bill_amt').val() + "',";
                sv += MB.getCookie('sysdate')+",0)";
		        //console.log(sv);
		        $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
                {
                    SQLStatement: sv
                }).done(function () {
                    bootbox.alert("Entry Saved..", function () {
                       // MB.push("UPDATE BankAsset SET Status=1 WHERE id=" + $('#checkid').val());

                       // location.reload();
                    });
                });
		    }
		});

		
		
	
	},
	
	
	bankbillerload: function () {

	    var ss = "select GLACC,TITLE,'' vselect FROM GLAC";
			
		$.ajax({
			type: "POST",
			url: "http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
			data: { SQLStatement: ss }
		}).done(function (msg) {
			//var x = '';
			$.each(JSON.parse(msg), function (id, value) {
				$('#billerGL').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.TITLE + "</option>");
			});

			//console.log(msg);
			//    alert(2);


		});
		
		var sql =  "SELECT A.billerid,A.billerdescription,A.GLACC,";
		sql += "(SELECT ISNULL(SUM(B.Amount),0) FROM BankBillerTrans B WHERE B.billerid=A.billerid and B.tag=0) AMT ";
		sql += "FROM BankBiller A WHERE A.tag=1";

		$.ajax({
			type : "POST",
			url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
			data : { SQLStatement: sql }
		}).done(function (msg) {
		   // console.log(msg);
				$.each(JSON.parse(msg), function(key,value) {
				//console.log(msg);
					var tr = "<tr>";
					tr += "<td></td>";
					tr += "<td>" + value.billerid + "</td>";
					tr += "<td>" + value.billerdescription + "</td>";
					//tr += "<td>" + value.Address + "</td>";
					//tr += "<td>" + value.PhoneNumber + "</td>";
					//tr += "<td>" + value.Email + "</td>";
					tr += "<td><a href='#' id='" + value.billerid + "' onclick=BankBiller.bankbilleropen(this.id,'"+value.billerdescription+"')><span class='label label-success'>Enroll Payment</span></a></td>";
					if (value.AMT > 0) {
					    tr += "<td><a href='#' id='" + value.billerid + "' onclick=BankBiller.bankbillerdisburse(this.id)><span class='label label-success'>Disburse Payment</span></a></td>";
					} else {
					    tr += "<td><span class='label label-danger'>Disburse Payment</span></td>";
					}
					//tr += "<td><a href='#'><span class='label label-success'>Disburse Payment</span></a></td>";
					tr += "</tr>";
					$('#tblpayment tbody').append(tr);
				});
				//$("#tblVendor").dataTable();
				//$(function () {
				//	  $('#tblVendor').dataTable();
				//  });
				$(document).ready(function () {
					$('#tblpayment').dataTable({
							"sScrollY": "400px",
							"scrollCollapse": true,
							"bPaginate": false
							
							}).fnDraw();;
				});

				 
			});
		  
	
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
	            console.log(data);
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

	pettycashinfo: function(glcode) {
	    var s='';
	    if (MB.isEmpty(glcode))
	    {
	        BankOperations.getDefBank();
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
				document.getElementById('paccttype').innerHTML = value.accounttype;
				document.getElementById('pacctnum').innerHTML = value.BankAccountNum;
				document.getElementById('pglcode').innerHTML = value.EXPACC + ' (' + value.TITLE + ') ';
				document.getElementById('pglBalance').innerHTML = accounting.formatMoney(value.glbalance);
				//$('#accttype').innerHTML = value.BankAccountType;
				//console.log(value.accounttype);
			});
		});
		
	},
	pettycashbanklist: function () {

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
	            $('#frmShareSelect1').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.BankName + "</option>");
	        });

	        //console.log(msg);
	        //    alert(2);


	    });
	},
	cabanklist: function () {

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
	            $('#frmSelect001').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.BankName + "</option>");
	        });

	        //console.log(msg);
	        //    alert(2);


	    });
	},
	cacashinfo: function (glcode) {
	    var s = '';
	    if (MB.isEmpty(glcode)) {
	        BankOperations.getDefBank();
	        glcode = MB.getCookie('defbank');
	    }


	    //var sv = "SELECT A.BankName,A.BankAccountNum,B.accounttype,C.EXPACC,C.TITLE FROM BankAccounts A left join accounttype b on a.BankAccountType=B.id left join GLAC C ON A.GLACC=C.GLACC WHERE A.GLACC='" + glcode + "'";
	    //console.log(sv);
	    var sv = "SELECT A.BankName,A.BankAccountNum,B.accounttype,C.EXPACC,C.TITLE,(SELECT SUM(amount) FROM BankAccTrn WHERE GLACC='" + glcode + "') glbalance ";
	    sv += "FROM BankAccounts A left join accounttype b on a.BankAccountType=B.id left join GLAC C ON A.GLACC=C.GLACC WHERE A.GLACC='" + glcode + "'";
	    $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
		{
		    SQLStatement: sv
		}, function (data) {
		    //console.log(data);
		    $.each($.parseJSON(data), function (id, value) {
		        document.getElementById('pt1').innerHTML = value.accounttype;
		        document.getElementById('pt2').innerHTML = value.BankAccountNum;
		        document.getElementById('pt3').innerHTML = value.EXPACC + ' (' + value.TITLE + ') ';
		        document.getElementById('pt4').innerHTML = accounting.formatMoney(value.glbalance);
		        //$('#accttype').innerHTML = value.BankAccountType;
		        //console.log(value.accounttype);
		    });
		});

	},

	cashadvopen: function (n) {
	    if (n == 1) {
	        $('#cashadv2').show();
	    }
	    $('#cashadv1').hide();
	},
	cashadvclose: function (n) {
	    if (n == 1) {
	        $('#cashadv2').hide();
	    }
	    $('#cashadv1').show();
	},
	pettycashopen: function (n) {
	    if (n == 1) {
	        $('#petty2').show();
	    }
	    $('#petty1').hide();
	},
	pettycashclose: function (n) {
	    if (n == 1) {
	        $('#petty2').hide();
	    }
	    
	    $('#petty1').show();
	},
	toggleopen: function(n) {
        if (n == 1) {
            $('#payscr2').show();
        }

        if (n == 2) {
            $('#payscr3').show();
        }

        $('#payscr1').hide();

        //BankOperations.resetValue();
    },

    toggleclose: function(n) {
        if (n == 1) {          
            $('#payscr2').hide();
        }

        if (n == 2) {
            $('#payscr3').hide();
        }

        $('#payscr1').show();
        //BankOperations.resetValue();
        //location.reload();

    }

}
