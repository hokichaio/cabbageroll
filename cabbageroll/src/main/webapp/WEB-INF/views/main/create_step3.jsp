<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
	<%@ include file="../com/meta.jsp"%>
</head>
<body>
	<%@ include file="../com/header.jsp"%>	
	<div class="container" id="container">
	<div id="cabbage">
		<form:form class="form-horizontal" id="enq" modelAttribute="enq" name="enq" action="./create_step2" method="post" enctype="multipart/form-data">
			<fieldset>
				<legend>Create a cabbageroll</legend>
				<ul style="list-style-type: none;">
					<li style="float:left; vertical-align: middle;">
						<div>
							<div style="float:left;" >
								<span style="font-size: 7pt; line-height: 0px;">Step 1</span><br/>
								<span>Create Questions</span>
							</div>
							<i class="icon-chevron-right"></i>
						</div>
					</li>
					<li style="float:left; vertical-align: middle;">
						<div>
							<div style="float:left;" >
								<span style="color:red; font-size: 7pt; line-height: 0px;">Step 2</span><br/>
								<span>Analyze</span>
							</div>
							<i class="icon-chevron-right"></i>
						</div>
					</li>
				</ul>
				
				<div id="preview">
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
									<p>
										${status.index+1}. ${choice.message}
									</p>							
								</c:forEach>
							</div>
						</c:forEach>
					</div>				
				
				</div>
				
				
				<div class="form-actions">
					<input type="submit" class="btn btn-primary" value="Create!" />
				</div>
			</fieldset>
		</form:form>
	</div>
	</div>
</body>
</html>