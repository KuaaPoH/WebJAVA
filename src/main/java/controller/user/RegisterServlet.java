package controller.user;

import dal.user.CustomerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Truyền các thông báo lỗi từ doPost nếu có
        String registerError = (String) request.getSession().getAttribute("registerError");
        if (registerError != null) {
            request.setAttribute("error", registerError);
            request.getSession().removeAttribute("registerError");
        }
        request.getRequestDispatcher("/user/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rePassword = request.getParameter("re_password");

        HttpSession session = request.getSession();

        if (!password.equals(rePassword)) {
            session.setAttribute("registerError", "Mật khẩu xác nhận không khớp!");
            response.sendRedirect("register");
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        if (customerDAO.checkEmailExist(email)) {
            session.setAttribute("registerError", "Email này đã được sử dụng!");
            response.sendRedirect("register");
            return;
        }

        // Đăng ký thành công
        customerDAO.register(username, email, password);
        session.setAttribute("registerMessage", "Đăng ký thành công! Vui lòng đăng nhập.");
        response.sendRedirect("login"); // Chuyển hướng về trang login
    }
}
