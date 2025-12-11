package controller.filter;

import model.Account;
import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(filterName = "AdminFilter", urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter nếu cần
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("admin") != null);

        if (isLoggedIn) {
            // Kiểm tra thêm Role nếu cần (ví dụ chỉ RoleID = 1 mới được vào)
            Account adminAccount = (Account) session.getAttribute("admin");
            if (adminAccount.getRoleId() == 1 || adminAccount.getRoleId() == 2) { // Giả sử 1, 2 là Admin/Staff
                 chain.doFilter(request, response);
            } else {
                 // Đã login nhưng không đủ quyền (ví dụ User thường cố tình set session admin - khó xảy ra nhưng phòng hờ)
                 httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=unauthorized");
            }
        } else {
            // Chưa đăng nhập Admin
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // Hủy filter
    }
}
