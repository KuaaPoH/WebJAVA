package controller.admin;

import dal.admin.AccountDAO;
import model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet(name = "AdminProfileServlet", urlPatterns = {"/admin/profile"})
@MultipartConfig
public class ProfileServlet extends HttpServlet {

    private final String UPLOAD_DIRECTORY = "assets/images/users";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account admin = (Account) session.getAttribute("admin");
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("/admin/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account admin = (Account) session.getAttribute("admin");
        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        AccountDAO dao = new AccountDAO();

        if ("changePass".equals(action)) {
            String currentPass = request.getParameter("currentPass");
            String newPass = request.getParameter("newPass");
            String confirmPass = request.getParameter("confirmPass");

            if (!admin.getPassword().equals(currentPass)) {
                request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            } else if (!newPass.equals(confirmPass)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            } else {
                dao.changePassword(admin.getAccountId(), newPass);
                admin.setPassword(newPass);
                session.setAttribute("admin", admin); // Update session
                request.setAttribute("message", "Đổi mật khẩu thành công!");
            }
        } else if ("updateInfo".equals(action)) {
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String description = request.getParameter("description");
            
            // Handle Image Upload (Dual Save)
            Part filePart = request.getPart("avatarFile");
            String fileName = admin.getImage(); // Keep old image by default

            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    fileName = System.currentTimeMillis() + "_" + submittedFileName;

                    // 1. Save to deployed server path (for immediate display)
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs();
                    
                    Path deployedPath = Paths.get(uploadPath, fileName);
                    try (InputStream input = filePart.getInputStream()) {
                        Files.copy(input, deployedPath, StandardCopyOption.REPLACE_EXISTING);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    // 2. Save to source code path (for git persistence)
                    // Hardcoded source path based on project convention in TAI_LIEU_KY_THUAT.md
                    String sourcePathStr = "D:\\hai\\WebJAVA\\src\\main\\webapp\\";
                    sourcePathStr += UPLOAD_DIRECTORY;
                    File sourceDir = new File(sourcePathStr);
                    if (!sourceDir.exists()) sourceDir.mkdirs();
                    
                    Path sourcePath = Paths.get(sourcePathStr, fileName);
                    try {
                        Files.copy(deployedPath, sourcePath, StandardCopyOption.REPLACE_EXISTING);
                    } catch (Exception e) {
                        System.err.println("Could not save to source directory: " + e.getMessage());
                    }
                }
            }

            // Update Object
            admin.setFullName(fullName);
            admin.setPhone(phone);
            admin.setEmail(email);
            admin.setDescription(description);
            admin.setImage(fileName);

            // Update DB
            dao.updateProfile(admin);
            session.setAttribute("admin", admin); // Update session
            request.setAttribute("message", "Cập nhật hồ sơ thành công!");
        }

        request.getRequestDispatcher("/admin/profile.jsp").forward(request, response);
    }
}
