package controller.user;

import dal.user.TourDAO;
import model.Tour;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "TourDetailServlet", urlPatterns = {"/tour-detail"})
public class TourDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            TourDAO dao = new TourDAO();
            Tour tour = dao.getTourById(id);
            
            if (tour != null) {
                request.setAttribute("tour", tour);
                // Có thể lấy thêm list tour liên quan (related tours) ở đây
                
                request.getRequestDispatcher("/user/tour/detail.jsp").forward(request, response);
            } else {
                response.sendRedirect("home"); // Hoặc trang 404
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
