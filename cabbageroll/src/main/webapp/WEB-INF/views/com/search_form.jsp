<%@ page language="java"
         session="false"
         pageEncoding="UTF-8"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="app.of.k.dto.Gift" %>
<script>
function submitSearchForm(category,paging){
	$('#categoryId').val(category);
	document.searchForm.submit();
}
</script>
<form:form modelAttribute="searchForm" name="searchForm" action="./gift" method="post">
	<ul class="nav nav-list">
		<li class="nav-header"><i class="icon-home"></i>Shop</li>
		<li><a href="javascript:void(0);">Restaurant</a></li>
		<li><a href="javascript:void(0);">Luxury</a></li>
		<li class="nav-header"><i class="icon-gift"></i>Gift</li>
		<li><a href="javascript:void(0);"
			onclick="submitSearchForm(<%= Gift.CATEGORY_ID_SWEETS %>,null)">Sweets</a>
		</li>
		<li><a href="javascript:void(0);"
			onclick="submitSearchForm('<%= Gift.CATEGORY_ID_BOOK %>','')">Book</a>
		</li>
		<li><a href="javascript:void(0);"
			onclick="submitSearchForm('<%= Gift.CATEGORY_ID_GROCERY %>','')">Grocery</a>
		</li>
	</ul>
	<form:hidden path="categoryId" />
</form:form>
