package controller.user;

import dal.admin.AccountDAO;
import dal.user.CustomerDAO;
import model.Account;
import model.Customer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login", "/logout"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getServletPath();
        if ("/logout".equals(action)) {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("login");
            return;
        }
        
        // Nếu đã đăng nhập rồi thì chuyển hướng
        HttpSession session = request.getSession(false);
        if (session != null) {
            if (session.getAttribute("admin") != null) {
                response.sendRedirect("admin");
                return;
            }
            if (session.getAttribute("user") != null) {
                response.sendRedirect("home");
                return;
            }
        }
        
        // Truyền các thông báo từ RegisterServlet nếu có
        String registerMessage = (String) request.getSession().getAttribute("registerMessage");
        if (registerMessage != null) {
            request.setAttribute("message", registerMessage);
            request.getSession().removeAttribute("registerMessage");
        }
        
        // Truyền thông báo yêu cầu đăng nhập (từ BookingPageServlet)
        String loginMessage = (String) request.getSession().getAttribute("loginMessage");
        if (loginMessage != null) {
            request.setAttribute("error", loginMessage); // Hiển thị như lỗi để người dùng chú ý
            request.getSession().removeAttribute("loginMessage");
        }

        request.getRequestDispatcher("/user/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user = request.getParameter("username"); // Có thể là username hoặc email
        String pass = request.getParameter("password");
        
        AccountDAO accountDAO = new AccountDAO();
        CustomerDAO customerDAO = new CustomerDAO();
        HttpSession session = request.getSession();

        // 1. Thử đăng nhập Admin trước
        Account admin = accountDAO.checkLogin(user, pass);
        if (admin != null) {
            session.setAttribute("admin", admin);
            session.setAttribute("role", "admin"); // Role identifier
            response.sendRedirect("admin");
            return;
        }

        // 2. Thử đăng nhập User
        Customer customer = customerDAO.checkLogin(user, pass);
        if (customer != null) {
            session.setAttribute("user", customer);
            session.setAttribute("role", "user");
            
            // Kiểm tra redirectUrl
            String redirectUrl = (String) session.getAttribute("redirectUrl");
            if (redirectUrl != null) {
                session.removeAttribute("redirectUrl");
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect("home");
            }
            return;
        }

        // 3. Đăng nhập thất bại
        request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
        request.setAttribute("username", user); // Giữ lại username để user đỡ phải nhập lại
        request.getRequestDispatcher("/user/login.jsp").forward(request, response);
    }
}
