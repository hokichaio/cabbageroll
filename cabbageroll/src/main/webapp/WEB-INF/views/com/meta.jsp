<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="jp.co.netmile.cabbageroll.social.SecurityContext" %>
<!--[if lt IE 9]>
	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>Surprise!</title>
<link type='text/css' href='<%= request.getContextPath() %>/resources/css/layout.css' rel='stylesheet' />
<link type='text/css' href='<%= request.getContextPath() %>/resources/jquery-ui/jquery-ui-1.8.18.custom.css' rel='stylesheet' />
<link type='text/css' href='<%= request.getContextPath() %>/resources/bootstrap/css/bootstrap.min.css' rel='stylesheet' />
<link type='text/css' href='<%= request.getContextPath() %>/resources/bootstrap/css/bootstrap-responsive.min.css' rel='stylesheet' />
<link type='text/css' href='<%= request.getContextPath() %>/resources/css/jquery.simplyscroll.css' rel='stylesheet' />
<script type='text/javascript' src='<%= request.getContextPath() %>/resources/js/jquery-1.7.min.js'></script>
<script type='text/javascript' src='<%= request.getContextPath() %>/resources/bootstrap/js/bootstrap.min.js'></script>
<script type='text/javascript' src='<%= request.getContextPath() %>/resources/jquery-ui/jquery-ui-1.8.18.custom.min.js'></script>
<script type='text/javascript' src='<%= request.getContextPath() %>/resources/js/jquery.simplemodal.js'></script>
<script type='text/javascript' src='<%= request.getContextPath() %>/resources/js/jquery.simplyscroll.min.js'></script>
<!-- 
<script type='text/javascript' src='<%= request.getContextPath() %>/resources/bootstrap/plugin/carousel.js'></script>
 -->