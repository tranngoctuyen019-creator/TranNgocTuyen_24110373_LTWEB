<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="admin-sidebar">
	<div class="admin-brand">Ngọc Tuyên <span>Admin</span></div>
	<ul class="admin-nav">
		<li><a href="<c:url value='/admin/category/list'/>">Quản lý danh mục</a></li>
		<li><a href="<c:url value='/admin/product/list'/>">Quản lý sản phẩm</a></li>
		<li><a href="<c:url value='/profile'/>">Hồ sơ cá nhân</a></li>
	</ul>
	<div class="admin-sidebar-bottom">
		<a href="<c:url value='/home'/>">&larr; Về trang chủ</a>
		<a href="<c:url value='/logout'/>">Đăng xuất</a>
	</div>
</div>
