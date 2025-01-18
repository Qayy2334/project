package com.shop.controller;

import com.shop.dao.CartDAO;
import com.shop.model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/CartController")
public class CartController extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // 未登录跳转到登录页面
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int userId = (Integer) session.getAttribute("userId");
            int productId = Integer.parseInt(request.getParameter("productId"));

            CartItem cartItem = new CartItem();
            cartItem.setUserId(userId);
            cartItem.setProductId(productId);
            cartItem.setQuantity(1);

            boolean success = cartDAO.addToCart(cartItem);
            if (success) {
                response.sendRedirect("cart.jsp");  // 加入购物车成功后跳转购物车页面
            } else {
                response.sendRedirect("index.jsp?error=加入购物车失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=服务器异常");
        }
    }
}
