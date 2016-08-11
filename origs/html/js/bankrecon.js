function ListGLSOA() {
    // items --------------------------

    var b = reservation.value;
    var arr = b.split("-", 2);
    var GLCODE = document.getElementById('frmReconSelect').value;

    var sv = "SELECT * FROM ( ";
    sv += "SELECT X.TrnID,dbo.NUM2DATE(X.v8RunDate) TransDate,X.ModuleID,";
    sv += "(SELECT Description FROM Modules WHERE ModuleID= X.ModuleID) TransType,";
    sv += "X.CheckNumber,X.Amount,X.Amount Debit,0 Credit,";
    sv += "(SELECT COALESCE(Balance,0) FROM BankAccTrn WHERE MasterID=X.TrnID AND GLACC='" + GLCODE + "') Balance, Status ";
    sv += "FROM MasterTRN X ";
    sv += "WHERE X.DebitAcct='" + GLCODE + "' ";
    sv += "UNION ";
    sv += "SELECT A.TrnID,dbo.NUM2DATE(A.v8RunDate) TransDate,A.ModuleID,";
    sv += "(SELECT Description FROM Modules WHERE ModuleID= A.ModuleID) TransType,";
    sv += "A.CheckNumber,A.Amount,0 Debit,A.Amount Credit,";
    sv += "(SELECT COALESCE(Balance,0) FROM BankAccTrn WHERE MasterID=A.TrnID AND GLACC='" + GLCODE + "') Balance, Status ";
    sv += "FROM MasterTRN A ";
    sv += "WHERE A.CreditAcct='" + GLCODE + "' ) C ";
    sv += "Where LEFT(C.ModuleID,2) <> 'BR' AND C.[Status]=2 AND C.transdate between cast('" + arr[0] + "' as date) and cast('" + arr[1] + "' as date)";

    //var sv = "Select * from (SELECT a.TrnID, " +
    //    "dbo.NUM2DATE(a.v8RunDate) TransDate," +
    //    "(SELECT Description FROM Modules WHERE ModuleID= a.ModuleID) TransType," +
    //    "a.CheckNumber," +
    //    "case When c.Amount > 0 then a.Amount else 0 end as Debit," +
    //    "case When c.Amount < 0 then a.Amount else 0 end as Credit,  coalesce(c.balance, 0) as Balance, " +
    //    " a.Amount" +
    //    " FROM MasterTRN a left join glentry b on b.ModuleID = a.ModuleID inner join BankAccTrn c on c.MasterId = a.Trnid" +
    //    " WHERE a.[status] = 2 and LEFT(a.ModuleID,2) <> 'BR' and c.Glacc = '" + GLCODE + "') a " +
    //    " Where a.transdate between cast('" + arr[0] + "' as date) and cast('" + arr[1] + "' as date)";

   // var sv = "SELECT * FROM (SELECT A.TrnID,dbo.NUM2DATE(A.v8RunDate) TransDate,(SELECT Description FROM Modules WHERE ModuleID= A.ModuleID) TransType,";
    //sv += "A.CheckNumber,";
    //sv += "IIF ( A.DebitAcct='" + GLCODE + "', A.Amount, 0) Debit,";
    //sv += "IIF ( A.CreditAcct='" + GLCODE + "', A.Amount, 0) Credit,";
    //sv += "coalesce(B.balance, 0) as Balance, A.Amount ";
    //sv += "FROM MasterTRN A ";
    //sv += "LEFT JOIN BankAccTrn B ON A.Trnid = B.MasterID ";
    //sv += "WHERE A.DebitAcct='" + GLCODE + "' ";
    //sv += "union ";
    //sv += "SELECT A.TrnID,dbo.NUM2DATE(A.v8RunDate) TransDate,(SELECT Description FROM Modules WHERE ModuleID= A.ModuleID) TransType,";
    //sv += "A.CheckNumber,";
    //sv += "IIF ( A.DebitAcct='" + GLCODE + "', A.Amount, 0) Debit,";
    //sv += "IIF ( A.CreditAcct='" + GLCODE + "', A.Amount, 0) Credit,";
    //sv += "coalesce(B.balance, 0) as Balance, A.Amount,A.ModuleID ";
    //sv += "FROM MasterTRN A ";
    //sv += "LEFT JOIN BankAccTrn B ON A.Trnid = B.MasterID ";
    //sv += "WHERE A.CreditAcct='" + GLCODE + "' AND A.Status=1 ) A ";
    //sv += " WHERE LEFT(ModuleID,2) <> 'BR' AND  Transdate between cast('" + arr[0] + "' as date) and cast('" + arr[1] + "' as date)";


    console.log('ListGLSOA : ' + sv);
    var rets = $.post(MB.URLPoster(), { SQLStatement: sv });
    rets.success(function (msg) {
        $('#Table0 > tbody').html('');
        $.each($.parseJSON(msg), function (id, value) {

            var tr = "<tr>";
            tr += "<td>" + value.TransDate + "</td>";
            tr += "<td>" + value.TransType + "</td>";
            tr += "<td>" + value.CheckNumber + " </td>";
            tr += "<td>" + accounting.formatMoney(value.Debit) + "</td>";
            tr += "<td>" + accounting.formatMoney(value.Credit) + "</td>";
            //    tr += "<td>" + accounting.formatMoney(value.Balance) + "</td>";
            tr += "</tr>";
            $('#Table0 tbody').append(tr);

        });

    });



    // summary ------------------------
    var sqlstmt = "SELECT * FROM SOAReconTrans WHERE ";
    sqlstmt += "tag=2 AND ";
    sqlstmt += "GLACC='" + document.getElementById('frmReconSelect').value.trim() + "' AND ";
    sqlstmt += "v8RunDate=(SELECT v8RunDate FROM BankRecon WHERE ";
    sqlstmt += "DateRange+GLACC='" + $('#reservation').val().trim() + document.getElementById('frmReconSelect').value.trim() + "') ";
    sqlstmt += "ORDER BY GLAction";
    // console.log(sqlstmt);
    var rets = $.post(MB.URLPoster(), { SQLStatement: sqlstmt });
    rets.success(function (data) {
        $('#Table2 > tbody').html('');
        $.each(JSON.parse(data), function (id, value) {
            var tr = "<tr>";
            tr += "<td>" + value.GLAction + "</td>";
            tr += "<td>" + accounting.formatMoney(value.Amount) + "</td>";
            tr += "<td>" + value.Remarks + "</td>";
            tr += "</tr>";
            $('#Table2 tbody').append(tr);

        });
    });

    var sqlstmt = "SELECT * FROM SOAReconTrans WHERE ";
    sqlstmt += "tag=1 AND ";
    sqlstmt += "GLACC='" + document.getElementById('frmReconSelect').value.trim() + "' AND ";
    sqlstmt += "v8RunDate=(SELECT v8RunDate FROM BankRecon WHERE ";
    sqlstmt += "DateRange+GLACC='" + $('#reservation').val().trim() + document.getElementById('frmReconSelect').value.trim() + "') ";
    sqlstmt += "ORDER BY GLAction";
    // console.log(sqlstmt);
    var rets = $.post(MB.URLPoster(), { SQLStatement: sqlstmt });
    rets.success(function (data) {
        $('#Table3 > tbody').html('');
        $.each(JSON.parse(data), function (id, value) {
            var tr = "<tr>";
            tr += "<td>" + value.GLAction + "</td>";
            tr += "<td>" + accounting.formatMoney(value.Amount) + "</td>";
            tr += "<td>" + value.Check + "</td>";
            tr += "<td>" + value.Remarks + "</td>";
            tr += "</tr>";
            $('#Table3 tbody').append(tr);
        });
    });


    //var sqlstmt = "SELECT SUM(Amount) Amount,GLAction FROM SOAReconTrans WHERE ";
    //sqlstmt += "GLACC='" + document.getElementById('frmReconSelect').value.trim() + "' AND ";
    //sqlstmt += "v8RunDate=(SELECT v8RunDate FROM BankRecon WHERE ";
    //sqlstmt += "DateRange+GLACC='" + $('#reservation').val().trim() + document.getElementById('frmReconSelect').value.trim() + "') ";
    //sqlstmt += "GROUP BY GLAction ";
    //sqlstmt += "ORDER BY GLAction ";

    var sqlstmt = "SELECT v8RunDate FROM BankRecon WHERE ";
    sqlstmt += "DateRange+GLACC='" + $('#reservation').val().trim() + document.getElementById('frmReconSelect').value.trim() + "' ";
    var rets = $.post(MB.URLPoster(), { SQLStatement: sqlstmt });
    //var sss;
    rets.success(function (data) {
        var s = JSON.parse(data);
        //  console.log(s[0].v8RunDate);
        var sss = s[0].v8RunDate;
        var sqlstmt = "SELECT ";
        sqlstmt += "(SELECT ISNULL(SUM(Amount),0) FROM SOAReconTrans WHERE v8RunDate=" + sss + " AND GLACC='" + document.getElementById('frmReconSelect').value.trim() + "' AND GLAction LIKE '%deposit%') GLDT,";
        sqlstmt += "(SELECT ISNULL(SUM(Amount),0) FROM SOAReconTrans WHERE v8RunDate=" + sss + " AND GLACC='" + document.getElementById('frmReconSelect').value.trim() + "' AND GLAction LIKE '%outstanding%') GLOC,";
        sqlstmt += "(SELECT ISNULL(SUM(Amount),0) FROM SOAReconTrans WHERE v8RunDate=" + sss + " AND GLACC='" + document.getElementById('frmReconSelect').value.trim() + "' AND GLAction LIKE '%deduct%') GLCH,";
        sqlstmt += "(SELECT ISNULL(SUM(Amount),0) FROM SOAReconTrans WHERE v8RunDate=" + sss + " AND GLACC='" + document.getElementById('frmReconSelect').value.trim() + "' AND GLAction LIKE '%add%') GLIN,";
        sqlstmt += "(SELECT SOABalance FROM BankRecon WHERE v8RunDate=" + sss + " AND GLACC='" + document.getElementById('frmReconSelect').value.trim() + "') SOA,";
        sqlstmt += "(SELECT GLBalance FROM BankRecon WHERE v8RunDate=" + sss + " AND GLACC='" + document.getElementById('frmReconSelect').value.trim() + "') GL,";
        sqlstmt += "(SELECT EndSOA FROM BankRecon WHERE v8RunDate=" + sss + " AND GLACC='" + document.getElementById('frmReconSelect').value.trim() + "') ESOA,";
        sqlstmt += "(SELECT EndGL FROM BankRecon WHERE v8RunDate=" + sss + " AND GLACC='" + document.getElementById('frmReconSelect').value.trim() + "') EGL";

     //  console.log(sqlstmt);

        var ret = $.post(MB.URLPoster(), { SQLStatement: sqlstmt });
        ret.success(function (data) {
            var s = JSON.parse(data);
            //$('#gldt').innerHTML = s[0].GLDT;
            document.getElementById('gldt').innerText = accounting.formatMoney(s[0].GLDT);
            document.getElementById('gloc').innerHTML = "(" + accounting.formatMoney(s[0].GLOC) + ")";
            document.getElementById('glcg').innerText = "(" + accounting.formatMoney(s[0].GLCH) + ")";
            document.getElementById('glin').innerHTML = accounting.formatMoney(s[0].GLIN);
            var tfin = s[0].GLDT - s[0].GLOC;
            if (tfin < 0) {
                document.getElementById('totsoa').innerHTML = "(" + accounting.formatMoney(Math.abs(tfin)) + ")";
            } else {
                document.getElementById('totsoa').innerHTML = accounting.formatMoney(tfin);
            }
            var tfin = s[0].GLIN - s[0].GLCH;
            if (tfin < 0) {
                document.getElementById('totgl').innerHTML = "(" + accounting.formatMoney(Math.abs(tfin)) + ")";
            } else {
                document.getElementById('totgl').innerHTML = accounting.formatMoney(tfin);
            }
            var tfin = s[0].SOA;
            if (tfin < 0) {
                document.getElementById('soa_initial').innerHTML = "(" + accounting.formatMoney(Math.abs(tfin)) + ")";
            } else {
                document.getElementById('soa_initial').innerHTML = accounting.formatMoney(tfin);
            }
            var tfin = s[0].GL;
            if (tfin < 0) {
                document.getElementById('gl_initial').innerHTML = "(" + accounting.formatMoney(Math.abs(tfin)) + ")";
            } else {
                document.getElementById('gl_initial').innerHTML = accounting.formatMoney(tfin);
            }
            var tfin = s[0].ESOA;
            if (tfin < 0) {
                document.getElementById('soa_ending').innerHTML = "(" + accounting.formatMoney(Math.abs(tfin)) + ")";
            } else {
                document.getElementById('soa_ending').innerHTML = accounting.formatMoney(tfin);
            }
            var tfin = s[0].EGL;
            if (tfin < 0) {
                document.getElementById('gl_ending').innerHTML = "(" + accounting.formatMoney(Math.abs(tfin)) + ")";
            } else {
                document.getElementById('gl_ending').innerHTML = accounting.formatMoney(tfin);
            }
            var tfin = s[0].EGL;
            if (tfin < 0) {
                document.getElementById('gl_ending').innerHTML = "(" + accounting.formatMoney(Math.abs(tfin)) + ")";
            } else {
                document.getElementById('gl_ending').innerHTML = accounting.formatMoney(tfin);
            }
            var tfin = s[0].SOA - s[0].GL;
            if (tfin < 0) {
                document.getElementById('gl_difference').innerHTML = "(" + accounting.formatMoney(Math.abs(tfin)) + ")";
            } else {
                document.getElementById('gl_difference').innerHTML = accounting.formatMoney(tfin);
            }
        });
    });

    //console.log(sss);


}


