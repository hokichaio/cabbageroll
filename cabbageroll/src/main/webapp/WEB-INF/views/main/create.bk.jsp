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
		<form:form class="form-horizontal" id="enq" modelAttribute="enq" name="enq" action="./create" method="post" enctype="multipart/form-data">
			<fieldset>
				<legend>Create a cabbageroll</legend>
				<div class="control-group">
					<label class="control-label" for="type">Type</label>
					<div class="controls">
						<label class="radio">
			                <form:radiobutton id="type1" path="type" value="1" checked="true" /> Single Qustion
						</label>
						<label class="radio">
			                <form:radiobutton id="type2" path="type" value="2" />Multiple Questions
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
					<label class="control-label" for="media">Media</label>
					<div class="controls">
						<label class="checkbox inline">
			                <input type="checkbox" id="media_flg0" name="questions[0].multimedia.type" onclick="useMedia(0);" value="0" /> Use
        				</label>
					</div>
				</div>
				<div id="media_content0" class="control-group" style="display:none;">
					<label class="control-label" >Media Type</label>
					<div class="controls">
						<!-- 
						<label class="radio">
			                <form:radiobutton id="media_type_upload" class="media_type" path="questions[0].multimedia.type" onclick="mUploader(0);" value="1" /> Upload a file
        				</label>
        				 -->
        				<label class="radio">
			                <form:radiobutton id="media_type_youtube" class="media_type" path="questions[0].multimedia.type" onclick="mUri(0);" value="2" /> Place a youtube link
        				</label>
        				<label class="radio">
			                <form:radiobutton id="media_type_imgurl" class="media_type" path="questions[0].multimedia.type" onclick="mUri(0);" value="3" /> Place an image link
        				</label>
	        			<label>
	        				<input class="media_type" type="file" name="questions[0].multimedia.file" id="media_fileuploader0" style="display:none;"/>
	        			</label>
        				<label>
	        				<form:input class="media_type input-xlarge" path="questions[0].multimedia.uri" id="media_uri0" style="display:none;"/>
	        			</label>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="description">Description</label>
					<div class="controls">
			        	<form:textarea path="questions[0].description" cols="320" rows="5" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="type">Question Type</label>
					<div class="controls">
			        	<form:select path="questions[0].type" >
			        		<form:option value="1" label="SA" />
			        		<form:option value="2" label="MA" />
			        	</form:select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="title"><input type="button" class="btn btn-primary btn-mini" onclick="addChoice(0)" value="AddChoice" /></label>
					<div class="controls" id="choice_list0">
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

function useMedia(q) {
	if($("#media_flg" + q).is(':checked')) {
		//$(".media_type").removeAttr("disabled");
		$("#media_content" + q).show();
	} else {
		//$(".media_type").attr("disabled", "disabled" );
		$("#media_content" + q).hide();
	}
}
function mUploader(q) {
	$("#media_uri" + q).hide();
	$("#media_fileuploader" + q).show();
}
function mUri(q) {
	$("#media_fileuploader" + q).hide();
	$("#media_uri" + q).show();
}
$(function() {
	$("#type2").click(function() {
		
		
	});
});
function addChoice(q) {
	$("#choice_list" + q).append("<label class='c" + i + "' class='text'>");
	$("#choice_list" + q).append("<input type='text' class='c" + i + "' name='questions[0].choices[" + i + "].message' />");
	$("#choice_list" + q).append("<input type='button' class='btn btn-primary btn-mini c" + i + "' onclick='removeChoice(" + i + ")' value='Remove' />");
	$("#choice_list" + q).append("</label>");
	i++;
}
function removeChoice(i) {
	$(".c" + i).remove();
}

//$.ajaxSetup({ cache: false });
function MQ(q){
	$("#cabbage").remove();
	data = jQuery.get("/async/mqmaker?q=" + q, null, function(){
		$("#container").append(data.responseText);
		//document.getElementById("cpBanner").innerHTML = cpnObj.responseText;
	});
};
</script>
</html>