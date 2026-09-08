<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hồ sơ cá nhân</title>
<style>
	.page-wrap { max-width: 640px; margin: 0 auto; padding: 40px 20px 60px; }
	.page-header { margin-bottom: 22px; }
	.page-header h1 { font-size: 22px; font-weight: 600; margin: 0; }
	.page-header p { color: var(--muted); margin: 6px 0 0; font-size: 13.5px; }
	.form-card { background: var(--surface); border: 1px solid var(--border); padding: 28px 30px; }
	.avatar-row { display: flex; align-items: center; gap: 20px; margin-bottom: 22px; }
	.avatar-preview { width: 84px; height: 84px; border-radius: 50%; object-fit: cover; border: 1px solid var(--border); background: #f2f2f2; }
	.avatar-pick label { display: inline-block; margin-top: 8px; font-size: 13px; color: var(--accent); cursor: pointer; }
	.form-group label { font-weight: 500; color: var(--ink); font-size: 13.5px; margin-bottom: 6px; }
	.form-control { border: 1px solid var(--border); border-radius: 4px; padding: 9px 12px; font-size: 14px; }
	.form-control[readonly] { background: #f6f6f4; color: var(--muted); }
	.btn { border-radius: 4px; font-weight: 500; padding: 10px 22px; border: none; font-size: 14px; }
	.btn-success { background: var(--accent); color: #fff; }
	.btn-success:hover { background: var(--accent-dark); color: #fff; }
	.alert { border-radius: 4px; }
</style>
</head>
<body>
	<div class="page-wrap">
		<div class="page-header">
			<h1>Hồ sơ cá nhân</h1>
			<p>Cập nhật họ tên, số điện thoại và ảnh đại diện của bạn</p>
		</div>

		<div class="form-card">
			<c:if test="${not empty error}">
				<div class="alert alert-danger">${error}</div>
			</c:if>
			<c:if test="${not empty message}">
				<div class="alert alert-success">${message}</div>
			</c:if>

			<form action="<c:url value='/profile'/>" method="post" enctype="multipart/form-data">

				<div class="avatar-row">
					<c:choose>
						<c:when test="${not empty account.avatar}">
							<c:url value="/image?fname=${account.avatar}" var="avatarUrl"/>
							<img class="avatar-preview" id="avatarPreview" src="${avatarUrl}" alt="avatar"
								onerror="this.src='https://placehold.co/84x84?text=%20'">
						</c:when>
						<c:otherwise>
							<img class="avatar-preview" id="avatarPreview" src="https://placehold.co/84x84?text=%20" alt="avatar">
						</c:otherwise>
					</c:choose>
					<div class="avatar-pick">
						<input type="file" name="avatar" id="avatarInput" accept="image/*" style="display:none"
							onchange="previewAvatar(this)">
						<label for="avatarInput">Đổi ảnh đại diện...</label>
					</div>
				</div>

				<div class="form-group">
					<label>Tên đăng nhập</label>
					<input type="text" class="form-control" value="${account.username}" readonly>
				</div>

				<div class="form-group">
					<label>Email</label>
					<input type="text" class="form-control" value="${account.email}" readonly>
				</div>

				<div class="form-group">
					<label>Họ và tên</label>
					<input type="text" class="form-control" name="fullName" value="${account.fullName}" required>
				</div>

				<div class="form-group">
					<label>Số điện thoại</label>
					<input type="text" class="form-control" name="phone" value="${account.phone}"
						pattern="^[0-9+ ]{8,15}$" placeholder="VD: 0908617108">
				</div>

				<button type="submit" class="btn btn-success" style="margin-top:8px;">Lưu thay đổi</button>
			</form>
		</div>
	</div>

	<script>
		function previewAvatar(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function (e) {
					document.getElementById('avatarPreview').src = e.target.result;
				};
				reader.readAsDataURL(input.files[0]);
			}
		}
	</script>
</body>
</html>
