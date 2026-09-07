<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-custom">
	<div class="container-fluid" style="max-width:1200px; margin:0 auto;">
		<div class="navbar-header">
			<a class="navbar-brand" href="<c:url value='/home'/>">Ngọc Tuyên</a>
		</div>
		<ul class="nav navbar-nav">
			<li><a href="<c:url value='/home'/>">Trang chủ</a></li>
			<li><a href="<c:url value='/product'/>">Sản phẩm</a></li>
			<c:if test="${not empty sessionScope.account}">
				<li><a href="<c:url value='/admin/category/list'/>">Quản lý danh mục</a></li>
				<li><a href="<c:url value='/admin/product/list'/>">Quản lý sản phẩm</a></li>
			</c:if>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<c:choose>
				<c:when test="${not empty sessionScope.account}">
					<li>
						<a href="<c:url value='/profile'/>" class="nav-avatar-link">
							<c:choose>
								<c:when test="${not empty sessionScope.account.avatar}">
									<c:url value="/image?fname=${sessionScope.account.avatar}" var="avatarUrl"/>
									<img class="nav-avatar" src="${avatarUrl}" alt="avatar"
										onerror="this.src='https://placehold.co/28x28?text=%20'">
								</c:when>
								<c:otherwise>
									<img class="nav-avatar" src="https://placehold.co/28x28?text=%20" alt="avatar">
								</c:otherwise>
							</c:choose>
							Xin chào, ${sessionScope.account.fullName}
						</a>
					</li>
					<li><a href="<c:url value='/logout'/>">Đăng xuất</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="<c:url value='/login'/>">Đăng nhập</a></li>
					<li><a href="<c:url value='/register'/>">Đăng ký</a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</nav>
