<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><sitemesh:write property="title"/> | Ngọc Tuyên Shop</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style>
	
	:root { --ink: #1c1c1c; --muted: #6b6b6b; --border: #dcdcdc; --surface: #ffffff; --accent: #2f5d50; --accent-dark: #24463c; --danger: #a13d3d; }
	body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; background: #f6f6f4; color: var(--ink); margin: 0; }
	.navbar-custom { background: #fff; border-bottom: 1px solid var(--border); border-radius: 0; box-shadow: none; margin-bottom: 0; }
	.navbar-custom .navbar-brand { color: var(--ink) !important; font-weight: 600; }
	.navbar-custom a { color: var(--muted) !important; font-weight: 400; }
	.navbar-custom a:hover, .navbar-custom li.active a { color: var(--ink) !important; }
	.nav-avatar-link { display: flex !important; align-items: center; gap: 8px; }
	.nav-avatar { width: 26px; height: 26px; border-radius: 50%; object-fit: cover; border: 1px solid var(--border); }
	.site-footer { border-top: 1px solid var(--border); background: #fff; margin-top: 50px; }
	.footer-inner { max-width: 1180px; margin: 0 auto; padding: 22px 20px; display: flex; justify-content: space-between; flex-wrap: wrap; gap: 6px; font-size: 13px; color: var(--muted); }
	.footer-muted { color: #9c9c9c; }
</style>

<sitemesh:write property="head"/>

</head>
<body>

	<%@ include file="/commons/web/header.jsp"%>

	<sitemesh:write property="body"/>

	<%@ include file="/commons/web/footer.jsp"%>

</body>
</html>
