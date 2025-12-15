package controller.user;

import dal.user.BlogCommentDAO;
import dal.user.BlogDAO;
import model.Blog;
import model.BlogComment;
import model.Customer;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "BlogDetailServlet", urlPatterns = {"/blog-detail"})
public class BlogDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("blog");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            BlogDAO blogDao = new BlogDAO();
            BlogCommentDAO commentDao = new BlogCommentDAO();
            
            // Get Slides
            dal.admin.SlideDAO slideDao = new dal.admin.SlideDAO();
            java.util.List<model.Slide> slides = slideDao.getActiveSlides();
            request.setAttribute("slides", slides);

            // 1. Tăng view
            blogDao.increaseViewCount(id);

            // 2. Lấy chi tiết Blog
            Blog blog = blogDao.getBlogById(id);
            if (blog == null) {
                response.sendRedirect("blog");
                return;
            }

            // 3. Lấy comment
            List<BlogComment> comments = commentDao.getCommentsByBlogId(id);

            // 4. Lấy bài viết mới nhất (cho Sidebar)
            List<Blog> recentBlogs = blogDao.getLatestBlogs(3);

            request.setAttribute("blog", blog);
            request.setAttribute("comments", comments);
            request.setAttribute("recentBlogs", recentBlogs);
            
            request.getRequestDispatcher("/user/blog_detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("blog");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("blogId");
        if (idStr == null) {
            response.sendRedirect("blog");
            return;
        }

        try {
            int blogId = Integer.parseInt(idStr);
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String detail = request.getParameter("detail");
            
            // Xử lý thông tin người dùng (nếu đã login)
            HttpSession session = request.getSession();
            Customer user = (Customer) session.getAttribute("user");
            String avatar = "reviewer/avatar-1.jpg"; // Default

            if (user != null) {
                name = user.getUsername(); // Hoặc FullName nếu có
                email = user.getEmail();
                if (user.getAvatar() != null) {
                    avatar = user.getAvatar();
                }
            } else {
                if (name == null || name.trim().isEmpty()) name = "Ẩn Danh";
            }

            BlogComment comment = new BlogComment();
            comment.setBlogId(blogId);
            comment.setName(name);
            comment.setEmail(email);
            comment.setDetail(detail);
            comment.setImage(avatar);
            comment.setActive(true); // Auto approve

            BlogCommentDAO dao = new BlogCommentDAO();
            dao.insertComment(comment);

            response.sendRedirect("blog-detail?id=" + blogId);

        } catch (NumberFormatException e) {
            response.sendRedirect("blog");
        }
    }
}
