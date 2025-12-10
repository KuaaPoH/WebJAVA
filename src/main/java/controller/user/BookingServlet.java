package controller.user;

import dal.user.OrderDAO;
import dal.user.TourDAO;
import model.Order;
import model.OrderDetail;
import model.Tour;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        try {
            // 1. Nhận dữ liệu từ form
            int tourId = Integer.parseInt(request.getParameter("tourId"));
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            int guests = Integer.parseInt(request.getParameter("guests"));
            String dateStr = request.getParameter("date");
            
            // 2. Lấy thông tin tour để tính giá
            TourDAO tourDAO = new TourDAO();
            Tour tour = tourDAO.getTourById(tourId);
            
            if (tour == null) {
                response.sendRedirect("home");
                return;
            }
            
            // Tính giá (ưu tiên giá Sale)
            int pricePerPerson = (tour.getPriceSale() > 0) ? tour.getPriceSale() : tour.getPrice();
            int totalAmount = pricePerPerson * guests;
            
            // Parse ngày khởi hành
            Date departureDate = null;
            try {
                departureDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
            } catch (ParseException e) {
                e.printStackTrace();
            }

            // 3. Tạo Order Object
            Order order = new Order();
            order.setCode("ORD" + System.currentTimeMillis()); // Mã đơn hàng đơn giản
            order.setCustomerName(fullname);
            order.setEmail(email);
            order.setPhone(phone);
            order.setAddress(""); // Tạm để trống hoặc thêm trường địa chỉ vào form nếu cần
            order.setQuanlity(guests);
            order.setTotalAmount(totalAmount);
            
            // 4. Tạo OrderDetail Object
            OrderDetail detail = new OrderDetail();
            detail.setTourId(tourId);
            detail.setPrice(pricePerPerson);
            detail.setQuantity(guests);
            detail.setDepartureDate(departureDate);
            
            // 5. Lưu vào database
            OrderDAO orderDAO = new OrderDAO();
            boolean success = orderDAO.insertOrder(order, detail);
            
            if (success) {
                // Gửi thông báo thành công (có thể chuyển sang trang booking-success.jsp)
                request.setAttribute("message", "Đặt tour thành công! Mã đơn hàng của bạn là: " + order.getCode());
                request.getRequestDispatcher("/user/booking/success.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đặt tour thất bại. Vui lòng thử lại sau.");
                request.getRequestDispatcher("tour-detail?id=" + tourId).forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
}
