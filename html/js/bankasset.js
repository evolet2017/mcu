//$('#asset_warranty').datepick();
//$('#po_date').datepick();

function randomString(length, chars) {
    var result = '';
    for (var i = length; i > 0; --i) result += chars[Math.round(Math.random() * (chars.length - 1))];
    return result;
}
//var rString = randomString(32, '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');


function sellasset(s, y) {
    console.log('sell y : ' + y);
    $('#assetnum').val(s).prop('readOnly', true);
    var SQL = "SELECT id,GLACC,DebitGLAcct,CreditGLAcct,asset_desc,asset_po,asset_serial,CONVERT(VARCHAR(10),asset_expire,126) asset_expire,VendorLink,";
    //var SQL = "SELECT id,GLACC,DebitGLAcct,CreditGLAcct,asset_desc,asset_po,asset_serial,cast(varchar,asset_expire),VendorLink,";
    SQL += "CONVERT(VARCHAR(10),pur_date,126) pur_date,";
    SQL += "pur_cost,pur_salvagevalue,pur_deprevalue,pur_lifeinyears,pur_annualexpense ";
    SQL += "FROM BankAsset WHERE asset_code='" + s + "'";
    var retv = $.post(MB.URLPoster(), { SQLStatement: SQL });
    retv.success(function (msg) {
        //   console.log(msg);
        $.each(JSON.parse(msg), function (key, value) {
            //$('#assetacct').val(msg.GLACC);

            //console.log(value.asset_desc);
            $('#assetacct option[value=' + value.GLACC + ']').prop('selected', true);
            $('#assetacct').attr('disabled', 'disabled');
            $('#SelectAccu option[value=' + value.DebitGLAcct + ']').prop('selected', true);
            $('#SelectAccu').attr('disabled', 'disabled');
            $('#SelectExp option[value=' + value.CreditGLAcct + ']').prop('selected', true);
            $('#SelectExp').attr('disabled', 'disabled');
            // alert(value.asset_desc);
            $('#asset_desc').val(value.asset_desc).prop('readOnly', true)
            $('#asset_po').val(value.asset_po).prop('readOnly', true)
            $('#asset_serial').val(value.asset_serial).prop('readOnly', true)
            $('#asset_warranty').val(value.asset_expire).prop('readOnly', true)
            $('#po_vendorlist option[value=' + value.VendorLink + ']').prop('selected', true);
            $('#po_vendorlist').attr('disabled', 'disabled');
            $('#po_date').val(value.pur_date).prop('readOnly', true);
            $('#po_cost').val(value.pur_cost).prop('readOnly', true);
            $('#po_salvagevalue').val(value.pur_salvagevalue).prop('readOnly', true);
            $('#po_depreciablevalue').val(value.pur_deprevalue).prop('readOnly', true);
            $('#po_lifeinyears').val(value.pur_lifeinyears).prop('readOnly', true)
            $('#po_depreciationexpense').val(value.pur_annualexpense).prop('readOnly', true)
            $('#ptr_id').val(value.id);
            $('#po_monthlydep').val((($('#po_cost').val() - $('#po_salvagevalue').val()) / ($('#po_lifeinyears').val() * 12)).toFixed(2));
            $('#btnreset').hide();
            $('#btnpost').hide();
            $('#btnupdate').hide();
            $('#listofasset').slideToggle();
            $('#add_asset').slideToggle();
            $('#btnDispose').hide();
            $('#btnSell').hide();
            if (y == 'sell') {
                $('#btnSell').show();
            } else {
                $('#btnDispose').show();
            }
        });
    });
}

