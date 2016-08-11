var BankVendor = {

	BAIL: function() {
				window.location = "/Main";
	},
	processthis: function(T) {
		var S = document.getElementById(T.id).innerHTML;
		var I = 1;
		//console.log(S);
		if (S == '<span class="label label-success">Active</span>')
		{
			document.getElementById(T.id).innerHTML = '<span class="label label-warning">Inactive</span>';
			I = 0;
		} else {
			document.getElementById(T.id).innerHTML = '<span class="label label-success">Active</span>';
		}
		
		$.ajax({
			type: "POST",
			url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
			data : { SQLStatement: "UPDATE Vendors SET Status="+I+" WHERE ID="+T.id}
		});
		
		
	},
	loadvalues: function (s) {
	    var SQL = "SELECT * FROM Vendors WHERE VendorID='" + s + "'";
	   // console.log(SQL);
	    var retv1 = $.post(MB.URLPoster(), { SQLStatement: SQL });
	    retv1.success(function (result) {
	        $.each(JSON.parse(result), function (id, value) {

	            $('#vend_id').val(s);
	            $('#vend_coy').val(value.CompanyName);
	            $('#vend_con').val(value.ContactName);
	            $('#vend_add').val(value.Address);
	            $('#vend_mail').val(value.Email);
	            $('#vend_phone').val(value.PhoneNumber);

	        });
	    });
	},
	vendorsave2: function () {
	    bootbox.confirm("Save Entry?", function (result) {
	        if (result == true) {
	            var sv = "DELETE FROM Vendors WHERE VendorID='" + $('#vend_id').val() + "'";
	            MB.push(sv);
	            var sv = "INSERT INTO Vendors (CompanyName,ContactName,Address,PhoneNumber,Remarks,Status,DateAdded,AddedBy,Email,VendorID)";
	            sv += " VALUES ('";
	            sv += $('#vend_coy').val() + "','";
	            sv += $('#vend_con').val() + "','";
	            sv += $('#vend_add').val() + "','";
	            sv += $('#vend_phone').val() + "',";
	            sv +="'value editted',";
	            sv += "1,getdate(),'";
	            sv += MB.getCookie('activeid') + "','";
	            sv += $('#vend_mail').val() + "','" + $('#vend_id').val() + "')";
	           // console.log(sv);
	            MB.push(sv);
	            bootbox.alert("Save Complete..", function () {
	                location.reload();
	            });


	        } else {

	        }
	    });
	},

	vendorlist: function() {
		$.ajax({
			type : "POST",
			url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
			data : { SQLStatement: "SELECT ID,CompanyName,ContactName,Address,PhoneNumber,Remarks,IIF (Status=1,'Active','Inactive') Status,CONVERT(VARCHAR(10), DateAdded, 110) AS DateAdded,AddedBy,Email,VendorID FROM Vendors" }
				}).done(function(msg) {
					$.each(JSON.parse(msg), function(key,value) {
					//console.log(msg);
						var tr = "<tr>";
						//tr += "<td></td>";
						tr += "<td><a href='#' data-target='#edit-vendor' data-toggle='modal' onclick=BankVendor.loadvalues('" + value.VendorID + "');>" + value.CompanyName + "</a></td>";
						tr += "<td>" + value.ContactName + "</td>";
						tr += "<td>" + value.Address + "</td>";
						tr += "<td>" + value.PhoneNumber + "</td>";
						tr += "<td>" + value.Email + "</td>";
						if(value.Status=='Active') {
						tr += "<td id='"+value.ID+"' onclick='BankVendor.processthis(this);'><span class='label label-success'>" + value.Status + "</span></td>";
						} else { 
						tr += "<td id='"+value.ID+"' onclick='BankVendor.processthis(this);'><span class='label label-warning'>" + value.Status + "</span></td>";
						}
						tr += "<td>" + value.DateAdded + "</td></tr>";
						$('#tblVendor tbody').append(tr);
					});
					//$("#tblVendor").dataTable();
					//$(function () {
					//	  $('#tblVendor').dataTable();
					//  });
					$(document).ready(function () {
						$('#tblVendor').dataTable().fnDraw();;
					});

					 
				});
				



	},

	vendorreset: function () {
	    $('#coyvendor').val("");
	    $('#coyname').val("");
	    $('#coycontact').val("");
	    $('#coyaddress').val("");
	    $('#coyphone').val("");
	    $('#coyremarks').val("");
	    $('#coyemail').val("");

	},
	
	vendorsave: function () {
	    if (MB.isEmpty($('#coyvendor').val())) {
	        bootbox.alert("Empty Vendor ID not allowed!");
            return
	    }
	    if (MB.isEmpty($('#coyname').val())) {
	        bootbox.alert("Empty Company Name not allowed!");
	        return
	    }
	    if (MB.isEmpty($('#coycontact').val())) {
	        bootbox.alert("Empty Company Contact not allowed!");
	        return
	    }

	    var sv = "select count(VendorId) FROM Vendors WHERE VendorID='" + $('#coyvendor').val() + "'";
	    var retv = $.post(MB.jURLPoster(), { SQLStatement: sv });

	    retv.success(function (result) {
	        var rets = result.replace('[["', '').replace('"]]', '');
	        if (rets == "1") {
	            bootbox.alert("Vendor Id already in used!");
	            return
	        } else {

	            bootbox.confirm("Save Entry?", function (result) {
	                if (result == true) {
	                    var sv = "INSERT INTO Vendors (CompanyName,ContactName,Address,PhoneNumber,Remarks,Status,DateAdded,AddedBy,Email,VendorID)";
	                    sv += " VALUES ('";
	                    sv += $('#coyname').val() + "','";
	                    sv += $('#coycontact').val() + "','";
	                    sv += $('#coyaddress').val() + "','";
	                    sv += $('#coyphone').val() + "','";
	                    sv += $('#coyremarks').val() + "',";
	                    sv += "1,getdate(),'";
	                    sv += MB.getCookie('activeid') + "','";
	                    sv += $('#coyemail').val() + "','" + $('#coyvendor').val() + "')";
	                    MB.push(sv);
	                    bootbox.alert("Save Complete..", function () { location.reload(); });


	                } else {

	                }
	            });
	        }
	    });
        	   

		
	}
		

}

