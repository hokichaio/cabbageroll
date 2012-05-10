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
								<span style="color:red; font-size: 7pt; line-height: 0px;">Step 1</span><br/>
								<span>Create Questions</span>
							</div>
							<i class="icon-chevron-right"></i>
						</div>
					</li>
					<li style="float:left; vertical-align: middle;">
						<div>
							<div style="float:left;" >
								<span style="font-size: 7pt; line-height: 0px;">Step 2</span><br/>
								<span>Analyze</span>
							</div>
							<i class="icon-chevron-right"></i>
						</div>
					</li>
				</ul>
				
				<div style="clear:both; padding-top: 20px"class="control-group">
					<label class="control-label" for="title">Title</label>
					<div class="controls docs-input-sizes">
			        	<form:input class="input-xlarge" id="title" path="title" />
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="title">Option</label>
					<div class="controls">
						<label class="checkbox inline">
				        	<form:checkbox id="diagnose" path="diagnose" value="true" onclick="diagnoseOnOff()"/>診断付き
						</label>
					</div>
					<div class="controls">
						<label class="checkbox inline">
					        <form:checkbox id="advertise" path="advertise" value="true"/>広告付き
						</label>
					</div>
				</div>
				
				<ul class="nav nav-tabs">
					<li class="active" id="tab1">
						<a href="#Q1" data-toggle="tab">Q1</a>
					</li>
					<li id="tabAdd">
						<a href="javascript:void(0);" onclick="addQ();">+</a>
					</li>
				</ul>
				
				<div class="tab-content" id="target">
					<div class="tab-pane active" id="Q1">
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
		        				<label class="radio">
					                <input type="radio" id="media_type_youtube" class="media_type" name="questions[0].multimedia.type" onclick="mUri(0);" value="2" /> Place a youtube link
		        				</label>
		        				<label class="radio">
					                <input type="radio" id="media_type_imgurl" class="media_type" name="questions[0].multimedia.type" onclick="mUri(0);" value="3" /> Place an image link
		        				</label>
			        			<label>
			        				<input class="media_type" type="file" name="questions[0].multimedia.file" id="media_fileuploader0" style="display:none;"/>
			        			</label>
		        				<label>
			        				<input type="text" class="media_type input-xlarge" name="questions[0].multimedia.uri" id="media_uri0" style="display:none;"/>
			        			</label>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="description">Description</label>
							<div class="controls">
					        	<textarea name="questions[0].description" cols="320" rows="5" ></textarea>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="type">Question Type</label>
							<div class="controls">
					        	<select name="questions[0].type" >
					        		<option value="1" label="SA" />
					        		<option value="2" label="MA" />
					        	</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for="title"><input type="button" class="btn btn-primary btn-mini" onclick="addChoice(0)" value="AddChoice" /></label>
							<div class="controls" id="choice_list0">
							</div>
						</div>
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
var r = 0;
var questions = 1;

function addQ() {
	questions += 1;
	$("#tabAdd").before('<li id="tab' + questions + '"><a href="#Q' + questions +'" data-toggle="tab">Q' + questions + '</a></li>');
	$.ajaxSetup({ cache: false });
	cpnObj = jQuery.get("<%= request.getContextPath() %>/async/mqmaker?qno=" + (questions-1), null, function(){
		if(cpnObj != '') {
			$("#target").append(cpnObj.responseText);
		}
	});
}

function removeQ(q) {
	$("#tab" + q).remove();
	$("#Q" + q).remove();
	$("#tab1").addClass("active");
	$("#Q1").addClass("active");
}

function useMedia(q) {
	if($("#media_flg" + q).is(':checked')) {
		$("#media_content" + q).show();
	} else {
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
function addChoice(q) {
	$("#choice_list" + q).append("<label class='c" + i + "' class='text'>");
	$("#choice_list" + q).append("<input type='text' class='c" + i + "' name='questions[" + q + "].choices[" + i + "].message' placeholder='選択肢メッセージ' />");
	$("#choice_list" + q).append("<input type='number' class='c" + i + " cp span1' name='questions[" + q + "].choices[" + i + "].value' style='display:none;' />");
	$("#choice_list" + q).append("<i class='icon-remove c" + i + "' onclick='removeChoice(" + i + ")' style='cursor: pointer;' ></i>");
	$("#choice_list" + q).append("</label>");
	diagnoseOnOff();
	i++;
}
function removeChoice(i) {
	$(".c" + i).remove();
}
function diagnoseOnOff() {
	if($("#diagnose").is(':checked')) {
		$(".cp").show();
		$("#tabAdd").after('<li class="cp" id="tab_rules"><a href="#rules" data-toggle="tab">Rules</a></li>');
		$("#target").append('<div class="tab-pane" id="rules"><input type="button" class="btn btn-primary btn-mini" onclick="addRule()" value="AddRule" /></div>');
	} else {
		$(".cp").hide();
		$("#tab_rules").remove();
		$("#rules").remove();
		$("#tab1").addClass("active");
		$("#Q1").addClass("active");
	}
}
function addRule() {
	$("#rules").append("<div id='rule" + r + "'><input type='text' name='rules[" + r + "].s' class='input-small cp' /> ~ <input type='text' name='rules[" + r + "].l' class='input-small cp' /><i class='icon-remove' onclick='removeRule(" + r + ")' style='cursor: pointer;' ></i></div>");
	r++;
}
function removeRule(i) {
	$("#rule" + i).remove();
}
</script>
</html>