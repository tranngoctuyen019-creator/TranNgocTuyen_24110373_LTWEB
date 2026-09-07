<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kiểm tra tải và hiển thị ảnh</title>
    <style>
        :root { --ink: #1c1c1c; --muted: #6b6b6b; --border: #dcdcdc; --surface: #ffffff; --accent: #2f5d50; --accent-dark: #24463c; }
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; background: #f6f6f4; color: var(--ink); }
        .page-wrap { max-width: 720px; margin: 0 auto; padding: 40px 20px 60px; }
        .topbar { border-bottom: 1px solid var(--border); padding-bottom: 18px; margin-bottom: 24px; }
        .topbar h1 { font-size: 20px; font-weight: 600; margin: 0; }
        .topbar p { color: var(--muted); font-size: 13.5px; margin: 4px 0 0; }
        .search-card { background: var(--surface); border: 1px solid var(--border); padding: 18px 22px; margin-bottom: 22px; }
        .search-card label { font-weight: 500; color: var(--ink); font-size: 13.5px; margin-right: 10px; }
        .search-card .form-control { border: 1px solid var(--border); border-radius: 4px; padding: 8px 12px; font-size: 14px; box-shadow: none; }
        .btn { border-radius: 4px; font-weight: 500; padding: 9px 20px; border: 1px solid transparent; font-size: 14px; }
        .btn-primary { background: var(--accent); color: #fff; }
        .btn-primary:hover { background: var(--accent-dark); color: #fff; }
        .btn-default { background: #fff; color: var(--muted); border-color: var(--border); }
        .btn-default:hover { background: #f2f2f2; color: var(--ink); text-decoration: none; }
        .result-card { background: var(--surface); border: 1px solid var(--border); }
        .result-heading { background: #fafafa; color: var(--ink); font-weight: 500; font-size: 14px; padding: 12px 18px; border-bottom: 1px solid var(--border); }
        .result-body { padding: 24px; }
        .result-body img { border: 1px solid var(--border); }
        .back-link { margin-top: 22px; display: inline-block; }
    </style>
</head>
<body>
    <div class="page-wrap">

        <div class="topbar">
            <h1>Kiểm tra tải và hiển thị ảnh</h1>
            <p>Test hiển thị ảnh từ Controller /image</p>
        </div>

        <!-- Form nhập tên file ảnh để test -->
        <div class="search-card">
            <form action="download.jsp" method="get" class="form-inline">
                <div class="form-group" style="width:100%; display:flex; gap:10px; flex-wrap:wrap; align-items:center;">
                    <label style="margin-bottom:0;">Tên file:</label>
                    <input type="text" name="fname" class="form-control" value="${param.fname}" placeholder="vd: category/abc.png" style="flex:1; min-width:220px;" />
                    <button type="submit" class="btn btn-primary">Xem ảnh</button>
                </div>
            </form>
        </div>

        <c:if test="${not empty param.fname}">
            <div class="result-card">
                <div class="result-heading">Kết quả hiển thị cho file: ${param.fname}</div>
                <div class="result-body text-center">
                    <c:url value="/image" var="imgUrl">
                        <c:param name="fname" value="${param.fname}" />
                    </c:url>

                    <img src="${imgUrl}" class="img-responsive" alt="Uploaded Image" style="max-height: 400px; margin: 0 auto;"
                         onerror="this.onerror=null; this.src='https://via.placeholder.com/300x200?text=Khong+Tim+Thay+Anh';" />
                </div>
            </div>
        </c:if>

        <a href="<c:url value='/admin/category/list'/>" class="btn btn-default back-link">Quay lại quản lý danh mục</a>
    </div>
</body>
</html>
