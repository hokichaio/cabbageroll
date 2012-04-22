<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="jp.co.netmile.cabbageroll.social.SecurityContext" %>

<div class="navbar navbar-fixed-top">
	<div class="navbar-inner">
		<div class="container">
			<a class="brand" href="./">Backend</a>
			<div class="nav-collapse">
				<ul class="nav" >
					<li class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#">User Management</a>
						<ul class="dropdown-menu">
							<li><a href="./userList"><i class="icon-zoom-in"></i>Find User</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>