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
			<div class="span2">
				<%@ include file="../com/search_form.jsp"%>	
			</div>
			<div class="span10">
				<div id="gift_detail">
					<h2>${gift.name}</h2>
					<h4><img src="./resources/img/com/yen.gif" /> ${gift.price}</h4>
					<img src="./resources/img/gift/${gift.id}_main.jpg" />
					<p>${gift.description}</p>
					
				</div>
				<form:form id="sendForm" modelAttribute="sendForm" name="sendForm" action="./sendp1" method="post">
				    <legend>Choose a friend</legend>
					<div id="friendListBox" style="visibility:hidden;">
						<p>Receiver List</p>
							<span id="friendAnchor"><span id="friendList"></span></span>
						<p>*Click to remove</p>
					</div>
				    <img id="loading" src="<%= request.getContextPath() %>/resources/img/com/loading.gif" width="25" height="25" />
				    <input id="friend_input" style="visibility:hidden;" type="text" class="ui-autocomplete-input" autocomplete="off" role="textbox" aria-autocomplete="list" aria-haspopup="true" placeholder="Search by name..." />
				    <span id="sign_in_msg" style="display:none;" >Please sign in</span>
				    <form:input path="gift.id" type="hidden" value="${gift.id}"/>
				    <form:input path="gift.name" type="hidden" value="${gift.name}"/>
				    <form:input path="gift.price" type="hidden" value="${gift.price}"/>
				    <form:input path="senderList[0].id" type="hidden" />
				    <form:input path="senderList[0].name" type="hidden" />
				    <form:input path="senderList[0].promoter" type="hidden" />
				    <input class="btn btn-primary" id="send_submit" name="commit" style="visibility:hidden;" type="submit" value=" Next " />
				</form:form>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
var i=${sendForm.receiverList.size()}; 
  $(function() {
	  if(<%= SecurityContext.userSignedIn() %>) {
		  $.ajax({
			  type: "GET",
			  url: "./friends/facebook?to=receiver",
			  dataType: "script"
			});
	  } else {
		  $("#sign_in_msg").css("display","run-in");
		  $("#friend_input").css("display","none");
		  $("#loading").css("display","none");
	  }
  });
function addFriend(id,name) {
	$("#friendListBox").css("visibility","visible");
	$("#friendList").append($('<img onclick="removeFriend(' + id + ')" id="i' + id + '" src="https://graph.facebook.com/' + id + '/picture"/>').hide().fadeIn(2000));
	$("#friendList").append("<input type='hidden' id='s" + id + "' value='" +  id + "' name='receiverList[" + i + "].id' />");
	$("#friendList").append("<input type='hidden' id='n" + id + "' value='" +  name + "' name='receiverList[" + i + "].name' />");
	$("#send_submit").css("visibility","visible");
	i++;
};
function removeFriend(id) {
	$("#i" + id).remove();
	$("#n" + id).remove();
	$("#s" + id).remove();
};
</script>
</body>
</html>