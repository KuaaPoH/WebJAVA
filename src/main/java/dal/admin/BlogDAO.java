package dal.admin;

import dal.DBContext;
import model.Blog;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO extends DBContext {

    public List<Blog> getAllBlogs() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM tb_Blog ORDER BY BlogId DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setBlogId(rs.getInt("BlogId"));
                b.setTitle(rs.getString("Title"));
                b.setAlias(rs.getString("Alias"));
                b.setCategoryId(rs.getInt("CategoryId"));
                b.setDescription(rs.getString("Description"));
                b.setDetail(rs.getString("Detail"));
                b.setImage(rs.getString("Image"));
                b.setSeoTitle(rs.getString("SeoTitle"));
                b.setSeoDescription(rs.getString("SeoDescription"));
                b.setSeoKeywords(rs.getString("SeoKeywords"));
                b.setCreatedDate(rs.getDate("CreatedDate"));
                b.setCreatedBy(rs.getString("CreatedBy"));
                b.setModifiedDate(rs.getDate("ModifiedDate"));
                b.setModifiedBy(rs.getString("ModifiedBy"));
                b.setAccountId(rs.getInt("AccountId"));
                b.setActive(rs.getBoolean("IsActive"));
                b.setDayCreated(rs.getInt("DayCreated"));
                b.setMonthCreated(rs.getString("MonthCreated"));
                b.setCountView(rs.getInt("CountView"));
                list.add(b);
            }
        } catch (SQLException e) {
            System.out.println("BlogDAO getAllBlogs: " + e);
        }
        return list;
    }

    public Blog getBlogById(int id) {
        String sql = "SELECT * FROM tb_Blog WHERE BlogId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Blog b = new Blog();
                b.setBlogId(rs.getInt("BlogId"));
                b.setTitle(rs.getString("Title"));
                b.setAlias(rs.getString("Alias"));
                b.setCategoryId(rs.getInt("CategoryId"));
                b.setDescription(rs.getString("Description"));
                b.setDetail(rs.getString("Detail"));
                b.setImage(rs.getString("Image"));
                b.setSeoTitle(rs.getString("SeoTitle"));
                b.setSeoDescription(rs.getString("SeoDescription"));
                b.setSeoKeywords(rs.getString("SeoKeywords"));
                b.setCreatedDate(rs.getDate("CreatedDate"));
                b.setCreatedBy(rs.getString("CreatedBy"));
                b.setModifiedDate(rs.getDate("ModifiedDate"));
                b.setModifiedBy(rs.getString("ModifiedBy"));
                b.setAccountId(rs.getInt("AccountId"));
                b.setActive(rs.getBoolean("IsActive"));
                b.setDayCreated(rs.getInt("DayCreated"));
                b.setMonthCreated(rs.getString("MonthCreated"));
                b.setCountView(rs.getInt("CountView"));
                return b;
            }
        } catch (SQLException e) {
            System.out.println("BlogDAO getBlogById: " + e);
        }
        return null;
    }

    public void insert(Blog b) {
        String sql = "INSERT INTO [dbo].[tb_Blog] " +
                     "([Title], [Description], [Detail], [Image], [CategoryId], [AccountId], [IsActive], [CreatedDate]) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, b.getTitle());
            st.setString(2, b.getDescription());
            st.setString(3, b.getDetail());
            st.setString(4, b.getImage());
            st.setInt(5, 1); // Default CategoryId
            st.setInt(6, 5); // Default AccountId
            st.setBoolean(7, b.isActive());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("BlogDAO insert: " + e);
        }
    }

    public void update(Blog b) {
        String sql = "UPDATE [dbo].[tb_Blog] SET " +
                     "[Title] = ?, " +
                     "[Description] = ?, " +
                     "[Detail] = ?, " +
                     "[Image] = ?, " +
                     "[IsActive] = ?, " +
                     "[ModifiedDate] = GETDATE() " +
                     "WHERE BlogId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, b.getTitle());
            st.setString(2, b.getDescription());
            st.setString(3, b.getDetail());
            st.setString(4, b.getImage());
            st.setBoolean(5, b.isActive());
            st.setInt(6, b.getBlogId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("BlogDAO update: " + e);
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM [dbo].[tb_Blog] WHERE BlogId = ?";
        try {
            // Must delete comments first due to foreign key constraint
            String deleteCommentsSql = "DELETE FROM [dbo].[tb_BlogComment] WHERE BlogId = ?";
            PreparedStatement stComments = connection.prepareStatement(deleteCommentsSql);
            stComments.setInt(1, id);
            stComments.executeUpdate();

            // Then delete the blog
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("BlogDAO delete: " + e);
        }
    }
    
    public void toggleStatus(int id) {
        String sql = "UPDATE [dbo].[tb_Blog] SET [IsActive] = CASE WHEN [IsActive] = 1 THEN 0 ELSE 1 END WHERE BlogId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("BlogDAO toggleStatus: " + e);
        }
    }
}
