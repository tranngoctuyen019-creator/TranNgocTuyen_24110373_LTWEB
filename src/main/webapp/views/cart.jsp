<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Giỏ hàng</title>
<style>
	.page-wrap { max-width: 1020px; margin: 0 auto; padding: 40px 20px 60px; }
	.topbar { border-bottom: 1px solid var(--border); padding-bottom: 18px; margin-bottom: 26px; }
	.topbar h1 { font-size: 24px; font-weight: 600; margin: 0; }
	.topbar p { color: var(--muted); font-size: 13.5px; margin: 4px 0 0; }
	.empty-box { background: var(--surface); border: 1px solid var(--border); padding: 50px 30px; text-align: center; color: var(--muted); }
	.empty-box a { color: var(--accent); font-weight: 500; }
	.select-all-row { display:flex; align-items:center; justify-content:space-between; padding: 4px; margin-bottom: 14px; flex-wrap: wrap; gap: 10px; }
	.select-all-row label { display:flex; align-items:center; gap:8px; font-size:14.5px; color: var(--ink); margin:0; cursor:pointer; }
	.select-all-row input[type=checkbox] { width: 16px; height: 16px; cursor:pointer; }
	.cart-table { width:100%; border-collapse: collapse; background: var(--surface); border: 1px solid var(--border); }
	.cart-table th { text-align:left; font-size: 12px; text-transform: uppercase; letter-spacing:.03em; color: var(--muted); font-weight:600; padding: 14px 16px; border-bottom: 1px solid var(--border); }
	.cart-table td { padding: 16px; border-bottom: 1px solid #eee; vertical-align: middle; font-size: 14.5px; }
	.cart-table tr:last-child td { border-bottom: none; }
	.item-info { display:flex; align-items:center; gap:14px; text-decoration:none; color: inherit; }
	.item-info:hover .p-name { color: var(--accent); }
	.item-info img { width: 64px; height: 64px; object-fit: cover; border: 1px solid var(--border); flex: 0 0 auto; background:#fafafa; }
	.item-info .p-name { font-weight: 500; color: var(--ink); }
	.item-info .p-cate { font-size:12px; color: var(--muted); margin-top:3px; }
	.qty-form { display:flex; align-items:center; gap:8px; }
	.qty-form input[type=number] { width: 60px; border:1px solid var(--border); padding:6px 8px; font-size:14px; text-align:center; }
	.subtotal { font-weight:600; color: var(--ink); white-space:nowrap; }
	.inline-form { display:inline; margin:0; }
	/* Align the row action buttons with the site theme instead of Bootstrap's default blue/red */
	.cart-table .btn { border-radius: 4px; font-weight: 500; box-shadow: none; }
	.cart-table .btn-sm { padding: 6px 14px; font-size: 13px; }
	.cart-table .btn-primary { background: transparent; border: 1px solid var(--accent); color: var(--accent); }
	.cart-table .btn-primary:hover,
	.cart-table .btn-primary:focus { background: var(--accent); border-color: var(--accent); color: #fff; }
	.cart-table .btn-danger { background: transparent; border: 1px solid var(--danger); color: var(--danger); }
	.cart-table .btn-danger:hover,
	.cart-table .btn-danger:focus { background: var(--danger); border-color: var(--danger); color: #fff; }
	.cart-summary { margin-top: 22px; background: var(--surface); border: 1px solid var(--border); padding: 20px 26px; display:flex; justify-content:flex-end; align-items:center; gap: 22px; flex-wrap: wrap; }
	.cart-summary .total-label { color: var(--muted); font-size:14px; }
	.cart-summary .total-value { font-size: 22px; font-weight: 600; color: var(--ink); }
	.cart-actions { margin-top: 22px; display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:12px; }
	.back-link { color: var(--muted); font-size: 13.5px; }
	.back-link:hover { color: var(--ink); }
	.btn-clear { background:#fff; border:1px solid var(--danger); color: var(--danger); padding: 9px 18px; font-size: 13.5px; cursor:pointer; }
	.btn-clear:hover { background: var(--danger); color:#fff; }
	.btn-checkout { background: var(--accent); color:#fff; border:none; padding: 13px 30px; font-size: 15px; font-weight:500; cursor:pointer; }
	.btn-checkout:hover { background: var(--accent-dark); }
	@media (max-width: 700px) {
		.cart-table thead { display:none; }
		.cart-table, .cart-table tbody, .cart-table tr, .cart-table td { display:block; width:100%; box-sizing: border-box; }
		.cart-table tr { border-bottom: 6px solid #f6f6f4; padding: 10px 0; }
		.cart-table td { border:none; padding: 6px 16px; }
	}
</style>
</head>
<body>
	<div class="page-wrap">
		<div class="topbar">
			<h1>Giỏ hàng của bạn</h1>
			<c:choose>
				<c:when test="${itemCount == 0}">
					<p>Chưa có sản phẩm nào</p>
				</c:when>
				<c:otherwise>
					<p>${itemCount} sản phẩm trong giỏ hàng</p>
				</c:otherwise>
			</c:choose>
		</div>

		<c:choose>
			<c:when test="${itemCount == 0}">
				<div class="empty-box">
					Giỏ hàng của bạn đang trống.<br><br>
					<a href="<c:url value='/product'/>">Tiếp tục mua sắm &rarr;</a>
				</div>
			</c:when>
			<c:otherwise>

				<div class="select-all-row">
					<form method="post" action="<c:url value='/cart/select'/>" class="inline-form">
						<input type="hidden" name="all" value="${allSelected ? 'false' : 'true'}">
						<label>
							<input type="checkbox" ${allSelected ? 'checked' : ''} onchange="this.form.submit()">
							Chọn tất cả
						</label>
					</form>

					<form method="post" action="<c:url value='/cart/clear'/>" class="inline-form"
						onsubmit="return confirm('Bạn có chắc chắn muốn xóa toàn bộ giỏ hàng?');">
						<button type="submit" class="btn-clear">Xóa giỏ hàng</button>
					</form>
				</div>

				<table class="cart-table">
					<thead>
						<tr>
							<th style="width:36px;"></th>
							<th>Sản phẩm</th>
							<th>Đơn giá</th>
							<th>Số lượng</th>
							<th>Thành tiền</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${cart.items}" var="item">
							<tr>
								<td>
									<form method="post" action="<c:url value='/cart/select'/>" class="inline-form">
										<input type="hidden" name="itemId" value="${item.id}">
										<input type="hidden" name="selected" value="${item.selected ? 'false' : 'true'}">
										<input type="checkbox" ${item.selected ? 'checked' : ''} onchange="this.form.submit()">
									</form>
								</td>
								<td>
									<a class="item-info" href="<c:url value='/product/detail?id=${item.product.id}'/>">
										<c:url value="/image?fname=${item.product.image}" var="imgUrl"/>
										<img src="${imgUrl}" alt="${item.product.name}" onerror="this.src='https://placehold.co/64x64?text=No+Image'">
										<div>
											<div class="p-name">${item.product.name}</div>
											<div class="p-cate">${item.product.category.name}</div>
										</div>
									</a>
								</td>
								<td><fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/> đ</td>
								<td>
									<form method="post" action="<c:url value='/cart/update'/>" class="qty-form">
										<input type="hidden" name="itemId" value="${item.id}">
										<input type="number" name="quantity" min="1" max="${item.product.quantity}" value="${item.quantity}">
										<button type="submit" class="btn btn-primary btn-sm">Cập nhật</button>
									</form>
								</td>
								<td class="subtotal"><fmt:formatNumber value="${item.subtotal}" type="number" groupingUsed="true"/> đ</td>
								<td>
									<form method="post" action="<c:url value='/cart/remove'/>" class="inline-form"
										onsubmit="return confirm('Xóa sản phẩm này khỏi giỏ hàng?');">
										<input type="hidden" name="itemId" value="${item.id}">
										<button type="submit" class="btn btn-danger btn-sm">Xóa</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<div class="cart-summary">
					<span class="total-label">Tổng tiền (sản phẩm đã chọn):</span>
					<span class="total-value"><fmt:formatNumber value="${cartTotal}" type="number" groupingUsed="true"/> đ</span>
				</div>

				<div class="cart-actions">
					<a class="back-link" href="<c:url value='/product'/>">&larr; Tiếp tục mua hàng</a>
					<button type="button" class="btn-checkout" onclick="alert('Chức năng thanh toán đang được phát triển.');">Thanh toán</button>
				</div>

			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>
