<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
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
				
				
		<ul class="nav nav-tabs">
			<c:forEach var="q" begin="1" end="${qestions}">
				<c:if test="${q == 1}}">
					<li class="active">
						<a href="#Q${q}" data-toggle="tab">Q${q}</a>
					</li>
				</c:if>
				<c:if test="${q != 1}}">
					<li>
						<a href="#Q${q}" data-toggle="tab">Q${q}</a>
					</li>
				</c:if>
			</c:forEach>
		</ul>
		<div class="tab-content">
			<div class="tab-pane active" id="history">
				<h2>回答履歴</h2>
				<br/>
				<table class="table table-striped">
					<tr><th>タイトル</th><th>回答者数</th></tr>
					<c:forEach var="enq" items="${enqs}" >
						<tr>
							<td><a href="./goto?enqId=${enq.id}">${enq.title}</a></td>
							<td>${enq.questions[0].answered}</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="tab-pane" id="title">
				<h2>称号一覧</h2>
				<div class="span12">
					<i class="icon-glass"></i>制作中・・・
				</div>
			</div>
			<div class="tab-pane" id="friends">
				<h2>友達一覧</h2>
				<div class="span12">
					<i class="icon-glass"></i>制作中・・・
				</div>
			</div>
			<div class="tab-pane" id="myenqs">
				<h2>Myアンケート</h2>
				<br/>
				<table class="table table-striped">
					<tr><th>タイトル</th><th>回答者数</th><th>削除</th></tr>
					<c:forEach var="myenq" items="${myenqs}" >
						<tr>
							<td><a href="./goto?enqId=${myenq.id}">${myenq.title}</a></td>
							<td>${myenq.questions[0].answered}</td>
							<td><i class="icon-trash"></i></td>
						</tr>
					</c:forEach>
				</table>
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