package dal.user;

import dal.DBContext;
import model.Tour;
import model.TourCategory;
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

    // Lấy danh sách Categories để hiển thị Filter
    public List<TourCategory> getAllTourCategories() {
        List<TourCategory> list = new ArrayList<>();
        String sql = "SELECT * FROM tb_TourCategory WHERE IsActive = 1 ORDER BY Position ASC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                TourCategory c = new TourCategory();
                c.setCategoryTourId(rs.getInt("CategoryTourId"));
                c.setTitle(rs.getString("Title"));
                c.setAlias(rs.getString("Alias"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println("User TourDAO getAllTourCategories: " + e);
        }
        return list;
    }

    // Đếm tổng số tour thỏa mãn điều kiện tìm kiếm (để phân trang)
    public int countTours(String keyword, Integer categoryId, Double minPrice, Double maxPrice) {
        String sql = "SELECT COUNT(*) FROM tb_Tour WHERE IsActive = 1";
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND Title LIKE ?";
            params.add("%" + keyword.trim() + "%");
        }
        if (categoryId != null) {
            sql += " AND CategoryTourId = ?";
            params.add(categoryId);
        }
        if (minPrice != null) {
            sql += " AND (CASE WHEN PriceSale > 0 THEN PriceSale ELSE Price END) >= ?";
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql += " AND (CASE WHEN PriceSale > 0 THEN PriceSale ELSE Price END) <= ?";
            params.add(maxPrice);
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("User TourDAO countTours: " + e);
        }
        return 0;
    }

    // Tìm kiếm và lọc tour có phân trang
    public List<Tour> searchTours(String keyword, Integer categoryId, Double minPrice, Double maxPrice, int page, int pageSize) {
        List<Tour> list = new ArrayList<>();
        String sql = "SELECT * FROM tb_Tour WHERE IsActive = 1";
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND Title LIKE ?";
            params.add("%" + keyword.trim() + "%");
        }
        if (categoryId != null) {
            sql += " AND CategoryTourId = ?";
            params.add(categoryId);
        }
        if (minPrice != null) {
            sql += " AND (CASE WHEN PriceSale > 0 THEN PriceSale ELSE Price END) >= ?";
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql += " AND (CASE WHEN PriceSale > 0 THEN PriceSale ELSE Price END) <= ?";
            params.add(maxPrice);
        }

        // Sắp xếp và phân trang (SQL Server)
        sql += " ORDER BY CreatedDate DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
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
            System.out.println("User TourDAO searchTours: " + e);
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
