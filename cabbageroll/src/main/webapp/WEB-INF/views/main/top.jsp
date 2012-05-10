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
	
		<div id="target">
		</div>
		
		<div id="sushiMenu">
			<c:forEach var="enq" items="${enqs}" varStatus="status" >
				<input type="button" onclick="findenq('${enq.id}');" value="press" />
			</c:forEach>
		</div>
	</div>
<script>

function findenq(enqId){
	$.ajaxSetup({ cache: false });
	
	$("#target").fadeOut("fast", function(){
		$("#target").load("<%= request.getContextPath() %>/async/goto?enqId=" + enqId, false, function() {
			$("#target").fadeIn("fast");
		});
	});
	return false;
	
}

$(function(){
	$('form').submit(function(){
		var postData = {};
		$('form').find(':input').each(function(){
			postData[$(this).attr('name')] = $(this).val();
		});
		$.post('<%= request.getContextPath() %>/async/answer',postData);
		return false;
    });
});

</script>
</body>
</html>