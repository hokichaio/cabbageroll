<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="./com/meta.jsp"%>	
</head>
<body>
	<%@ include file="./com/header.jsp"%>	
	<div class="container">
		<table class="table table-striped">
			<tr><th>UserId</th><th>ProfilePic</th><th>Update</th></tr>
			<c:forEach var="user" items="${users}" >
				<tr>
					<td><a href="./userDetail?pid=${user.providerUserId}">${user.userId}</a></td>
					<td><img src="https://graph.facebook.com/${user.providerUserId}/picture" /></td>
					<td>
						<p><i class="icon-refresh"></i><a href="./update?uid=${user.userId}">Update</a></p>
						<p><i class="icon-trash"></i><a href="./delete?uid=${user.userId}">Delete</a></p>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>




