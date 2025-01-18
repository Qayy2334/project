<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.shop.util.DBUtil" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>购物车</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
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
        .content {
            padding: 20px;
            text-align: center;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        button {
            padding: 5px 10px;
            background-color: #f44336;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #d32f2f;
        }
        .error-message {
            color: red;
            font-weight: bold;
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

<div class="content">
    <h2>我的购物车</h2>

    <%-- 判断用户是否登录 --%>
    <% if (session == null || session.getAttribute("userId") == null) { %>
    <p class="error-message">请先 <a href="login.jsp">登录</a> 查看购物车。</p>
    <% } else { %>
    <table>
        <tr>
            <th>商品ID</th>
            <th>数量</th>
            <th>操作</th>
        </tr>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                conn = DBUtil.getConnection();
                ps = conn.prepareStatement("SELECT * FROM cart_items WHERE user_id = ?");
                ps.setInt(1, (Integer) session.getAttribute("userId"));
                rs = ps.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("product_id") %></td>
            <td><%= rs.getInt("quantity") %></td>
            <td>
                <form method="post" action="DeleteCartItemController">
                    <input type="hidden" name="productId" value="<%= rs.getInt("product_id") %>">
                    <button type="submit">删除</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<p class='error-message'>购物车加载失败，请稍后重试。</p>");
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        %>
    </table>
    <% } %>
</div>
</body>
</html>
