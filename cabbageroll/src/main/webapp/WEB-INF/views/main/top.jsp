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
		<div id="myCarousel" class="carousel" style="text-align:center;">
		  <!-- Carousel items -->
		  <div class="carousel-inner">
		  
		  	<c:forEach var="enq" items="${enqs}" varStatus="status" >
		  		<c:if test="${status.index==0}" >
					<div class="active item"><iframe width="580" height="800" src="<%= request.getContextPath() %>/iframe/goto?enqId=${enq.id}" seamless sandbox="allow-same-origin" frameborder=0></iframe></div>
				</c:if>
				<c:if test="${status.index!=0}" >
					<div class="item"><iframe width="580" height="800" src="<%= request.getContextPath() %>/iframe/goto?enqId=${enq.id}" seamless sandbox="allow-same-origin" frameborder=0></iframe></div>
				</c:if>
			</c:forEach>
		    
		  </div>
		  <!-- Carousel nav -->
		  <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
		  <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
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