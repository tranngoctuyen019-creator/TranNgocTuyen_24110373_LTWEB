<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm danh mục mới</title>
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
            max-width: 650px;
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

        .page-header::after {
            content: "";
            position: absolute;
            width: 90px;
            height: 90px;
            background: rgba(255,255,255,0.12);
            border-radius: 50%;
            bottom: -45px;
            right: 70px;
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

        .form-card {
            background: #fff;
            border-radius: 20px;
            padding: 30px 32px;
            box-shadow: 0 10px 35px rgba(92, 189, 140, 0.18);
        }

        .form-group label {
            font-weight: 600;
            color: var(--mint-700);
            font-size: 13.5px;
            text-transform: uppercase;
            letter-spacing: 0.4px;
            margin-bottom: 8px;
        }

        .form-control {
            border: 1.5px solid var(--mint-200);
            border-radius: 12px;
            padding: 10px 14px;
            font-size: 14px;
            box-shadow: none;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            border-color: var(--mint-500);
            box-shadow: 0 0 0 3px rgba(92, 189, 140, 0.2);
        }

        .form-control::placeholder {
            color: #b9c9c0;
        }

        .upload-hint {
            background: var(--mint-50);
            border: 1.5px dashed var(--mint-300);
            border-radius: 16px;
            padding: 16px;
            text-align: center;
            color: var(--mint-600);
            font-size: 13px;
            margin-bottom: 10px;
        }

        hr.divider {
            border: none;
            border-top: 1px solid var(--mint-100);
            margin: 22px 0;
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

        .btn-success {
            background: linear-gradient(120deg, var(--mint-500), var(--mint-600));
            color: #fff;
        }
        .btn-success:hover {
            background: linear-gradient(120deg, var(--mint-600), var(--mint-700));
            color: #fff;
        }

        .btn-primary {
            background: var(--mint-200);
            color: var(--mint-700);
        }
        .btn-primary:hover {
            background: var(--mint-300);
            color: var(--mint-700);
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

        .btn-group-actions {
            margin-top: 24px;
        }
    </style>
</head>
<body>
    <div class="page-wrap">

        <div class="page-header">
            <h2>🌱 Thêm danh mục mới</h2>
            <p>Tạo một danh mục sản phẩm mới cho hệ thống</p>
        </div>

        <div class="form-card">
            <form role="form" action="add" method="post" enctype="multipart/form-data">

                <div class="form-group">
                    <label>Tên danh mục</label>
                    <input type="text" class="form-control" placeholder="Nhập tên danh mục" name="name" required />
                </div>

                <hr class="divider">

                <div class="form-group">
                    <label>Ảnh đại diện</label>
                    <div class="upload-hint">
                        📷 Chọn hình ảnh đại diện cho danh mục (JPG, PNG...)
                    </div>
                    <input type="file" name="icon" class="form-control" />
                </div>

                <div class="btn-group-actions">
                    <button type="submit" class="btn btn-success">Thêm</button>
                    <button type="reset" class="btn btn-primary">Hủy</button>
                    <a href="<c:url value='/admin/category/list'/>" class="btn btn-default">Quay lại danh sách</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>