var BankAsset = {

	bankassetsave : function() {	

			if(MB.isEmpty($('#assetnum').val())) {
				bootbox.alert("Empty Asset Number not allowed!!");
                return
			}
			if(MB.isEmpty($('#po_desc').val())) {
				bootbox.alert("Empty Purchase Description not allowed!!");
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
				if (result == true) {
					var sql = "INSERT INTO BankAsset (asset_code,asset_desc,asset_expire,asset_serial,asset_po,pur_desc,pur_date,pur_cost,pur_isnew,GLACC,userid) VALUES ";
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
						sql += MB.getCookie('activeid')+"')";
					console.log(sql);
				    $.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
					{
						SQLStatement: sql
					},	function () { }).done(function () { bootbox.alert("Save Complete.", function () { window.location = 'Po-Transactions'; }); }).fail(function () { bootbox.alert("unknown error on saving."); }).complete(function () { });
				}
			});
					//
				
	},
	
	bankassetload : function() {
		//var ss = "select A.GLACC,A.BankName,B.accounttype,A.BankAccountNum,";
	    //ss += "(SELECT 'selected' from appconfig where mbfield1='Deposit' and mbvalue=a.GLACC) as vselect ";
	    //ss += "from BankAccounts A LEFT JOIN accounttype B on A.BankAccountType=B.id WHERE 1=1 AND A.GLACC in (select GLACC FROM CheckBooks)";
		//console.log(ss);
		//console.log(MB.push(ss));
		var ss = "select GLACC,TITLE,'' vselect FROM GLAC";
		$.ajax({
			type: "POST",
			url: MB.URLPoster(),  // "http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
			data: { SQLStatement: ss }
		}).done(function (msg) {
			//var x = '';
			$.each(JSON.parse(msg), function (id, value) {
				$('#assetacct').append("<option value='" + value.GLACC + "'" + value.vselect + ">" + value.TITLE + "</option>");
			});

			//console.log(msg);
			//    alert(2);


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
	bankassetinfo: function(glcode) {
	    var s='';
	    if (MB.isEmpty(glcode))
	    {
	        BankAsset.getDefBank();
	        glcode = MB.getCookie('defbank');
	    }
	    
        
		var sv = "SELECT A.BankName,A.BankAccountNum,B.accounttype,C.EXPACC,C.TITLE FROM BankAccounts A left join accounttype b on a.BankAccountType=B.id left join GLAC C ON A.GLACC=C.GLACC WHERE A.GLACC='"+glcode+"'";
		//console.log(sv);
		$.post(MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
		{
		  SQLStatement: sv
		}, function (data) {
			//console.log(data);
			$.each($.parseJSON(data),function(id,value) {
				document.getElementById('accttype').innerHTML = value.accounttype;
				document.getElementById('acctnum').innerHTML = value.BankAccountNum;
				document.getElementById('glcode').innerHTML = value.EXPACC+' ('+value.TITLE+') ';
				//$('#accttype').innerHTML = value.BankAccountType;
				//console.log(value.accounttype);
			});
		});
		
	}
}
