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
	<script src="http://connect.facebook.net/en_US/all.js"></script>
    <div id="fb-root"></div>
	<%@ include file="../com/header.jsp"%>	
	<div class="container">
		<div id="cabbage">
			<img width="50" src="https://graph.facebook.com/${enq.owner}/picture" /> ask you:
			<p>${enq.title}</p>
			<c:if test="${enq.questions[qNo].multimedia.type == 1}">
				<img src="<%= request.getContextPath() %>/resources/test/${enq.questions[qNo].multimedia.uri}" width="100"/>
			</c:if>
			<c:if test="${enq.questions[qNo].multimedia.type == 2}">
				<iframe width="560" height="315" src="http://www.youtube.com/embed/${enq.questions[qNo].multimedia.uri}" frameborder="0" allowfullscreen></iframe>
			</c:if>
			<c:if test="${enq.questions[qNo].multimedia.type == 3}">
				<img src="${enq.questions[qNo].multimedia.uri}" width="100"/>
			</c:if>
			<p>${enq.questions[qNo].description}</p>
			<form:form id="answerForm" modelAttribute="answerForm" name="answerForm" action="./answer" method="post">
				<c:forEach var="choice" items="${enq.questions[qNo].choices}" varStatus="status" >
					<p><button type="button" class="btn btn-primary" onclick="choose(${status.index});">!</button>${choice.message}</p>
				</c:forEach>
				<input type="hidden" name="enqId" value="${enq.id}"/>
				<input type="hidden" name="qNo" value="${qNo}"/>
				<input type="hidden" id="cNo" name="cNo" value=""/>
			</form:form>
		</div>
	</div>
<script type="text/javascript">
choose = function(cNo) {
	$("#cNo").val(cNo);
	document.answerForm.submit();
}
FB.init({appId: '112651685520077', xfbml: true, cookie: true});
postWall = function() {
	var messageStr = '${enq.title}<br/>${enq.questions[qNo].description}';
	var pic = ''
	FB.ui({ 
		method: 'feed',
		caption: messageStr,
		name: 'Playing With Cabbageroll Now',
		<c:if test="${enq.questions[qNo].multimedia.type == 1}">
			picture: 'http://<%= request.getServerName() %><%= request.getContextPath() %>/resources/test/${enq.questions[qNo].multimedia.uri}"',
		</c:if>
		<c:if test="${enq.questions[qNo].multimedia.type == 2}">
			picture: 'http://www.youtube.com/embed/${enq.questions[qNo].multimedia.uri}',
		</c:if>
		<c:if test="${enq.questions[qNo].multimedia.type == 3}">
			picture: '${enq.questions[qNo].multimedia.uri}',
		</c:if>
		link: 'http://<%= request.getServerName() %><%= request.getContextPath() %>/goto?enqId=${enq.id}'
	});
}
<c:if test="${postWallFlg}">
	$(function() {
		postWall();
	});
</c:if>
</script>
</body>
</html>