var BankRecon = {


    BAIL: function () {
        window.location = "/Main";
    },
    bankinfo: function (glcode) {
        //var sv = "SELECT A.BankName,A.BankAccountNum,B.accounttype,C.EXPACC,C.TITLE FROM BankAccounts A left join accounttype b on a.BankAccountType=B.id left join GLAC C ON A.GLACC=C.GLACC WHERE A.GLACC='"+glcode+"'";
        //console.log(sv);
        var sv = "SELECT A.BankName,A.BankAccountNum,B.accounttype,C.EXPACC,C.TITLE,(SELECT SUM(amount) FROM BankAccTrn WHERE GLACC='" + glcode + "') glbalance ";
        sv += "FROM BankAccounts A left join accounttype B on A.BankAccountType=B.id left join GLAC C ON A.GLACC=C.GLACC WHERE A.GLACC='" + glcode + "'";
        var rets = $.post(MB.URLPoster(), { SQLStatement: sv });
        rets.success(function (data) {
            var value = JSON.parse(data);
            //console.log(value)
            document.getElementById('accttype').innerHTML = value[0].accounttype;
            document.getElementById('acctnum').innerHTML = value[0].BankAccountNum;
            document.getElementById('glcode').innerHTML = value[0].EXPACC + ' (' + value[0].TITLE + ') ';
            document.getElementById('glbalance').innerHTML = accounting.formatMoney(value[0].glbalance);


        });

        if (!$('#transmatching').is(':hidden')) {
            $('#blance').hide();
            $('#transmatching').hide();
            $('#marktrans').hide();
        }

       

    },
    bankreconInfo: function (ModuleId) {
        var sv = "exec sp_bankrecon '','','" + ModuleId + "',0,'','',1";
        //console.log(sv);
        $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
		{
		    SQLStatement: sv
		}, function (data) {
		    //console.log(data);
		    $.each($.parseJSON(data), function (id, value) {
		        document.getElementById('chkgl').innerHTML = value.expacc + ' (' + value.title + ') ';
		    });
		});
    },
    bankreconpost: function (n) {

        var _fChkTitLe = document.getElementById('HiddenKo').value;
        var _fReference = document.getElementById('chkref').value;
        var _fAMount = document.getElementById('chkamt').value;
        var _ftrn = document.getElementById('HiddenTRNNo').value;
        var _username = MB.getCookie("activeid");
        var _fBankGlacc = document.getElementById('frmReconSelect').value;
        //var sv;
        //alert(_fChkTitLe);
        //var sv = "exec sp_bankrecon '','" + _fBankGlacc + "','" + _fModuleID + "'," + _fAMount + ",'" + _fReference + "', '" + _username + "',3";

        if (_fReference > '') {

        } else {
            //  bootbox.alert("Remarks Field is Empty.");
            //  return;
        }
        //console.log(document.getElementById('chkamt').value);

        _fAMount = accounting.unformat(_fAMount);

        _fAMount = (document.getElementById('soa_select').value == 1) ? _fAMount * 1 : _fAMount * -1;

        if (_fChkTitLe == '1') {
            var sv = "exec sp_bankrecon '" + _ftrn + "','',''," + _fAMount + ",'" + _fReference + "','',2";
        } else {
            var sv = "exec sp_bankrecon '" + _ftrn + "','" + _fBankGlacc + "',''," + _fAMount + ",'" + _fReference + "', '" + _username + "',4";
        }
        //console.log(sv);

        //document.getElementById('sqlstmt_' + $('#soaidd').val()).innerText = sv;
        //$('#sqlstmt_' + $('#soaidd').val()).val(sv);

        $('#sqlstmt_' + $('#soaidd').val()).append(sv.trim());
        //alert(sv);
        //alert($('#idptr').val());

        $('#addsoa' + $('#idptr').val().trim()).fadeToggle();
        var n = parseInt($('#idptr').val()) + 1;
        //console.log(n);
        var gcx = document.getElementById('example2');
        //console.log(gcx);
        var chkno = gcx.rows[n].cells[3].innerHTML;

        //console.log(gcx.rows.length);

        //console.log(chkno);
        //console.log(gcx);
        //console.log(gcx.rows[n].cells[11].innerHTML);


        //console.log(gcx.rows[$('#idptr').val()].cells[3].innerHTML);

        var soa_ptr = 'addsoa' + $('#idptr').val();
        var sql_ptr = 'sqlstmt_' + $('#soaidd').val();

        //var sv = "exec sp_bankrecon '','" + _fBankGlacc + "','" + _fModuleID + "'," + _fAMount + ",'" + _fReference + "', '" + _username + "',3";
        var tr = "<tr id='soacancel_" + soa_ptr + "'>";
        tr += "<td style='display:none'>" + soa_ptr + "</td>";
        tr += "<td style='display:none'>" + sql_ptr + "</td>";
        tr += "<td>" + chkno + "</td><td>" + accounting.formatMoney(_fAMount) + "</td><td>" + $('#soa_select option:selected').html() + "</td><td>" + _fReference + "</td>";
        tr += "<td><a class='label label-warning' onclick=soa_cancel('" + soa_ptr + "','" + sql_ptr + "'," + _fAMount + ");>Cancel</a></td></tr>";

        var sql123 = "INSERT INTO SOAReconTrans (v8RunDate,GLACC,Amount,Remarks,tag,[Check],GLAction,MasterID) ";
        sql123 += " SELECT " + MB.getCookie('sysdate') + ",'" + _fBankGlacc + "'," + parseFloat(_fAMount) + ",'" + _fReference + "',1," + parseInt(chkno.trim()) + ",'" + $('#soa_select option:selected').html() + "'," + parseInt($('#soaidd').val().trim());

        //$('#add_gl_sql tbody').append("<tr><td>"+sv+"</td></tr>");
        //console.log(sql123);
        gcx.rows[n].cells[11].innerHTML = sql123;
        $('#add_soa_sql tbody').append(tr);



        //console.log(sv);
        //$.post(MB.URLPoster(),  
        //{
        //  SQLStatement: sv
        //}, function (data) {
        //	$.each($.parseJSON(data),function(id,value) {

        //	});
        //});
        //console.log(gcx.rows[n].cells[11].innerHTML);

        //bootbox.alert("Post Successful.");
        document.getElementById('discard').click()

        //if (sysbalance2.value > '') {
        //    sysbalance2.value = accounting.formatMoney(parseFloat(accounting.unformat(sysbalance2.value)) + parseFloat(_fAMount));
        //} else {
        //    sysbalance2.value = accounting.formatMoney(parseFloat(_fAMount));
        //}
        var soa0 = accounting.unformat(document.getElementById('soa_0').innerHTML);
        document.getElementById('soa_0').innerHTML = accounting.formatMoney(parseFloat(soa0) + parseFloat(_fAMount));
        var soa0 = accounting.unformat(document.getElementById('soa_0').innerHTML);
        var soa1 = accounting.unformat(document.getElementById('soa_1').innerHTML);
        document.getElementById('soa_2').innerHTML = accounting.formatMoney(parseFloat(soa0) - parseFloat(soa1));


        //sysbalance.value = accounting.formatMoney(parseFloat(accounting.unformat(sysbalance.value)) - parseFloat(_fAMount));


        //BankRecon.PostConfirm(_ftrn);
        //var xx = "#" + _ftrn;
        //$(xx).remove();

    },
    bankreconpostGL: function () {


        var _fReference = document.getElementById('GLRemarks').value;
        var _fAMount = document.getElementById('frmGLAmt').value;
        var _fModuleID = document.getElementById('Select1').value;
        var _fBankGlacc = document.getElementById('frmReconSelect').value;
        var _username = MB.getCookie("activeid");

        //console.log($('#Select1 option:selected').html());
        //alert(document.getElementById('Select1').value);





        if (_fReference > '') {
            //bootbox.alert("Post Successful.");


        } else {
            bootbox.alert("Remarks Field is Empty.");
            return;
        }

        bootbox.confirm("Add entry to GL Addition?", function (result) {
            if (result) {

                var nnn = document.getElementById('add_gl_sql').rows.length;

                _fAMount = accounting.unformat(_fAMount);
                _fAMount = (document.getElementById('Select1').value == 'BR001') ? _fAMount * 1 : _fAMount * -1;

                var sv = "exec sp_bankrecon '" + $('#Select1 option:selected').html() + "','" + _fBankGlacc + "','" + _fModuleID + "'," + _fAMount + ",'" + _fReference + "', '" + _username + "',3";

                var sql123 = "INSERT INTO SOAReconTrans (v8RunDate,GLACC,Amount,Remarks,tag,GLAction,MasterID) ";
                sql123 += "SELECT " + MB.getCookie('sysdate') + ",'" + _fBankGlacc + "'," + _fAMount + ",'" + _fReference + "',2,'" + $('#Select1 option:selected').html() + "',(SELECT MAX(TrnID) FROM MasterTRN)";

                var tr = "<tr id='glcancel" + (nnn + 1) + "'>";
                tr += "<td  style='display:none'>" + sv + "</td>";
                tr += "<td  style='display:none'>" + sql123 + "</td>";
                tr += "<td  style='display:none'>" + _fBankGlacc + "</td><td>" + accounting.formatMoney(_fAMount) + "</td><td>" + $('#Select1 option:selected').html() + "</td><td>" + _fReference + "</td>";
                tr += "<td><a class='label label-warning' onclick=gl_cancel('glcancel" + (nnn + 1) + "'," + _fAMount + ");>Cancel</a></td></tr>";

                $('#add_gl_sql tbody').append(tr);

                var soa0 = accounting.unformat(document.getElementById('soa_1').innerHTML);
                document.getElementById('soa_1').innerHTML = accounting.formatMoney(parseFloat(soa0) + parseFloat(_fAMount));

                var soa0 = accounting.unformat(document.getElementById('soa_0').innerHTML);
                var soa1 = accounting.unformat(document.getElementById('soa_1').innerHTML);

                document.getElementById('soa_2').innerHTML = accounting.formatMoney(parseFloat(soa0) - parseFloat(soa1));

                //var soa0 = accounting.unformat(document.getElementById('soa_0').innerHTML);
                //var soa1 = accounting.unformat(document.getElementById('soa_1').innerHTML) + parseFloat(_fAMount);
                //document.getElementById('soa_1').innerHTML = accounting.formatMoney(parseFloat(soa1));
                //document.getElementById('soa_2').innerHTML = accounting.formatMoney(parseFloat(soa0) - parseFloat(soa1));
                document.getElementById('GLRemarks').value = '';
                document.getElementById('frmGLAmt').value = '';

            }
        });



    },

    bankreconlist: function (dtfrom, dtto) {

        //var sv = "Select * from (SELECT TrnID, "+
        //	"dbo.NUM2DATE(MasterTRN.v8RunDate) TransDate,"+
        //	"(SELECT Description FROM Modules WHERE ModuleID=MasterTRN.ModuleID) TransType,"+
        //	"CheckNumber,"+
        //	"Amount "+
        //	"FROM MasterTRN "+
        //	"WHERE TrnID NOT IN (SELECT TrnID FROM BankRecon) and [status] = 1) a "+ 
        //	"Where transdate between cast('" + dtfrom + "' as date) and cast('" + dtto + "' as date)";

        var GLCODE = document.getElementById('frmReconSelect').value;
        var sv = "SELECT * FROM ( ";
            sv += "SELECT X.TrnID,dbo.NUM2DATE(X.v8RunDate) TransDate,";
            sv += "(SELECT Description FROM Modules WHERE ModuleID= X.ModuleID) TransType,";
            sv += "X.CheckNumber,X.Amount,X.Amount Debit,0 Credit,";
            sv += "(SELECT COALESCE(Balance,0) FROM BankAccTrn WHERE MasterID=X.TrnID AND GLACC='" + GLCODE + "') Balance, Status ";
            sv += "FROM MasterTRN X ";
            sv += "WHERE X.DebitAcct='" + GLCODE + "' ";
            sv += "UNION ";
            sv += "SELECT A.TrnID,dbo.NUM2DATE(A.v8RunDate) TransDate,";
            sv += "(SELECT Description FROM Modules WHERE ModuleID= A.ModuleID) TransType,";
            sv += "A.CheckNumber,A.Amount,0 Debit,A.Amount Credit,";
            sv += "(SELECT COALESCE(Balance,0) FROM BankAccTrn WHERE MasterID=A.TrnID AND GLACC='" + GLCODE + "') Balance, Status ";
            sv += "FROM MasterTRN A ";
            sv += "WHERE A.CreditAcct='" + GLCODE + "' ) C ";
            sv += "Where C.[Status]=1 AND C.transdate between cast('" + dtfrom + "' as date) and cast('" + dtto + "' as date)";

        //var sv = "Select * from (SELECT a.TrnID, " +
		//	"dbo.NUM2DATE(a.v8RunDate) TransDate," +
		//	"(SELECT Description FROM Modules WHERE ModuleID= a.ModuleID) TransType," +
		//	"a.CheckNumber," +
		//	"case When c.Amount > 0 then a.Amount else 0 end as Debit," +
        //    "case When c.Amount < 0 then a.Amount else 0 end as Credit,  coalesce(c.balance, 0) as Balance, " +
        //    " a.Amount" +
		//	" FROM MasterTRN a left join glentry b on b.ModuleID = a.ModuleID inner join BankAccTrn c on c.MasterId = a.Trnid" +
		//	//" WHERE a.TrnID NOT IN (SELECT TrnID FROM BankRecon) and a.[status] = 1 and c.Glacc = '" + GLCODE + "') a " +
        //    " WHERE a.[status] = 1 and c.Glacc = '" + GLCODE + "') a " +
		//	" Where a.transdate between cast('" + dtfrom + "' as date) and cast('" + dtto + "' as date)";

        //var sv = "SELECT * FROM (SELECT A.TrnID,dbo.NUM2DATE(A.v8RunDate) TransDate,(SELECT Description FROM Modules WHERE ModuleID= A.ModuleID) TransType,";
        //sv += "A.CheckNumber,";
        //sv += "IIF ( A.DebitAcct='" + GLCODE + "', A.Amount, 0) Debit,";
        //sv += "IIF ( A.CreditAcct='" + GLCODE + "', A.Amount, 0) Credit,";
        //sv += "coalesce(B.balance, 0) as Balance, A.Amount ";
        //sv += "FROM MasterTRN A ";
        //sv += "LEFT JOIN BankAccTrn B ON A.Trnid = B.MasterID ";
        //sv += "WHERE A.DebitAcct='" + GLCODE + "' ";
        //sv += "union ";
        //sv += "SELECT A.TrnID,dbo.NUM2DATE(A.v8RunDate) TransDate,(SELECT Description FROM Modules WHERE ModuleID= A.ModuleID) TransType,";
        //sv += "A.CheckNumber,";
        //sv += "IIF ( A.DebitAcct='" + GLCODE + "', A.Amount, 0) Debit,";
        //sv += "IIF ( A.CreditAcct='" + GLCODE + "', A.Amount, 0) Credit,";
        //sv += "coalesce(B.balance, 0) as Balance, A.Amount ";
        //sv += "FROM MasterTRN A ";
        //sv += "LEFT JOIN BankAccTrn B ON A.Trnid = B.MasterID ";
        //sv += "WHERE A.CreditAcct='" + GLCODE + "' AND A.Status=1 ) A ";
        //sv += " WHERE Transdate between cast('" + dtfrom + "' as date) and cast('" + dtto + "' as date)";

      //  console.log(sv);
        var Sumamt = 0;
        var retss = $.post(MB.URLPoster(), { SQLStatement: "SELECT SUM(amount) amt FROM BankAccTrn WHERE GLACC='" + GLCODE + "' AND dbo.NUM2DATE(v8RunDate) <= cast('" + dtto + "' as date)" });
        retss.success(function (msg) {
            var rets = JSON.parse(msg);
            Sumamt = rets[0].amt;
        });



        $.ajax({
            type: "POST",
            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            data: { SQLStatement: sv }
        }).done(function (msg) {
            //$each
            //console.log(msg);
            $('#example2 > tbody').html('');

            $.each($.parseJSON(msg), function (id, value) {

                var tr = "<tr id= " + value.TrnID + ">";
                tr += "<td>" + value.TrnID + "</td>";
                tr += "<td>" + value.TransDate + "</td>";
                tr += "<td>" + value.TransType + "</td>";
                tr += "<td>" + value.CheckNumber + " </td>";
                tr += "<td style='display:none;' id='tdAmount' hide= 'True'>" + accounting.formatMoney(value.Amount) + "</td>";
                tr += "<td>" + accounting.formatMoney(value.Debit) + "</td>";
                tr += "<td>" + accounting.formatMoney(value.Credit) + "</td>";
                tr += "<td>" + accounting.formatMoney(value.Balance) + "</td>";
                //tr += "<td class='small-col'><input type='checkbox' name='checkbox[]' value=" + value.TrnID + '-' + value.Amount + "></td>";
                tr += "<td style='display:none;' class='small-col'><input type='checkbox' name='checkbox[]' value=" + value.TrnID + '-' + value.Amount + "></td>";
                tr += "<td><a id='addsoa" + id + "' class='label label-info' data-toggle='modal' data-target='#checkmanager' onclick= SOAEntry_onclick(" + value.TrnID + "," + id + ")>Add to SOA</a>";
                tr += "<br><a class='label label-success' onclick=SOAMark(" + id + "," + value.TrnID + "); name='tagset[]'>Mark as Reconciled</a></td>";
                //tr += "<td style='display:none;' ><input type='text' id='sqlstmt_" + value.TrnID + "'></td>";
                tr += "<td style='display:none;' id='sqlstmt_" + value.TrnID + "'></td>";
                tr += "<td style='display:none;'></td>";

                tr += "</tr>";
               // Sumamt = Sumamt + value.Amount;
                //$('#sysbalance text').value = Sumamt;			
                $('#example2 tbody').append(tr);

            });

            document.getElementById('soabalance1').innerHTML = accounting.formatMoney($('#soabalance').val());
            
            document.getElementById('sysbalance').innerHTML = accounting.formatMoney(Sumamt);
            document.getElementById('sysbalance2').innerHTML = accounting.formatMoney($('#soabalance').val() - Sumamt);

            document.getElementById('soa_0').innerHTML = accounting.formatMoney($('#soabalance').val());
            document.getElementById('soa_1').innerHTML = accounting.formatMoney(Sumamt);
            document.getElementById('soa_2').innerHTML = accounting.formatMoney($('#soabalance').val() - Sumamt);




            document.getElementById('CheckTitle').innerHTML = '<i class="fa fa-dollar"></i> SOA Entry';

            $('#example2').dataTable({
                // "bPaginate": false,
                //"sScrollY": "200px",
                // "scrollCollapse": true,
                // "jQueryUI": true,
                // "bLengthChange": false,
                //  "bFilter": false,
                // "bSort": true,
                // "bInfo": true,
                //  "bAutoWidth": false
            });
        });
    },

    bankreconlistAdjGLView: function (dtfrom, dtto) {

        var GLCODE = document.getElementById('frmReconSelect').value;

        var sv = "Select * from (SELECT a.TrnID, " +
			"dbo.NUM2DATE(a.v8RunDate) TransDate," +
			"(SELECT Description FROM Modules WHERE ModuleID= a.ModuleID) TransType," +
			"a.CheckNumber," +
			"case When c.Amount > 0 then a.Amount else 0 end as Debit," +
            "case When c.Amount < 0 then a.Amount else 0 end as Credit,  coalesce(c.balance, 0) as Balance, " +
            " a.Amount" +
			" FROM MasterTRN a left join glentry b on b.ModuleID = a.ModuleID inner join BankAccTrn c on c.MasterId = a.Trnid" +
			" WHERE a.TrnID NOT IN (SELECT TrnID FROM BankRecon) and a.[status] = 1 and c.Glacc = '" + GLCODE + "') a " +
			" Where a.transdate between cast('" + dtfrom + "' as date) and cast('" + dtto + "' as date)";

        //console.log(sv);
        var Sumamt = 0;

        $.ajax({
            type: "POST",
            url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
            data: { SQLStatement: sv }
        }).done(function (msg) {
            //$each
            //console.log(msg);

            $.each($.parseJSON(msg), function (id, value) {

                var tr = "<tr id= " + value.TrnID + ">";
                tr += "<td>" + value.TrnID + "</td>";
                tr += "<td>" + value.TransDate + "</td>";
                tr += "<td>" + value.TransType + "</td>";
                tr += "<td> - </td>";
                tr += "<td style='display:none;' id='tdAmount' hide= 'True'>" + accounting.formatMoney(value.Amount) + "</td>";
                tr += "<td>" + accounting.formatMoney(value.Debit) + "</td>";
                tr += "<td>" + accounting.formatMoney(value.Credit) + "</td>";
                tr += "<td>" + accounting.formatMoney(value.Balance) + "</td>";
                tr += "<td onclick= SOAEntry_onclick2('" + value.TrnID + "')><a class='label label-info' data-toggle='modal' data-target='#checkmanager'>Reverse</a></td> </tr>";
                Sumamt = Sumamt + value.Amount;
                //$('#sysbalance text').value = Sumamt;

                document.getElementById('CheckTitle').innerHTML = '<i class="fa fa-dollar"></i> Reverse Entry';
                document.getElementById('sysbalance').value = accounting.formatMoney(Sumamt);

                $('#example3 tbody').append(tr);

            });
            $('#example3').dataTable({
                // "bPaginate": false,
                // "sScrollY": "200px",
                // "scrollCollapse": true,
                // "jQueryUI": true,
                // "bLengthChange": false,
                //  "bFilter": false,
                // "bSort": true,
                // "bInfo": true,
                // "bAutoWidth": false
            });
        });
    },

    PostConfirm: function (trnid) {
        return;
        var sv = "update masterTrn set [status] = 2 where trnid = '" + trnid + "'";
        MB.post(sv);

        //console.log(sv);
        //$.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
		//{
		//    SQLStatement: sv
		//}, function (data) {
        //});
    }
}

