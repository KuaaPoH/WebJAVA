package controller.admin;

import dal.admin.ReviewDAO;
import model.BlogComment;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "BlogReviewServlet", urlPatterns = {"/admin/blog-reviews"})
public class BlogReviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ReviewDAO dao = new ReviewDAO();

        if (action == null || action.equals("list")) {
            List<BlogComment> listComments = dao.getAllBlogComments();
            System.out.println("DEBUG: listComments size = " + (listComments != null ? listComments.size() : "null"));
            
            request.setAttribute("blogComments", listComments);
            request.getRequestDispatcher("/admin/quanlydanhgiablog/index.jsp").forward(request, response);
        } else if (action.equals("hide")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.updateBlogCommentStatus(id, false);
            response.sendRedirect("blog-reviews");
        } else if (action.equals("show")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.updateBlogCommentStatus(id, true);
            response.sendRedirect("blog-reviews");
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteBlogComment(id);
            response.sendRedirect("blog-reviews");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        doGet(request, response);
    }
}
