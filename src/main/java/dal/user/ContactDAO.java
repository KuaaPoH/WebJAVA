package dal.user;

import dal.DBContext;
import model.Contact;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ContactDAO extends DBContext {

    public boolean insert(Contact c) {
        String sql = "INSERT INTO tb_Contact (Name, Phone, Email, Message, IsRead, CreatedDate) VALUES (?, ?, ?, ?, 0, GETDATE())";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, c.getName());
            st.setString(2, c.getPhone());
            st.setString(3, c.getEmail());
            st.setString(4, c.getMessage());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("User ContactDAO insert: " + e);
        }
        return false;
    }
}
