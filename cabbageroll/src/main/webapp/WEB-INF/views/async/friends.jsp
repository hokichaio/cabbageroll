<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

$(function(){
		$("#receiver_image_icon").css("visibility","visible");
		$("#friend_input").css("visibility","visible");
		$("#loading").css("display","none");
		var friends = new Array();
		<c:forEach var="friend" items="${friends}" >
	    friends.push({
	      label: "${friend.name}",
	      value: "${friend.name}",
	      id: "${friend.id}",
	      image_path: "https://graph.facebook.com/${friend.id}/picture"
	    });
	    </c:forEach>
	    $("#friend_input").autocomplete({
	      source: friends,
	      minLength: 1,
	      select: function( event, ui ) {
	       	addFriend(ui.item.id,ui.item.value);
	       	$("#friend_input").val("");
	        $("#send_submit").css("visibility","visible");
	        return false;
	      }
	    })
	    .data( "autocomplete" )._renderItem = function( ul, item ) {
	      if ( typeof item.nameOpt === "undefined" ) {
	        return $( "<li></li>" )
	        .data( "item.autocomplete", item )
	        .append( "<a>" + "<img src='" + item.image_path + "' width=30 /><span class='screen-name'>" + item.label + "</span></a>" )
	        .appendTo( ul );
	      } else {
	        return $( "<li></li>" )
	        .data( "item.autocomplete", item )
	        .append( "<a>" + "<img src='" + item.image_path + "' width=30 /><span class='screen-name'>" + item.nameOpt + "<br /><small>" + item.value + "</small></span></a>" )
	        .appendTo( ul );
	      }

	    };
	});
	$(function() {
	  $(".pic img").click(function(){
	    var title = $(this).attr("info");
	    var array = title.split(",");
	    var id = array[0];
	    var name = array[1];
    	addFriend(id,name);
    	$("#friend_input").val("");
	});
	<c:if test="${to.equals('receiver')}">
	$(function() {
		 $("#sendForm").append("<br/><br/><h4>Upcoming birthday</h4>");
		 <c:forEach var="b" items="${birthday}" >
			 $("#sendForm").append('<div id="bday_box"><a href="javascript:void(0);" onclick="addFriend(${b.id},\'${b.name}\')"><img src="https://graph.facebook.com/${b.id}/picture" /></a><p>${b.name}</p><p>${b.birthday}</p></div>');
		 </c:forEach>
	});
	</c:if>
});
