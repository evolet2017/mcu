var MB = {
    
	isEmpty: function(s) {
			//console.log(s);
            //return ( s == "" );
			if( s )
			{ return 1==2 } else { return 1==1}
	},
	isStatus: function(s) {
	    var T = s.replace(/^\s+|\s+$/gm, '');
            return ( s == 1 ? "Active" : "Closed");
	},

	isSavingsType: function(s) {
		var ret = "Savings"
                switch (s) {
                     case 1: ret = "Savings"; break;
                     case 2: ret = "Current Account"; break;
                     case 3: ret = "Time Deposit"; break;
                     case 4: ret = "Others"; break;
                 }
                 return ret;
	},

	getCookie: function(cname) {
		var name = cname + "=";
		var ca = document.cookie.split(';');
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i].trim();
			if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
		}
		return "";
	},
	setCookie: function(cname, cvalue, exdays) {
		var d = new Date();
		d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
		var expires = "expires=" + d.toGMTString();
		document.cookie = cname + "=" + cvalue + "; " + expires;
	},
	getParameterByName: function(s) {
		var url = window.location.href;
		var result = "";
		keyvalues = url.split(/[\?&]+/);
		for ( i = 0; i < keyvalues.length; i++ ) {
			keyvalue = keyvalues[i].split("=");
			if (keyvalue[0] == s) {
			result = keyvalue[1];
			}
		}
		
		return result;

               // name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
               // var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
               //     results = regex.exec(location.search);
               // return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));

    },
	xpad: function(num,string,char)
	{
		var y='';
		for (var i = 0; i < num; i++)
		{
		y += '~';
		}
		y=string.substring(0,num)+y.substring(0,(num-string.length));
		return y.replace(/~/gi,char);
	},
	

	push: function (s) {
	    console.log(s);
		
	    var frmCall = $.post(MB.URLPoster(), { SQLStatement: s });

	    frmCall.success(function (data) {
	        cb(s + ' -success- ' + data);
	    });

	    frmCall.done(function (data) {
	        cb(s + ' -done- ' + data);
	    });

	    frmCall.error(function (data) {
	        cb(s + ' -error- ' + data);
	    });

        
	
	    //console.log('push event');
        /*
	    console.log(MB.URLPoster());
		var client = getXmlHttp();
		client.open("POST",MB.URLPoster());
		client.setRequestHeader("Content-Type", "text/plain;charset=UTF-8");
		client.send(s);
		*/
		/*
	    $.ajax({
	        type: "POST",
	        url: MB.URLPoster(),
	        data: { SQLStatement: s },
	       
	    });
		*/

	},
	post: function (s) {
	    return $.post(MB.URLPoster(), { SQLStatement: s });
	},
	checkeod: function ()
	{
	    $.ajax({
	        type: "POST",
	        url: MB.jURLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/jExec",
	        data: { SQLStatement: "SELECT TAG FROM EOD WHERE v8RunDate=" + MB.getCookie('sysdate') },
	        success: function (data) {
	          
	            if (data == '[["0"]]') {
	                MB.push("UPDATE EOD SET TAG=1 WHERE v8RunDate=" + MB.getCookie('sysdate'));
	                MB.push("EXEC sp_UpdateSOA " + MB.getCookie('sysdate'));
	                }
	      
	        }
	    });
	},
	generateCSV: function () {
		bootbox.confirm("Are you sure you want to perform End of Day?", function(result) {
			if (result == true) {
				var sql =  "SELECT Id,dbo.NUM2DATE(v8RunDate) numdate,ClientName,CheckAmount,'' checknumber,'Disburse' remarks FROM BankPayables ";
			        sql += "WHERE v8RunDate = (SELECT mbvalue FROM appconfig WHERE mbfield1='sysdate') AND status=0 AND trntype in ('02','14')";
			    console.log(sql);
			    var undefinedstring = "[]";
			    $.ajax({
			        type: "POST",
			        url: MB.URLPoster(),  //"http://" + MB.getCookie("serveraddress") + ":8080/Default.asmx/Exec",
			        data: { SQLStatement: sql },
			        datatype: 'json',
			        success: function (data, textStatus, jqXHR) {
			        	if (data == undefinedstring) {
			        		//console.log(data, textStatus, jqXHR);
			        		console.log(data);
			        		console.log('No checks subject for disbursement');
			        		//bootbox.alert('There are still pending transactions, please check the dashboard again!');
			        		MB.push('sp_OutputCSV');
				    		MB.checkeod();
							bootbox.alert('Export Successful');
			        	} else {
			        		//console.log(data, textStatus, jqXHR);
			        		console.log(data);
			        		console.log('There are still pending transactions')
			        		bootbox.alert('There are still pending transactions, please check the dashboard again!');
			        	}
			        },
			        error: function (data) {
			        	bootbox.alert('Something went wrong. please try again!');
			        },
			    });


				// MB.push('sp_OutputCSV');
	   //  		MB.checkeod();
				// bootbox.alert('Export Successful');
			} else {
				//do nothing
			}
		  
		}); 
		//bootbox.alert('Export Successful')
	    // MB.push('sp_OutputCSV');
	    // MB.checkeod();
	},

	generateEOMDepre: function () {
		bootbox.confirm("Are you sure you want to perform end of month? if yes please click the end of day after confirming end of month to generate csv.", function(result) {
			if(result == true) {
				bootbox.confirm("Warning: Performing End of Month should be synchronize with MBv8 End of Month, Are you sure you want to proceed?", function(result2) {

					if (result2 == true) {

						var SQL = 'exec sp_MonthlyDepre2';

						$.ajax({
							type: 'post',
							url: MB.URLPoster(),
							data: { SQLStatement: SQL },
							
							success: function(result) {
								console.log(result + '--Success sp_MonthlyDepre2--');
								//bootbox.alert("Save Complete..", function () { window.location = "/Transaction"; });
								bootbox.confirm("Save Complete..", function(pod) {

									if(pod == true) {
										MB.generateCSV();
									}
								});
								
							},
						});
					} else {
						//do nothing
					}
				});
			} else {
				//do nothing
			}

		});
	},

	synccoa: function () {
		bootbox.confirm("Are you sure you want to sync chart of accounts?", function(result) {
			if (result == true) {
				MB.push('sp_FetchGLACC');
				bootbox.alert('Sync Complete');
			} else {
				//do nothing
			}
		  
		}); 
		//bootbox.alert('Sync Complete')
	    //MB.push('sp_glacc');
	},
	
	URLPoster: function (x) {    
        var s = "/dbserver/Default.asmx/Exec"; 
        try {
                if(x)
                {
                    s = x;
                }  
            
                // alert(s);
                //s = "/html/pages/Default.aspx";
                //s = "/dbserver/Default.asmx/Exec";
                // console.log(s);
	    } catch (e) {
		console.log(e);
		}
	    return s;
	},
	jURLPoster: function () {
	    var s = 'abcde';
	    try {
	        // s = "/html/pages/Default2.aspx";
	        s = "/dbserver/Default.asmx/jExec";
	    } catch (e) {
	        console.log(e);
	    }
	    return s;
	}
		
};
function getXmlHttp() {
   if (window.XMLHttpRequest) {
      xmlhttp=new XMLHttpRequest();
   } else if (window.ActiveXObject) {
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
   }
   if (xmlhttp == null) {
      alert("Your browser does not support XMLHTTP.");
   }
   console.log('getxml');
   return xmlhttp;
}

function cb(s)
{
    console.log('called finish '+s);
}

function L10000() {
    console.log('test');
}

//console.log('passme '+"You are running jQuery version: " + $.fn.jquery );