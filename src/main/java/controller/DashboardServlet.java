package controller;

import dal.DashboardDAO;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
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

        // Chart Data
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        List<Double> monthlyRevenue = dao.getMonthlyRevenue(currentYear);
        
        // Convert to JS Array String: [100, 200, 300...]
        StringBuilder revenueData = new StringBuilder("[");
        for (int i = 0; i < monthlyRevenue.size(); i++) {
            revenueData.append(monthlyRevenue.get(i));
            if (i < monthlyRevenue.size() - 1) revenueData.append(", ");
        }
        revenueData.append("]");

        request.setAttribute("totalTours", totalTours);
        request.setAttribute("totalBlogs", totalBlogs);
        request.setAttribute("newContacts", newContacts);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("revenue", revenue);
        request.setAttribute("revenueData", revenueData.toString());
        request.setAttribute("currentYear", currentYear);

        request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
