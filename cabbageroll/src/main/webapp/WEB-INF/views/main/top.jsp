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
	<script>
	<!--
	jQuery.noConflict();
	-->
	</script>
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

		<div id="target"></div>
		<%@ include file="../com/enqList.jsp"%>
		
	</div>
</body>
<script>
function submitForm() {
	event.preventDefault();
	jQuery.post('<%= request.getContextPath() %>/answer',jQuery("#answerForm").serialize(), function(data) {
		var content = jQuery(data).find('#cabbage');
		console.log(data);
		jQuery("#target").empty().append(content);
		new PieChart();
    });
	return false;
}
function choose(cNo) {
	jQuery("#cNo").val(cNo);
	submitForm();
}
function subLogin() {
	parent.location = "<%= request.getContextPath() %>/signin";
}
</script>
</html>