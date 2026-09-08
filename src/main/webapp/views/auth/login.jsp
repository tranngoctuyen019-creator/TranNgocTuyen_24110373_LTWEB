<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <style>
        :root { --ink: #1c1c1c; --muted: #6b6b6b; --border: #dcdcdc; --surface: #ffffff; --accent: #2f5d50; --accent-dark: #24463c; }
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; background: #f6f6f4; color: var(--ink); }
        .page-wrap { max-width: 400px; margin: 70px auto; padding: 0 20px; }
        .page-header { text-align: center; margin-bottom: 22px; }
        .page-header h1 { font-size: 22px; font-weight: 600; margin: 0; }
        .page-header p { color: var(--muted); margin: 6px 0 0; font-size: 13.5px; }
        .form-card { background: var(--surface); border: 1px solid var(--border); padding: 28px 30px; }
        .form-group label { font-weight: 500; color: var(--ink); font-size: 13.5px; margin-bottom: 6px; }
        .form-control { border: 1px solid var(--border); border-radius: 4px; padding: 9px 12px; font-size: 14px; }
        .btn { border-radius: 4px; font-weight: 500; padding: 10px 20px; border: none; width: 100%; font-size: 14px; }
        .btn-success { background: var(--accent); color: #fff; }
        .btn-success:hover { background: var(--accent-dark); color: #fff; }
        .alert { border-radius: 4px; }
        .bottom-link { text-align: center; margin-top: 16px; font-size: 13.5px; color: var(--muted); }
        .bottom-link a { color: var(--ink); font-weight: 500; }
        .link-row { display:flex; justify-content: space-between; font-size: 12.5px; margin: -6px 0 16px; }
        .link-row a { color: var(--muted); }
    </style>
</head>
<body>
    <div class="page-wrap">
        <div class="page-header">
            <h1>Đăng nhập</h1>
            <p>Đăng nhập để tiếp tục mua sắm</p>
        </div>

        <div class="form-card">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>

            <form action="<c:url value='/login'/>" method="post">
                <div class="form-group">
                    <label>Tên đăng nhập / Email</label>
                    <input type="text" class="form-control" name="username" value="${username}" required>
                </div>
                <div class="form-group">
                    <label>Mật khẩu</label>
                    <input type="password" class="form-control" name="password" required>
                </div>
                <div class="link-row">
                    <span></span>
                    <a href="<c:url value='/forgot-password'/>">Quên mật khẩu?</a>
                </div>
                <button type="submit" class="btn btn-success">Đăng nhập</button>
            </form>

            <div class="bottom-link">
                Chưa có tài khoản? <a href="<c:url value='/register'/>">Đăng ký ngay</a>
            </div>
        </div>
    </div>
</body>
</html>
