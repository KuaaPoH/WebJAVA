package controller.user;

import dal.user.TourDAO;
import model.Tour;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "BookingPageServlet", urlPatterns = {"/booking-page"})
public class BookingPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            String idStr = request.getParameter("id");
            String redirectUrl = "booking-page?id=" + (idStr != null ? idStr : "");
            session.setAttribute("redirectUrl", redirectUrl);
            session.setAttribute("loginMessage", "Vui lòng đăng nhập để tiếp tục đặt tour!"); // Dùng loginMessage để hiển thị bên Login
            response.sendRedirect("login");
            return;
        }

        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect("home");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            TourDAO dao = new TourDAO();
            Tour tour = dao.getTourById(id);
            
            if (tour != null) {
                request.setAttribute("tour", tour);
                request.getRequestDispatcher("/user/booking/index.jsp").forward(request, response);
            } else {
                response.sendRedirect("home");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
