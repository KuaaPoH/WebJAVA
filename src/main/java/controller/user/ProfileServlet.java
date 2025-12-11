package controller.user;

import dal.user.CustomerDAO;
import dal.user.OrderDAO;
import model.Customer;
import model.Order;
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
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("user");

        // 1. Check Login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 2. Get Order History
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orderList = orderDAO.getOrdersByEmail(user.getEmail());

        // 3. Set Attributes
        request.setAttribute("orderList", orderList);

        // 4. Forward to JSP
        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer user = (Customer) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String contentType = request.getContentType();
        
        // --- CASE 1: AVATAR UPLOAD (Multipart) ---
        if (contentType != null && contentType.startsWith("multipart/")) {
            try {
                Part filePart = request.getPart("avatarFile");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    // Rename file to avoid conflict: user_id_timestamp.ext
                    String fileExt = fileName.substring(fileName.lastIndexOf("."));
                    String newFileName = "user_" + user.getCustomerId() + "_" + System.currentTimeMillis() + fileExt;

                    // 1. Save to temporary deployment directory (webapp/assets/images/users)
                    String deployedUploadPath = getServletContext().getRealPath("/assets/images/users");
                    Path deployedPath = Paths.get(deployedUploadPath, newFileName);
                    Files.createDirectories(deployedPath.getParent());
                    try (InputStream input = filePart.getInputStream()) {
                        Files.copy(input, deployedPath, StandardCopyOption.REPLACE_EXISTING);
                    }

          
                    try {
                        String sourceProjectPath = "D:\\hai\\WebJAVA";
                        String sourceUploadPath = Paths.get(sourceProjectPath, "src", "main", "webapp", "assets", "images", "users").toString();
                        Path sourcePath = Paths.get(sourceUploadPath, newFileName);
                        Files.createDirectories(sourcePath.getParent());
                        Files.copy(deployedPath, sourcePath, StandardCopyOption.REPLACE_EXISTING);
                    } catch (Exception e) {
                        System.err.println("Could not save file to source directory: " + e.getMessage());
                    }

                    // 3. Update Database
                    CustomerDAO customerDAO = new CustomerDAO();
                    customerDAO.updateAvatar(user.getCustomerId(), newFileName);

                    // 4. Update Session
                    user.setAvatar(newFileName);
                    session.setAttribute("user", user);
                    
                    session.setAttribute("message", "Cập nhật ảnh đại diện thành công!");
                    session.setAttribute("messageType", "success");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("message", "Lỗi khi upload ảnh: " + e.getMessage());
                session.setAttribute("messageType", "danger");
            }
        } 
        // --- CASE 2: INFO UPDATE (Normal Form) ---
        else {
            String phone = request.getParameter("phone");
            String birthdayStr = request.getParameter("birthday");
            
            // Validation
            boolean hasError = false;
            String errorMessage = "";

            // Validate Phone: Must be 10 digits, starts with 0
            if (phone == null || !phone.matches("^0\\d{9}$")) {
                hasError = true;
                errorMessage = "Số điện thoại không hợp lệ (Phải có 10 số và bắt đầu bằng 0).";
            }

            // Validate Birthday
            java.sql.Date dob = null;
            if (!hasError) {
                try {
                    dob = java.sql.Date.valueOf(birthdayStr); // Format yyyy-MM-dd
                    // Check if future date
                    if (dob.after(new java.util.Date(System.currentTimeMillis()))) {
                        hasError = true;
                        errorMessage = "Ngày sinh không thể lớn hơn ngày hiện tại.";
                    }
                } catch (IllegalArgumentException e) {
                    hasError = true;
                    errorMessage = "Định dạng ngày sinh không hợp lệ.";
                }
            }

            if (hasError) {
                session.setAttribute("message", errorMessage);
                session.setAttribute("messageType", "danger");
            } else {
                CustomerDAO dao = new CustomerDAO();
                boolean success = dao.updateProfile(user.getCustomerId(), phone, dob);
                if (success) {
                    // Update Session
                    user.setPhone(phone);
                    user.setBirthday(dob);
                    session.setAttribute("user", user);
                    
                    session.setAttribute("message", "Cập nhật thông tin thành công!");
                    session.setAttribute("messageType", "success");
                } else {
                    session.setAttribute("message", "Có lỗi xảy ra, vui lòng thử lại.");
                    session.setAttribute("messageType", "danger");
                }
            }
        }

        // Redirect back to profile to see changes
        response.sendRedirect(request.getContextPath() + "/profile");
    }
}
