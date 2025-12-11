package dal.admin;

import dal.DBContext;
import model.Customer;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO extends DBContext {

    // Lấy danh sách tất cả khách hàng
    public List<Customer> getAllCustomers() {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM tb_Customer ORDER BY CustomerId DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerId(rs.getInt("CustomerId"));
                c.setUsername(rs.getString("Username"));
                c.setEmail(rs.getString("Email"));
                c.setPhone(rs.getString("Phone"));
                c.setAvatar(rs.getString("Avatar"));
                c.setBirthday(rs.getDate("Birthday"));
                c.setActive(rs.getBoolean("IsActive"));
                // Các trường khác nếu cần
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println("Admin CustomerDAO getAllCustomers: " + e);
        }
        return list;
    }

    // Cập nhật trạng thái (Khóa/Mở khóa)
    public boolean updateStatus(int customerId, boolean isActive) {
        String sql = "UPDATE tb_Customer SET IsActive = ? WHERE CustomerId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBoolean(1, isActive);
            st.setInt(2, customerId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Admin CustomerDAO updateStatus: " + e);
        }
        return false;
    }
}
