package controller.user;

import dal.user.TourDAO;
import dal.user.TourReviewDAO;
import model.Tour;
import model.TourReview;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "TourDetailServlet", urlPatterns = {"/tour-detail"})
public class TourDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam == null) {
                 response.sendRedirect("home");
                 return;
            }
            int id = Integer.parseInt(idParam);
            TourDAO dao = new TourDAO();
            Tour tour = dao.getTourById(id);
            
            if (tour != null) {
                // Get Slides
                dal.admin.SlideDAO slideDao = new dal.admin.SlideDAO();
                java.util.List<model.Slide> slides = slideDao.getActiveSlides();
                request.setAttribute("slides", slides);

                request.setAttribute("tour", tour);
                
                // Load Reviews
                TourReviewDAO reviewDAO = new TourReviewDAO();
                List<TourReview> reviews = reviewDAO.getReviewsByTourId(id);
                request.setAttribute("reviews", reviews);
                
                // Tính điểm đánh giá trung bình (nếu cần hiển thị dynamic thay vì fix trong DB)
                double avgStar = 0;
                if (!reviews.isEmpty()) {
                    int totalStar = 0;
                    for (TourReview r : reviews) {
                        totalStar += r.getStar();
                    }
                    avgStar = (double) totalStar / reviews.size();
                    // Làm tròn 1 chữ số thập phân
                    avgStar = Math.round(avgStar * 10.0) / 10.0;
                }
                request.setAttribute("avgStar", avgStar > 0 ? avgStar : tour.getStar()); // Ưu tiên tính toán hoặc lấy từ Tour
                request.setAttribute("reviewCount", reviews.size());
                
                request.getRequestDispatcher("/user/tour/detail.jsp").forward(request, response);
            } else {
                response.sendRedirect("home");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        // Xử lý Submit Review
        try {
            int tourId = Integer.parseInt(request.getParameter("tourId"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String detail = request.getParameter("detail");
            
            // Lấy số sao từ form
            int star = 5; 
            String starParam = request.getParameter("star");
            if(starParam != null && !starParam.isEmpty()) {
                try {
                    star = Integer.parseInt(starParam);
                } catch (NumberFormatException e) {
                    star = 5;
                }
            }
            
            // Xử lý ẩn danh
            String image = "reviewer/avatar-1.jpg"; // Default avatar path relative to assets/travelin/images/
            
            if (name == null || name.trim().isEmpty()) {
                name = "Ẩn Danh";
                image = "reviewer/avatar-1.jpg"; // Avatar ẩn danh
            } else {
                // Nếu có tên, có thể random avatar hoặc lấy avatar user login (nếu có session)
                // Tạm thời set random hoặc một ảnh khác
                image = "reviewer/2.jpg"; 
            }
            
            TourReview review = new TourReview();
            review.setProductId(tourId);
            review.setName(name);
            review.setEmail(email);
            review.setDetail(detail);
            review.setStar(star);
            review.setImage(image);
            
            TourReviewDAO reviewDAO = new TourReviewDAO();
            reviewDAO.insertReview(review);
            
            // Redirect lại trang detail để tránh resubmit form
            response.sendRedirect("tour-detail?id=" + tourId);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }
}
