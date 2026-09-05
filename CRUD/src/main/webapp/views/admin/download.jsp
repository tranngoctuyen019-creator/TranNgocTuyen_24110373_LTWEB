<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kiểm tra tải và hiển thị ảnh</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
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
            max-width: 750px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .page-header {
            background: linear-gradient(120deg, var(--mint-400), var(--mint-500));
            border-radius: 22px;
            padding: 26px 30px;
            box-shadow: 0 10px 30px rgba(92, 189, 140, 0.35);
            position: relative;
            overflow: hidden;
            margin-bottom: 26px;
        }

        .page-header::before {
            content: "";
            position: absolute;
            width: 160px;
            height: 160px;
            background: rgba(255,255,255,0.15);
            border-radius: 50%;
            top: -70px;
            right: -50px;
        }

        .page-header h2 {
            color: #fff;
            font-weight: 700;
            margin: 0;
            font-size: 20px;
            letter-spacing: 0.4px;
            position: relative;
            z-index: 1;
        }

        .page-header p {
            color: rgba(255,255,255,0.9);
            margin: 6px 0 0;
            font-size: 13.5px;
            position: relative;
            z-index: 1;
        }

        .search-card {
            background: #fff;
            border-radius: 20px;
            padding: 22px 26px;
            box-shadow: 0 10px 30px rgba(92, 189, 140, 0.15);
            margin-bottom: 24px;
        }

        .search-card label {
            font-weight: 600;
            color: var(--mint-700);
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.4px;
            margin-right: 10px;
        }

        .search-card .form-control {
            border: 1.5px solid var(--mint-200);
            border-radius: 12px;
            padding: 9px 14px;
            font-size: 14px;
            box-shadow: none;
            transition: all 0.2s ease;
        }

        .search-card .form-control:focus {
            border-color: var(--mint-500);
            box-shadow: 0 0 0 3px rgba(92, 189, 140, 0.2);
        }

        .btn {
            border-radius: 24px;
            font-weight: 600;
            padding: 9px 22px;
            border: none;
            transition: all 0.25s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(0,0,0,0.15);
        }

        .btn-primary {
            background: linear-gradient(120deg, var(--mint-500), var(--mint-600));
            color: #fff;
        }
        .btn-primary:hover {
            background: linear-gradient(120deg, var(--mint-600), var(--mint-700));
            color: #fff;
        }

        .btn-default {
            background: #f4f4f4;
            color: #6b6b6b;
        }
        .btn-default:hover {
            background: #e8e8e8;
            color: #444;
            text-decoration: none;
        }

        .result-card {
            background: #fff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(92, 189, 140, 0.18);
            border: none;
        }

        .result-heading {
            background: var(--mint-100);
            color: var(--mint-700);
            font-weight: 600;
            font-size: 14px;
            padding: 14px 20px;
            border: none;
        }

        .result-heading b {
            color: var(--mint-700);
        }

        .result-body {
            padding: 26px;
        }

        .result-body img {
            border-radius: 14px;
            border: 3px solid var(--mint-200);
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
        }

        .back-link {
            margin-top: 24px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class="page-wrap">

        <div class="page-header">
            <h2>🖼️ Kiểm tra tải và hiển thị ảnh</h2>
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

        <!-- Hiển thị ảnh nếu có tham số fname truyền vào -->
        <c:if test="${not empty param.fname}">
            <div class="result-card">
                <div class="result-heading"><b>Kết quả hiển thị cho file:</b> ${param.fname}</div>
                <div class="result-body text-center">
                    <!-- Gọi trực tiếp đến Servlet DownloadImageController qua URL /image?fname=... -->
                    <c:url value="/image" var="imgUrl">
                        <c:param name="fname" value="${param.fname}" />
                    </c:url>

                    <img src="${imgUrl}" class="img-responsive img-thumbnail" alt="Uploaded Image" style="max-height: 400px; margin: 0 auto;"
                         onerror="this.onerror=null; this.src='https://via.placeholder.com/300x200?text=Khong+Tim+Thay+Anh';" />
                </div>
            </div>
        </c:if>

        <a href="<c:url value='/admin/category/list'/>" class="btn btn-default back-link">Quay lại quản lý danh mục</a>
    </div>
</body>
</html>