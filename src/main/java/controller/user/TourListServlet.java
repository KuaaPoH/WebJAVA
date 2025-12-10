package controller.user;

import dal.user.TourDAO;
import model.Tour;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "TourListServlet", urlPatterns = {"/tours"})
public class TourListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TourDAO dao = new TourDAO();
        
        // Có thể thêm logic phân trang hoặc lọc theo category ở đây sau này
        // String category = request.getParameter("category");
        
        List<Tour> list = dao.getAllTours();
        
        request.setAttribute("listT", list);
        request.getRequestDispatcher("/user/tour/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
