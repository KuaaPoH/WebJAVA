package controller.admin;

import dal.admin.ContactDAO;
import model.Contact;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminContactServlet", urlPatterns = {"/admin/quanlylienhe"})
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "view":
                viewContact(request, response);
                break;
            case "delete":
                deleteContact(request, response);
                break;
            default:
                listContacts(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // No POST actions needed for this module yet, can be used for future enhancements
        doGet(request, response);
    }

    private void listContacts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ContactDAO dao = new ContactDAO();
        List<Contact> list = dao.getAllContacts();
        request.setAttribute("listC", list);
        request.getRequestDispatcher("/admin/quanlylienhe/index.jsp").forward(request, response);
    }

    private void viewContact(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ContactDAO dao = new ContactDAO();
            
            // Mark the contact as read when it is viewed
            dao.markAsRead(id);
            
            Contact contact = dao.getContactById(id);
            if (contact != null) {
                request.setAttribute("contact", contact);
                request.getRequestDispatcher("/admin/quanlylienhe/view.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/quanlylienhe");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/quanlylienhe");
        }
    }

    private void deleteContact(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            ContactDAO dao = new ContactDAO();
            dao.delete(id);
        } catch (NumberFormatException e) {
            // Log error or handle appropriately
        }
        response.sendRedirect(request.getContextPath() + "/admin/quanlylienhe");
    }
}
