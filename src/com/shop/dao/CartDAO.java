package com.shop.dao;

import com.shop.model.CartItem;
import com.shop.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class CartDAO {

    // 添加商品到购物车
    public boolean addToCart(CartItem cartItem) {
        String sql = "INSERT INTO cart_items (user_id, product_id, quantity) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cartItem.getUserId());
            ps.setInt(2, cartItem.getProductId());
            ps.setInt(3, cartItem.getQuantity());

            // 打印 SQL 语句进行调试
            System.out.println("执行 SQL: " + sql + " 参数: " + cartItem.getUserId() + ", " + cartItem.getProductId() + ", " + cartItem.getQuantity());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();  // 打印异常
            return false;
        }
    }



    // 删除购物车商品
    public boolean removeFromCart(int userId, int productId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ? AND product_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
