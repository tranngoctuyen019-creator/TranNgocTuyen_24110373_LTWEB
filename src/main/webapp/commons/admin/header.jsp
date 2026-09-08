<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="admin-topbar">
	<div class="admin-topbar-title">Trang quản trị</div>
	<c:if test="${not empty sessionScope.account}">
		<a href="<c:url value='/profile'/>" class="admin-topbar-user">
			Xin chào, ${sessionScope.account.fullName}
		</a>
	</c:if>
</div>
