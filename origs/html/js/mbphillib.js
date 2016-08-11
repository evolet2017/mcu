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
	push: function(s)
	{
	    var retval = $.post(MB.URLPoster(), { SQLStatement: s });
	    retval.success(function (result) { return result; });		
	},
	post: function (s) {
	   // var retval = $.post(MB.URLPoster(), { SQLStatement: s });
	    //retval.success(function (result) { return result; });
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
	    MB.push('sp_OutputCSV');
	    MB.checkeod();
	},
	URLPoster: function () {       
	    var s = 'abcde';
	    try {
	        s = "http://"+MB.getCookie("dbserver");
	        if (MB.getCookie("dbport") != null)
	        {
	            s = s + ":" + MB.getCookie("dbport") + "/Default.asmx/Exec";
	        } else {
	            s = s + "/Default.asmx/Exec";
	        }
	    } catch (e) {
	        $("head").append("<script src=\"/html/js/base64.js\"></script>");
	        try
	        {
	            s = "http://"+MB.getCookie("dbserver");
	            if (MB.getCookie("dbport") != null)
	            {
	                s = s + ":" +MB.getCookie("dbport") + "/Default.asmx/Exec";
	            }
	        } catch(e) {
	            s = "http://" + MB.getCookie("dbserver") + "/Default.asmx/Exec";
	        }
	        //s = //B64.encode(s);
	        s = "http://" + MB.getCookie("dbserver") + "/Default.asmx/Exec";
	    }
	    return s;
	},
	jURLPoster: function () {
	    var s = 'abcde';
	    try {
	        s = "http://" + MB.getCookie("dbserver");
	        if (MB.getCookie("dbport") != null) {
	            s = s + ":" + MB.getCookie("dbport") + "/Default.asmx/jExec";
	        } else {
	            s = s + "/Default.asmx/jExec";
	        }
	    } catch (e) {
	        $("head").append("<script src=\"/html/js/base64.js\"></script>");
	        try {
	            s = "http://" + MB.getCookie("dbserver");
	            if (MB.getCookie("dbport") != null) {
	                s = s + ":" + MB.getCookie("dbport") + "/Default.asmx/jExec";
	            }
	        } catch (e) {
	            s = "http://" + MB.getCookie("dbserver") + "/Default.asmx/jExec";
	        }
	        //s = //B64.encode(s);
	        s = "http://" + MB.getCookie("dbserver") + "/Default.asmx/jExec";
	    }
	    return s;
	}
		
};

function L10000() {
    console.log('test');
}

console.log('passme');