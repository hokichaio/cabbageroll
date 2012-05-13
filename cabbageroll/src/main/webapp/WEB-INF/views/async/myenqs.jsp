<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<tr><th>タイトル</th><th>回答者数</th><th>削除</th></tr>
<c:forEach var="myenq" items="${myenqs}" >
	<tr>
		<td><a href="./goto?enqId=${myenq.id}">${myenq.title}</a></td>
		<td>${myenq.questions[0].answered}</td>
		<td><i class="icon-trash" onclick="delEnq('${myenq.id}');" style='cursor: pointer;'></i></td>
	</tr>
</c:forEach>