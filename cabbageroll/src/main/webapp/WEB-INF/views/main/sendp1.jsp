<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="app.of.k.social.SecurityContext" %>
<!DOCTYPE html>
<html xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
	<%@ include file="../com/meta.jsp"%>	
</head>
<body>
	<%@ include file="../com/header.jsp"%>
	<script src="http://connect.facebook.net/en_US/all.js"></script>
    <div id="fb-root"></div>
	<div class="container">
		<div class="row">
			<div class="span12">
				<h1>Surprise!</h1>
				<form:form class="form-horizontal" modelAttribute="sendForm" name="sendForm" action="./sendp2" method="post">
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
				</div>
				<div id="gift_detail">
					<img src="./resources/img/gift/${sendForm.gift.id}_main.jpg" />
				</div>
				    <fieldset>
					    <legend>Send this with your friends</legend>
					    
						<div class="control-group">
							<label class="control-label" for="friend_input">Find Sponsor</label>
							<div class="controls">
								<label class="checkbox">
									<form:checkbox path="noSponsor" id="noSponsor" /> No sponsor <i class="icon-info-sign"></i>
								</label>
								<input id="friend_input" type="text" class="input-xlarge" autocomplete="off" role="textbox" aria-autocomplete="list" aria-haspopup="true" placeholder="Send your surprise together with your frineds..." />
							</div>
					    </div>
					    
					    <div id="friendListBox" style="visibility:hidden;">
						    <p>Sponsor List</p>
						   		<span id="friendAnchor"><span id="friendList"></span></span>
						    <p>*Click to remove</p>
					    </div>
					    <form:input path="id" type="hidden" value="${id}"/>
					    <form:input path="gift.id" type="hidden" value="${gift.id}"/>
					    <form:input path="gift.name" type="hidden" value="${gift.name}"/>
					    <form:input path="gift.price" type="hidden" value="${gift.price}"/>
					    <form:input path="senderList[0].id" type="hidden" />
					    <form:input path="senderList[0].name" type="hidden" />
					    <form:input path="senderList[0].promoter" type="hidden" />
					    <form:input path="receiverList[0].id" type="hidden" />
					    <form:input path="receiverList[0].name" type="hidden" />
					    <form:input path="tempMessageToSponsor" type="hidden" />
					    <div class="form-actions">
				            <button type="submit" class="btn" name="cancel">Cancel</button>
				            <button type="button" class="btn btn-primary" onclick="next();">Next</button>
				            <input type="submit" id="submitNext" style="visibility:hidden;">
				        </div>
				    </fieldset>
				</form:form>
			</div>
		</div>
	</div>
<script type="text/javascript">
  var map = new Object();
  var i=${sendForm.senderList.size()}; 
  $(function() {
	  if(<%= SecurityContext.userSignedIn() %>) {
		  $.ajax({
			  type: "GET",
			  url: "./friends/facebook?to=sender",
			  dataType: "script"
			});
	  } else {
		  $("#sign_in_msg").css("display","run-in");
		  $("#friend_input").css("display","none");
		  $("#loading").css("display","none");
	  }
  });
  $(function() {
	  $("#noSponsor").click(function() {
			if($("#noSponsor").is(':checked')) {
				$("#friend_input").attr("disabled", "disabled" );
				$("#messageToSponsor").attr("disabled", "disabled" );
				$("#friendList").remove();
				$("#friendListBox").css("visibility","hidden");
			} else {
				$("#friend_input").removeAttr("disabled");
				$("#messageToSponsor").removeAttr("disabled");
				$("#friendAnchor").append('<span id="friendList"></span>');
			}
	  });
  });
  function addFriend(id,name) {
		$("#friendListBox").css("visibility","visible");
		$("#friendList").append($('<img onclick="removeFriend(' + id + ')" id="i' + id + '" src="https://graph.facebook.com/' + id + '/picture"/>').hide().fadeIn(2000));
		$("#friendList").append("<input type='hidden' id='s" + id + "' value='" +  id + "' name='senderList[" + i + "].id' />");
		$("#friendList").append("<input type='hidden' id='n" + id + "' value='" +  name + "' name='senderList[" + i + "].name' />");
		$("#send_submit").css("visibility","visible");
		map[id] = id;
		i++;
	};
	function removeFriend(id) {
		$("#i" + id).remove();
		$("#n" + id).remove();
		$("#s" + id).remove();
		delete map[id];
	};
	FB.init({appId: '112651685520077', xfbml: true, cookie: true});
	
	next = function() {
		if(!$("#noSponsor").is(':checked')) {
			FB.ui({
		          method: 'send',
		          name: 'Send this with me hey!',
		          link: 'http://<%= request.getServerName() %><%= request.getContextPath() %>/goto?id=${sendForm.id}',
		          to: getArray(),
		      }, 
		     function(response) {
		        if (response) {
		        	$("#submitNext").click();
		        } else {
		        }
		    });
		} else {
			$("#submitNext").click();
		}
	}
	getArray = function() {
		var result = "";
		for (var i in map) {
			result += i + ",";
		}
		return result;
	}
	
</script>
</body>
</html>