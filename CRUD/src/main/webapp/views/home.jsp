<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
	:root { --ink: #1c1c1c; --muted: #6b6b6b; --border: #dcdcdc; --surface: #ffffff; --accent: #2f5d50; --accent-dark: #24463c; }
	body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; background: #f6f6f4; color: var(--ink); }
	.navbar-custom { background: #fff; border-bottom: 1px solid var(--border); border-radius: 0; box-shadow: none; margin-bottom: 0; }
	.navbar-custom .navbar-brand { color: var(--ink) !important; font-weight: 600; }
	.navbar-custom a { color: var(--muted) !important; font-weight: 400; }
	.navbar-custom a:hover { color: var(--ink) !important; }
	.page-wrap { max-width: 1180px; margin: 0 auto; padding: 36px 20px 60px; }
	.hero { border: 1px solid var(--border); padding: 32px; margin-bottom: 32px; }
	.hero h1 { font-weight: 600; font-size: 24px; margin: 0 0 8px; }
	.hero p { margin: 0; color: var(--muted); }
	.section-title { font-weight: 600; font-size: 17px; color: var(--ink); margin: 0 0 18px; border-bottom: 1px solid var(--border); padding-bottom: 10px; }
	.product-grid { display: flex; flex-wrap: wrap; gap: 18px; }
	.product-card { background: var(--surface); border: 1px solid var(--border); width: calc(20% - 15px); min-width: 200px; text-decoration: none; color: var(--ink); display:block; }
	.product-card:hover { border-color: var(--accent); text-decoration: none; color: var(--ink); }
	.product-card img { width: 100%; height: 150px; object-fit: cover; border-bottom: 1px solid var(--border); }
	.product-info { padding: 12px 14px; }
	.product-info .p-name { font-weight: 500; font-size: 14px; margin-bottom: 6px; height: 38px; overflow: hidden; }
	.product-info .p-price { color: var(--ink); font-weight: 600; }
	.product-info .p-cate { font-size: 11.5px; color: var(--muted); }
	.view-all { text-align: center; margin-top: 26px; }
	.btn-view-all { background: var(--accent); color: #fff; border-radius: 4px; padding: 10px 24px; font-weight: 500; }
	.btn-view-all:hover { background: var(--accent-dark); color: #fff; text-decoration: none; }
	.empty-box { background: var(--surface); border: 1px solid var(--border); padding: 40px; text-align: center; color: var(--muted); }
</style>
</head>
<body>
	<nav class="navbar navbar-custom">
		<div class="container-fluid" style="max-width:1200px; margin:0 auto;">
			<div class="navbar-header">
				<a class="navbar-brand" href="<c:url value='/home'/>">Ngọc Tuyên</a>
			</div>
			<ul class="nav navbar-nav">
				<li><a href="<c:url value='/home'/>">Trang chủ</a></li>
				<li><a href="<c:url value='/product'/>">Sản phẩm</a></li>
				<li><a href="<c:url value='/admin/category/list'/>">Quản lý danh mục</a></li>
				<li><a href="<c:url value='/admin/product/list'/>">Quản lý sản phẩm</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<c:choose>
					<c:when test="${not empty sessionScope.account}">
						<li><a href="#">Xin chào, ${sessionScope.account.fullName}</a></li>
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

	<div class="page-wrap">
		<div class="hero">
			<h1>Chào mừng đến với Ngọc Tuyên Shop</h1>
			<p>Khám phá những sản phẩm mới nhất của chúng tôi</p>
		</div>

		<h3 class="section-title">Sản phẩm mới nhất</h3>

		<c:choose>
			<c:when test="${empty latestProducts}">
				<div class="empty-box">Chưa có sản phẩm nào.</div>
			</c:when>
			<c:otherwise>
				<div class="product-grid">
					<c:forEach items="${latestProducts}" var="p">
						<a class="product-card" href="<c:url value='/product/detail?id=${p.id}'/>">
							<c:url value="/image?fname=${p.image}" var="imgUrl"></c:url>
							<img src="${imgUrl}" alt="${p.name}" onerror="this.src='https://placehold.co/300x200?text=No+Image'">
							<div class="product-info">
								<div class="p-cate">${p.category.name}</div>
								<div class="p-name">${p.name}</div>
								<div class="p-price"><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/> đ</div>
							</div>
						</a>
					</c:forEach>
				</div>
			</c:otherwise>
		</c:choose>

		<div class="view-all">
			<a href="<c:url value='/product'/>" class="btn-view-all">Xem tất cả sản phẩm</a>
		</div>
	</div>
</body>
</html>
