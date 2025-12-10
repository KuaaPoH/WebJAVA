package controller.user;

import dal.user.TourDAO;
import model.Tour;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "BookingPageServlet", urlPatterns = {"/booking-page"})
public class BookingPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
