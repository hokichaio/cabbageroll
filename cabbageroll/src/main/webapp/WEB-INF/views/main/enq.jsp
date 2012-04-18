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
	<div class="container" style="text-align:center;">
			<iframe class="enq" src="<%= request.getContextPath() %>/iframe/goto?enqId=${enqId}" seamless frameborder=0></iframe>
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
$('.carousel').carousel(('pause'))
</script>
</body>
</html>