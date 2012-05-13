<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
		<ul class="nav nav-tabs">
			<li><a href="#question" data-toggle="tab">Question</a></li>
			<li class="active"><a href="#result" data-toggle="tab">Result</a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane" id="question">
			
				<ul class="nav nav-tabs">
					<c:forEach var="q" items="${enq.questions}" varStatus="no" >
						<li <c:if test="${no.index == 0}">class="active"</c:if> ><a href="#q${no.index}" data-toggle="tab">Q${no.index + 1}</a></li>
					</c:forEach>
				</ul>
				
				<div class="tab-content">
					<c:forEach var="q" items="${enq.questions}" varStatus="no" >
					<div class="tab-pane <c:if test="${no.index == 0}">active</c:if>" id="q${no.index}">
					
						<h3>${enq.title}</h3>
						<c:if test="${q.multimedia.type == 1}">
							<img src="<%= request.getContextPath() %>/resources/test/${q.multimedia.uri}"/>
						</c:if>
						<c:if test="${q.multimedia.type == 2}">
							<iframe class="youtube" src="http://www.youtube.com/embed/${q.multimedia.uri}" frameborder="0" allowfullscreen></iframe>
						</c:if>
						<c:if test="${q.multimedia.type == 3}">
							<img src="${q.multimedia.uri}"/>
						</c:if>
						<p>${q.description}</p>
						<c:forEach var="choice" items="${q.choices}" varStatus="status" >
							<p>${status.index+1}. ${choice.message}</p>
						</c:forEach>
					
					</div>
					</c:forEach>
				</div>
			
			
				
				
				
			</div>
			<div class="tab-pane active" id="result">
			
			
			<ul class="nav nav-tabs">
				<c:forEach var="result" items="${results}" varStatus="r" >
					<li <c:if test="${r.index == 0}">class="active"</c:if> ><a href="#r${r.index}" data-toggle="tab">Q${r.index + 1}</a></li>
				</c:forEach>
			</ul>
			<div class="tab-content">
			<c:forEach var="result" items="${results}" varStatus="r" >
				<div class="tab-pane <c:if test="${r.index == 0}">active</c:if>" id="r${r.index}">
				
				
				<img id="profile_frame" src="<%= request.getContextPath() %>/resources/img/com/profile_frame.jpg" />
				<img id="profile_img" width="50" src="https://graph.facebook.com/${enq.owner}/picture" />
				${result.description}
				<br/>
				<table class="pieChart">
				    <!-- <tr><th>Choice</th> <th>Value</th> <th>PPL</th></tr> -->
					<c:forEach var="choice" items="${result.choices}" varStatus="status" >
						<tr>
							<td>${choice.message}</td>
							<td>${fn:length(choice.answers)}</td>
							<td>
								<c:forEach var="friend" items="${choice.friends}" varStatus="status" >
									<img width="25" src="https://graph.facebook.com/${friend}/picture" />
								</c:forEach>
							</td>
						</tr>
					</c:forEach>
				</table>
				<div class="fb-like" data-href="http://<%= request.getServerName() %><%= request.getContextPath() %>/goto?enqId=${result.enqId}" data-send="false" data-layout="button_count" data-show-faces="true" data-font="segoe ui"></div>
				<div class="fb-comments" data-href="http://<%= request.getServerName() %><%= request.getContextPath() %>/goto?enqId=${result.enqId}" data-num-posts="2"  ></div>
				
				
				</div>
			</c:forEach>
			</div>
			
			
			</div>
		</div>
		</div>
	</div>
</body>
</html>