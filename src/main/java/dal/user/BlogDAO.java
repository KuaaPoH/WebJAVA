package dal.user;

import dal.DBContext;
import model.Blog;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO extends DBContext {

    // Lấy tất cả bài viết đang hoạt động
    public List<Blog> getAllBlogs() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM tb_Blog WHERE IsActive = 1 ORDER BY CreatedDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog b = mapResultSetToBlog(rs);
                list.add(b);
            }
        } catch (SQLException e) {
            System.out.println("User BlogDAO getAllBlogs: " + e);
        }
        return list;
    }

    // Lấy 3 bài viết mới nhất (cho Sidebar hoặc Home)
    public List<Blog> getLatestBlogs(int limit) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM tb_Blog WHERE IsActive = 1 ORDER BY CreatedDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, limit);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Blog b = mapResultSetToBlog(rs);
                list.add(b);
            }
        } catch (SQLException e) {
            System.out.println("User BlogDAO getLatestBlogs: " + e);
        }
        return list;
    }

    // Lấy chi tiết bài viết
    public Blog getBlogById(int id) {
        String sql = "SELECT * FROM tb_Blog WHERE BlogId = ? AND IsActive = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return mapResultSetToBlog(rs);
            }
        } catch (SQLException e) {
            System.out.println("User BlogDAO getBlogById: " + e);
        }
        return null;
    }

    // Tăng lượt xem
    public void increaseViewCount(int id) {
        String sql = "UPDATE tb_Blog SET CountView = CountView + 1 WHERE BlogId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("User BlogDAO increaseViewCount: " + e);
        }
    }

    // Helper mapping method
    private Blog mapResultSetToBlog(ResultSet rs) throws SQLException {
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
}
