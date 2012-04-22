<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="./com/meta.jsp"%>	
</head>
<body>
			<img id="profile_frame" src="<%= request.getContextPath() %>/resources/img/com/profile_frame.jpg" />
			<img id="profile_img" width="50" src="https://graph.facebook.com/${enq.owner}/picture" /> <h3>${enq.title}</h3>
			<c:if test="${enq.questions[qNo].multimedia.type == 1}">
				<div><img src="<%= request.getContextPath() %>/resources/test/${enq.questions[qNo].multimedia.uri}"/></div>
			</c:if>
			<c:if test="${enq.questions[qNo].multimedia.type == 2}">
				<iframe class="youtube" src="http://www.youtube.com/embed/${enq.questions[qNo].multimedia.uri}?rel=0&amp;autohide=1&amp;showinfo=0&amp;wmode=transparent" frameborder="0" allowfullscreen="" ></iframe>
			</c:if>
			<c:if test="${enq.questions[qNo].multimedia.type == 3}">
				<div><img src="${enq.questions[qNo].multimedia.uri}"/></div>
			</c:if>
			
			<p>${enq.questions[qNo].description}</p>
			<c:if test="<%= SecurityContext.userSignedIn(request) %>">
			<form:form id="answerForm" modelAttribute="answerForm" name="answerForm" action="./answer" method="post">
				<c:forEach var="choice" items="${enq.questions[qNo].choices}" varStatus="status" >
					<p><button type="button" class="btn btn-primary" onclick="choose(${status.index});">!</button>${choice.message}</p>
				</c:forEach>
				<input type="hidden" name="enqId" value="${enq.id}"/>
				<input type="hidden" name="qNo" value="${qNo}"/>
				<input type="hidden" id="cNo" name="cNo" value=""/>
			</form:form>
			</c:if>
			<c:if test="<%= !SecurityContext.userSignedIn(request) %>">
				<c:forEach var="choice" items="${enq.questions[qNo].choices}" varStatus="status" >
					<p><a data-toggle="modal" href="#loginModal" class="btn btn-primary" >!</a>${choice.message}</p>
				</c:forEach>
			</c:if>
			<div  class="modal hide fade" id="loginModal">
				<div class="modal-header">
					<a class="close" data-dismiss="modal">×</a>
					<h3>利用規約</h3>
				</div>
				<div class="modal-body">
							<h3>Sign upをクリックして、アプリを利用してください。</h3>
							<p>注意：このアプリはまだ未完成です。</p>
				</div>
				<div class="modal-footer">
					<a href="#" class="btn" data-dismiss="modal">Close</a>
					<a href="#" class="btn btn-primary" onclick="subLogin(); return false;" >Sign up</a>
				</div>
			</div>
			
<script type="text/javascript">
choose = function(cNo) {
	$("#cNo").val(cNo);
	document.answerForm.submit();
}
subLogin = function() {
	parent.location = "<%= request.getContextPath() %>/signin";
}
</script>
</body>
</html>




