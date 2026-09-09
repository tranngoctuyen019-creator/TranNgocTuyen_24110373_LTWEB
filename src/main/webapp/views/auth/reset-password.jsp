<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu</title>
    <style>
        :root { --ink: #1c1c1c; --muted: #6b6b6b; --border: #dcdcdc; --surface: #ffffff; --accent: #2f5d50; --accent-dark: #24463c; }
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; background: #f6f6f4; color: var(--ink); }
        .page-wrap { max-width: 480px; margin: 60px auto; padding: 0 20px; }
        .page-header { text-align: center; margin-bottom: 22px; }
        .page-header h1 { font-size: 26px; font-weight: 600; margin: 0; }
        .page-header p { color: var(--muted); margin: 6px 0 0; font-size: 15px; }
        .form-card { background: var(--surface); border: 1px solid var(--border); padding: 32px 34px; }
        .form-group label { font-weight: 500; color: var(--ink); font-size: 15px; margin-bottom: 7px; }
        .form-control { border: 1px solid var(--border); border-radius: 4px; padding: 11px 14px; font-size: 16px; }
        .btn { border-radius: 4px; font-weight: 500; padding: 12px 24px; border: none; width: 100%; font-size: 16px; }
        .btn-success { background: var(--accent); color: #fff; }
        .btn-success:hover { background: var(--accent-dark); color: #fff; }
        .alert { border-radius: 4px; }
        .bottom-link { text-align: center; margin-top: 18px; font-size: 14.5px; color: var(--muted); }
        .bottom-link a { color: var(--ink); font-weight: 500; }
    </style>
</head>
<body>
    <div class="page-wrap">
        <div class="page-header">
            <h1>Đặt lại mật khẩu</h1>
            <p>Nhập mã OTP đã gửi tới <b>${email}</b> và mật khẩu mới</p>
        </div>

        <div class="form-card">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form action="<c:url value='/reset-password'/>" method="post">
                <input type="hidden" name="email" value="${email}">
                <div class="form-group">
                    <label>Mã OTP</label>
                    <input type="text" class="form-control" name="otp" maxlength="6" required>
                </div>
                <div class="form-group">
                    <label>Mật khẩu mới</label>
                    <input type="password" class="form-control" name="newPassword" required>
                </div>
                <div class="form-group">
                    <label>Xác nhận mật khẩu</label>
                    <input type="password" class="form-control" name="confirmPassword" required>
                </div>
                <button type="submit" class="btn btn-success">Đặt lại mật khẩu</button>
            </form>

            <div class="bottom-link">
                <a href="<c:url value='/forgot-password'/>">Gửi lại OTP</a>
                &nbsp;|&nbsp;
                <a href="<c:url value='/login'/>">Đăng nhập</a>
            </div>
        </div>
    </div>
</body>
</html>
