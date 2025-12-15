package controller.user;

import dal.user.ContactDAO;
import model.Contact;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UserContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get Slides
        dal.admin.SlideDAO slideDao = new dal.admin.SlideDAO();
        java.util.List<model.Slide> slides = slideDao.getActiveSlides();
        request.setAttribute("slides", slides);
        
        request.getRequestDispatcher("/user/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // Get Slides (Re-fetch for postback)
        dal.admin.SlideDAO slideDao = new dal.admin.SlideDAO();
        java.util.List<model.Slide> slides = slideDao.getActiveSlides();
        request.setAttribute("slides", slides);

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");

        Contact c = new Contact();
        c.setName(name);
        c.setEmail(email);
        c.setPhone(phone);
        c.setMessage(message);

        ContactDAO dao = new ContactDAO();
        boolean success = dao.insert(c);

        if (success) {
            request.setAttribute("message", "Cảm ơn bạn đã liên hệ. Chúng tôi sẽ phản hồi sớm nhất!");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Có lỗi xảy ra. Vui lòng thử lại sau.");
            request.setAttribute("messageType", "danger");
        }
        
        request.getRequestDispatcher("/user/contact.jsp").forward(request, response);
    }
}
