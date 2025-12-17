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
            // Lọc theo trạng thái
            String statusStr = request.getParameter("status");
            Integer statusId = null;
            if (statusStr != null && !statusStr.isEmpty()) {
                try {
                    statusId = Integer.parseInt(statusStr);
                } catch (NumberFormatException e) {
                    // Ignore invalid status param
                }
            }

            List<Order> orders = orderDAO.getAllOrders(statusId);
            request.setAttribute("orders", orders);
            request.setAttribute("currentStatus", statusId); // Để highlight button filter
            request.getRequestDispatcher("/admin/quanlydonhang/index.jsp").forward(request, response);
        } else if (action.equals("view")) {
            int orderId = Integer.parseInt(request.getParameter("id"));
            Order order = orderDAO.getOrderById(orderId);
            List<model.OrderStatus> statuses = orderDAO.getAllOrderStatuses();
            request.setAttribute("order", order);
            request.setAttribute("statuses", statuses);
            request.getRequestDispatcher("/admin/quanlydonhang/detail.jsp").forward(request, response);
        } else if (action.equals("updateStatus")) {
            // Xử lý cập nhật trạng thái qua GET (cho nút bấm nhanh)
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int statusId = Integer.parseInt(request.getParameter("statusId"));
            orderDAO.updateOrderStatus(orderId, statusId);
            
            String from = request.getParameter("from");
            if ("list".equals(from)) {
                response.sendRedirect("orders?action=list");
            } else {
                response.sendRedirect("orders?action=view&id=" + orderId);
            }
        } else if (action.equals("fix_db")) {
            // Cập nhật tên trạng thái trong DB sang Tiếng Việt
            orderDAO.fixStatusNamesToVietnamese();
            response.sendRedirect("orders?action=list");
        } else {
            response.sendRedirect("orders?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        OrderDAO orderDAO = new OrderDAO();

        if (action != null && action.equals("updateStatus")) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            int statusId = Integer.parseInt(request.getParameter("statusId"));
            orderDAO.updateOrderStatus(orderId, statusId);
            
            String from = request.getParameter("from");
            if ("list".equals(from)) {
                response.sendRedirect("orders?action=list");
            } else {
                response.sendRedirect("orders?action=view&id=" + orderId);
            }
        } else {
            response.sendRedirect("orders?action=list");
        }
    }
}
