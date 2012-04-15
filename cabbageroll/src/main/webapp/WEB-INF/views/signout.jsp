<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<title>Sign In</title>
		<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-1.7.min.js"></script>
		<script>
		$(function(){ 
			parent.location = "http://www.facebook.com/"
		});
		</script>
	</head>
	<body>
		<div align="center">
			Goodbye...
		</div>
	</body>
</html>
