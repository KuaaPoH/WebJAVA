package dal.user;

import dal.DBContext;
import model.TourReview;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TourReviewDAO extends DBContext {

    public List<TourReview> getReviewsByTourId(int tourId) {
        List<TourReview> list = new ArrayList<>();
        String sql = "SELECT * FROM tb_TourReview WHERE ProductId = ? AND IsActive = 1 ORDER BY CreatedDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, tourId);
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
                list.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertReview(TourReview review) {
        String sql = "INSERT INTO tb_TourReview (Name, Phone, Email, CreatedDate, Detail, Star, ProductId, IsActive, Image) VALUES (?, ?, ?, GETDATE(), ?, ?, ?, 1, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, review.getName());
            st.setString(2, review.getPhone());
            st.setString(3, review.getEmail());
            st.setString(4, review.getDetail());
            st.setInt(5, review.getStar());
            st.setInt(6, review.getProductId());
            st.setString(7, review.getImage()); // Avatar
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
