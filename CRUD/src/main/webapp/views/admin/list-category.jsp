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
<style>
	:root { --ink: #1c1c1c; --muted: #6b6b6b; --border: #dcdcdc; --surface: #ffffff; --accent: #2f5d50; --accent-dark: #24463c; --danger: #a13d3d; --info: #3d6a8a; }

	body {
		font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
		background: #f6f6f4;
		color: var(--ink);
	}

	.page-wrap {
		max-width: 1000px;
		margin: 0 auto;
		padding: 40px 20px 60px;
	}

	.topbar {
		display: flex;
		justify-content: space-between;
		align-items: flex-end;
		border-bottom: 1px solid var(--border);
		padding-bottom: 18px;
		margin-bottom: 26px;
	}

	.topbar h1 {
		font-size: 22px;
		font-weight: 600;
		margin: 0;
	}

	.topbar p {
		color: var(--muted);
		font-size: 13.5px;
		margin: 4px 0 0;
	}

	.topbar a.home-link {
		color: var(--muted);
		font-size: 13.5px;
		text-decoration: none;
		border-bottom: 1px solid transparent;
	}
	.topbar a.home-link:hover {
		color: var(--ink);
		border-bottom-color: var(--ink);
	}

	.btn-add {
		background: var(--accent);
		color: #fff;
		font-weight: 500;
		border: none;
		border-radius: 4px;
		padding: 9px 18px;
		font-size: 14px;
		display: inline-block;
		margin-bottom: 22px;
	}

	.btn-add:hover {
		background: var(--accent-dark);
		color: #fff;
		text-decoration: none;
	}

	table {
		margin-bottom: 0 !important;
		background: var(--surface);
	}

	.table > thead > tr > th {
		background: transparent;
		color: var(--muted);
		border-bottom: 1px solid var(--border) !important;
		border-top: none !important;
		font-weight: 600;
		font-size: 12.5px;
		padding: 10px 12px;
	}

	.table > tbody > tr > td {
		border-top: 1px solid #eee !important;
		vertical-align: middle !important;
		padding: 12px;
		font-size: 14px;
	}

	img[alt="Icon"] {
		border-radius: 2px;
		border: 1px solid var(--border);
		object-fit: cover;
	}

	.cate-name {
		font-weight: 500;
		color: var(--ink);
	}

	.btn-sm {
		border-radius: 4px;
		font-weight: 500;
		padding: 5px 12px;
		border: 1px solid transparent;
		font-size: 13px;
	}

	.btn-info {
		background: transparent;
		color: var(--info);
		border-color: var(--info);
	}
	.btn-info:hover {
		background: var(--info);
		color: #fff;
	}

	.btn-primary {
		background: transparent;
		color: var(--accent);
		border-color: var(--accent);
	}
	.btn-primary:hover {
		background: var(--accent);
		color: #fff;
	}

	.btn-danger {
		background: transparent;
		color: var(--danger);
		border-color: var(--danger);
	}
	.btn-danger:hover {
		background: var(--danger);
		color: #fff;
	}

	.empty-row {
		padding: 30px !important;
		color: var(--muted);
	}
</style>
</head>
<body>
	<div class="page-wrap">

		<div class="topbar">
			<div>
				<h1>Quản lý danh mục</h1>
				<p>Danh sách các danh mục sản phẩm hiện có trong hệ thống</p>
			</div>
			<a href="<c:url value='/home'/>" class="home-link">Về trang chủ</a>
		</div>

		<a href="<c:url value='/admin/category/add'/>" class="btn-add">
			Thêm danh mục mới
		</a>

		<table class="table table-hover">
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
						<td>${STT.index + 1}</td>

						<td>
							<c:url value="/image?fname=${cate.icon}" var="imgUrl"></c:url>
							<img height="56" width="76" src="${imgUrl}" alt="Icon"
								onerror="this.src='https://placehold.co/80x60?text=No+Image'" />
						</td>

						<td class="cate-name">${cate.name}</td>

						<td>
							<c:url value="/views/admin/download.jsp" var="downloadTestUrl">
								<c:param name="fname" value="${cate.icon}" />
							</c:url>
							<a href="${downloadTestUrl}" class="btn btn-info btn-sm" target="_blank">
								Xem/Tải ảnh
							</a>
						</td>

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
</body>
</html>
