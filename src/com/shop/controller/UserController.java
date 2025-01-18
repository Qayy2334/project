package com.shop.controller;

import com.shop.dao.UserDAO;
import com.shop.dao.CartDAO;
import com.shop.model.CartItem;
import com.shop.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/UserController")
public class UserController extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            handleRegister(request, response);
        } else if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("addToCart".equals(action)) {
            handleAddToCart(request, response);
        }
    }

    // 注册处理
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "两次密码输入不一致！");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);

        boolean success = userDAO.registerUser(user);
        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "注册失败，请重试！");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    // 用户登录处理
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.loginUser(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user.getUsername());
            session.setAttribute("role", user.getRole());

            if ("admin".equals(user.getRole())) {
                System.out.println("管理员登录成功，跳转到后台");
                response.sendRedirect(request.getContextPath() + "/admin/admin_dashboard.jsp");  // 管理员跳后台
            } else {
                System.out.println("普通用户登录成功，跳转到首页");
                response.sendRedirect(request.getContextPath() + "/index.jsp");  // 普通用户跳首页
            }
        } else {
            request.setAttribute("error", "用户名或密码错误！");
            request.getRequestDispatcher("admin_login.jsp").forward(request, response);
        }
    }
    // 加入购物车处理
    private void handleAddToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        int productId = Integer.parseInt(request.getParameter("productId"));

        CartItem cartItem = new CartItem();
        cartItem.setUserId(userId);
        cartItem.setProductId(productId);
        cartItem.setQuantity(1);

        boolean success = cartDAO.addToCart(cartItem);
        if (success) {
            request.setAttribute("success", "商品已成功加入购物车！");
        } else {
            request.setAttribute("error", "加入购物车失败，请重试！");
        }
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
