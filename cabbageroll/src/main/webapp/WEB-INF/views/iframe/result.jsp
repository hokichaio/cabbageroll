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
	<%@ include file="./com/meta.jsp"%>
	<link type='text/css' href='<%= request.getContextPath() %>/resources/css/piechart.css' rel='stylesheet' />
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/mootools-beta-1.2b2.js"></script> 
	<script type='text/javascript' src='<%= request.getContextPath() %>/resources/js/piechart.iframe.js'></script>
	<!--[if IE]>
		<script type='text/javascript' src='<%= request.getContextPath() %>/resources/js/piechart.js'></script>
	<![endif]-->
</head>
<body>
	<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=112651685520077";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
	<div class="container">
		<div id="cabbage">
		<ul class="nav nav-tabs">
			<li><a href="#question" data-toggle="tab">Question</a></li>
			<li class="active"><a href="#result" data-toggle="tab">Result</a></li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane" id="question">
				<h3>${enq.title}</h3>
				<c:if test="${enq.questions[0].multimedia.type == 1}">
					<img src="<%= request.getContextPath() %>/resources/test/${enq.questions[0].multimedia.uri}"/>
				</c:if>
				<c:if test="${enq.questions[0].multimedia.type == 2}">
					<iframe class="youtube" src="http://www.youtube.com/embed/${enq.questions[0].multimedia.uri}" frameborder="0" allowfullscreen></iframe>
				</c:if>
				<c:if test="${enq.questions[0].multimedia.type == 3}">
					<img src="${enq.questions[0].multimedia.uri}"/>
				</c:if>
				<p>${enq.questions[0].description}</p>
				<form:form id="answerForm" modelAttribute="answerForm" name="answerForm" action="./answer" method="post">
					<c:forEach var="choice" items="${enq.questions[0].choices}" varStatus="status" >
						<p>${status.index+1}. ${choice.message}</p>
					</c:forEach>
				</form:form>
			</div>
			<div class="tab-pane active" id="result">
			<img id="profile_frame" src="<%= request.getContextPath() %>/resources/img/com/profile_frame.jpg" />
			<img id="profile_img" width="50" src="https://graph.facebook.com/${enq.owner}/picture" />
			${result.title}
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
		</div>
		</div>
	</div>
</body>
</html>