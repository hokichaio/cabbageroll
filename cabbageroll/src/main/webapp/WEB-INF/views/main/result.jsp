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
	<link type='text/css' href='<%= request.getContextPath() %>/resources/css/piechart.css' rel='stylesheet' />
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/mootools-beta-1.2b2.js"></script> 
	<script type='text/javascript' src='<%= request.getContextPath() %>/resources/js/piechart.js'></script>
	<!--[if IE]>
		<script type='text/javascript' src='<%= request.getContextPath() %>/resources/js/piechart.js'></script>
	<![endif]-->
</head>
<body>
	<%@ include file="../com/header.jsp"%>	
	<div class="container">
		<div id="cabbage">
			<img src="${enq.questions[qNo].multimedia.uri}" width="100"/>
			<p>${enq.questions[qNo].title}</p>
			<p>${enq.questions[qNo].description}</p>
			<form:form id="answerForm" modelAttribute="answerForm" name="answerForm" action="./answer" method="post">
				<c:forEach var="choice" items="${enq.questions[qNo].choices}" varStatus="status" >
					<p><button type="button" class="btn btn-primary" onclick="choose(${status.index});">!</button>${choice.message}</p>
				</c:forEach>
				<input type="hidden" name="enqId" value="${enq.id}"/>
				<input type="hidden" name="qNo" value="${qNo}"/>
				<input type="hidden" id="cNo" name="cNo" value=""/>
			</form:form>
			<br/>
			<table class="pieChart">
			    <tr><th>Browser</th> <th>Value</th> <th>PPL</th></tr>
			    <tr><td>Safari </td> <td>180  </td> <td><img id="profileImgS" src="https://graph.facebook.com/6544325/picture" /><img id="profileImgS" src="https://graph.facebook.com/654217325/picture" /></td></tr>
			    <tr><td>Firefox</td> <td>210  </td> <td>peter</td></tr>
			    <tr><td>IE     </td> <td>30   </td> <td>Kevin</td></tr>
			    <tr><td>Opera  </td> <td>120  </td> <td>gaya</td></tr>
			</table>
		</div>
	</div>
</body>
</html>