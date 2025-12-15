package dal.admin;

import dal.DBContext;
import model.Account;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AccountDAO extends DBContext {

    // Kiểm tra đăng nhập Admin
    public Account checkLogin(String username, String password) {
        String sql = "SELECT * FROM tb_Account WHERE Username = ? AND Password = ? AND IsActive = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setAccountId(rs.getInt("AccountId"));
                account.setUsername(rs.getString("Username"));
                account.setPassword(rs.getString("Password"));
                account.setFullName(rs.getString("FullName"));
                account.setPhone(rs.getString("Phone"));
                account.setEmail(rs.getString("Email"));
                account.setRoleId(rs.getInt("RoleId"));
                account.setLastLogin(rs.getString("LastLogin"));
                account.setActive(rs.getBoolean("IsActive"));
                account.setImage(rs.getString("Image"));
                account.setDescription(rs.getString("Description"));
                return account;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateProfile(Account account) {
        String sql = "UPDATE tb_Account SET FullName = ?, Phone = ?, Email = ?, Description = ?, Image = ? WHERE AccountId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, account.getFullName());
            st.setString(2, account.getPhone());
            st.setString(3, account.getEmail());
            st.setString(4, account.getDescription());
            st.setString(5, account.getImage());
            st.setInt(6, account.getAccountId());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean changePassword(int accountId, String newPassword) {
        String sql = "UPDATE tb_Account SET Password = ? WHERE AccountId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, newPassword);
            st.setInt(2, accountId);
            int rows = st.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
