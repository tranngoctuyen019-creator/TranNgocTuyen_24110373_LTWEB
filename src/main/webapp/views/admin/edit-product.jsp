<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Chỉnh sửa sản phẩm</title>

    <style>

        :root {
            --ink: #1c1c1c;
            --muted: #6b6b6b;
            --border: #dcdcdc;
            --surface: #ffffff;
            --accent: #2f5d50;
            --accent-dark: #24463c;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
                         Roboto, Helvetica, Arial, sans-serif;
            background: #f6f6f4;
            color: var(--ink);
        }

        .page-wrap {
            max-width: 860px;
            margin: 0 auto;
            padding: 46px 24px 70px;
        }

        .topbar {
            border-bottom: 1px solid var(--border);
            padding-bottom: 18px;
            margin-bottom: 26px;
        }

        .topbar h1 {
            font-size: 26px;
            font-weight: 600;
            margin: 0;
        }

        .topbar p {
            color: var(--muted);
            font-size: 15px;
            margin: 4px 0 0;
        }

        .form-card {
            background: var(--surface);
            border: 1px solid var(--border);
            padding: 32px 36px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            color: var(--ink);
            font-size: 15px;
            margin-bottom: 7px;
        }

        .form-control {
            display: block;
            width: 100%;
            height: 36px;
            box-sizing: border-box;

            border: 1px solid var(--border);
            border-radius: 4px;

            padding: 7px 14px;
            font-size: 16px;

            background: #fff;
            color: var(--ink);

            box-shadow: none;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: none;
        }

        select.form-control {
            cursor: pointer;
        }

        textarea.form-control {
            height: auto;
            min-height: 100px;
            resize: vertical;
            padding: 10px 14px;
            line-height: 1.5;
        }

        .current-image-box {
            width: 100%;
            border: 1px solid var(--border);
            padding: 14px;
            text-align: center;
            margin-bottom: 16px;
        }

        .current-image-box img {
            display: block;
            width: 120px;
            height: auto;
            margin: 0 auto;

            border: 1px solid var(--border);
            border-radius: 0;
        }

        .current-image-box .img-label {
            display: block;
            font-size: 14px;
            color: var(--muted);
            margin-bottom: 10px;
        }

        .form-group input[type="file"] {
            display: block;
            width: 100%;
            height: 36px;
            box-sizing: border-box;

            border: 1px solid var(--border);
            border-radius: 4px;

            padding: 5px 14px;
            font-size: 15px;

            background: #fff;
            color: var(--ink);
        }

        .form-group input[type="file"]:focus {
            outline: none;
            border-color: var(--accent);
        }

        hr.divider {
            border: none;
            border-top: 1px solid var(--border);
            margin: 22px 0;
        }

        .btn {
            display: inline-block;

            border-radius: 4px;
            font-weight: 500;

            padding: 11px 24px;

            border: 1px solid transparent;
            font-size: 15px;

            text-decoration: none;
            cursor: pointer;
            line-height: 1.2;
        }

        .btn-success {
            background: var(--accent);
            color: #fff;
        }

        .btn-success:hover {
            background: var(--accent-dark);
            color: #fff;
        }

        .btn-default {
            background: #fff;
            color: var(--muted);
            border-color: var(--border);
        }

        .btn-default:hover {
            background: #f2f2f2;
            color: var(--ink);
            text-decoration: none;
        }

        .btn-group-actions {
            margin-top: 22px;
        }

    </style>

</head>


<body>

    <div class="page-wrap">

        <div class="topbar">

            <h1>Chỉnh sửa sản phẩm</h1>

            <p>
                Cập nhật thông tin sản phẩm
            </p>

        </div>

        <div class="form-card">

            <c:url value="/admin/product/edit" var="editUrl" />

            <form
                role="form"
                action="${editUrl}"
                method="post"
                enctype="multipart/form-data">

                <input
                    type="hidden"
                    name="id"
                    value="${product.id}">

                <div class="form-group">

                    <label>
                        Tên sản phẩm
                    </label>

                    <input
                        type="text"
                        class="form-control"
                        name="name"
                        value="${product.name}"
                        required />

                </div>

                <div class="form-group">

                    <label>
                        Danh mục
                    </label>

                    <select
                        class="form-control"
                        name="cateId"
                        required>

                        <c:forEach
                            items="${cateList}"
                            var="c">

                            <option
                                value="${c.id}"
                                ${c.id == product.category.id ? 'selected' : ''}>

                                ${c.name}

                            </option>

                        </c:forEach>

                    </select>

                </div>

                <div class="form-group">

                    <label>
                        Giá (VNĐ)
                    </label>

                    <input
                        type="number"
                        step="0.01"
                        min="0"
                        class="form-control"
                        name="price"
                        value="${product.price}"
                        required />

                </div>

                <div class="form-group">

                    <label>
                        Số lượng
                    </label>

                    <input
                        type="number"
                        min="0"
                        class="form-control"
                        name="quantity"
                        value="${product.quantity}"
                        required />

                </div>
                
                <div class="form-group">

                    <label>
                        Mô tả
                    </label>

                    <textarea
                        class="form-control"
                        name="description"
                        rows="4">${product.description}</textarea>

                </div>

                <div class="form-group">

                    <label>
                        Hình ảnh
                    </label>

                    <div class="current-image-box">

                        <span class="img-label">
                            Ảnh hiện tại
                        </span>

                        <c:url
                            value="/image?fname=${product.image}"
                            var="imgUrl" />

                        <img
                            src="${imgUrl}"
                            alt="Ảnh hiện tại"
                            onerror="this.src='https://via.placeholder.com/120x100?text=No+Image'">

                    </div>

                    <label>
                        Chọn ảnh mới (nếu muốn thay đổi)
                    </label>

                    <input
                        type="file"
                        name="image"
                        class="form-control" />

                </div>

                <div class="btn-group-actions">

                    <button
                        type="submit"
                        class="btn btn-success">
                        Cập nhật
                    </button>

                    <a
                        href="<c:url value='/admin/product/list'/>"
                        class="btn btn-default">
                        Quay lại danh sách
                    </a>

                </div>

            </form>

        </div>

    </div>

</body>

</html>