<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="app.of.k.social.SecurityContext" %>
<!DOCTYPE html>
<html xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
	<%@ include file="../com/meta.jsp"%>	
</head>
<body>
	<%@ include file="../com/header.jsp"%>
	<script src="http://connect.facebook.net/en_US/all.js"></script>
    <div id="fb-root"></div>
	<div class="container">
		<div class="row">
			<div class="span12">
				<h1>Surprise!</h1>
				<form method="post" action="./upload" enctype="multipart/form-data">
		            <input type="file" name="file"/>
		            <input type="hidden" name="userId" value="${userId}"/>
		            <input type="hidden" name="enqId" value="${enqId}"/>
		            <input type="submit"/>
      		 	</form>
			</div>
		</div>
	</div>
</body>
</html>