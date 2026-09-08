<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sản phẩm</title>
<style>
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
	.category-filter { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 24px; }
	.category-filter a { display: inline-block; padding: 7px 16px; border: 1px solid var(--border); border-radius: 20px; color: var(--ink); font-size: 13px; text-decoration: none; background: var(--surface); }
	.category-filter a:hover { border-color: var(--accent); color: var(--ink); text-decoration: none; }
	.category-filter a.active { background: var(--accent); border-color: var(--accent); color: #fff; }
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
	<div class="page-wrap">
		<div class="topbar">
			<h1>Tất cả sản phẩm</h1>
			<p>Trang ${currentPage} / ${totalPages}</p>
		</div>

		<div class="category-filter">
			<a href="<c:url value='/product'/>" class="${empty selectedCateId ? 'active' : ''}">Tất cả</a>
			<c:forEach items="${categories}" var="cate">
				<a href="<c:url value='/product'><c:param name='cateId' value='${cate.id}'/></c:url>"
					class="${selectedCateId == cate.id ? 'active' : ''}">${cate.name}</a>
			</c:forEach>
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
						<a href="<c:url value='/product'><c:param name='page' value='${currentPage - 1}'/><c:if test='${not empty selectedCateId}'><c:param name='cateId' value='${selectedCateId}'/></c:if></c:url>">&laquo;</a>
					</li>
					<c:forEach begin="1" end="${totalPages}" var="i">
						<li class="${i == currentPage ? 'active' : ''}">
							<a href="<c:url value='/product'><c:param name='page' value='${i}'/><c:if test='${not empty selectedCateId}'><c:param name='cateId' value='${selectedCateId}'/></c:if></c:url>">${i}</a>
						</li>
					</c:forEach>
					<li class="${currentPage == totalPages ? 'disabled' : ''}">
						<a href="<c:url value='/product'><c:param name='page' value='${currentPage + 1}'/><c:if test='${not empty selectedCateId}'><c:param name='cateId' value='${selectedCateId}'/></c:if></c:url>">&raquo;</a>
					</li>
				</ul>
			</div>
		</c:if>
	</div>
</body>
</html>
