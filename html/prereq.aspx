<%@ Page Language="C#" Debug="false" %>
<%@ Import Namespace="System.Text" %>


<html>
<head>
<script src="js/jquery.js"></script>
<script src="js/mbphillib.js"></script>
</head>
<body>


<script type="text/javascript">
	$(function() {
    		console.log( "Execute Push!" );
		MB.push("sp_ProcessRequired");
	});
</script>
</body>
</html>