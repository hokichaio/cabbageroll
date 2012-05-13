<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var="enq" items="${enqs}">
	<li><input type="button" onclick="findenq('${enq.id}');" value="press" /></li>
</c:forEach>


