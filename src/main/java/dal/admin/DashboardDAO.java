package dal.admin;

import dal.DBContext;
import model.Order;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DashboardDAO extends DBContext {

    // Đếm đơn hàng theo trạng thái cụ thể
    public int countOrdersByStatus(int statusId) {
        String sql = "SELECT COUNT(*) FROM tb_Order WHERE OrderStatusId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, statusId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("DashboardDAO countOrdersByStatus: " + e);
        }
        return 0;
    }

    // Lấy danh sách đơn hàng mới nhất
    public List<Order> getRecentOrders(int top) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT TOP (?) o.*, os.Name AS OrderStatusName " +
                     "FROM tb_Order o " +
                     "JOIN tb_OrderStatus os ON o.OrderStatusId = os.OrderStatusId " +
                     "ORDER BY o.CreatedDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, top);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderId"));
                order.setCode(rs.getString("Code"));
                order.setCustomerName(rs.getString("CustomerName"));
                order.setPhone(rs.getString("Phone"));
                order.setTotalAmount(rs.getInt("TotalAmount"));
                order.setQuanlity(rs.getInt("Quanlity"));
                order.setOrderStatusId(rs.getInt("OrderStatusId"));
                order.setStatusName(rs.getString("OrderStatusName"));
                order.setCreatedDate(rs.getTimestamp("CreatedDate"));
                list.add(order);
            }
        } catch (SQLException e) {
            System.out.println("DashboardDAO getRecentOrders: " + e);
        }
        return list;
    }

    public List<Double> getMonthlyRevenue(int year) {
        List<Double> list = new ArrayList<>();
        // Initialize list with 0.0 for 12 months
        for (int i = 0; i < 12; i++) {
            list.add(0.0);
        }
        
        String sql = "SELECT MONTH(CreatedDate) as Month, SUM(TotalAmount) as Total " +
                     "FROM tb_Order WHERE YEAR(CreatedDate) = ? GROUP BY MONTH(CreatedDate)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, year);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int month = rs.getInt("Month");
                double total = rs.getDouble("Total");
                if (month >= 1 && month <= 12) {
                    list.set(month - 1, total); // month 1 maps to index 0
                }
            }
        } catch (SQLException e) {
            System.out.println("DashboardDAO getMonthlyRevenue: " + e);
        }
        return list;
    }

    public Map<String, Integer> getOrderStatusCounts() {
        Map<String, Integer> map = new HashMap<>();
        String sql = "SELECT os.Name, COUNT(o.OrderId) as Count " +
                     "FROM tb_OrderStatus os " +
                     "LEFT JOIN tb_Order o ON os.OrderStatusId = o.OrderStatusId " +
                     "GROUP BY os.Name";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                map.put(rs.getString("Name"), rs.getInt("Count"));
            }
        } catch (SQLException e) {
            System.out.println("DashboardDAO getOrderStatusCounts: " + e);
        }
        return map;
    }

    public int countTours() {
        String sql = "SELECT COUNT(*) FROM tb_Tour WHERE IsActive = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("DashboardDAO countTours: " + e);
        }
        return 0;
    }

    public int countBlogs() {
        String sql = "SELECT COUNT(*) FROM tb_Blog WHERE IsActive = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("DashboardDAO countBlogs: " + e);
        }
        return 0;
    }

    public int countContacts() {
        String sql = "SELECT COUNT(*) FROM tb_Contact WHERE IsRead = 0"; // Đếm tin nhắn chưa đọc
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("DashboardDAO countContacts: " + e);
        }
        return 0;
    }

    public int countOrders() {
        String sql = "SELECT COUNT(*) FROM tb_Order";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("DashboardDAO countOrders: " + e);
        }
        return 0;
    }

    public int countCustomers() {
        String sql = "SELECT COUNT(*) FROM tb_Customer";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("DashboardDAO countCustomers: " + e);
        }
        return 0;
    }

    public long totalRevenue() {
        String sql = "SELECT SUM(TotalAmount) FROM tb_Order"; // Giả sử TotalAmount là int, dùng long cho chắc
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch (SQLException e) {
            System.out.println("DashboardDAO totalRevenue: " + e);
        }
        return 0;
    }
}
