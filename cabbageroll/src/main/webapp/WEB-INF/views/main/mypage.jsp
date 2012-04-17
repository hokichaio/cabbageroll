<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../com/meta.jsp"%>	
</head>
<body>
	<%@ include file="../com/header.jsp"%>	
	<div class="container">
	<div id="cabbage">
		<ul class="nav nav-tabs">
			<li class="dropdown active">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">Me<b class="caret"></b></a>
			    <ul class="dropdown-menu">
					<li><a href="#history" data-toggle="tab">History</a></li>
					<li><a href="#title" data-toggle="tab">Title</a></li>
			    </ul>
			</li>
			<li>
				<a href="#friends" data-toggle="tab">Friends</a>
			</li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane active" id="history">
				<c:forEach var="enq" items="${enqs}" varStatus="status" >
					<li><a href="./goto?enqId=${enq.id}">${enq.title}</a></li>
				</c:forEach>
			</div>
			<div class="tab-pane" id="title">
				<div class="span12">
					<i class="icon-glass"></i>Under Construct...
				</div>
			</div>
			<div class="tab-pane" id="friends">
				<div class="span12">
					<i class="icon-glass"></i>Under Construct as well...
				</div>
			</div>
		</div>
	</div>
	</div>
<script>
getMe = function() {
	$.ajax({
		type: "GET",
		url: "./async/me",
		dataType: "html"
	});
};
getFriend = function() {
	$.ajax({
		type: "GET",
		url: "./async/friend",
		dataType: "html"
	});
}
</script>	
</body>
</html>