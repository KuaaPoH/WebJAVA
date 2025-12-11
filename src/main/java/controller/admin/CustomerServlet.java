package controller.admin;

import dal.admin.CustomerDAO;
import model.Customer;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminCustomerServlet", urlPatterns = {"/admin/customers"})
public class CustomerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerDAO dao = new CustomerDAO();

        if (action == null || action.equals("list")) {
            List<Customer> list = dao.getAllCustomers();
            request.setAttribute("customers", list);
            request.getRequestDispatcher("/admin/quanlynguoidung/index.jsp").forward(request, response);
        } else if (action.equals("lock")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.updateStatus(id, false); // false = Locked/Inactive
            response.sendRedirect("customers");
        } else if (action.equals("unlock")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.updateStatus(id, true); // true = Active
            response.sendRedirect("customers");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
