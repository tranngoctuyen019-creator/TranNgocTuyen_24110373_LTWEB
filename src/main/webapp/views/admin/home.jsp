<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ quản trị</title>

    <style>
        :root {
            --ink: #1c1c1c;
            --muted: #6b6b6b;
            --border: #dcdcdc;
            --surface: #ffffff;
            --accent: #2f5d50;
            --accent-dark: #24463c;
        }

        .page-wrap {
            width: 100%;
            max-width: none;
            margin: 0;
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
            font-size: 22px;
            font-weight: 600;
            margin: 0;
        }

        .topbar p {
            margin: 4px 0 0;
            color: var(--muted);
            font-size: 14px;
        }

        .stat-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 18px;
            margin-bottom: 34px;
        }

        .stat-card {
            flex: 1 1 220px;
            background: var(--surface);
            border: 1px solid var(--border);
            padding: 22px 24px;
        }

        .stat-card .stat-label {
            font-size: 13px;
            color: var(--muted);
            margin-bottom: 8px;
        }

        .stat-card .stat-value {
            font-size: 28px;
            font-weight: 700;
            color: var(--ink);
        }

        .stat-card a.stat-link {
            display: inline-block;
            margin-top: 12px;
            font-size: 13.5px;
            color: var(--accent);
            text-decoration: none;
            font-weight: 500;
        }

        .stat-card a.stat-link:hover {
            color: var(--accent-dark);
            text-decoration: underline;
        }

        .section-title {
            font-weight: 600;
            font-size: 17px;
            color: var(--ink);
            margin: 0 0 16px;
            border-bottom: 1px solid var(--border);
            padding-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--surface);
        }

        th, td {
            padding: 11px 14px;
            border-bottom: 1px solid var(--border);
            text-align: left;
            font-size: 14px;
        }

        th {
            color: var(--muted);
            font-weight: 600;
            font-size: 12.5px;
            text-transform: uppercase;
            letter-spacing: .03em;
        }

        .thumb {
            object-fit: cover;
            border: 1px solid var(--border);
        }

        .empty-box {
            background: var(--surface);
            border: 1px solid var(--border);
            padding: 30px;
            text-align: center;
            color: var(--muted);
        }
    </style>
</head>

<body>
    <div class="page-wrap">

        <div class="topbar">
            <div>
                <h1>Xin chào, ${sessionScope.account.fullName}</h1>
                <p>Đây là trang chủ khu vực quản trị.</p>
            </div>
        </div>

        <div class="stat-grid">
            <div class="stat-card">
                <div class="stat-label">Tổng số danh mục</div>
                <div class="stat-value">${totalCategories}</div>
                <a class="stat-link" href="<c:url value='/admin/category/list'/>">Quản lý danh mục &rarr;</a>
            </div>
            <div class="stat-card">
                <div class="stat-label">Tổng số sản phẩm</div>
                <div class="stat-value">${totalProducts}</div>
                <a class="stat-link" href="<c:url value='/admin/product/list'/>">Quản lý sản phẩm &rarr;</a>
            </div>
        </div>

        <div class="section-title">Sản phẩm mới nhất</div>

        <c:choose>
            <c:when test="${not empty latestProducts}">
                <table>
                    <thead>
                        <tr>
                            <th>Ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Danh mục</th>
                            <th>Giá</th>
                            <th>SL</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${latestProducts}" var="p">
                            <tr>
                                <td>
                                    <c:url value="/image" var="imgUrl">
                                        <c:param name="fname" value="${p.image}" />
                                    </c:url>
                                    <img class="thumb" height="52" width="70" src="${imgUrl}" alt="Ảnh"
                                        onerror="this.src='https://placehold.co/70x52?text=No+Image'" />
                                </td>
                                <td>${p.name}</td>
                                <td>${p.category.name}</td>
                                <td><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" />đ</td>
                                <td>${p.quantity}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="empty-box">Chưa có sản phẩm nào.</div>
            </c:otherwise>
        </c:choose>

    </div>
</body>
</html>
