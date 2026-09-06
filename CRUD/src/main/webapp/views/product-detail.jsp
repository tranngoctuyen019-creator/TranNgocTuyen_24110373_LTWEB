<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.name}</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
	:root { --ink: #1c1c1c; --muted: #6b6b6b; --border: #dcdcdc; --surface: #ffffff; --accent: #2f5d50; --accent-dark: #24463c; --bg: #f6f6f4; }
	body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; background: var(--bg); color: var(--ink); }
	.navbar-custom { background: #fff; border-bottom: 1px solid var(--border); border-radius: 0; box-shadow: none; margin-bottom: 0; }
	.navbar-custom .navbar-brand { color: var(--ink) !important; font-weight: 600; }
	.navbar-custom a { color: var(--muted) !important; font-weight: 400; }
	.navbar-custom a:hover { color: var(--ink) !important; }
	.page-wrap { max-width: 1180px; margin: 0 auto; padding: 40px 20px 60px; }
	.detail-card { background: var(--surface); border: 1px solid var(--border); padding: 40px; display: flex; gap: 48px; flex-wrap: wrap; }
	.detail-img { flex: 1 1 420px; }
	.detail-img img { width: 100%; border: 1px solid var(--border); object-fit: cover; max-height: 500px; display: block; }
	.detail-info { flex: 1.1 1 460px; display: flex; flex-direction: column; }
	.detail-info .p-cate { font-size: 13px; color: var(--muted); margin-bottom: 12px; }
	.detail-info h1 { font-size: 28px; font-weight: 600; margin: 0 0 18px; line-height: 1.3; }
	.price-row { border-top: 1px solid var(--border); border-bottom: 1px solid var(--border); padding: 18px 0; margin-bottom: 18px; }
	.price-row .p-price { font-size: 30px; color: var(--ink); font-weight: 600; }
	.price-row .p-price span { font-size: 14px; color: var(--muted); font-weight: 400; margin-left: 6px; }
	.stock-line { font-size: 14px; margin-bottom: 22px; }
	.stock-line.in { color: var(--accent); }
	.stock-line.out { color: #a13d3d; }
	.qty-row { display: flex; align-items: center; gap: 14px; margin-bottom: 24px; }
	.qty-row label { font-size: 14px; font-weight: 500; color: var(--ink); margin: 0; }
	.qty-stepper { display: inline-flex; align-items: center; border: 1px solid var(--border); }
	.qty-stepper button { width: 34px; height: 34px; border: none; background: #fafafa; color: var(--ink); font-size: 16px; cursor: pointer; }
	.qty-stepper button:hover { background: #eee; }
	.qty-stepper input { width: 44px; height: 34px; border: none; border-left: 1px solid var(--border); border-right: 1px solid var(--border); text-align: center; font-size: 14px; }
	.action-row { display: flex; gap: 12px; flex-wrap: wrap; margin-bottom: 28px; }
	.btn-cart, .btn-buy { flex: 1 1 180px; border: 1px solid var(--accent); padding: 13px 20px; font-size: 14.5px; font-weight: 500; cursor: pointer; }
	.btn-cart { background: #fff; color: var(--accent); }
	.btn-cart:hover { background: #f2f5f4; }
	.btn-buy { background: var(--accent); color: #fff; }
	.btn-buy:hover { background: var(--accent-dark); }
	.desc-block { border-top: 1px solid var(--border); padding-top: 20px; margin-top: auto; }
	.desc-block h3 { font-size: 15px; font-weight: 600; color: var(--ink); margin: 0 0 10px; }
	.detail-info .p-desc { font-size: 14.5px; line-height: 1.8; color: #45473f; }
	.back-link { display:inline-block; margin-top: 22px; color: var(--muted); font-size: 13.5px; }
	.back-link:hover { color: var(--ink); }
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
		<div class="detail-card">
			<div class="detail-img">
				<c:url value="/image?fname=${product.image}" var="imgUrl"></c:url>
				<img src="${imgUrl}" alt="${product.name}" onerror="this.src='https://via.placeholder.com/500x400?text=No+Image'">
			</div>
			<div class="detail-info">
				<div class="p-cate">${product.category.name}</div>
				<h1>${product.name}</h1>

				<div class="price-row">
					<span class="p-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> đ<span>/ sản phẩm</span></span>
				</div>

				<c:choose>
					<c:when test="${product.quantity > 0}">
						<div class="stock-line in">Còn ${product.quantity} sản phẩm</div>
					</c:when>
					<c:otherwise>
						<div class="stock-line out">Tạm hết hàng</div>
					</c:otherwise>
				</c:choose>

				<div class="qty-row">
					<label>Số lượng:</label>
					<div class="qty-stepper">
						<button type="button" onclick="changeQty(-1)">−</button>
						<input type="text" id="qtyInput" value="1" readonly>
						<button type="button" onclick="changeQty(1)">+</button>
					</div>
				</div>

				<div class="action-row">
					<button type="button" class="btn-cart" onclick="alert('Chức năng giỏ hàng đang được phát triển.');">Thêm vào giỏ hàng</button>
					<button type="button" class="btn-buy" onclick="alert('Chức năng đặt hàng đang được phát triển.');">Mua ngay</button>
				</div>

				<div class="desc-block">
					<h3>Mô tả sản phẩm</h3>
					<div class="p-desc">${product.description}</div>
				</div>
			</div>
		</div>
		<a class="back-link" href="<c:url value='/product'/>">&larr; Quay lại danh sách sản phẩm</a>
	</div>

	<script>
		var maxQty = ${product.quantity > 0 ? product.quantity : 0};
		function changeQty(delta) {
			var input = document.getElementById('qtyInput');
			var val = parseInt(input.value, 10) || 1;
			val += delta;
			if (val < 1) val = 1;
			if (maxQty > 0 && val > maxQty) val = maxQty;
			input.value = val;
		}
	</script>
</body>
</html>
