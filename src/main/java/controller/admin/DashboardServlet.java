package controller.admin;

import dal.admin.DashboardDAO;
import java.io.IOException;
import java.util.Calendar;
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
        int newContacts = dao.countContacts();
        int totalOrders = dao.countOrders();
        int totalCustomers = dao.countCustomers();
        long revenue = dao.totalRevenue();

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
        
        int count = 0;
        for (Map.Entry<String, Integer> entry : statusCounts.entrySet()) {
            orderLabels.append("'").append(entry.getKey()).append("'");
            orderData.append(entry.getValue());
            
            if (count < statusCounts.size() - 1) {
                orderLabels.append(", ");
                orderData.append(", ");
            }
            count++;
        }
        orderLabels.append("]");
        orderData.append("]");
        
        // Handle empty data case for visual appeal if DB is empty
        if (statusCounts.isEmpty()) {
            orderLabels = new StringBuilder("['Chưa có dữ liệu']");
            orderData = new StringBuilder("[1]"); // Dummy data
        }

        request.setAttribute("totalTours", totalTours);
        request.setAttribute("totalBlogs", totalBlogs);
        request.setAttribute("newContacts", newContacts);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("revenue", revenue);
        request.setAttribute("revenueData", revenueData.toString());
        request.setAttribute("orderLabels", orderLabels.toString());
        request.setAttribute("orderData", orderData.toString());
        request.setAttribute("currentYear", currentYear);

        request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
