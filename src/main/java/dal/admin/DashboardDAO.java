package dal.admin;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAO extends DBContext {

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

    // Returns counts for: [Total, Pending, Completed, Cancelled] - Simplification
    // Or just a raw list of counts by status ID
    public List<Integer> getOrderStatusCounts() {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT COUNT(*) FROM tb_Order GROUP BY OrderStatusId ORDER BY OrderStatusId";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt(1));
            }
        } catch (SQLException e) {
            System.out.println("DashboardDAO getOrderStatusCounts: " + e);
        }
        // Ensure we return some data even if empty to avoid JS errors
        if (list.isEmpty()) {
            list.add(0); list.add(0); list.add(0);
        }
        return list;
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
