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
	<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=112651685520077";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
	<%@ include file="../com/header.jsp"%>
	<div class="container">
		<div id="cabbage">
			<p>${result.title}</p>
			<br/>
			<table class="pieChart">
			    <!-- <tr><th>Choice</th> <th>Value</th> <th>PPL</th></tr> -->
				<c:forEach var="choice" items="${result.choices}" varStatus="status" >
					<tr>
						<td>${choice.message}</td>
						<td>${choice.answers.size()}</td>
						<td>
							<c:forEach var="friend" items="${choice.friends}" varStatus="status" >
								<img width="25" src="https://graph.facebook.com/${friend}/picture" />
							</c:forEach>
						</td>
					</tr>
				</c:forEach>
			</table>
			<div class="fb-like" data-href="http://<%= request.getServerName() %><%= request.getContextPath() %>/goto?enqId=${result.enqId}" data-send="false" data-layout="button_count" data-width="300" data-show-faces="true" data-font="segoe ui"></div>
			<div class="fb-comments" data-href="http://<%= request.getServerName() %><%= request.getContextPath() %>/goto?enqId=${result.enqId}" data-num-posts="2" data-width="300"></div>
		</div>
	</div>
</body>
</html>