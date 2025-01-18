<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>电商商城首页</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
    }
    .header {
      background-color: #333;
      color: white;
      padding: 10px;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .header a {
      color: white;
      margin: 0 10px;
      text-decoration: none;
    }
    .content-container {
      width: 80%;
      margin: 20px auto;
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      display: flex;
    }
    .sidebar {
      width: 20%;
      padding: 20px;
      border-right: 1px solid #ddd;
    }
    .sidebar h3 {
      margin-top: 0;
    }
    .sidebar ul {
      list-style: none;
      padding: 0;
    }
    .sidebar ul li {
      margin: 10px 0;
    }
    .sidebar ul li a {
      text-decoration: none;
      color: #333;
    }
    .product-list {
      width: 80%;
      display: flex;
      flex-wrap: wrap;
      justify-content: flex-start;
      padding-left: 20px;
    }
    .product-item {
      background-color: white;
      border: 1px solid #ddd;
      margin: 10px;
      padding: 10px;
      width: 200px;
      text-align: center;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    .product-item img {
      width: 100%;
      height: 150px;
      object-fit: cover;
    }
  </style>
</head>
<body>
<div class="header">
  <div>
    <a href="index.jsp">首页</a>
    <a href="cart.jsp">购物车</a>
    <a href="admin/admin_login.jsp">管理员登录</a>
  </div>
  <div>
    <% if (session != null && session.getAttribute("user") != null) { %>
    <span>欢迎，<%= session.getAttribute("user") %>！</span>
    <a href="logout.jsp">退出登录</a>
    <% } else { %>
    <a href="login.jsp">登录</a> |
    <a href="register.jsp">注册</a>
    <% } %>
  </div>
</div>

<div class="content-container">
  <div class="sidebar">
    <h3>商品分类</h3>
    <ul>
      <li><a href="#">电子产品</a></li>
      <li><a href="#">服装鞋帽</a></li>
      <li><a href="#">家用电器</a></li>
      <li><a href="#">图书音像</a></li>
    </ul>
  </div>

  <div class="product-item">
    <img src="images/product1.jpg" alt="商品1">
    <h3>商品1</h3>
    <p>价格：￥99.00</p>
    <form method="post" action="UserController?action=addToCart">
      <input type="hidden" name="productId" value="1">
      <button type="submit">加入购物车</button>
    </form>
  </div>

  <div class="product-item">
    <img src="images/product2.jpg" alt="商品2">
    <h3>商品2</h3>
    <p>价格：￥199.00</p>
    <form method="post" action="UserController?action=addToCart">
      <input type="hidden" name="productId" value="2">
      <button type="submit">加入购物车</button>
    </form>
  </div>

</div>
</body>
</html>