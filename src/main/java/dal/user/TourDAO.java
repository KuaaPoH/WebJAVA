package dal.user;

import dal.DBContext;
import model.Tour;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TourDAO extends DBContext {

    // Lấy danh sách Top tour mới nhất (hoặc nổi bật) để hiển thị trang chủ
    // Ví dụ: Lấy 6 tour mới nhất đang Active
    public List<Tour> getTopTours(int top) {
        List<Tour> list = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM tb_Tour WHERE IsActive = 1 ORDER BY CreatedDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, top);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Tour t = new Tour();
                t.setTourId(rs.getInt("TourId"));
                t.setTitle(rs.getString("Title"));
                t.setAlias(rs.getString("Alias"));
                t.setImage(rs.getString("Image"));
                t.setPrice(rs.getInt("Price"));
                t.setPriceSale(rs.getInt("PriceSale"));
                t.setDescription(rs.getString("Description"));
                t.setDetail(rs.getString("Detail"));
                t.setLocation(rs.getString("Location"));
                t.setTimeTravel(rs.getInt("TimeTravel"));
                t.setStar(rs.getInt("Star"));
                list.add(t);
            }
        } catch (SQLException e) {
            System.out.println("User TourDAO getTopTours: " + e);
        }
        return list;
    }
    
    public Tour getTourById(int id) {
        String sql = "SELECT * FROM tb_Tour WHERE TourId = ? AND IsActive = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Tour t = new Tour();
                t.setTourId(rs.getInt("TourId"));
                t.setTitle(rs.getString("Title"));
                t.setAlias(rs.getString("Alias"));
                t.setCategoryTourId(rs.getInt("CategoryTourId"));
                t.setDescription(rs.getString("Description"));
                t.setDetail(rs.getString("Detail"));
                t.setImage(rs.getString("Image"));
                t.setPrice(rs.getInt("Price"));
                t.setPriceSale(rs.getInt("PriceSale"));
                t.setCreatedDate(rs.getDate("CreatedDate"));
                t.setCreatedBy(rs.getString("CreatedBy"));
                t.setModifiedDate(rs.getDate("ModifiedDate"));
                t.setModifiedBy(rs.getString("ModifiedBy"));
                t.setActive(rs.getBoolean("IsActive"));
                t.setStar(rs.getInt("Star"));
                t.setLocation(rs.getString("Location"));
                t.setTimeTravel(rs.getInt("TimeTravel"));
                return t;
            }
        } catch (SQLException e) {
            System.out.println("User TourDAO getTourById: " + e);
        }
        return null;
    }
    
    public List<Tour> getAllTours() {
        List<Tour> list = new ArrayList<>();
        String sql = "SELECT * FROM tb_Tour WHERE IsActive = 1 ORDER BY CreatedDate DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Tour t = new Tour();
                t.setTourId(rs.getInt("TourId"));
                t.setTitle(rs.getString("Title"));
                t.setAlias(rs.getString("Alias"));
                t.setImage(rs.getString("Image"));
                t.setPrice(rs.getInt("Price"));
                t.setPriceSale(rs.getInt("PriceSale"));
                t.setDescription(rs.getString("Description"));
                t.setDetail(rs.getString("Detail"));
                t.setLocation(rs.getString("Location"));
                t.setTimeTravel(rs.getInt("TimeTravel"));
                t.setStar(rs.getInt("Star"));
                list.add(t);
            }
        } catch (SQLException e) {
            System.out.println("User TourDAO getAllTours: " + e);
        }
        return list;
    }

    // Test nhanh
    public static void main(String[] args) {
        TourDAO dao = new TourDAO();
        List<Tour> list = dao.getTopTours(3);
        for (Tour t : list) {
            System.out.println(t.getTitle());
        }
    }
}
