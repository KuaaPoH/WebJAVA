package controller.admin;

import dal.admin.SlideDAO;
import model.Slide;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.text.Normalizer;
import java.util.List;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(name = "SlideServlet", urlPatterns = {"/admin/quanlyslide"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class SlideServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        SlideDAO dao = new SlideDAO();

        if (action == null || action.equals("list")) {
            List<Slide> list = dao.getAllSlides();
            request.setAttribute("slides", list);
            request.getRequestDispatcher("/admin/quanlyslide/index.jsp").forward(request, response);
        } else if (action.equals("add")) {
            request.getRequestDispatcher("/admin/quanlyslide/form.jsp").forward(request, response);
        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Slide s = dao.getSlideById(id);
            request.setAttribute("slide", s);
            request.getRequestDispatcher("/admin/quanlyslide/form.jsp").forward(request, response);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteSlide(id);
            response.sendRedirect("quanlyslide");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        SlideDAO dao = new SlideDAO();

        try {
            if (action.equals("insert")) {
                String title = request.getParameter("title");
                String alias = request.getParameter("alias");
                boolean isActive = request.getParameter("isActive") != null;
                
                // Auto generate alias if empty
                if (alias == null || alias.trim().isEmpty()) {
                    alias = toSlug(title);
                }

                // Handle Image Upload
                Part filePart = request.getPart("image");
                String fileName = getSubmittedFileName(filePart);
                String imagePath = "";

                if (fileName != null && !fileName.isEmpty()) {
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "images" + File.separator + "banners";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();
                    
                    // Rename file to avoid conflict (optional, here keep simple)
                    filePart.write(uploadPath + File.separator + fileName);
                    imagePath = "banners/" + fileName; // Store relative path
                }

                Slide s = new Slide(0, title, alias, imagePath, isActive);
                dao.insertSlide(s);
                response.sendRedirect("quanlyslide");

            } else if (action.equals("update")) {
                int id = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                String alias = request.getParameter("alias");
                boolean isActive = request.getParameter("isActive") != null;
                String currentImage = request.getParameter("currentImage");

                if (alias == null || alias.trim().isEmpty()) {
                    alias = toSlug(title);
                }

                // Handle Image Upload
                Part filePart = request.getPart("image");
                String fileName = getSubmittedFileName(filePart);
                String imagePath = currentImage; // Default to old image

                if (fileName != null && !fileName.isEmpty()) {
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "images" + File.separator + "banners";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();
                    
                    filePart.write(uploadPath + File.separator + fileName);
                    imagePath = "banners/" + fileName;
                }

                Slide s = new Slide(id, title, alias, imagePath, isActive);
                dao.updateSlide(s);
                response.sendRedirect("quanlyslide");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý: " + e.getMessage());
            request.getRequestDispatcher("/admin/quanlyslide/form.jsp").forward(request, response);
        }
    }

    // Utility to get filename from Part
    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

    // Utility to create slug
    public static String toSlug(String input) {
        if (input == null) return "";
        String nowhitespace = input.trim().replaceAll("\\s+", "-");
        String normalized = Normalizer.normalize(nowhitespace, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(normalized).replaceAll("").toLowerCase().replaceAll("[^a-z0-9-]", "");
    }
}
