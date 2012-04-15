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
	<div class="row">
		<div class="span12">
			<h1>My Page</h1>
				<ul class="nav nav-tabs">
					<li class="active"><a href="#1" data-toggle="tab">My Surprise</a></li>
					<li><a href="#2" data-toggle="tab">Friend's Surprise</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane active" id="1">
						<table class="table table-striped">
							<tr>
								<td>Select</td><td>To</td><td>From</td><td>Price</td>						
							</tr>
							<c:forEach var="surprise" items="${myList}" varStatus="idx">
								<tr>
									<td>
										<div class="btn-group">
											<a href="./goto?id=${surprise.id}"><button type="submit" name="goto" class="btn btn-primary">Select</button></a>
											<button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
												<span class="caret"></span>
											</button>
											<ul class="dropdown-menu">
												<a href="#"><i class=" icon-trash"></i>delete</a>
											</ul>
										</div>
									</td>
									<td>
										<img src="https://graph.facebook.com/${surprise.receiverList[0].id}/picture" />${surprise.receiverList[0].name}<br/>
										<c:forEach var="receiver" items="${surprise.receiverList}" begin="1" varStatus="idx">
											<img id="profileImgS" src="https://graph.facebook.com/${receiver.id}/picture" />
										</c:forEach>
									</td>
									<td>
										<img src="https://graph.facebook.com/${surprise.senderList[0].id}/picture" />${surprise.senderList[0].name}<br/>
										<c:forEach var="sender" items="${surprise.senderList}" begin="1" varStatus="idx">
											<img id="profileImgS" src="https://graph.facebook.com/${sender.id}/picture" />
										</c:forEach>
									</td>
									<td>
										Price: ${surprise.gift.price}
										<div class="progress progress-striped active">
											<div class="bar" style="width: ${(surprise.gift.price - surprise.remainingBill) / surprise.gift.price * 100}%;">${(surprise.gift.price - surprise.remainingBill)} / ${(surprise.gift.price )}</div>
										</div>
									</td>
								</tr>				
							</c:forEach>		    
						</table>
					</div>
					<div class="tab-pane" id="2">
						<table class="table table-striped">
							<tr>
								<td>Select</td><td>To</td><td>From</td><td>Price</td>						
							</tr>
							<c:forEach var="surprise" items="${friendList}" varStatus="idx">
								<tr>
									<td>
										<div class="btn-group">
											<a href="./goto?id=${surprise.id}"><button type="submit" name="goto" class="btn btn-primary">Select</button></a>
											<button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
												<span class="caret"></span>
											</button>
											<ul class="dropdown-menu">
												<a href="#"><i class=" icon-trash"></i>delete</a>
											</ul>
										</div>
									</td>
									<td>
										<img src="https://graph.facebook.com/${surprise.receiverList[0].id}/picture" />${surprise.receiverList[0].name}<br/>
										<c:forEach var="receiver" items="${surprise.receiverList}" begin="1" varStatus="idx">
											<img id="profileImgS" src="https://graph.facebook.com/${receiver.id}/picture" />
										</c:forEach>
									</td>
									<td>
										<img src="https://graph.facebook.com/${surprise.senderList[0].id}/picture" />${surprise.senderList[0].name}<br/>
										<c:forEach var="sender" items="${surprise.senderList}" begin="1" varStatus="idx">
											<img id="profileImgS" src="https://graph.facebook.com/${sender.id}/picture" />
										</c:forEach>
									</td>
									<td>
										Price: ${surprise.gift.price}
										<div class="progress progress-striped active">
											<div class="bar" style="width: ${(surprise.gift.price - surprise.remainingBill) / surprise.gift.price * 100}%;">${(surprise.gift.price - surprise.remainingBill)} / ${(surprise.gift.price )}</div>
										</div>
									</td>
								</tr>				
							</c:forEach>		    
						</table>
					</div>
				</div>
		</div>
	</div>
	</div>
</body>
</html>