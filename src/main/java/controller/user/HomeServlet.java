package controller.user;

import dal.user.TourDAO;
import dal.admin.SlideDAO;
import model.Tour;
import model.Slide;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", ""})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TourDAO tourDao = new TourDAO();
        List<Tour> list = tourDao.getTopTours(6);
        
        SlideDAO slideDao = new SlideDAO();
        List<Slide> slides = slideDao.getActiveSlides();
        
        request.setAttribute("listT", list);
        request.setAttribute("slides", slides);
        request.getRequestDispatcher("/user/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
