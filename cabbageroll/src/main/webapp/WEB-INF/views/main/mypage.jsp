<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../com/meta.jsp"%>	
</head>
<body>
	<%@ include file="../com/header.jsp"%>	
	<div class="container">
	<div id="cabbage">
		<ul class="nav nav-tabs">
			<li class="dropdown active">
				<a class="dropdown-toggle" data-toggle="dropdown" href="#">Me<b class="caret"></b></a>
			    <ul class="dropdown-menu">
					<li><a href="#myenqs" data-toggle="tab">My Cabbage</a></li>
					<li><a href="#history" data-toggle="tab">History</a></li>
					<li><a href="#title" data-toggle="tab">Title</a></li>
			    </ul>
			</li>
			<li>
				<a href="#friends" data-toggle="tab">Friends</a>
			</li>
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
							<td>${enq.questions[0].countAnswered()}</td>
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
							<td>${myenq.questions[0].countAnswered()}</td>
							<td><i class="icon-trash"></i></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	</div>
</body>
</html>