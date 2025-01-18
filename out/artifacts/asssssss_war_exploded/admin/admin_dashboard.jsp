<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>管理员后台</title>
</head>
<body>

<%
  if (session == null || !"admin".equals(session.getAttribute("role"))) {
    response.sendRedirect("../admin_login.jsp");
    return;
  }
%>

<h1>欢迎，管理员 <%= session.getAttribute("user") %>！</h1>
<a href="manage_products.jsp">商品管理</a><br>
<a href="manage_users.jsp">用户管理</a><br>
<a href="../logout.jsp">退出登录</a>

</body>
</html>
