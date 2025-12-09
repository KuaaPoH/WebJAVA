package dal;

import model.Contact;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO extends DBContext {

    public List<Contact> getAllContacts() {
        List<Contact> list = new ArrayList<>();
        // Order by IsRead (unread first), then by latest date
        String sql = "SELECT * FROM tb_Contact ORDER BY IsRead ASC, CreatedDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Contact c = new Contact();
                c.setContactId(rs.getInt("ContactId"));
                c.setName(rs.getString("Name"));
                c.setPhone(rs.getString("Phone"));
                c.setEmail(rs.getString("Email"));
                c.setMessage(rs.getString("Message"));
                c.setIsRead(rs.getInt("IsRead"));
                c.setCreatedDate(rs.getTimestamp("CreatedDate"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println("ContactDAO getAllContacts: " + e);
        }
        return list;
    }

    public Contact getContactById(int id) {
        String sql = "SELECT * FROM tb_Contact WHERE ContactId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Contact c = new Contact();
                c.setContactId(rs.getInt("ContactId"));
                c.setName(rs.getString("Name"));
                c.setPhone(rs.getString("Phone"));
                c.setEmail(rs.getString("Email"));
                c.setMessage(rs.getString("Message"));
                c.setIsRead(rs.getInt("IsRead"));
                c.setCreatedDate(rs.getTimestamp("CreatedDate"));
                return c;
            }
        } catch (SQLException e) {
            System.out.println("ContactDAO getContactById: " + e);
        }
        return null;
    }

    public void delete(int id) {
        String sql = "DELETE FROM [dbo].[tb_Contact] WHERE ContactId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("ContactDAO delete: " + e);
        }
    }
    
    public void markAsRead(int id) {
        String sql = "UPDATE [dbo].[tb_Contact] SET [IsRead] = 1 WHERE ContactId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("ContactDAO markAsRead: " + e);
        }
    }
}
