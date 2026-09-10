<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.name}</title>
<style>
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
	.toast-notify {
		position: fixed; top: 24px; right: 24px; z-index: 9999;
		background: var(--accent); color: #fff; padding: 14px 22px;
		border-radius: 4px; font-size: 14.5px; font-weight: 500;
		box-shadow: 0 4px 14px rgba(0,0,0,.15);
		opacity: 0; transform: translateY(-10px);
		transition: opacity .25s ease, transform .25s ease;
		pointer-events: none;
	}
	.toast-notify.error { background: var(--danger, #a13d3d); }
	.toast-notify.show { opacity: 1; transform: translateY(0); }
</style>
</head>
<body>
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
					<form id="addToCartForm" method="post" action="<c:url value='/cart/add'/>" style="display:contents;">
						<input type="hidden" name="productId" value="${product.id}">
						<input type="hidden" id="qtyHidden" name="quantity" value="1">
						<button type="submit" id="addToCartBtn" class="btn-cart" ${product.quantity <= 0 ? 'disabled' : ''}>Thêm vào giỏ hàng</button>
					</form>
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

	<div id="toast" class="toast-notify"></div>

	<script>
		var maxQty = ${product.quantity > 0 ? product.quantity : 0};
		function changeQty(delta) {
			var input = document.getElementById('qtyInput');
			var val = parseInt(input.value, 10) || 1;
			val += delta;
			if (val < 1) val = 1;
			if (maxQty > 0 && val > maxQty) val = maxQty;
			input.value = val;

			var qtyHidden = document.getElementById('qtyHidden');
			if (qtyHidden) {
				qtyHidden.value = val;
			}
		}

		var toastTimer = null;
		function showToast(message, isError) {
			var toast = document.getElementById('toast');
			toast.textContent = message;
			toast.classList.toggle('error', !!isError);
			toast.classList.add('show');
			clearTimeout(toastTimer);
			toastTimer = setTimeout(function () {
				toast.classList.remove('show');
			}, 2500);
		}

		var addToCartForm = document.getElementById('addToCartForm');
		if (addToCartForm) {
			addToCartForm.addEventListener('submit', function (e) {
				e.preventDefault();

				var btn = document.getElementById('addToCartBtn');
				var originalText = btn.textContent;
				btn.disabled = true;

				fetch(addToCartForm.action, {
					method: 'POST',
					headers: { 'X-Requested-With': 'XMLHttpRequest' },
					body: new URLSearchParams(new FormData(addToCartForm))
				})
					.then(function (res) { return res.json(); })
					.then(function (data) {
						showToast(data.message || 'Đã thêm sản phẩm vào giỏ hàng!', !data.success);

						if (data.success && typeof data.cartCount === 'number') {
							var badge = document.getElementById('cartCountBadge');
							if (badge) {
								badge.textContent = data.cartCount > 0 ? '(' + data.cartCount + ')' : '';
							}
						}
					})
					.catch(function () {
						showToast('Có lỗi xảy ra, vui lòng thử lại.', true);
					})
					.finally(function () {
						btn.disabled = (maxQty <= 0);
						btn.textContent = originalText;
					});
			});
		}
	</script>
</body>
</html>
