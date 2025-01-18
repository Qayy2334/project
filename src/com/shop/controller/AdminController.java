package com.shop.controller;

import com.shop.dao.UserDAO;
import com.shop.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.loginUser(username, password);

        if (user != null && "admin".equals(user.getRole())) {  // 判断是否是管理员
            HttpSession session = request.getSession();
            session.setAttribute("admin", user.getUsername());
            response.sendRedirect("admin_dashboard.jsp");  // 管理员登录成功跳转
        } else {
            request.setAttribute("error", "管理员用户名或密码错误！");
            request.getRequestDispatcher("admin_login.jsp").forward(request, response);
        }
    }
}