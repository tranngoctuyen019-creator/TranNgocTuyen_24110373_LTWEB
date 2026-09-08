<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="uri" value="${pageContext.request.requestURI}" />
<div class="admin-sidebar">
	<div class="admin-brand">Ngọc Tuyên <span>Admin</span></div>

	<c:choose>
		<%-- Product management page: sidebar lists categories, clicking one filters the product list --%>
		<c:when test="${not empty categories}">
			<div class="admin-nav-heading">Danh mục</div>
			<ul class="admin-nav">
				<li>
					<a href="<c:url value='/admin/product/list'/>" class="${empty selectedCateId ? 'active' : ''}">Tất cả sản phẩm</a>
				</li>
				<c:forEach items="${categories}" var="cate">
					<c:url value="/admin/product/list" var="cateUrl">
						<c:param name="cateId" value="${cate.id}" />
					</c:url>
					<li>
						<a href="${cateUrl}" class="${selectedCateId == cate.id ? 'active' : ''}">${cate.name}</a>
					</li>
				</c:forEach>
			</ul>
			<div class="admin-nav-divider"></div>
			<ul class="admin-nav">
				<li><a href="<c:url value='/admin/category/list'/>">Quản lý danh mục</a></li>
				<li><a href="<c:url value='/profile'/>" class="${fn:contains(uri, '/profile') ? 'active' : ''}">Hồ sơ cá nhân</a></li>
			</ul>
		</c:when>
		<c:otherwise>
			<ul class="admin-nav">
				<li><a href="<c:url value='/admin/product/list'/>" class="${fn:contains(uri, '/admin/product') ? 'active' : ''}">Quản lý sản phẩm</a></li>
				<li><a href="<c:url value='/profile'/>" class="${fn:contains(uri, '/profile') ? 'active' : ''}">Hồ sơ cá nhân</a></li>
			</ul>
		</c:otherwise>
	</c:choose>

	<div class="admin-sidebar-bottom">
		<a href="<c:url value='/home'/>">Về trang chủ</a>
		<a href="<c:url value='/logout'/>">Đăng xuất</a>
	</div>
</div>
