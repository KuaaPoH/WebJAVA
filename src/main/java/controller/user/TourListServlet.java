package controller.user;

import dal.user.TourDAO;
import dal.admin.SlideDAO;
import model.Tour;
import model.Slide;
import model.TourCategory;
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
        
        // 1. Get Banner Slides (Added Feature)
        SlideDAO slideDao = new SlideDAO();
        List<Slide> slides = slideDao.getActiveSlides();
        request.setAttribute("slides", slides);

        // 2. Get Filters
        String keyword = request.getParameter("keyword");
        String categoryIdStr = request.getParameter("category");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String pageStr = request.getParameter("page");

        // 3. Parse Parameters
        Integer categoryId = null;
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
            }
        }

        Double minPrice = null;
        if (minPriceStr != null && !minPriceStr.isEmpty()) {
            try {
                minPrice = Double.parseDouble(minPriceStr);
            } catch (NumberFormatException e) {
            }
        }

        Double maxPrice = null;
        if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
            try {
                maxPrice = Double.parseDouble(maxPriceStr);
            } catch (NumberFormatException e) {
            }
        }

        int page = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
            }
        }
        int pageSize = 9; 

        // 4. Call DAO
        TourDAO dao = new TourDAO();
        List<Tour> list = dao.searchTours(keyword, categoryId, minPrice, maxPrice, page, pageSize);
        int totalTours = dao.countTours(keyword, categoryId, minPrice, maxPrice);
        int totalPages = (int) Math.ceil((double) totalTours / pageSize);
        List<TourCategory> categories = dao.getAllTourCategories();

        // 5. Set Attributes
        request.setAttribute("listT", list);
        request.setAttribute("categories", categories);
        request.setAttribute("keyword", keyword);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/user/tour/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}