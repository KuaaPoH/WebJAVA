package dal.admin;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Tour;

public class TourDAO extends DBContext {

    public List<Tour> getAllTours() {
        List<Tour> list = new ArrayList<>();
        String sql = "SELECT * FROM tb_Tour";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
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
                list.add(t);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void insert(Tour c) {
        String sql = "INSERT INTO [dbo].[tb_Tour]\n"
                + "           ([Title]\n"
                + "           ,[Image]\n"
                + "           ,[Price]\n"
                + "           ,[Description]\n"
                + "           ,[Detail]\n"
                + "           ,[Location]\n"
                + "           ,[TimeTravel]\n"
                + "           ,[IsActive]\n"
                + "           ,[CategoryTourId])\n" // Thêm category
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, c.getTitle());
            st.setString(2, c.getImage());
            st.setInt(3, c.getPrice());
            st.setString(4, c.getDescription());
            st.setString(5, c.getDetail());
            st.setString(6, c.getLocation());
            st.setInt(7, c.getTimeTravel());
            st.setBoolean(8, c.isActive());
            st.setInt(9, 6); // Tạm thời set cứng Category = 6 (Du lịch nước ngoài) hoặc lấy từ form sau
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Tour getTourById(int id) {
        String sql = "SELECT * FROM tb_Tour WHERE TourId = ?";
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
            System.out.println(e);
        }
        return null;
    }

    public void update(Tour c) {
        String sql = "UPDATE [dbo].[tb_Tour]\n"
                + "   SET [Title] = ?\n"
                + "      ,[Image] = ?\n"
                + "      ,[Price] = ?\n"
                + "      ,[Description] = ?\n"
                + "      ,[Detail] = ?\n"
                + "      ,[Location] = ?\n"
                + "      ,[TimeTravel] = ?\n"
                + "      ,[IsActive] = ?\n"
                + " WHERE TourId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, c.getTitle());
            st.setString(2, c.getImage());
            st.setInt(3, c.getPrice());
            st.setString(4, c.getDescription());
            st.setString(5, c.getDetail());
            st.setString(6, c.getLocation());
            st.setInt(7, c.getTimeTravel());
            st.setBoolean(8, c.isActive());
            st.setInt(9, c.getTourId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void delete(int id) {
        String sql = "DELETE FROM [dbo].[tb_Tour] WHERE TourId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void toggleStatus(int id) {
        String sql = "UPDATE [dbo].[tb_Tour] SET [IsActive] = CASE WHEN [IsActive] = 1 THEN 0 ELSE 1 END WHERE TourId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // Main method to test DAO quickly
    public static void main(String[] args) {
        TourDAO dao = new TourDAO();
        List<Tour> list = dao.getAllTours();
        for (Tour o : list) {
            System.out.println(o.getTitle());
        }
    }
}
