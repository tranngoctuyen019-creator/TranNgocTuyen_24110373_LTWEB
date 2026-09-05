<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý danh mục</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
	:root {
		--mint-50: #f2faf6;
		--mint-100: #e3f6ec;
		--mint-200: #c9ecda;
		--mint-300: #a9e0c3;
		--mint-400: #7fd1a6;
		--mint-500: #5cbd8c;
		--mint-600: #479f73;
		--mint-700: #38805d;
		--ink: #2f4a3d;
	}

	body {
		font-family: 'Poppins', sans-serif;
		background: linear-gradient(160deg, var(--mint-50) 0%, #eef9f2 45%, #e6f5ec 100%);
		min-height: 100vh;
		color: var(--ink);
	}

	.page-wrap {
		max-width: 1100px;
		margin: 40px auto;
		padding: 0 20px;
	}

	.page-header {
		background: linear-gradient(120deg, var(--mint-400), var(--mint-500));
		border-radius: 22px;
		padding: 28px 32px;
		box-shadow: 0 10px 30px rgba(92, 189, 140, 0.35);
		position: relative;
		overflow: hidden;
		margin-bottom: 28px;
	}

	.page-header::before {
		content: "";
		position: absolute;
		width: 180px;
		height: 180px;
		background: rgba(255,255,255,0.15);
		border-radius: 50%;
		top: -80px;
		right: -60px;
	}

	.page-header::after {
		content: "";
		position: absolute;
		width: 100px;
		height: 100px;
		background: rgba(255,255,255,0.12);
		border-radius: 50%;
		bottom: -50px;
		right: 80px;
	}

	.page-header h2 {
		color: #fff;
		font-weight: 700;
		margin: 0;
		letter-spacing: 0.5px;
		position: relative;
		z-index: 1;
	}

	.page-header p {
		color: rgba(255,255,255,0.9);
		margin: 6px 0 0;
		font-size: 14px;
		position: relative;
		z-index: 1;
	}

	.btn-add {
		background: #ffffff;
		color: var(--mint-700);
		font-weight: 600;
		border: none;
		border-radius: 30px;
		padding: 10px 22px;
		box-shadow: 0 6px 16px rgba(0,0,0,0.12);
		transition: all 0.25s ease;
		display: inline-block;
		margin-bottom: 20px;
	}

	.btn-add:hover {
		background: var(--mint-600);
		color: #fff;
		text-decoration: none;
		transform: translateY(-2px);
		box-shadow: 0 10px 20px rgba(71, 159, 115, 0.35);
	}

	.table-card {
		background: #fff;
		border-radius: 20px;
		padding: 10px;
		box-shadow: 0 10px 35px rgba(92, 189, 140, 0.18);
		overflow: hidden;
	}

	table {
		margin-bottom: 0 !important;
		border-collapse: separate !important;
		border-spacing: 0;
	}

	.table > thead > tr > th {
		background: var(--mint-100);
		color: var(--mint-700);
		border: none !important;
		font-weight: 600;
		text-transform: uppercase;
		font-size: 12.5px;
		letter-spacing: 0.5px;
		padding: 14px 12px;
	}

	.table > tbody > tr > td {
		border-top: 1px solid var(--mint-100) !important;
		vertical-align: middle !important;
		padding: 12px;
		font-size: 14px;
	}

	.table-striped > tbody > tr:nth-of-type(odd) {
		background-color: var(--mint-50);
	}

	.table-hover > tbody > tr:hover {
		background-color: var(--mint-200) !important;
		transition: background-color 0.2s ease;
	}

	img[alt="Icon"] {
		border-radius: 10px;
		border: 2px solid var(--mint-200);
		object-fit: cover;
		box-shadow: 0 3px 8px rgba(0,0,0,0.08);
	}

	.cate-name {
		font-weight: 600;
		color: var(--ink);
	}

	.btn-sm {
		border-radius: 20px;
		font-weight: 500;
		padding: 5px 14px;
		border: none;
		transition: all 0.2s ease;
	}

	.btn-info {
		background: var(--mint-300);
		color: var(--mint-700);
	}
	.btn-info:hover {
		background: var(--mint-400);
		color: #fff;
	}

	.btn-primary {
		background: var(--mint-500);
	}
	.btn-primary:hover {
		background: var(--mint-600);
	}

	.btn-danger {
		background: #f6a8a8;
	}
	.btn-danger:hover {
		background: #ef7f7f;
	}

	.btn-sm:hover {
		transform: translateY(-1px);
		box-shadow: 0 4px 10px rgba(0,0,0,0.15);
		text-decoration: none;
	}

	.text-center.empty-row {
		padding: 30px !important;
		color: #8fa89a;
		font-style: italic;
	}
</style>
</head>
<body>
	<div class="page-wrap">

		<div class="page-header">
			<h2>🌿 Quản lý danh mục</h2>
			<p>Danh sách các danh mục sản phẩm hiện có trong hệ thống</p>
		</div>

		<a href="<c:url value='/admin/category/add'/>" class="btn-add">
			+ Thêm danh mục mới
		</a>

		<div class="table-card">
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>STT</th>
						<th>Hình ảnh</th>
						<th>Tên danh mục</th>
						<th>Thao tác ảnh</th>
						<th>Hành động</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cateList}" var="cate" varStatus="STT">
						<tr>
							<!-- Cột 1: STT -->
							<td>${STT.index + 1}</td>

							<!-- Cột 2: Hiển thị hình ảnh thu nhỏ -->
							<td>
								<c:url value="/image?fname=${cate.icon}" var="imgUrl"></c:url>
								<img height="60" width="80" src="${imgUrl}" alt="Icon"
									onerror="this.src='https://via.placeholder.com/80x60?text=No+Image'" />
							</td>

							<!-- Cột 3: Tên danh mục -->
							<td class="cate-name">${cate.name}</td>

							<!-- Cột 4: Thao tác xem/tải ảnh -->
							<td>
								<c:url value="/views/admin/download.jsp" var="downloadTestUrl">
									<c:param name="fname" value="${cate.icon}" />
								</c:url>
								<a href="${downloadTestUrl}" class="btn btn-info btn-sm" target="_blank">
									Xem/Tải ảnh
								</a>
							</td>

							<!-- Cột 5: Hành động Sửa / Xóa -->
							<td>
								<a href="<c:url value='/admin/category/edit?id=${cate.id}'/>"
									class="btn btn-primary btn-sm">Sửa</a>
								<a href="<c:url value='/admin/category/delete?id=${cate.id}'/>"
									class="btn btn-danger btn-sm"
									onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">Xóa</a>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty cateList}">
						<tr>
							<td colspan="5" class="text-center empty-row">Không có danh mục nào.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>