package controller;

import dal.BlogDAO;
import model.Blog;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(name = "BlogServlet", urlPatterns = {"/admin/quanlyblog"})
@MultipartConfig
public class BlogServlet extends HttpServlet {

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
                deleteBlog(request, response);
                break;
            case "toggle":
                toggleBlogStatus(request, response);
                break;
            default:
                listBlogs(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Handle Vietnamese characters
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "insert":
                insertBlog(request, response);
                break;
            case "update":
                updateBlog(request, response);
                break;
            default:
                listBlogs(request, response);
                break;
        }
    }

    private void listBlogs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BlogDAO dao = new BlogDAO();
        List<Blog> list = dao.getAllBlogs();
        request.setAttribute("listB", list);
        request.getRequestDispatcher("/admin/quanlyblog/index.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/quanlyblog/add.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            BlogDAO dao = new BlogDAO();
            Blog existingBlog = dao.getBlogById(id);
            if (existingBlog != null) {
                request.setAttribute("blog", existingBlog);
                request.getRequestDispatcher("/admin/quanlyblog/edit.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/quanlyblog");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/quanlyblog");
        }
    }

    private void insertBlog(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String detail = request.getParameter("detail");
        boolean isActive = "on".equals(request.getParameter("active"));

        Part filePart = request.getPart("imageFile");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        if (fileName != null && !fileName.isEmpty()) {
            // 1. Save to temporary deployment directory
            String deployedUploadPath = getServletContext().getRealPath("/assets/images/blogs");
            Path deployedPath = Paths.get(deployedUploadPath, fileName);
            Files.createDirectories(deployedPath.getParent());
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, deployedPath, StandardCopyOption.REPLACE_EXISTING);
            }

            // 2. Save to source directory
            try {
                String sourceProjectPath = "D:\\hai\\WebJAVA";
                String sourceUploadPath = Paths.get(sourceProjectPath, "src", "main", "webapp", "assets", "images", "blogs").toString();
                Path sourcePath = Paths.get(sourceUploadPath, fileName);
                Files.createDirectories(sourcePath.getParent());
                Files.copy(deployedPath, sourcePath, StandardCopyOption.REPLACE_EXISTING);
            } catch (Exception e) {
                System.err.println("Could not save file to source directory: " + e.getMessage());
            }
        }

        Blog newBlog = new Blog();
        newBlog.setTitle(title);
        newBlog.setImage(fileName);
        newBlog.setDescription(description);
        newBlog.setDetail(detail);
        newBlog.setActive(isActive);

        BlogDAO dao = new BlogDAO();
        dao.insert(newBlog);
        response.sendRedirect(request.getContextPath() + "/admin/quanlyblog");
    }

    private void updateBlog(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String detail = request.getParameter("detail");
            boolean isActive = "on".equals(request.getParameter("active"));
            String currentImage = request.getParameter("currentImage");

            Part filePart = request.getPart("imageFile");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String imageToSave;

            if (fileName != null && !fileName.isEmpty()) {
                imageToSave = fileName;
                // 1. Save to temporary deployment directory
                String deployedUploadPath = getServletContext().getRealPath("/assets/images/blogs");
                Path deployedPath = Paths.get(deployedUploadPath, imageToSave);
                Files.createDirectories(deployedPath.getParent());
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, deployedPath, StandardCopyOption.REPLACE_EXISTING);
                }
                
                // 2. Save to source directory
                try {
                    String sourceProjectPath = "D:\\hai\\WebJAVA";
                    String sourceUploadPath = Paths.get(sourceProjectPath, "src", "main", "webapp", "assets", "images", "blogs").toString();
                    Path sourcePath = Paths.get(sourceUploadPath, imageToSave);
                    Files.createDirectories(sourcePath.getParent());
                    Files.copy(deployedPath, sourcePath, StandardCopyOption.REPLACE_EXISTING);
                } catch (Exception e) {
                    System.err.println("Could not save file to source directory: " + e.getMessage());
                }
            } else {
                imageToSave = currentImage;
            }

            Blog blog = new Blog();
            blog.setBlogId(id);
            blog.setTitle(title);
            blog.setImage(imageToSave);
            blog.setDescription(description);
            blog.setDetail(detail);
            blog.setActive(isActive);

            BlogDAO dao = new BlogDAO();
            dao.update(blog);
            response.sendRedirect(request.getContextPath() + "/admin/quanlyblog");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/quanlyblog");
        }
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            BlogDAO dao = new BlogDAO();
            dao.delete(id);
        } catch (NumberFormatException e) {
            // Log error or handle appropriately
        }
        response.sendRedirect(request.getContextPath() + "/admin/quanlyblog");
    }

    private void toggleBlogStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            BlogDAO dao = new BlogDAO();
            dao.toggleStatus(id);
        } catch (NumberFormatException e) {
            // Log error or handle appropriately
        }
        response.sendRedirect(request.getContextPath() + "/admin/quanlyblog");
    }
}
