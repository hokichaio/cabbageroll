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
	<div class="container">
	<div id="cabbage">
		<form:form class="form-horizontal" id="enq" modelAttribute="enq" name="enq" action="./create" method="post" enctype="multipart/form-data">
			<fieldset>
				<legend>Create a cabbageroll</legend>
				<div class="control-group">
					<label class="control-label" for="type">Type</label>
					<div class="controls">
						<label class="radio">
			                <form:radiobutton id="type" path="type" value="1" checked="true" /> Single Qustion
        				</label>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="title">Title</label>
					<div class="controls docs-input-sizes">
			        	<form:input class="input-xlarge" id="title" path="title" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="title">Media</label>
					<div class="controls">
						<label class="checkbox inline">
			                <input type="checkbox" id="media_flg" /> Use
        				</label>
					</div>
				</div>
				<div id="media_content" class="control-group" style="display:none;">
					<label class="control-label" >Media Type</label>
					<div class="controls">
						<label class="radio">
			                <form:radiobutton id="media_type_radio_1" class="media_type" path="questions[0].multimedia.type" value="1" /> Upload a file
        				</label>
        				<label class="radio">
			                <form:radiobutton id="media_type_radio_2" class="media_type" path="questions[0].multimedia.type" value="2" /> Place a youtube link
        				</label>
        				<label class="radio">
			                <form:radiobutton id="media_type_radio_3" class="media_type" path="questions[0].multimedia.type" value="3" /> Place an image link
        				</label>
	        			<label>
	        				<input class="media_type" type="file" name="questions[0].multimedia.file" id="media_fileuploader" style="display:none;"/>
	        			</label>
        				<label>
	        				<form:input class="media_type input-xlarge" path="questions[0].multimedia.uri" id="media_uri" style="display:none;"/>
	        			</label>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="title">Description</label>
					<div class="controls">
			        	<form:textarea path="questions[0].description" cols="320" rows="5" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="title"><input type="button" class="btn btn-primary btn-mini" onclick="addChoice()" value="AddChoice" /></label>
					<div class="controls" id="choice_list">
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
<script>
var i = 0;
$(function() {
	$("#media_flg").click(function() {
		if($("#media_flg").is(':checked')) {
			$(".media_type").removeAttr("disabled");
			$("#media_content").show();
		} else {
			$(".media_type").attr("disabled", "disabled" );
			$("#media_content").hide();
		}
  	});
});
$(function() {
	$("#media_type_radio_1").click(function() {
		$("#media_uri").css("display","none");
		$("#media_fileuploader").css("display","run-in");
  	});
	$("#media_type_radio_2").click(function() {
		$("#media_fileuploader").css("display","none");
		$("#media_uri").css("display","run-in");
  	});
	$("#media_type_radio_3").click(function() {
		$("#media_fileuploader").css("display","none");
		$("#media_uri").css("display","run-in");
  	});
});
addChoice = function() {
	$("#choice_list").append("<label class='c" + i + "' class='text'>");
	$("#choice_list").append("<input type='text' class='c" + i + "' name='questions[0].choices[" + i + "].message' />");
	$("#choice_list").append("<input type='button' class='btn btn-primary btn-mini c" + i + "' onclick='removeChoice(" + i + ")' value='Remove' />");
	$("#choice_list").append("</label>");
	i++;
}
removeChoice = function(i) {
	$(".c" + i).remove();
}
</script>
</html>