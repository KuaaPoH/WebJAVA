package controller.admin;

import dal.admin.TourDAO;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Tour;

@WebServlet(name = "TourServlet", urlPatterns = {"/admin/quanlytour"})
@MultipartConfig
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
        request.setCharacterEncoding("UTF-8");
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
            throws IOException, ServletException {
        String title = request.getParameter("title");
        int price = Integer.parseInt(request.getParameter("price"));
        String description = request.getParameter("description");
        String detail = request.getParameter("detail");
        String location = request.getParameter("location");
        int timeTravel = Integer.parseInt(request.getParameter("timeTravel"));
        boolean isActive = "on".equals(request.getParameter("active"));

        Part filePart = request.getPart("imageFile");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        if (fileName != null && !fileName.isEmpty()) {
            // 1. Save to temporary deployment directory (for immediate display)
            String deployedUploadPath = getServletContext().getRealPath("/assets/images/products");
            Path deployedPath = Paths.get(deployedUploadPath, fileName);
            Files.createDirectories(deployedPath.getParent());
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, deployedPath, StandardCopyOption.REPLACE_EXISTING);
            }

            // 2. Save to source directory (for Git)
            try {
                String sourceProjectPath = "D:\\hai\\WebJAVA";
                String sourceUploadPath = Paths.get(sourceProjectPath, "src", "main", "webapp", "assets", "images", "products").toString();
                Path sourcePath = Paths.get(sourceUploadPath, fileName);
                Files.createDirectories(sourcePath.getParent());
                Files.copy(deployedPath, sourcePath, StandardCopyOption.REPLACE_EXISTING);
            } catch (Exception e) {
                System.err.println("Could not save file to source directory: " + e.getMessage());
            }
        }

        Tour newTour = new Tour();
        newTour.setTitle(title);
        newTour.setImage(fileName);
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
            throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        int price = Integer.parseInt(request.getParameter("price"));
        String description = request.getParameter("description");
        String detail = request.getParameter("detail");
        String location = request.getParameter("location");
        int timeTravel = Integer.parseInt(request.getParameter("timeTravel"));
        boolean isActive = "on".equals(request.getParameter("active"));
        String currentImage = request.getParameter("currentImage");

        Part filePart = request.getPart("imageFile");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String imageToSave;

        if (fileName != null && !fileName.isEmpty()) {
            imageToSave = fileName;
            // 1. Save to temporary deployment directory
            String deployedUploadPath = getServletContext().getRealPath("/assets/images/products");
            Path deployedPath = Paths.get(deployedUploadPath, imageToSave);
            Files.createDirectories(deployedPath.getParent());
             try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, deployedPath, StandardCopyOption.REPLACE_EXISTING);
            }
            // 2. Save to source directory
            try {
                String sourceProjectPath = "D:\\hai\\WebJAVA";
                String sourceUploadPath = Paths.get(sourceProjectPath, "src", "main", "webapp", "assets", "images", "products").toString();
                Path sourcePath = Paths.get(sourceUploadPath, imageToSave);
                Files.createDirectories(sourcePath.getParent());
                Files.copy(deployedPath, sourcePath, StandardCopyOption.REPLACE_EXISTING);
            } catch (Exception e) {
                System.err.println("Could not save file to source directory: " + e.getMessage());
            }
        } else {
            imageToSave = currentImage;
        }

        Tour tour = new Tour();
        tour.setTourId(id);
        tour.setTitle(title);
        tour.setImage(imageToSave);
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
