<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<title>Sign In</title>
		<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-1.7.min.js"></script>
		<script>
		$(function(){ 
			$("#login").submit();
		});
		</script>
	</head>
	<body>
		<div align="center">
			Authorizing...
		</div>
		<form id="login" action="<c:url value="/signin/facebook" />" method="POST">
		    <input type="hidden" name="scope" value="email,publish_stream,offline_access,friends_birthday" />		    
		</form>
	</body>
</html>