function editasset(s) {
    //alert(s);
    $('#assetnum').val(s);
    var SQL = "SELECT id,asset_code,GLACC,DebitGLAcct,CreditGLAcct,asset_desc,asset_po,asset_serial, CONVERT(VARCHAR(10),asset_expire,126) asset_expire,VendorLink,";
        SQL += "CONVERT(VARCHAR(10),pur_date,126) pur_date,";
        SQL += "pur_cost,pur_salvagevalue,pur_deprevalue,pur_lifeinyears,pur_annualexpense ";
        SQL += "FROM BankAsset WHERE id='" + s + "'";
    var retv = $.post(MB.URLPoster(), { SQLStatement: SQL });
    retv.success(function (msg) {
     
        $.each(JSON.parse(msg), function (key, value) {
            console.log(value.asset_expire.toString());
            $('#assetnum').val(value.asset_code);
            $('#assetacct option[value=' + value.GLACC + ']').prop('selected', true);
            $('#SelectAccu option[value=' + value.DebitGLAcct + ']').prop('selected', true);
            $('#SelectExp option[value=' + value.CreditGLAcct + ']').prop('selected', true);     
            $('#asset_desc').val(value.asset_desc);
            $('#asset_po').val(value.asset_po);
            $('#asset_serial').val(value.asset_serial);
            document.getElementById('asset_warranty').value = value.asset_expire.toString().trim();
            //$('#asset_warranty').val(value.asset_expire.toString());
            //document.getElementById('asset_warranty').value = '1991-01-01';
            $('#po_vendorlist option[value=' + value.VendorLink + ']').prop('selected', true);
            $('#po_date').val(value.pur_date).prop('readOnly', true);
            $('#po_cost').val(value.pur_cost).prop('readOnly', true);
            $('#po_salvagevalue').val(value.pur_salvagevalue).prop('readOnly', true);
            $('#po_depreciablevalue').val(value.pur_deprevalue).prop('readOnly', true);
            $('#po_lifeinyears').val(value.pur_lifeinyears).prop('readOnly', true);
            $('#po_depreciationexpense').val(value.pur_annualexpense).prop('readOnly', true);
            $('#ptr_id').val(value.id);
            $('#po_monthlydep').val((($('#po_cost').val() - $('#po_salvagevalue').val()) / ($('#po_lifeinyears').val() * 12)).toFixed(2));
            $('#btnreset').hide();
            $('#btnpost').hide();
            $('#btnupdate').show();
            $('#listofasset').slideToggle();
            $('#add_asset').slideToggle();

            $('#btnSell').hide();
            $('#btnDispose').hide();
        });
    });
}

function add_new() {
    resetthis();
    // $('#listofasset').hide();
    $('#listofasset').slideToggle();
    $('#btnreset').show();
    //$('#add_asset').show();
    $('#add_asset').slideToggle();
    $('#btnpost').show();
    $('#btnupdate').hide();
    $('#btnSell').hide();
    $('#btnDispose').hide();

    $('#assetnum').val(randomString(20, '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'));

}

function closethis() {
    var ll = location.href.split("?");  
    if (ll[1] == null) {
        $('#listofasset').slideToggle();
        $('#add_asset').slideToggle();
    } else {
        window.location = '/Asset-SellDispose';
    }
   
    
}

function xx(id) {
    $('#tbll_x' + id).hide();
}

$('#po_cost').on("keyup", function (result) {
    $('#po_depreciablevalue').val(($('#po_cost').val() - $('#po_salvagevalue').val()).toFixed(2));
    $('#po_depreciationexpense').val(($('#po_depreciablevalue').val() / $('#po_lifeinyears').val()).toFixed(2));
    $('#po_monthlydep').val((($('#po_cost').val() - $('#po_salvagevalue').val()) / ($('#po_lifeinyears').val() * 12)).toFixed(2));

});
$('#po_salvagevalue').on("keyup", function (result) {
    $('#po_depreciablevalue').val(($('#po_cost').val() - $('#po_salvagevalue').val()).toFixed(2));
    $('#po_depreciationexpense').val(($('#po_depreciablevalue').val() / $('#po_lifeinyears').val()).toFixed(2));
    $('#po_monthlydep').val((($('#po_cost').val() - $('#po_salvagevalue').val()) / ($('#po_lifeinyears').val() * 12)).toFixed(2));
});

$('#po_lifeinyears').on("keyup", function (result) {
    // $('#po_depreciablevalue').val($('#po_cost').val() - $('#po_salvagevalue').val());
    $('#po_depreciationexpense').val(($('#po_depreciablevalue').val() / $('#po_lifeinyears').val()).toFixed(2));
    $('#po_monthlydep').val((($('#po_cost').val() - $('#po_salvagevalue').val()) / ($('#po_lifeinyears').val() * 12)).toFixed(2));

});

function sellme(n) {
    window.location = '/Fix-Assets?status=sell&id=' + n;
}

function disposeme(n) {
    window.location = '/Fix-Assets?status=dispose&id=' + n;
}

