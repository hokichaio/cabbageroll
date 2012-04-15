<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../com/meta.jsp"%>	
</head>
<body>
	<%@ include file="../com/header.jsp"%>	
	<div class="container">
	<div class="row">
		<div class="span2">
			<%@ include file="../com/search_form.jsp"%>	
		</div>
		<div class="span10">
			<c:forEach var="gift" items="${gifts}" >
				<div id="gift_box">
					<a href="./gift_detail?id=${gift.id}"><img src="./resources/img/gift/${gift.id}_main.jpg" /></a>
					<p>${gift.name}</p>
				</div>
			</c:forEach>
		</div>
	</div>
	</div>
</body>
</html>