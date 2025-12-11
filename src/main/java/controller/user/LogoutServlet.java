package controller.user;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String role = request.getParameter("role");

        if (session != null) {
            if ("admin".equals(role)) {
                // Chỉ đăng xuất Admin
                session.removeAttribute("admin");
                // Nếu không còn user, có thể invalidate luôn nếu muốn sạch sẽ, nhưng không bắt buộc
                if (session.getAttribute("user") == null) {
                    session.invalidate();
                }
                response.sendRedirect("login"); // Admin logout về trang login
            } else if ("user".equals(role)) {
                // Chỉ đăng xuất User
                session.removeAttribute("user");
                if (session.getAttribute("admin") == null) {
                    session.invalidate();
                }
                response.sendRedirect("home"); // User logout về trang chủ
            } else {
                // Logout tất cả (mặc định cũ)
                session.invalidate();
                response.sendRedirect("login");
            }
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
