package dal.admin;

import dal.DBContext;
import model.TourReview;
import model.BlogComment;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO extends DBContext {

    // Lấy tất cả đánh giá (Kèm tên Tour)
    public List<TourReview> getAllReviews() {
        List<TourReview> list = new ArrayList<>();
        String sql = "SELECT r.ProductReviewId, r.Name, r.Phone, r.Email, r.CreatedDate, r.Detail, r.Star, r.ProductId, r.IsActive, r.Image, t.Title AS TourName " +
                     "FROM tb_TourReview r " +
                     "LEFT JOIN tb_Tour t ON r.ProductId = t.TourId " +
                     "ORDER BY r.CreatedDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                TourReview r = new TourReview();
                r.setProductReviewId(rs.getInt("ProductReviewId"));
                r.setName(rs.getString("Name"));
                r.setPhone(rs.getString("Phone"));
                r.setEmail(rs.getString("Email"));
                r.setCreatedDate(rs.getTimestamp("CreatedDate"));
                r.setDetail(rs.getString("Detail"));
                r.setStar(rs.getInt("Star"));
                r.setProductId(rs.getInt("ProductId"));
                r.setActive(rs.getBoolean("IsActive"));
                r.setImage(rs.getString("Image"));
                r.setTourName(rs.getString("TourName")); 
                
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Cập nhật trạng thái (Ẩn/Hiện)
    public boolean updateStatus(int reviewId, boolean isActive) {
        String sql = "UPDATE tb_TourReview SET IsActive = ? WHERE ProductReviewId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBoolean(1, isActive);
            st.setInt(2, reviewId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa đánh giá
    public boolean deleteReview(int reviewId) {
        String sql = "DELETE FROM tb_TourReview WHERE ProductReviewId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, reviewId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // --- BLOG COMMENT METHODS ---

    // Lấy tất cả bình luận Blog (Kèm tên Blog)
    public List<BlogComment> getAllBlogComments() {
        List<BlogComment> list = new ArrayList<>();
        String sql = "SELECT c.*, b.Title as BlogTitle " +
                     "FROM tb_BlogComment c " +
                     "LEFT JOIN tb_Blog b ON c.BlogId = b.BlogId " +
                     "ORDER BY c.CreatedDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
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
                c.setImage(rs.getString("Image"));
                c.setBlogTitle(rs.getString("BlogTitle")); // Set tên blog
                
                list.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Cập nhật trạng thái Blog Comment (Ẩn/Hiện)
    public boolean updateBlogCommentStatus(int commentId, boolean isActive) {
        String sql = "UPDATE tb_BlogComment SET IsActive = ? WHERE CommentId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setBoolean(1, isActive);
            st.setInt(2, commentId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa Blog Comment
    public boolean deleteBlogComment(int commentId) {
        String sql = "DELETE FROM tb_BlogComment WHERE CommentId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, commentId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