var BankAsset = {

    bankassetsell: function (n) {
        // modified table - BankAsset, BankAssetDepres
        //if (n == 1) alert('sell? ');
        // -- Sell item
        var mnuchoi = $('#testbtn').val().substring(0,4);

        if (n == 1) {
            // alert($('#testbtn').val());
            $('#checkReference').val($('#po_vendorlist').val() + ' - ' + $('#asset_desc').val()).prop('readOnly', true);
        }
        if (n == 2) {
            var SQL = "SELECT ISNULL(SUM(Amount),0) amt FROM BankAssetDepre WHERE Tag=1 AND assetID='" + $('#assetnum').val() + "'";
            var retv = $.post(MB.URLPoster(), { SQLStatement: SQL });
            retv.success(function (msg) {
                //console.log(msg);
                $.each(JSON.parse(msg), function (id, ret) {
                   // console.log(ret.amt);
                    $('#bookvalue').val(accounting.formatMoney($('#po_cost').val() - ret.amt));
                    $('#accumudepreciation').val(accounting.formatMoney(ret.amt));
                    $('#lossinsale').val($('#bookvalue').val());
                });
            });

        }
        // -- Save Transaction
        if (n == 3) {            
            if (mnuchoi == 'Cash') {
                if (MB.isEmpty($('#checkAmount').val())) {
                    bootbox.alert("Empty Amount is not allowed");
                    return
                }

                var SQL = "UPDATE BankAsset SET Sold_Amount=" + $('#checkAmount').val() + ", TAG=1 WHERE asset_code='" + $('#assetnum').val() + "'";
                MB.push(SQL);
                var SQL = "INSERT INTO dashboard (acc,trn,trntype,trndate,trnamt,trnnonc,[level],tag,apptype,lname,fname) ";
                SQL += "SELECT '"+$('#assetacct').val()+"',1,93," + MB.getCookie('sysdate') + ",REPLACE(REPLACE(str(" + $('#checkAmount').val() + ", 25, 2),',',''), '.', ''),0,9,1,1,'" + $('#asset_desc').val() + "','" + $('#po_vendorlist').val() + "'";
              //  console.log(SQL);
                MB.push(SQL);

                bootbox.alert("Save Complete..", function () {
                    window.location = "/Asset-SellDispose";
                });
                
            } else {
                //if (MB.isEmpty($('#checkBank').val())) {
                //    bootbox.alert("Empty Issuing Bank is not allowed");
                //    return
                //}
                //if (MB.isEmpty($('#checkBy').val())) {
                //    bootbox.alert("Empty Issued By is not allowed");
                //    return
                //}
                if (MB.isEmpty($('#checkNumber').val())) {
                    bootbox.alert("Empty Check Number is not allowed");
                    return
                }
                if (MB.isEmpty($('#checkDate').val())) {
                    bootbox.alert("Empty Check Issued Date is not allowed");
                    return
                }
                if (MB.isEmpty($('#checkAmount').val())) {
                    bootbox.alert("Empty Amount is not allowed");
                    return
                }
                //if (MB.isEmpty($('#checkParticular').val())) {
                //    bootbox.alert("Empty Particulars is not allowed");
                //    return
                //}

                var SQL = "UPDATE BankAsset SET Sold_Amount=" + $('#checkAmount').val() + ", TAG=1 WHERE asset_code='" + $('#assetnum').val() + "'";
                MB.push(SQL);
                var SQL = "INSERT INTO dashboard (acc,trn,trntype,trndate,trnamt,trnnonc,[level],tag,apptype,lname,fname) ";
                SQL += "SELECT '" + $('#assetacct').val() + "',1,95," + MB.getCookie('sysdate') + ",REPLACE(REPLACE(str(" + $('#checkAmount').val() + ", 25, 2),',',''), '.', ''),REPLACE(REPLACE(str(" + $('#checkAmount').val() + ", 25, 2),',',''), '.', ''),9,1,1,'" + $('#asset_desc').val() + "','" + $('#po_vendorlist').val() + "'";
                MB.push(SQL);
                var SQL = "INSERT INTO SVUCDEP (CHQNUM,DEPAMT,STATUS,TRNDATE,LNAME,FNAME) ";
                SQL += "SELECT '" + $('#checkNumber').val() + "',REPLACE(REPLACE(str(" + $('#checkAmount').val() + ", 25, 2),',',''), '.', ''),0," + MB.getCookie('sysdate') + ",'" + $('#asset_desc').val() + "','" + $('#po_vendorlist').val() + "'";
                //console.log(SQL);
                MB.push(SQL);

                //CHQNUM,DEPAMT,STATUS,TRNDATE,id
                bootbox.alert("Save Complete..", function () {
                    window.location = "/Asset-SellDispose";
                });                
            }
        }
        if (n == 4) {
            var SQL = "UPDATE BankAsset SET TAG=2 WHERE asset_code='" + $('#assetnum').val() + "'";
            MB.push(SQL);
            bootbox.alert("Dispose Complete..", function () {
                window.location = "/Asset-SellDispose";
            });

        }


    },

    bankassetupdate: function () {

        if (MB.isEmpty($('#assetnum').val())) {
            bootbox.alert("Empty Asset Number not allowed!!");
            return
        }
        if (MB.isEmpty($('#po_date').val())) {
            bootbox.alert("Empty Purchase Date not allowed!!");
            return
        }
        if (MB.isEmpty($('#po_cost').val())) {
            bootbox.alert("Empty Purchase Cost not allowed!!");
            return
        }

        bootbox.confirm("Update Record?", function (result) {
            if (result) {
                var sql = "UPDATE BankAsset SET ";
                sql += "asset_code='" + $('#assetnum').val() + "',";
                sql += "GLACC='" + $('#assetacct').val() + "',";
                sql += "DebitGLAcct='" + $('#SelectAccu').val() + "',";
                sql += "CreditGLAcct='" + $('#SelectExp').val() + "',";
                sql += "asset_desc='" + $('#asset_desc').val() + "',";
                sql += "asset_po='" + $('#asset_po').val() + "',";
                sql += "asset_expire='" + $('#asset_warranty').val() + "',";
                sql += "pur_deprevalue=" + $('#po_depreciablevalue').val() + ",";
                sql += "pur_salvagevalue=" + $('#po_salvagevalue').val() + ",";
                sql += "pur_lifeinyears=" + $('#po_lifeinyears').val() + ",";

                sql += "VendorLink='" + $('#po_vendorlist').val() + "' WHERE id=" + $('#ptr_id').val();
            //    console.log(sql);
                MB.push(sql);                
                bootbox.alert("Update Complete.", function () { window.location = 'Fix-Assets'; });
                // $.ajax({
                //     type: 'post',
                //     url: MB.URLPoster(),
                //     data: { SQLStatement: sql },
                //     beforeSend: function() {

                //     },
                //     success: function(result) {

                //     },
                //     error: function(result) {

                //     },
                // });

            }
        });


    },
	bankassetsave : function() {	

			if(MB.isEmpty($('#assetnum').val())) {
				bootbox.alert("Empty Asset Number not allowed!!");
                return
			}
			if(MB.isEmpty($('#po_date').val())) {
				bootbox.alert("Empty Purchase Date not allowed!!");
                return
			}			
			if(MB.isEmpty($('#po_cost').val())) {
				bootbox.alert("Empty Purchase Cost not allowed!!");
                return
			}

			bootbox.confirm("Post Entry?", function(result){
				if (result) {

                    if($('#entry_type').val() == 1) {
                        var depre = "exec sp_OldEntryDepre"

                        $.ajax({
                            type: 'post',
                            url: MB.URLPoster(),
                            data: { SQLStatement: depre },
                            success: function(result) {
                                console.log(result + '--success--');
                            },
                        });
                    }

				    var sql = "INSERT INTO BankAsset (asset_code,asset_desc,asset_expire,asset_serial,asset_po,pur_desc,pur_date,pur_cost,pur_isnew,GLACC,userid,pur_salvagevalue,pur_deprevalue,pur_lifeinyears,pur_annualexpense,DebitGLAcct,CreditGLAcct,VendorLink,assacc,tag2) VALUES ";
						sql += "('"+$('#assetnum').val()+"','";
						sql += $('#asset_desc').val()+"','";
						sql += $('#asset_warranty').val()+"','";
						sql += $('#asset_serial').val()+"','";
						sql += $('#asset_po').val()+"','";
						sql += $('#po_desc').val()+"','";
						sql += $('#po_date').val()+"','";
						sql += $('#po_cost').val()+"','";
						sql += ($('#po_new').is(':checked')?1:0)+"','";
						sql += $('#assetacct').val()+"','";
						sql += MB.getCookie('activeid') + "','";
						sql += $('#po_salvagevalue').val() + "','";
						sql += $('#po_depreciablevalue').val() + "','";
						sql += $('#po_lifeinyears').val() + "','";
						sql += $('#po_depreciationexpense').val() + "','";
						sql += $('#SelectAccu').val() + "','";
						sql += $('#SelectExp').val() + "','" + $('#po_vendorlist').val() + "','" + $('#assetacct option:selected').text() + "', '" + $('#entry_type').val() + "')";

						MB.push(sql);

						var sql = "SELECT MAX(id) ID FROM BankAsset";
						var retv = $.post(MB.jURLPoster(), { SQLStatement: sql });
						retv.success(function (result) {
						    var chkid = result.replace('[["', '').replace('"]]', '');
						    var sql = "UpdateMaster '" + $('#assetacct').val() + "'," + $('#po_cost').val() + ",6,'" + chkid + "','','" + MB.getCookie("activeid") + "'";
						  //  console.log(sql);
						    MB.push(sql);
						    bootbox.alert("Save Complete.", function () { window.location = 'Po-Transactions'; });

						});
				   
				}
			});
					//
				
	},

	bankfixasset: function () {
	    var ss = "SELECT id,";
	    ss += "asset_code,";
	    ss += "asset_desc,";
	    ss += "LEFT(pur_date,10) po_date,";
	    ss += "ISNULL((SELECT CompanyName FROM Vendors WHERE VendorID=VendorLink),'') VendorLink,";
	    ss += "pur_cost ";
	    ss += "FROM BankAsset WHERE TAG=0";
	    var retv1 = $.post(MB.URLPoster(), { SQLStatement: ss });
	    retv1.success(function (msg) {
	        $.each(JSON.parse(msg), function (id, value) {
	            var tr = "<tr>";
	            tr += "<td>" + value.asset_code + "</td>";
	            tr += "<td>" + value.asset_desc + "</td>";
	            tr += "<td>" + value.po_date + "</td>";
	            tr += "<td>" + value.VendorLink + "</td>";
	            tr += "<td>" + accounting.formatMoney(value.pur_cost) + "</td>";
	            tr += "<td class='no-print'><button type='button' class='btn btn-success btn-xs' data-toggle='on' onclick=editasset('"+value.id+"')>Edit</button></td>";

	            tr += "</tr>";
	            $('#assetlisting tbody').append(tr);
	        });
	        $('#assetlisting').dataTable();

	    });
	},

	bankassetload2: function (n) {
	    var ss = "SELECT ";
	    ss += "asset_code,";
	    ss += "asset_desc,";
	    ss += "LEFT(pur_date,10) po_date,";
	    ss += "ISNULL((SELECT CompanyName FROM Vendors WHERE VendorID=VendorLink),'') VendorLink,";
	    ss += "pur_cost,";
	    ss += "pur_salvagevalue,";
	    ss += "pur_cost - ISNULL((SELECT SUM(Amount) FROM BankAssetDepre WHERE Tag=1 AND  assetID=asset_code),0) current_value,";
	    ss += "ISNULL((SELECT SUM(Amount) FROM BankAssetDepre WHERE  Tag=1 AND assetID=asset_code),0) accumulated,";
	    ss += "round((pur_cost-pur_salvagevalue) / (pur_lifeinyears * 12),2) AS monthlydep ";
	    ss += "FROM BankAsset WHERE TAG=0";
	   // console.log(ss);

	    var retv1 = $.post(MB.URLPoster(), { SQLStatement: ss });
	    retv1.success(function (msg) {
	        $.each(JSON.parse(msg), function (id, value) {
	            var tr = "<tr>";
	            tr += "<td>" + value.asset_code + "</td>";
	            tr += "<td>" + value.asset_desc + "</td>";
	            tr += "<td>" + value.po_date + "</td>";
	            tr += "<td>" + value.VendorLink + "</td>";
	            tr += "<td>" + accounting.formatMoney(value.pur_cost) + "</td>";
	            tr += "<td>" + accounting.formatMoney(value.pur_salvagevalue) + "</td>";
	            
	
	            //tr += "<td onclick=alert('" + value.asset_code + "');><span class='badge pull-center bg-green' onclick=alert('sell')>Sell</span><span class='badge pull-center bg-green' onclick=alert('dispose');>Dispose</span></td>";

	          //  if (n == 0) {
	            tr += "<td>" + accounting.formatMoney(value.monthlydep) + "</td>";
	            tr += "<td>" + accounting.formatMoney(value.accumulated) + "</td>";
	          //  } else {
	         //       tr += "<td onclick=alert('" + value.asset_code + "');><span class='badge pull-center bg-green'>Sell</span></td>";
	         //   }

	            tr += "<td>" + accounting.formatMoney(value.current_value) + "</td>";
	       
	           
	            tr += "</tr>";
	            $('#assetlisting tbody').append(tr);
	        });
	        $('#assetlisting').dataTable();
	    });
	},
	
	bankassetload3: function (n) {
	    var ss = "SELECT id,";
	    ss += "asset_code,";
	    ss += "asset_desc,";
	    ss += "LEFT(pur_date,10) po_date,";
	    ss += "ISNULL((SELECT CompanyName FROM Vendors WHERE VendorID=VendorLink),'') VendorLink,";
	    ss += "pur_cost,";
	    ss += "pur_salvagevalue,";
	    ss += "pur_cost - ISNULL((SELECT SUM(Amount) FROM BankAssetDepre WHERE Tag=1 AND  assetID=asset_code),0) current_value,";
	    ss += "round(pur_cost / (pur_lifeinyears * 12),2) AS monthlydep ";
	    ss += "FROM BankAsset WHERE TAG=0";
	    // console.log(ss);

	    var retv1 = $.post(MB.URLPoster(), { SQLStatement: ss });
	    retv1.success(function (msg) {
	        $.each(JSON.parse(msg), function (id, value) {
	            var tr = "<tr id="+id+">";
	           
	            tr += "<td>" + value.asset_code + "</td>";
	           
	            tr += "<td>" + value.asset_desc + "</td>";
	            tr += "<td>" + value.po_date + "</td>";
	            tr += "<td>" + value.VendorLink + "</td>";
	            tr += "<td>" + accounting.formatMoney(value.pur_cost) + "</td>";
	            tr += "<td>" + accounting.formatMoney(value.pur_salvagevalue) + "</td>";
	            tr += "<td>" + accounting.formatMoney(value.current_value) + "</td>";

	            tr += "<td><a href=#><span class='badge pull-center bg-green' onclick=sellme('" + value.asset_code + "')>Sell</span><span class='badge pull-center bg-green' onclick=disposeme('" + value.asset_code + "');>Dispose</span></a></td>";
	
                tr += "</tr>";
	            $('#assetlisting tbody').append(tr);
	        });
	       
	        $('#assetlisting').dataTable();
	        //$('#assetlisting tbody tr').on('click', function () {
	        
	        //});


	    });
	},

	bankassetload : function() {



	    var ss = "select GLACC,TITLE,'' vselect FROM GLAC WHERE LEFT(GLACC,7)=1010300";
	    var retv1 = $.post(MB.URLPoster(), { SQLStatement: ss });
	    retv1.success(function (msg) {
	        $.each(JSON.parse(msg), function (id, value) {
	            $('#assetacct').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.TITLE + "</option>");
	        });
	    });

	    var ss = "select GLACC,TITLE,'' vselect FROM GLAC WHERE LEFT(GLACC,7)=1010399";
	    var retv1 = $.post(MB.URLPoster(), { SQLStatement: ss });
	    retv1.success(function (msg) {
	        $.each(JSON.parse(msg), function (id, value) {
	            $('#SelectAccu').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.TITLE + "</option>");
	        });
	    });

	    var ss = "select GLACC,TITLE,'' vselect FROM GLAC WHERE LEFT(GLACC,7)=5010007 OR GLACC=501000821 ORDER BY GLACC";
	    var retv1 = $.post(MB.URLPoster(), { SQLStatement: ss });
	    retv1.success(function (msg) {
	        $.each(JSON.parse(msg), function (id, value) {
	            $('#SelectExp').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.TITLE + "</option>");
	        });
	    });

	    var ss = "select VendorID, CompanyName FROM Vendors";
	    var retv1 = $.post(MB.URLPoster(), { SQLStatement: ss });
	    retv1.success(function (msg) {
	        $.each(JSON.parse(msg), function (id, value) {
	            $('#po_vendorlist').append("<option value='" + value.VendorID + "'>" + value.VendorID + " - " + value.CompanyName + "</option>");

	        });
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
	bankassetinfo: function (glcode) {
	    //alert($('#assetacct').selectedIndex);
	
	    try {
	      //  if (!$('#assetacct').selectedIndex) {
	            var ind = document.getElementById('assetacct').selectedIndex;

	            document.getElementById('SelectAccu').selectedIndex = ind;
	            document.getElementById('SelectExp').selectedIndex = ind;
	       // }
	    } catch (err) {
	       // alert(err.message);
	    }
		
	}
}



//BankAsset.bankassetload();
//BankAsset.bankassetinfo($('#assetacct').val())
//BankAsset.bankfixasset();

