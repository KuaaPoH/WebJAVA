package controller.admin;

import dal.admin.OrderDAO;
import model.Order;
import model.OrderDetail;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminOrderController", urlPatterns = {"/admin/orders"})
public class OrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        OrderDAO orderDAO = new OrderDAO();

        if (action == null || action.equals("list")) {
            List<Order> orders = orderDAO.getAllOrders();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/admin/quanlydonhang/index.jsp").forward(request, response);
        } else if (action.equals("view")) {
            int orderId = Integer.parseInt(request.getParameter("id"));
            Order order = orderDAO.getOrderById(orderId);
            List<model.OrderStatus> statuses = orderDAO.getAllOrderStatuses();
            request.setAttribute("order", order);
            request.setAttribute("statuses", statuses);
            request.getRequestDispatcher("/admin/quanlydonhang/detail.jsp").forward(request, response);
        } else {
            response.sendRedirect("orders?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        OrderDAO orderDAO = new OrderDAO();

        if (action != null && action.equals("updateStatus")) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int statusId = Integer.parseInt(request.getParameter("statusId"));
            orderDAO.updateOrderStatus(orderId, statusId);
            response.sendRedirect("orders?action=view&id=" + orderId);
        } else {
            response.sendRedirect("orders?action=list");
        }
    }
}
