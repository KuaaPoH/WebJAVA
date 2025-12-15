package controller.user;

import dal.user.BlogDAO;
import model.Blog;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UserBlogServlet", urlPatterns = {"/blog", "/blogs"})
public class BlogServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get Slides
        dal.admin.SlideDAO slideDao = new dal.admin.SlideDAO();
        java.util.List<model.Slide> slides = slideDao.getActiveSlides();
        request.setAttribute("slides", slides);

        BlogDAO dao = new BlogDAO();
        List<Blog> list = dao.getAllBlogs();
        
        request.setAttribute("blogList", list);
        request.getRequestDispatcher("/user/blog.jsp").forward(request, response);
    }
}
