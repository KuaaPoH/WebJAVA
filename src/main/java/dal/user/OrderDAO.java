package dal.user;

import dal.DBContext;
import model.Order;
import model.OrderDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO extends DBContext {

    // Lấy danh sách đơn hàng theo Email của khách hàng
    public List<Order> getOrdersByEmail(String email) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.*, s.Name AS StatusName "
                   + "FROM tb_Order o "
                   + "JOIN tb_OrderStatus s ON o.OrderStatusId = s.OrderStatusId "
                   + "WHERE o.Email = ? "
                   + "ORDER BY o.CreatedDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("OrderId"));
                o.setCode(rs.getString("Code"));
                o.setCustomerName(rs.getString("CustomerName"));
                o.setPhone(rs.getString("Phone"));
                o.setAddress(rs.getString("Address"));
                o.setEmail(rs.getString("Email"));
                o.setTotalAmount(rs.getInt("TotalAmount"));
                o.setQuanlity(rs.getInt("Quanlity"));
                o.setOrderStatusId(rs.getInt("OrderStatusId"));
                o.setCreatedDate(rs.getDate("CreatedDate"));
                
                // Set Status Name (cần thêm field này vào model Order nếu chưa có, hoặc dùng DTO)
                // Hiện tại giả định model Order đã được update từ task trước
                o.setStatusName(rs.getString("StatusName")); 
                
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy chi tiết đơn hàng theo ID (kèm thông tin Tour)
    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "SELECT o.*, s.Name AS StatusName, "
                   + "d.OrderDetailId, d.Price, d.Quantity, d.DepartureDate, "
                   + "t.TourId, t.Title AS TourTitle, t.Image AS TourImage "
                   + "FROM tb_Order o "
                   + "JOIN tb_OrderStatus s ON o.OrderStatusId = s.OrderStatusId "
                   + "JOIN tb_OrderDetail d ON o.OrderId = d.OrderId "
                   + "JOIN tb_Tour t ON d.TourId = t.TourId "
                   + "WHERE o.OrderId = ?";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            List<OrderDetail> details = new ArrayList<>();
            
            while (rs.next()) {
                if (order == null) {
                    order = new Order();
                    order.setOrderId(rs.getInt("OrderId"));
                    order.setCode(rs.getString("Code"));
                    order.setCustomerName(rs.getString("CustomerName"));
                    order.setPhone(rs.getString("Phone"));
                    order.setAddress(rs.getString("Address"));
                    order.setEmail(rs.getString("Email"));
                    order.setTotalAmount(rs.getInt("TotalAmount"));
                    order.setQuanlity(rs.getInt("Quanlity")); // Tổng số lượng khách
                    order.setOrderStatusId(rs.getInt("OrderStatusId"));
                    order.setCreatedDate(rs.getDate("CreatedDate"));
                    order.setStatusName(rs.getString("StatusName"));
                }
                
                OrderDetail od = new OrderDetail();
                od.setOrderDetailId(rs.getInt("OrderDetailId"));
                od.setOrderId(rs.getInt("OrderId"));
                od.setTourId(rs.getInt("TourId"));
                od.setPrice(rs.getDouble("Price"));
                od.setQuantity(rs.getInt("Quantity"));
                od.setDepartureDate(rs.getDate("DepartureDate"));
                od.setTourName(rs.getString("TourTitle"));
                od.setImage(rs.getString("TourImage"));
                
                details.add(od);
            }
            
            if (order != null) {
                order.setOrderDetails(details);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    // Cập nhật trạng thái đơn hàng (Dùng cho hủy đơn)
    public boolean updateOrderStatus(int orderId, int newStatusId) {
        String sql = "UPDATE tb_Order SET OrderStatusId = ? WHERE OrderId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, newStatusId);
            st.setInt(2, orderId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertOrder(Order order, OrderDetail detail) {
        boolean result = false;
        String sqlOrder = "INSERT INTO [dbo].[tb_Order] "
                + "([Code], [CustomerName], [Phone], [Address], [Email], [TotalAmount], [Quanlity], [OrderStatusId], [CreatedDate]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
        
        String sqlDetail = "INSERT INTO [dbo].[tb_OrderDetail] "
                + "([OrderId], [TourId], [Price], [Quantity], [DepartureDate]) "
                + "VALUES (?, ?, ?, ?, ?)";

        try {
            // Đảm bảo connection đang mở và auto-commit tắt
            if (connection.getAutoCommit()) {
                connection.setAutoCommit(false);
            }

            // 0. Set default OrderStatusId = 5 (Chờ)
            int statusId = 5;

            // 1. Insert Order
            PreparedStatement stOrder = connection.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            stOrder.setString(1, order.getCode());
            stOrder.setString(2, order.getCustomerName());
            stOrder.setString(3, order.getPhone());
            stOrder.setString(4, order.getAddress()); // Tạm thời dùng làm address hoặc note
            stOrder.setString(5, order.getEmail());
            stOrder.setInt(6, order.getTotalAmount());
            stOrder.setInt(7, order.getQuanlity()); // Tổng số lượng
            stOrder.setInt(8, statusId); 
            
            int affectedRows = stOrder.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating order failed, no rows affected.");
            }

            // Lấy OrderId vừa tạo
            try (ResultSet generatedKeys = stOrder.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int orderId = generatedKeys.getInt(1);
                    
                    // 2. Insert OrderDetail
                    PreparedStatement stDetail = connection.prepareStatement(sqlDetail);
                    stDetail.setInt(1, orderId);
                    stDetail.setInt(2, detail.getTourId());
                    stDetail.setDouble(3, detail.getPrice());
                    stDetail.setInt(4, detail.getQuantity());
                    
                    if (detail.getDepartureDate() != null) {
                         stDetail.setDate(5, new java.sql.Date(detail.getDepartureDate().getTime()));
                    } else {
                         stDetail.setNull(5, java.sql.Types.DATE);
                    }
                   
                    stDetail.executeUpdate();
                    
                    // Commit transaction
                    connection.commit();
                    result = true;
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // Rollback nếu có lỗi
                if (connection != null) {
                    connection.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                // Bật lại auto-commit
                if (connection != null) {
                    connection.setAutoCommit(true);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }
}
