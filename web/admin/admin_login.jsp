<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员登录</title>
</head>
<body>
<h2>管理员登录</h2>
<form method="post" action="${pageContext.request.contextPath}/admin/UserController?action=login">
    用户名：<input type="text" name="username" required><br>
    密码：<input type="password" name="password" required><br>
    <button type="submit">登录</button>
</form>

<% if (request.getAttribute("error") != null) { %>
<div style="color: red;"><%= request.getAttribute("error") %></div>
<% } %>
</body>
</html>
