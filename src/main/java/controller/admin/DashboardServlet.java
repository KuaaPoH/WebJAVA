package controller.admin;

import dal.admin.DashboardDAO;
import model.Order;
import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DashboardServlet", urlPatterns = {"/admin"})
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DashboardDAO dao = new DashboardDAO();
        
        int totalTours = dao.countTours();
        int totalBlogs = dao.countBlogs();
        // int newContacts = dao.countContacts(); // Replace with Cancel Requests
        int cancelRequests = dao.countOrdersByStatus(1008);
        int totalOrders = dao.countOrders();
        int totalCustomers = dao.countCustomers();
        long revenue = dao.totalRevenue();

        // Recent Orders
        List<Order> recentOrders = dao.getRecentOrders(5);

        // Revenue Chart Data
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        List<Double> monthlyRevenue = dao.getMonthlyRevenue(currentYear);
        
        StringBuilder revenueData = new StringBuilder("[");
        for (int i = 0; i < monthlyRevenue.size(); i++) {
            revenueData.append(monthlyRevenue.get(i));
            if (i < monthlyRevenue.size() - 1) revenueData.append(", ");
        }
        revenueData.append("]");

        // Order Status Chart Data
        Map<String, Integer> statusCounts = dao.getOrderStatusCounts();
        StringBuilder orderLabels = new StringBuilder("[");
        StringBuilder orderData = new StringBuilder("[");
        StringBuilder orderColors = new StringBuilder("["); // New: Colors array

        // Logic màu sắc thông minh (Heuristic Color Matching)
        // Không dùng HashMap cứng nhắc để tránh lỗi do sai lệch tên gọi/encoding
        int count = 0;
        for (Map.Entry<String, Integer> entry : statusCounts.entrySet()) {
            String statusName = entry.getKey().trim(); // Trim whitespace
            String lowerName = statusName.toLowerCase();
            
            orderLabels.append("'").append(statusName).append("'");
            orderData.append(entry.getValue());
            
            String color = "#6b7280"; // Default Neutral - Gray

            // Quy tắc so khớp từ khóa
            if (lowerName.contains("yêu cầu") || lowerName.contains("request")) {
                color = "#a855f7"; // Purple - Info (Yêu cầu hủy)
            } else if (lowerName.contains("hủy") || lowerName.contains("cancel") || lowerName.contains("từ chối") || lowerName.contains("reject")) {
                color = "#ef4444"; // Danger - Red (Đã hủy)
            } else if (lowerName.contains("chờ") || lowerName.contains("pending") || lowerName.contains("wait")) {
                color = "#f59e0b"; // Warning - Yellow (Chờ xác nhận)
            } else if (lowerName.contains("xác nhận") || lowerName.contains("confirm") || lowerName.contains("duyệt") || lowerName.contains("approve") || lowerName.contains("hoàn thành") || lowerName.contains("completed") || lowerName.contains("approved") || lowerName.contains("chấp nhận") || lowerName.contains("accept")) {
                color = "#22c55e"; // Success - Green (Đã xác nhận/Hoàn thành/Chấp nhận)
            }
            
            orderColors.append("'").append(color).append("'");
            
            if (count < statusCounts.size() - 1) {
                orderLabels.append(", ");
                orderData.append(", ");
                orderColors.append(", ");
            }
            count++;
        }
        orderLabels.append("]");
        orderData.append("]");
        orderColors.append("]"); // Close colors array
        
        // Handle empty data case for visual appeal if DB is empty
        if (statusCounts.isEmpty()) {
            orderLabels = new StringBuilder("['Chưa có dữ liệu']");
            orderData = new StringBuilder("[1]"); // Dummy data
            orderColors = new StringBuilder("['#6b7280']"); // Default gray for dummy
        }

        request.setAttribute("totalTours", totalTours);
        request.setAttribute("totalBlogs", totalBlogs);
        request.setAttribute("cancelRequests", cancelRequests); // Updated attribute
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("revenue", revenue);
        request.setAttribute("revenueData", revenueData.toString());
        request.setAttribute("orderLabels", orderLabels.toString());
        request.setAttribute("orderData", orderData.toString());
        request.setAttribute("orderColors", orderColors.toString()); // New: Pass colors to JSP
        request.setAttribute("recentOrders", recentOrders); // New attribute
        request.setAttribute("currentYear", currentYear);

        request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
