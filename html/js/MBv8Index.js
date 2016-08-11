function updateDashExpense(val1, val2) {
    document.getElementById("BILLS").innerHTML = accounting.formatMoney(val1);
    document.getElementById("PURCHASE").innerHTML = accounting.formatMoney(val2);
}

function updateOperation(val1, val2, val3) {
    document.getElementById("CADVANCE").innerHTML = accounting.formatMoney(val1);
    document.getElementById("PETTYCASH").innerHTML = accounting.formatMoney(val2);
    //document.getElementById("PAYROLL").innerHTML = accounting.formatMoney(val3);
}

function updateDashData(val1, val2, val3, val4) {
    document.getElementById("depositvalue").value = parseFloat(Math.round(val1 * 100) / 100).toFixed(2);
    document.getElementById("checkvalue").value = parseFloat(Math.round(val2 * 100) / 100).toFixed(2);
    document.getElementById("payablevalue").value = parseFloat(Math.round(val3 * 100) / 100).toFixed(2);
    document.getElementById("sharevalue").value = parseFloat(Math.round(val4 * 100) / 100).toFixed(2);


    document.getElementById("CASHDP").innerHTML = accounting.formatMoney(val1);
    document.getElementById("CHECKDP").innerHTML = accounting.formatMoney(val2);
    document.getElementById("PAYABLESDP").innerHTML = accounting.formatMoney(val3);
    document.getElementById("SHAREDP").innerHTML = accounting.formatMoney(val4);

}
function changeData() {
    Donut3D.transition("DataIncoming", randomData(), 130, 100, 30, 0.4);
}
function randomData() {
    return TData.map(function (d) {
        return { label: d.label, value: 1000 * Math.random(), color: d.color };
    });
}


function executetrix3() {
    console.log('exucutetrix3');
    var frmCall = $.post(MB.URLPoster(), { SQLStatement: 'sp_GetPayables' });
    console.log(MB.URLPoster());
    frmCall.success(function (data) {
        console.log('sp_GetPayables -success- ' + data);
        var items = 'More Info <i class="fa fa-arrow-circle-right"></i>';
       // spans = document.getElementsByClassName('process1');

        //[].slice.call(spans).forEach(function (span) {
        //    span.innerHTML = items;
        // });
        $('.process1').html(items);

       // document.getElementsByClassName('process1').innerHTML = 'More Info <i class="fa fa-arrow-circle-right"></i>';
    });

    frmCall.done(function (data) {
        console.log('sp_GetPayables -done- ' + data);
        //executetrix3()
        reloadTrix();

    });

    frmCall.error(function (data) {
        console.log('sp_GetPayables  -error- ' + data);
    });

}


function executetrix2() {
    console.log('exucutetrix2');
    var frmCall = $.post(MB.URLPoster(), { SQLStatement: 'sp_GETSVUCDEP' });
    //console.log(frmCall);
    frmCall.success(function (data) {
        console.log('sp_GETSVUCDEP -success- ' + data);
    });

    frmCall.done(function (data) {
        console.log('sp_GETSVUCDEP -done- ' + data);
        executetrix3()
    });

    frmCall.error(function (data) {
        console.log('sp_GETSVUCDEP  -error- ' + data);
    });

}

function executetrix1() {
    var items = 'Fetching Values from Database';
    $('.process1').html(items);
    
   
    
    $.when(
    $.ajax({
        type: "post",
        url: MB.URLPoster(),
        data: { SQLStatement: "select mbvalue as sysdate from appconfig where mbfield1='sysdate'" },
        crossDomain: true,
        success: function (res) {
            $.each(JSON.parse(res), function (id, value) {
                document.cookie = 'sysdate=' + value.sysdate;
            });

        }

    })).then(function( data, textStatus, jqHXR) {
        console.log('exucutetrix1');
        /*
        var frmCall = $.post(MB.URLPoster(), { SQLStatement: 'sp_PitchTransaction' });

        frmCall.success(function (data) {
            console.log('sp_PitchTransaction -success- ' + data);
        });

        frmCall.done(function (data) {
            console.log('sp_PitchTransaction -done- ' + data);
            executetrix2()
        });

        frmCall.error(function (data) {
            console.log('sp_PitchTransaction  -error- ' + data);
        }); 
        
        */
        
        $.when(MB.post('sp_PitchTransaction')).done(function(data1){
            console.log('sp_PitchTransaction -done- ' + data1);
            executetrix2()
        });   
            
    });

    
        
}

