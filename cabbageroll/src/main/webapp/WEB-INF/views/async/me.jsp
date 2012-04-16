<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="me">
					
					<c:forEach var="enq" items="${enqs}" varStatus="status" >
						<li><a href="./goto?enqId=${enq.id}">${enq.title}</a></li>
					</c:forEach>
			
</div>

	<div class="container">
		<ul class="nav nav-tabs">
			<li class="active">
				<a href="#1" data-toggle="tab">Me</a>
			</li>
			<li>
				<a href="#2" data-toggle="tab">Friends</a>
			</li>
		</ul>
		<div class="tab-content">
			<div class="tab-pane active" id="1">
				<ul class="nav nav-pills">
					<li><a href="#a" >History</a></li>
					<li><a href="#b" >Title</a></li>
				</ul>
				<div id="content">
					
					<c:forEach var="enq" items="${enqs}" varStatus="status" >
						<li><a href="./goto?enqId=${enq.id}">${enq.title}</a></li>
					</c:forEach>
				
				</div>
			</div>
			<div class="tab-pane" id="2">
				<div class="span12">
					<i class="icon-glass"></i>Under Construct...
				</div>
			</div>
		</div>
	</div>
