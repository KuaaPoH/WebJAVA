package controller;

import dal.TourDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; // Important for Servlet 3.0+
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Tour;

// Annotation mapping is easier than web.xml
@WebServlet(name = "TourServlet", urlPatterns = {"/admin/quanlytour"})
public class TourServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                showCreateForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteTour(request, response);
                break;
            case "toggle":
                toggleTourStatus(request, response);
                break;
            default:
                listTours(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "insert":
                insertTour(request, response);
                break;
            case "update":
                updateTour(request, response);
                break;
            default:
                listTours(request, response);
                break;
        }
    }

    private void listTours(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        TourDAO dao = new TourDAO();
        List<Tour> list = dao.getAllTours();
        request.setAttribute("listT", list);
        request.getRequestDispatcher("/admin/quanlytour/index.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/quanlytour/add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        TourDAO dao = new TourDAO();
        Tour existingTour = dao.getTourById(id);
        request.setAttribute("tour", existingTour);
        request.getRequestDispatcher("/admin/quanlytour/edit.jsp").forward(request, response);
    }

    private void insertTour(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String title = request.getParameter("title");
        String image = request.getParameter("image");
        int price = Integer.parseInt(request.getParameter("price"));
        String description = request.getParameter("description");
        String detail = request.getParameter("detail");
        String location = request.getParameter("location");
        int timeTravel = Integer.parseInt(request.getParameter("timeTravel"));
        boolean isActive = request.getParameter("active") != null;

        Tour newTour = new Tour();
        newTour.setTitle(title);
        newTour.setImage(image);
        newTour.setPrice(price);
        newTour.setDescription(description);
        newTour.setDetail(detail);
        newTour.setLocation(location);
        newTour.setTimeTravel(timeTravel);
        newTour.setActive(isActive);

        TourDAO dao = new TourDAO();
        dao.insert(newTour);
        response.sendRedirect(request.getContextPath() + "/admin/quanlytour");
    }

    private void updateTour(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String image = request.getParameter("image");
        int price = Integer.parseInt(request.getParameter("price"));
        String description = request.getParameter("description");
        String detail = request.getParameter("detail");
        String location = request.getParameter("location");
        int timeTravel = Integer.parseInt(request.getParameter("timeTravel"));
        boolean isActive = request.getParameter("active") != null;

        Tour tour = new Tour();
        tour.setTourId(id);
        tour.setTitle(title);
        tour.setImage(image);
        tour.setPrice(price);
        tour.setDescription(description);
        tour.setDetail(detail);
        tour.setLocation(location);
        tour.setTimeTravel(timeTravel);
        tour.setActive(isActive);

        TourDAO dao = new TourDAO();
        dao.update(tour);
        response.sendRedirect(request.getContextPath() + "/admin/quanlytour");
    }

    private void deleteTour(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        TourDAO dao = new TourDAO();
        dao.delete(id);
        response.sendRedirect(request.getContextPath() + "/admin/quanlytour");
    }

    private void toggleTourStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        TourDAO dao = new TourDAO();
        dao.toggleStatus(id);
        response.sendRedirect(request.getContextPath() + "/admin/quanlytour");
    }
}
