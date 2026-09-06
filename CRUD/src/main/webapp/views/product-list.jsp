<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sản phẩm</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
	:root { --ink: #1c1c1c; --muted: #6b6b6b; --border: #dcdcdc; --surface: #ffffff; --accent: #2f5d50; --accent-dark: #24463c; }
	body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; background: #f6f6f4; color: var(--ink); }
	.navbar-custom { background: #fff; border-bottom: 1px solid var(--border); border-radius: 0; box-shadow: none; margin-bottom: 0; }
	.navbar-custom .navbar-brand { color: var(--ink) !important; font-weight: 600; }
	.navbar-custom a { color: var(--muted) !important; font-weight: 400; }
	.navbar-custom a:hover, .navbar-custom li.active a { color: var(--ink) !important; }
	.page-wrap { max-width: 1180px; margin: 0 auto; padding: 36px 20px 60px; }
	.topbar { border-bottom: 1px solid var(--border); padding-bottom: 18px; margin-bottom: 26px; }
	.topbar h1 { font-size: 22px; font-weight: 600; margin: 0; }
	.topbar p { color: var(--muted); font-size: 13.5px; margin: 4px 0 0; }
	.product-grid { display: flex; flex-wrap: wrap; gap: 18px; }
	.product-card { background: var(--surface); border: 1px solid var(--border); width: calc(33.333% - 12px); min-width: 220px; text-decoration: none; color: var(--ink); display:block; }
	.product-card:hover { border-color: var(--accent); text-decoration: none; color: var(--ink); }
	.product-card img { width: 100%; height: 180px; object-fit: cover; border-bottom: 1px solid var(--border); }
	.product-info { padding: 14px; }
	.product-info .p-name { font-weight: 500; font-size: 15px; margin-bottom: 8px; height: 40px; overflow: hidden; }
	.product-info .p-price { color: var(--ink); font-weight: 600; }
	.product-info .p-cate { font-size: 11.5px; color: var(--muted); margin-bottom: 4px; }
	.empty-box { background: var(--surface); border: 1px solid var(--border); padding: 40px; text-align: center; color: var(--muted); }
	.pagination-wrap { text-align: center; margin-top: 30px; }
	.pagination > li > a { color: var(--ink); border-radius: 4px !important; margin: 0 3px; border-color: var(--border); }
	.pagination > .active > a { background: var(--accent); border-color: var(--accent); }
	@media (max-width: 768px) {
		.product-card { width: calc(50% - 9px); }
	}
	@media (max-width: 480px) {
		.product-card { width: 100%; }
	}
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
				<li class="active"><a href="<c:url value='/product'/>">Sản phẩm</a></li>
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
		<div class="topbar">
			<h1>Tất cả sản phẩm</h1>
			<p>Trang ${currentPage} / ${totalPages}</p>
		</div>

		<c:choose>
			<c:when test="${empty productList}">
				<div class="empty-box">Chưa có sản phẩm nào.</div>
			</c:when>
			<c:otherwise>
				<div class="product-grid">
					<c:forEach items="${productList}" var="p">
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

		<c:if test="${totalPages > 1}">
			<div class="pagination-wrap">
				<ul class="pagination">
					<li class="${currentPage == 1 ? 'disabled' : ''}">
						<a href="<c:url value='/product'><c:param name="page" value="${currentPage - 1}"/></c:url>">&laquo;</a>
					</li>
					<c:forEach begin="1" end="${totalPages}" var="i">
						<li class="${i == currentPage ? 'active' : ''}">
							<a href="<c:url value='/product'><c:param name="page" value="${i}"/></c:url>">${i}</a>
						</li>
					</c:forEach>
					<li class="${currentPage == totalPages ? 'disabled' : ''}">
						<a href="<c:url value='/product'><c:param name="page" value="${currentPage + 1}"/></c:url>">&raquo;</a>
					</li>
				</ul>
			</div>
		</c:if>
	</div>
</body>
</html>
