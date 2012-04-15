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
		</div>
	</div>
<script type="text/javascript">
	choose = function(cNo) {
		$("#cNo").val(cNo);
		document.answerForm.submit();
	}
</script>
</body>
</html>