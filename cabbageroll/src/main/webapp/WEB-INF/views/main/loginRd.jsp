<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/spring-social/facebook/tags" prefix="facebook" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../com/meta.jsp"%>	
</head>
<body>
	<%@ include file="../com/header.jsp"%>	
	<div class="container">
		<div class="row">
			<div class="span12" style="text-align=center">
				<h1>Welcome to Surprise!</h1>
				<hr/>
				<h3>Login with your facebook account!</h3>
				<a href="javascript:void(0);" onclick="document.login.submit(); return false;" ><img src="<%= request.getContextPath() %>/resources/img/com/fb_icon.png" /></a>
			</div>
		</div>
	</div>
</body>
</html>