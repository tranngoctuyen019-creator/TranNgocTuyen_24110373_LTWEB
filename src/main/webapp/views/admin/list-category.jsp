<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục</title>

    <style>
        :root {
            --ink: #1c1c1c;
            --muted: #6b6b6b;
            --border: #dcdcdc;
            --surface: #ffffff;
            --accent: #2f5d50;
            --accent-dark: #24463c;
            --danger: #a13d3d;
            --info: #3d6a8a;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
                Roboto, Helvetica, Arial, sans-serif;
            background: #f6f6f4;
            color: var(--ink);
        }

        .page-wrap {
		    width: 100%;
		    max-width: none;
		    margin: 0;
		    padding: 48px 56px 72px;
		    box-sizing: border-box;
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
            font-size: 32px;
            font-weight: 600;
            margin: 0;
        }

        .topbar p {
            color: var(--muted);
            font-size: 17px;
            margin: 4px 0 0;
        }

        .topbar a.home-link {
            color: var(--muted);
            font-size: 15px;
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
            padding: 14px 28px;
            font-size: 19px;
            display: inline-block;
            margin-bottom: 22px;
            text-decoration: none;
        }

        .btn-add:hover {
            background: var(--accent-dark);
            color: #fff;
            text-decoration: none;
        }

        table {
            margin-bottom: 0 !important;
            background: var(--surface);
            width: 100%
        }

        .table > thead > tr > th {
            background: transparent;
            color: var(--muted);
            border-bottom: 1px solid var(--border) !important;
            border-top: none !important;
            font-weight: 600;
            font-size: 17px;
            padding: 18px 20px;
        }

        .table > tbody > tr > td {
            border-top: 1px solid #eee !important;
            vertical-align: middle !important;
            padding: 20px 18px;
            font-size: 18px;
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
            padding: 9px 18px;
            border: 1px solid transparent;
            font-size: 17px;
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

    <c:url value="/admin/product/list" var="productListUrl" />
    <c:url value="/home" var="homeUrl" />
    <c:url value="/admin/category/add" var="addCategoryUrl" />

    <div class="page-wrap">

        <div class="topbar">

            <div>
                <h1>Quản lý danh mục</h1>

                <p>
                    Danh sách các danh mục sản phẩm hiện có trong hệ thống
                </p>
            </div>
        </div>

        <a href="${addCategoryUrl}" class="btn-add">
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

                        <td>
                            ${STT.index + 1}
                        </td>

                        <td>

                            <c:url value="/image" var="imgUrl">

                                <c:param
                                    name="fname"
                                    value="${cate.icon}" />

                            </c:url>

                            <img
                                height="80"
                                width="110"
                                src="${imgUrl}"
                                alt="Icon"
                                onerror="this.src='https://placehold.co/80x60?text=No+Image'" />

                        </td>

                        <td class="cate-name">
                            ${cate.name}
                        </td>

                        <td>

                            <c:url
                                value="/views/admin/download.jsp"
                                var="downloadTestUrl">

                                <c:param
                                    name="fname"
                                    value="${cate.icon}" />

                            </c:url>

                            <a
                                href="${downloadTestUrl}"
                                class="btn btn-info btn-sm"
                                target="_blank">

                                Xem/Tải ảnh

                            </a>

                        </td>

                        <td>

                            <c:url
                                value="/admin/category/edit"
                                var="editUrl">

                                <c:param
                                    name="id"
                                    value="${cate.id}" />

                            </c:url>

                            <a
                                href="${editUrl}"
                                class="btn btn-primary btn-sm">

                                Sửa

                            </a>

                            <c:url
                                value="/admin/category/delete"
                                var="deleteUrl">

                                <c:param
                                    name="id"
                                    value="${cate.id}" />

                            </c:url>

                            <a
                                href="${deleteUrl}"
                                class="btn btn-danger btn-sm"
                                onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">

                                Xóa

                            </a>

                        </td>

                    </tr>

                </c:forEach>

                <c:if test="${empty cateList}">

                    <tr>

                        <td
                            colspan="5"
                            class="text-center empty-row">

                            Không có danh mục nào.

                        </td>

                    </tr>

                </c:if>

            </tbody>

        </table>

    </div>
 
</body>

</html>