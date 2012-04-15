<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="app.of.k.social.SecurityContext" %>
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
				<h1>Surprise!</h1>
				<form:form class="form-horizontal" modelAttribute="sendForm" name="sendForm" action="./sendp3" method="post">
				<div style="width:300px;">
					<div style="text-align:right;">
						<c:forEach var="receiver" items="${sendForm.receiverList}" begin="1" varStatus="idx">
							<img id="profileImgS" src="https://graph.facebook.com/${receiver.id}/picture" />
							<form:input type="hidden" path="receiverList[${idx.index}].id" />
							<form:input type="hidden" path="receiverList[${idx.index}].name" />
						</c:forEach>
					</div>
					<div style="float:left;">
						<img src="https://graph.facebook.com/${sendForm.promoterId}/picture" /> ${sendForm.promoterName} 
						<i class="icon-gift"></i>-> ${sendForm.receiverList[0].name} 
					</div>
					<div style="text-align:right;" >
						<img src="https://graph.facebook.com/${sendForm.receiverList[0].id}/picture" />
					</div>
					<div style="clear:both;">
						<c:forEach var="sender" items="${sendForm.senderList}" begin="1" varStatus="idx">
							<img id="profileImgS" src="https://graph.facebook.com/${sender.id}/picture" />
						</c:forEach>
					</div>
				</div>
				<div id="gift_detail">
					<img src="./resources/img/gift/${sendForm.gift.id}_main.jpg" />
				</div>
				    <fieldset>
					    <legend>Pay list</legend>
					    
					    <h2>Remain: <img src="./resources/img/com/yen.gif" />${sendForm.remainingBill}</h2>
					    <div class="progress progress-striped active">
							<div class="bar" style="width: ${(sendForm.gift.price - sendForm.remainingBill) / sendForm.gift.price * 100}%;"></div>
						</div>
					    <table class="table table-striped">
						    <c:forEach var="sender" items="${sendForm.senderList}" varStatus="idx">
								<tr>						    
						    		<td width="150"><img src="https://graph.facebook.com/${sender.id}/picture" />${sender.name}</td>
						    		<td width="120">
							    		<div class="progress progress-striped active">
											<div class="bar" style="width: ${sender.payment / sendForm.gift.price * 100}%;">￥${sender.payment}</div>
										</div>
						    		</td>
						    		<td width="80">
						    			<c:if test="${userFbId == sender.id}">
						    				<i class="icon-shopping-cart"></i><a onclick="pay()">Pay</a><br/>
						    				<i class="icon-pencil"></i><a onclick="writeMessage()">Message</a>
						    			</c:if>	
						    		</td>
						    		<td>
						    			${sender.message}
						    		</td>
						    	</tr>
						    	<form:input path="senderList[${idx.index}].id" type="hidden" />
						    	<form:input path="senderList[${idx.index}].name" type="hidden" />
						    	<form:input path="senderList[${idx.index}].payment" type="hidden" />
						    	<form:input path="senderList[${idx.index}].promoter" type="hidden" />
						    	<form:input path="senderList[${idx.index}].message" type="hidden" />
							</c:forEach>
						</table>
					    
					    <form:input path="id" type="hidden" value="${id}"/>
					    <form:input path="gift.id" type="hidden" value="${gift.id}"/>
					    <form:input path="gift.name" type="hidden" value="${gift.name}"/>
					    <form:input path="gift.price" type="hidden" value="${gift.price}"/>
					    <form:input path="receiverList[0].id" type="hidden" />
					    <form:input path="receiverList[0].name" type="hidden" />
					    <div id="form-actions" class="form-actions" style="visibility:hidden;">
				            <button type="submit" class="btn btn-primary">Next</button>
				        </div>
				    </fieldset>
				    <div id="input_dialog_pay" style="display:none; text-align:center;'">
						<input type="number" id="input_pay" class="input-small"/>
					</div>
					<div id="input_dialog_message" style="display:none; text-align:center;'">
						<textarea id="message" cols="200" rows="8"></textarea>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	
</body>
</html>