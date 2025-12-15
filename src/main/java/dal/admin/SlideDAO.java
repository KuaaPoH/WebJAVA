package dal.admin;

import dal.DBContext;
import model.Slide;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SlideDAO extends DBContext {

    public List<Slide> getAllSlides() {
        List<Slide> list = new ArrayList<>();
        String sql = "SELECT * FROM tb_Slide";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Slide s = new Slide();
                s.setSlideID(rs.getInt("SlideID"));
                s.setTitle(rs.getString("Title"));
                s.setAlias(rs.getString("Alias"));
                s.setImage(rs.getString("Image"));
                s.setActive(rs.getBoolean("IsActive"));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Slide getSlideById(int id) {
        String sql = "SELECT * FROM tb_Slide WHERE SlideID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Slide s = new Slide();
                s.setSlideID(rs.getInt("SlideID"));
                s.setTitle(rs.getString("Title"));
                s.setAlias(rs.getString("Alias"));
                s.setImage(rs.getString("Image"));
                s.setActive(rs.getBoolean("IsActive"));
                return s;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Slide> getActiveSlides() {
        List<Slide> list = new ArrayList<>();
        String sql = "SELECT * FROM tb_Slide WHERE IsActive = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Slide s = new Slide();
                s.setSlideID(rs.getInt("SlideID"));
                s.setTitle(rs.getString("Title"));
                s.setAlias(rs.getString("Alias"));
                s.setImage(rs.getString("Image"));
                s.setActive(rs.getBoolean("IsActive"));
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void insertSlide(Slide s) {
        String sql = "INSERT INTO tb_Slide (Title, Alias, Image, IsActive) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, s.getTitle());
            st.setString(2, s.getAlias());
            st.setString(3, s.getImage());
            st.setBoolean(4, s.isActive());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateSlide(Slide s) {
        String sql = "UPDATE tb_Slide SET Title = ?, Alias = ?, IsActive = ? WHERE SlideID = ?";
        // Nếu có ảnh mới thì cập nhật, nếu không thì giữ nguyên (xử lý ở Servlet, ở đây giả sử truyền đủ)
        // Tuy nhiên, để linh hoạt, ta thường viết 2 câu query hoặc truyền tham số.
        // Ở đây tôi sẽ viết update full, logic check ảnh null sẽ nằm ở Servlet để truyền lại ảnh cũ.
        
        sql = "UPDATE tb_Slide SET Title = ?, Alias = ?, Image = ?, IsActive = ? WHERE SlideID = ?";
        
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, s.getTitle());
            st.setString(2, s.getAlias());
            st.setString(3, s.getImage());
            st.setBoolean(4, s.isActive());
            st.setInt(5, s.getSlideID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteSlide(int id) {
        String sql = "DELETE FROM tb_Slide WHERE SlideID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
