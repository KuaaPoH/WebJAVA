package dal;

import model.Menu;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO extends DBContext {

    public List<Menu> getAllMenus() {
        List<Menu> list = new ArrayList<>();
        String sql = "SELECT * FROM tb_Menu ORDER BY Position ASC, MenuId ASC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Menu m = new Menu();
                m.setMenuId(rs.getInt("MenuId"));
                m.setTitle(rs.getString("Title"));
                m.setAlias(rs.getString("Alias"));
                m.setDescription(rs.getString("Description"));
                m.setLevels(rs.getInt("Levels"));
                m.setParentId(rs.getInt("ParentId"));
                m.setPosition(rs.getInt("Position"));
                m.setCreatedDate(rs.getDate("CreatedDate"));
                m.setCreatedBy(rs.getString("CreatedBy"));
                m.setModifiedDate(rs.getDate("ModifiedDate"));
                m.setModifiedBy(rs.getString("ModifiedBy"));
                m.setActive(rs.getBoolean("IsActive"));
                list.add(m);
            }
        } catch (SQLException e) {
            System.out.println("MenuDAO getAllMenus: " + e);
        }
        return list;
    }

    public Menu getMenuById(int id) {
        String sql = "SELECT * FROM tb_Menu WHERE MenuId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Menu m = new Menu();
                m.setMenuId(rs.getInt("MenuId"));
                m.setTitle(rs.getString("Title"));
                m.setAlias(rs.getString("Alias"));
                m.setDescription(rs.getString("Description"));
                m.setLevels(rs.getInt("Levels"));
                m.setParentId(rs.getInt("ParentId"));
                m.setPosition(rs.getInt("Position"));
                m.setCreatedDate(rs.getDate("CreatedDate"));
                m.setCreatedBy(rs.getString("CreatedBy"));
                m.setModifiedDate(rs.getDate("ModifiedDate"));
                m.setModifiedBy(rs.getString("ModifiedBy"));
                m.setActive(rs.getBoolean("IsActive"));
                return m;
            }
        } catch (SQLException e) {
            System.out.println("MenuDAO getMenuById: " + e);
        }
        return null;
    }

    public void insert(Menu m) {
        String sql = "INSERT INTO [dbo].[tb_Menu] " +
                     "([Title], [Alias], [Position], [ParentId], [Levels], [IsActive], [CreatedDate]) " +
                     "VALUES (?, ?, ?, ?, ?, ?, GETDATE())";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, m.getTitle());
            st.setString(2, m.getAlias());
            st.setInt(3, m.getPosition());
            st.setInt(4, m.getParentId());
            st.setInt(5, m.getLevels());
            st.setBoolean(6, m.isActive());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("MenuDAO insert: " + e);
        }
    }

    public void update(Menu m) {
        String sql = "UPDATE [dbo].[tb_Menu] SET " +
                     "[Title] = ?, " +
                     "[Alias] = ?, " +
                     "[Position] = ?, " +
                     "[ParentId] = ?, " +
                     "[Levels] = ?, " +
                     "[IsActive] = ?, " +
                     "[ModifiedDate] = GETDATE() " +
                     "WHERE MenuId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, m.getTitle());
            st.setString(2, m.getAlias());
            st.setInt(3, m.getPosition());
            st.setInt(4, m.getParentId());
            st.setInt(5, m.getLevels());
            st.setBoolean(6, m.isActive());
            st.setInt(7, m.getMenuId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("MenuDAO update: " + e);
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM [dbo].[tb_Menu] WHERE MenuId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("MenuDAO delete: " + e);
        }
    }
    
    public void toggleStatus(int id) {
        String sql = "UPDATE [dbo].[tb_Menu] SET [IsActive] = CASE WHEN [IsActive] = 1 THEN 0 ELSE 1 END WHERE MenuId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("MenuDAO toggleStatus: " + e);
        }
    }
}
