<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="./com/meta.jsp"%>	
</head>
<body>
	<%@ include file="./com/header.jsp"%>	
	<div class="container">
		<h3>Welcome to the backend system</h3>
		<form action="./login" method="post">
			Password:<input type="text" name="password"/>
			<input type="submit" />
		</form>
	</div>
</body>
</html>




