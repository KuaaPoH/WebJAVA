package controller.user;

import dal.user.OrderDAO;
import model.Customer;
import model.Order;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/order-detail"})
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("user");

        // 1. Check Login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Get ID
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        // 3. Get Order
        OrderDAO dao = new OrderDAO();
        Order order = dao.getOrderById(orderId);

        // 4. Security Check & Forward
        if (order != null) {
            // Kiểm tra xem đơn hàng có đúng là của user này không (so sánh Email)
            // Lưu ý: User có thể nhập email khác khi đặt hàng, nên so sánh lỏng lẻo hoặc check cả phone nếu cần.
            // Ở đây ta so sánh Email tài khoản login với Email trong đơn hàng.
            if (user.getEmail().equalsIgnoreCase(order.getEmail())) {
                request.setAttribute("order", order);
                request.getRequestDispatcher("/user/order_detail.jsp").forward(request, response);
                return;
            }
        }

        // Nếu không tìm thấy hoặc không có quyền xem
        request.setAttribute("errorMessage", "Không tìm thấy đơn hàng hoặc bạn không có quyền truy cập.");
        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("user");

        // 1. Check Login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if ("cancel_request".equals(action) && idStr != null) {
            try {
                int orderId = Integer.parseInt(idStr);
                OrderDAO dao = new OrderDAO();
                Order order = dao.getOrderById(orderId);

                // Security Check: Ensure user owns the order
                if (order != null && user.getEmail().equalsIgnoreCase(order.getEmail())) {
                    // Chỉ cho phép yêu cầu hủy khi trạng thái là Chờ (5)
                    if (order.getOrderStatusId() == 5) {
                        // 1008 = Yêu cầu hủy
                        boolean success = dao.updateOrderStatus(orderId, 1008);
                        if (success) {
                            session.setAttribute("message", "Đã gửi yêu cầu hủy thành công. Vui lòng chờ Admin phê duyệt.");
                            session.setAttribute("messageType", "success");
                        } else {
                            session.setAttribute("message", "Có lỗi xảy ra, vui lòng thử lại.");
                            session.setAttribute("messageType", "danger");
                        }
                    } else {
                         session.setAttribute("message", "Đơn hàng này không thể hủy (đã được xử lý hoặc đang hủy).");
                         session.setAttribute("messageType", "warning");
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/order-detail?id=" + idStr);
    }
}
