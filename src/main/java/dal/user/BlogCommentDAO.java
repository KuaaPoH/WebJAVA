package dal.user;

import dal.DBContext;
import model.BlogComment;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BlogCommentDAO extends DBContext {

    public List<BlogComment> getCommentsByBlogId(int blogId) {
        List<BlogComment> list = new ArrayList<>();
        // JOIN để lấy Avatar mới nhất từ bảng Customer nếu Email trùng khớp
        String sql = "SELECT c.*, cust.Avatar as UserAvatar " +
                     "FROM tb_BlogComment c " +
                     "LEFT JOIN tb_Customer cust ON c.Email = cust.Email " +
                     "WHERE c.BlogId = ? AND c.IsActive = 1 " +
                     "ORDER BY c.CreatedDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, blogId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                BlogComment c = new BlogComment();
                c.setCommentId(rs.getInt("CommentId"));
                c.setName(rs.getString("Name"));
                c.setPhone(rs.getString("Phone"));
                c.setEmail(rs.getString("Email"));
                c.setCreatedDate(rs.getTimestamp("CreatedDate"));
                c.setDetail(rs.getString("Detail"));
                c.setBlogId(rs.getInt("BlogId"));
                c.setActive(rs.getBoolean("IsActive"));
                
                // Ưu tiên lấy Avatar từ bảng Customer, nếu không thì lấy từ bảng Comment
                String userAvatar = rs.getString("UserAvatar");
                String commentImage = rs.getString("Image");
                
                if (userAvatar != null && !userAvatar.isEmpty()) {
                    c.setImage(userAvatar);
                } else {
                    c.setImage(commentImage);
                }
                
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertComment(BlogComment comment) {
        String sql = "INSERT INTO tb_BlogComment (Name, Phone, Email, CreatedDate, Detail, BlogId, IsActive, Image) VALUES (?, ?, ?, GETDATE(), ?, ?, 1, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, comment.getName());
            st.setString(2, comment.getPhone());
            st.setString(3, comment.getEmail());
            st.setString(4, comment.getDetail());
            st.setInt(5, comment.getBlogId());
            st.setString(6, comment.getImage());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
