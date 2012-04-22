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
					<div class="active item"><iframe class="enq" src="<%= request.getContextPath() %>/iframe/goto?enqId=${enq.id}" seamless frameborder=0></iframe></div>
				</c:if>
				<c:if test="${status.index!=0}" >
					<div class="item"><iframe class="enq" src="<%= request.getContextPath() %>/iframe/goto?enqId=${enq.id}" seamless frameborder=0></iframe></div>
				</c:if>
			</c:forEach>
		    
		  </div>
		  <!-- Carousel nav -->
		  <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
		  <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
		</div>
	</div>
	
</body>
</html>