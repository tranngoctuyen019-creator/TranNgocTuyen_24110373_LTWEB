<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title>
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
        .bottom-link { text-align: center; margin-top: 18px; font-size: 13.5px; }
        .bottom-link a { color: var(--ink); font-weight: 500; }
    </style>
</head>
<body>
    <div class="page-wrap">
        <div class="page-header">
            <h1>Quên mật khẩu</h1>
            <p>Nhập email để nhận mã OTP đặt lại mật khẩu</p>
        </div>

        <div class="form-card">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="<c:url value='/forgot-password'/>" method="post">
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" class="form-control" name="email" value="${email}" required>
                </div>
                <button type="submit" class="btn btn-success">Gửi mã OTP</button>
            </form>

            <div class="bottom-link">
                <a href="<c:url value='/login'/>">Quay lại đăng nhập</a>
            </div>
        </div>
    </div>
</body>
</html>
