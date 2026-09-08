<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><sitemesh:write property="title"/> | Quản trị - Ngọc Tuyên Shop</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
	:root { --ink: #1c1c1c; --muted: #6b6b6b; --border: #dcdcdc; --surface: #ffffff; --accent: #2f5d50; --accent-dark: #24463c; --danger: #a13d3d; }
	* { box-sizing: border-box; }
	body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; background: #f6f6f4; color: var(--ink); margin: 0; }
	.admin-layout { min-height: 100vh; }
	.admin-main { min-width: 0; }
	.admin-topbar { background: #fff; border-bottom: 1px solid var(--border); padding: 14px 26px; display: flex; justify-content: space-between; align-items: center; }
	.admin-topbar-title { font-weight: 600; font-size: 15px; color: var(--muted); }
	.admin-topbar-user { color: var(--ink) !important; font-size: 13.5px; text-decoration: none; }
	.admin-content { padding: 30px 26px 50px; }
	.admin-footer { padding: 16px 26px; color: var(--muted); font-size: 12.5px; border-top: 1px solid var(--border); }
</style>

<sitemesh:write property="head"/>

</head>
<body>
	<div class="admin-layout">
		<div class="admin-main">
			<%@ include file="/commons/admin/header.jsp"%>
			<div class="admin-content">
				<sitemesh:write property="body"/>
			</div>
			<%@ include file="/commons/admin/footer.jsp"%>
		</div>
	</div>
</body>
</html>