function reloadTrix() {
    // $("#overlay").show();
    var y;
    // building dashboard
    // MB.push("sp_PitchTransaction");
    // building savings check uncleared deposit
    // MB.push("sp_GETSVUCDEP");
    // building Payables
    // MB.push("sp_GetPayables");
    // Balance Forward
    // MB.push("sp_SOABalanceForward");
    // Monthly_depreciation
    // MB.push("sp_MonthlyDepre");
    //
    var sqls = "SELECT " +
                        //   "(SELECT((SELECT SUM(PUR_COST) FROM BankAsset WHERE TAG IN (0,1))-(SELECT COALESCE(SUM(AMOUNT),0) FROM MasterTRN WHERE CheckNumber=0 AND REFERENCE IN (SELECT ASSET_CODE FROM BankAsset WHERE TAG IN (0,1))))) purchase,"+
                        //"ISNULL((SELECT SUM(pur_cost) - (SELECT SUM(amount) FROM BankAssetTrans where tag=1) FROM BankAsset ),0) purchase," +
			            //"ISNULL((SELECT SUM(PUR_COST) FROM BankAsset WHERE TAG=0),0) purchase," +
                        "(select isnull(sum(pur_cost), 0) - isnull((SELECT SUM(amount) FROM BankAssetTrans where tag=1), 0) from BankAsset) purchase," +
                        "ISNULL((SELECT SUM(A.AMOUNT) FROM BankBillerTrans A LEFT JOIN BankBiller B ON A.BILLERID=B.BILLERID WHERE A.TAG=0 AND B.TAG=1),0) bills," +
                        "ISNULL((SELECT SUM(amount) FROM BankPettyCash WHERE TAG=0),0) pettycash," +
                        "ISNULL((SELECT SUM(amount) FROM BankCashAdvance WHERE TAG=0),0) cashadvance," +
                        "ISNULL((SELECT SUM(amount) FROM BankOpTrans WHERE TAG=0),0) payroll," +
                        "ISNULL((SELECT SUM(TRNAMT)/100 FROM dashboard WHERE trnnonc=0 and trntype IN ('01','21','23','93','13','31') and trndate=(select mbvalue from appconfig where mbfield1='sysdate')),0) AS cash," +
                        "ISNULL((SELECT SUM(TRNAMT)/100 FROM dashboard WHERE trnnonc>0 and trntype IN ('01','21','31','95') and trndate=(select mbvalue from appconfig where mbfield1='sysdate')),0) AS checks," +
                        "ISNULL((SELECT SUM(TRNAMT)/100 FROM dashboard WHERE trntype='22' and trndate=(select mbvalue from appconfig where mbfield1='sysdate')),0) AS payables," +
                        "ISNULL((SELECT SUM(TRNAMT)/100 FROM dashboard WHERE trntype in ('02','14') and tag=0 and trndate=(select mbvalue from appconfig where mbfield1='sysdate')),0) AS shares ";
                        //"ISNULL((SELECT SUM(TRNAMT)/100 FROM dashboard WHERE trntype in ('02','14') and trndate=(select mbvalue from appconfig where mbfield1='sysdate')),0) AS shares ";
                        //"(SELECT CAST(MAX(trndate) AS DATETIME) FROM dashboard WHERE trntype IN ('01','22')  and trndate=(select mbvalue from appconfig where mbfield1='sysdate') ) AS thisdate";
    //console.log(sqls);
    $.ajax({        
        type: "post",
        url: MB.URLPoster(),  
        data: { SQLStatement: sqls },
        crossDomain: true,
        success: function (data) {
            y = JSON.parse(data.substring(1, data.length - 1));
            if ((y.cash + y.checks + y.payables + y.shares) != 0) {

                //UPDATE DASHBOARD DATA FIRST ROW
                updateDashData(y.cash, y.checks, y.payables, y.shares); 

                $.ajax({
                    type: "POST",
                    url: MB.URLPoster(),
                    data: { SQLStatement: "EXEC sp_UpdateEOD " + y.cash + "," + y.checks + "," + y.payables + "," + y.shares + ",1" },
                    crossDomain: true
                });               
            }
            if ((y.bills + y.purchase) != 0) {
                updateDashExpense(y.bills, y.purchase);
                $.ajax({
                    type: "POST",
                    url: MB.URLPoster(),
                    data: { SQLStatement: "EXEC sp_UpdateEOD " + y.purchase + "," + y.bills + ",0,0,2" },
                    crossDomain: true
                });
            }
            if ((y.cashadvance + y.pettycash + y.payroll ) != 0) {
                updateOperation(y.cashadvance, y.pettycash, y.payroll);
                $.ajax({
                    type: "POST",
                    url: MB.URLPoster(),
                    data: { SQLStatement: "EXEC sp_UpdateEOD " + y.cashadvance + "," + y.pettycash + "," + y.payroll + ",0,3" },
                    crossDomain: true
                });
            }
        }
    });
    // $("#overlay").hide();
    

    //EDITED 6302016
    setTimeout('executetrix1()', 1000);
    //setTimeout('executetrix1()', 5000);

    //bg - green
    //bg - yellow
    //bg - red
    //bg - maroon

    //bg - light - blue
    //bg - purple
    //bg - blue
    //bg - navy
}

function htl90912788928390() {
    var sql = "select log from usertable where username='" + MB.getCookie("activeid") + "'";
    jQuery.support.cors = true;
    $.ajax({
        type: "POST",
        url: MB.URLPoster(),
        data: { SQLStatement: sql },
        crossDomain: true,
        success: function (data) {
            $.each(JSON.parse(data), function (key, value) {
                if (value.log == 0) {
                    document.cookie = 'isactive=;';
                    document.cookie = 'activeid=;';
                }
            });

        }
    });
    document.getElementById('activeuser').innerText = MB.getCookie("activeuser");
}

//will fire after the event in index.aspx
function processClick(v) {
    if (v.id == 'cash') {
        window.location = 'Banking-Deposit#tab_1?pass_amt=' + $('#depositvalue').val();
    }
    if (v.id == 'checks') {
        window.location = 'Banking-Deposit#tab_2?pass_amt=' + $('#checkvalue').val() + '&pass_type=check';
    }
    if (v.id == 'disburse') {
        window.location = 'Loan-Disbursement';
    }
    if (v.id == 'shares') {
        window.location = 'Share-Withdrawals';
    }
    if (v.id == 'po-purchases') {
        window.location = 'Po-Transactions';
    }
    if (v.id == 'bills-payment') {
        window.location = 'Bills-Payment';
    }
    if (v.id == 'cashadv') {
        window.location = 'Cash-Advance';
    }
    if (v.id == 'pettycash') {
        window.location = 'Petty-Cash';
    }
    if (v.id == 'payroll') {
        window.location = 'Payroll';
    }
}

