package controller.admin;

import dal.admin.ReviewDAO;
import model.TourReview;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/admin/reviews"})
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            ReviewDAO dao = new ReviewDAO();

            if (action == null || action.equals("list")) {
                List<TourReview> listReviews = dao.getAllReviews();
                request.setAttribute("reviews", listReviews);
                request.getRequestDispatcher("/admin/quanlydanhgia/index.jsp").forward(request, response);
            } else if (action.equals("hide")) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.updateStatus(id, false);
                response.sendRedirect("reviews");
            } else if (action.equals("show")) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.updateStatus(id, true);
                response.sendRedirect("reviews");
            } else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteReview(id);
                response.sendRedirect("reviews");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().println("Error in ReviewServlet: " + e.getMessage());
            e.printStackTrace(response.getWriter());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        doGet(request, response);
    }
}