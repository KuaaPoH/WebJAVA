package dal.admin;

import dal.DBContext;
import model.Order;
import model.OrderDetail;
import model.Tour; // Cần thiết để lấy thông tin tour
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO extends DBContext {

    // Lấy danh sách đơn hàng (có thể lọc theo trạng thái)
    public List<Order> getAllOrders(Integer statusId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, os.Name AS OrderStatusName " +
                     "FROM tb_Order o " +
                     "JOIN tb_OrderStatus os ON o.OrderStatusId = os.OrderStatusId ";
        
        if (statusId != null) {
            sql += "WHERE o.OrderStatusId = ? ";
        }
        
        sql += "ORDER BY o.CreatedDate DESC";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            if (statusId != null) {
                st.setInt(1, statusId);
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("OrderId"));
                order.setCode(rs.getString("Code"));
                order.setCustomerName(rs.getString("CustomerName"));
                order.setPhone(rs.getString("Phone"));
                order.setAddress(rs.getString("Address"));
                order.setEmail(rs.getString("Email"));
                order.setTotalAmount(rs.getInt("TotalAmount"));
                order.setQuanlity(rs.getInt("Quanlity"));
                order.setOrderStatusId(rs.getInt("OrderStatusId"));
                order.setStatusName(rs.getString("OrderStatusName")); // Set statusName
                order.setCreatedDate(rs.getTimestamp("CreatedDate"));
                // ... set thêm các trường khác nếu cần
                list.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy chi tiết một đơn hàng cùng với thông tin OrderDetail và Tour
    public Order getOrderById(int orderId) {
        Order order = null;
        String sqlOrder = "SELECT o.*, os.Name AS OrderStatusName " +
                          "FROM tb_Order o " +
                          "JOIN tb_OrderStatus os ON o.OrderStatusId = os.OrderStatusId " +
                          "WHERE o.OrderId = ?";
        
        String sqlOrderDetail = "SELECT od.*, t.Title AS TourTitle, t.Image AS TourImage " +
                                "FROM tb_OrderDetail od " +
                                "JOIN tb_Tour t ON od.TourId = t.TourId " +
                                "WHERE od.OrderId = ?";
        try {
            // Get Order
            PreparedStatement stOrder = connection.prepareStatement(sqlOrder);
            stOrder.setInt(1, orderId);
            ResultSet rsOrder = stOrder.executeQuery();
            if (rsOrder.next()) {
                order = new Order();
                order.setOrderId(rsOrder.getInt("OrderId"));
                order.setCode(rsOrder.getString("Code"));
                order.setCustomerName(rsOrder.getString("CustomerName"));
                order.setPhone(rsOrder.getString("Phone"));
                order.setAddress(rsOrder.getString("Address"));
                order.setEmail(rsOrder.getString("Email"));
                order.setTotalAmount(rsOrder.getInt("TotalAmount"));
                order.setQuanlity(rsOrder.getInt("Quanlity"));
                order.setOrderStatusId(rsOrder.getInt("OrderStatusId"));
                order.setStatusName(rsOrder.getString("OrderStatusName"));
                order.setCreatedDate(rsOrder.getTimestamp("CreatedDate"));
                // ... set các trường khác

                // Get OrderDetail
                PreparedStatement stDetail = connection.prepareStatement(sqlOrderDetail);
                stDetail.setInt(1, orderId);
                ResultSet rsDetail = stDetail.executeQuery();
                List<OrderDetail> details = new ArrayList<>();
                while (rsDetail.next()) { // Có thể có nhiều detail nếu 1 order cho nhiều tour (nhưng hiện tại 1 order = 1 tour)
                    OrderDetail od = new OrderDetail();
                    od.setOrderDetailId(rsDetail.getInt("OrderDetailId"));
                    od.setOrderId(rsDetail.getInt("OrderId"));
                    od.setTourId(rsDetail.getInt("TourId"));
                    od.setPrice(rsDetail.getDouble("Price"));
                    od.setQuantity(rsDetail.getInt("Quantity"));
                    od.setDepartureDate(rsDetail.getDate("DepartureDate"));
                    od.setTourName(rsDetail.getString("TourTitle")); // Set tourName
                    od.setImage(rsDetail.getString("TourImage")); // Set tour image
                    details.add(od);
                }
                order.setOrderDetails(details); // Set list OrderDetails vào Order
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order; 
    }

    // Cập nhật trạng thái đơn hàng
    public boolean updateOrderStatus(int orderId, int orderStatusId) {
        String sql = "UPDATE tb_Order SET OrderStatusId = ? WHERE OrderId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderStatusId);
            st.setInt(2, orderId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Lấy danh sách OrderStatus (cho dropdown chọn trạng thái)
    public List<model.OrderStatus> getAllOrderStatuses() {
        List<model.OrderStatus> list = new ArrayList<>();
        String sql = "SELECT * FROM tb_OrderStatus";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                model.OrderStatus status = new model.OrderStatus();
                status.setOrderStatusId(rs.getInt("OrderStatusId"));
                status.setName(rs.getString("Name"));
                status.setDescription(rs.getString("Description"));
                list.add(status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Phương thức tiện ích để sửa tên trạng thái sang tiếng Việt (Chạy 1 lần)
    public void fixStatusNamesToVietnamese() {
        String sql = "UPDATE tb_OrderStatus SET Name = ? WHERE OrderStatusId = ?";
        try {
            connection.setAutoCommit(false); // Transaction
            PreparedStatement st = connection.prepareStatement(sql);
            
            // ID 5: Chờ xác nhận
            st.setString(1, "Chờ xác nhận");
            st.setInt(2, 5);
            st.addBatch();
            
            // ID 6: Đã xác nhận
            st.setString(1, "Đã xác nhận");
            st.setInt(2, 6);
            st.addBatch();
            
            // ID 7: Đã hủy
            st.setString(1, "Đã hủy");
            st.setInt(2, 7);
            st.addBatch();
            
            st.executeBatch();
            connection.commit();
            connection.setAutoCommit(true);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}