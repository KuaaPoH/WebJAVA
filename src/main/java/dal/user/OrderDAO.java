package dal.user;

import dal.DBContext;
import model.Order;
import model.OrderDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class OrderDAO extends DBContext {

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
