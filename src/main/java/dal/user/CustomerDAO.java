package dal.user;

import dal.DBContext;
import model.Customer;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerDAO extends DBContext {

    // Kiểm tra đăng nhập Khách hàng
    public Customer checkLogin(String email, String password) {
        // Hỗ trợ đăng nhập bằng Email hoặc Username
        String sql = "SELECT * FROM tb_Customer WHERE (Email = ? OR Username = ?) AND Password = ? AND IsActive = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, email);
            st.setString(3, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("CustomerId"));
                customer.setUsername(rs.getString("Username"));
                customer.setPassword(rs.getString("Password"));
                customer.setBirthday(rs.getDate("Birthday"));
                customer.setAvatar(rs.getString("Avatar"));
                customer.setPhone(rs.getString("Phone"));
                customer.setEmail(rs.getString("Email"));
                customer.setLocationId(rs.getInt("LocationId"));
                customer.setLastLogin(rs.getDate("LastLogin"));
                customer.setActive(rs.getBoolean("IsActive"));
                return customer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Kiểm tra xem Email đã tồn tại chưa
    public boolean checkEmailExist(String email) {
        String sql = "SELECT * FROM tb_Customer WHERE Email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Đăng ký tài khoản mới
    public void register(String username, String email, String password) {
        String sql = "INSERT INTO tb_Customer (Username, Email, Password, IsActive) VALUES (?, ?, ?, 1)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, email);
            st.setString(3, password);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật Avatar
    public void updateAvatar(int customerId, String avatarFile) {
        String sql = "UPDATE tb_Customer SET Avatar = ? WHERE CustomerId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, avatarFile);
            st.setInt(2, customerId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật Thông tin cá nhân
    public boolean updateProfile(int customerId, String phone, java.sql.Date birthday) {
        String sql = "UPDATE tb_Customer SET Phone = ?, Birthday = ? WHERE CustomerId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, phone);
            st.setDate(2, birthday);
            st.setInt(3, customerId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
