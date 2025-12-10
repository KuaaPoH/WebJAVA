# Tiến Trình Phát Triển Dự Án Web Quản Lý Tour Du Lịch

Tài liệu này ghi lại tiến độ, các chức năng đã hoàn thành và kế hoạch phát triển cho dự án.

- Để xem hướng dẫn cài đặt môi trường, vui lòng xem file `HUONG_DAN_CAI_DAT.md`.
- Để xem tài liệu về các kỹ thuật đã sử dụng, vui lòng xem file `TAI_LIEU_KY_THUAT.md`.

---

## 1. Thông Tin Dự Án
- **Mục tiêu:** Xây dựng website quản lý tour du lịch.
- **Công nghệ:** Java Servlet, JSP, JSTL, SQL Server.
- **Database:** SQL Server (Database: `Travel1`).

---

## 2. Trạng Thái Hiện Tại (10/12/2025)

### ✅ Đã Hoàn Thành

-   **Backend (Admin):**
    -   [x] Setup & Database: Hoàn thiện kịch bản SQL, hướng dẫn cài đặt CSDL và môi trường Eclipse.
    -   [x] Hoàn thiện đầy đủ Model, DAO, Servlet cho các chức năng: Quản lý Tour, Blog, Liên hệ.
    -   [x] Tích hợp chức năng Upload ảnh, tự động lưu vào thư mục source.
    -   [x] **Quản Lý Đơn Hàng:**
        -   [x] Tạo `dal.admin.OrderDAO`: Lấy danh sách đơn hàng, chi tiết đơn, cập nhật trạng thái.
        -   [x] Tạo `controller.admin.OrderServlet` (đổi tên từ OrderController): Xử lý request xem danh sách, chi tiết, duyệt/hủy.
        -   [x] Cập nhật Models `Order.java` và `OrderDetail.java` với các trường phụ trợ (`statusName`, `tourName`, `image`) để hiển thị thông tin đầy đủ.
        -   [x] Khắc phục lỗi "List cannot be resolved to a type" do thiếu import.

-   **Frontend (Admin):**
    -   [x] Áp dụng template WowDash cho toàn bộ trang quản trị.
    -   [x] Hoàn thiện giao diện CRUD (Thêm, Sửa, Xóa, Xem) cho Tour, Blog.
    -   [x] Hoàn thiện giao diện xem và xóa cho Liên hệ.
    -   [x] Giao diện responsive, có dark mode, và đã được Việt hóa.
    -   [x] Tích hợp thư viện `simple-datatables` với cấu hình tiếng Việt.
    -   [x] **Component Sidebar Menu dùng chung:**
        -   [x] Di chuyển sidebar Admin sang component dùng chung (`admin/components/sidebar.jsp`).
        -   [x] Cập nhật tất cả các trang Admin JSP (Dashboard, Quản lý Tour, Blog, Liên hệ, Menu, Đơn hàng, Thêm/Sửa Tour, Blog, Menu) để sử dụng component sidebar dùng chung và đảm bảo `taglib` đầy đủ.
    -   [x] **Quản Lý Đơn Hàng:**
        -   [x] Tạo giao diện `webapp/admin/quanlydonhang/index.jsp` (Danh sách đơn hàng).
        -   [x] Tạo giao diện `webapp/admin/quanlydonhang/detail.jsp` (Chi tiết & Cập nhật trạng thái đơn hàng).

-   **Backend (User):**
    -   [x] Tạo package `dal.user` và `controller.user`.
    -   [x] TourDAO, OrderDAO, TourReviewDAO.
    -   [x] HomeServlet, TourDetailServlet, BookingServlet, BookingPageServlet.

-   **Frontend (User - Public):**
    -   [x] Tích hợp template Travelin.
    -   [x] Trang Chủ (Home): Hiển thị tour nổi bật.
    -   [x] Trang Chi Tiết Tour:
        -   [x] Hiển thị thông tin tour.
        -   [x] Tích hợp Bản đồ (Google Maps).
        -   [x] Hiển thị danh sách đánh giá (Reviews) & Bình luận từ DB.
        -   [x] Form gửi đánh giá với tính năng chọn 5 sao tương tác, xử lý avatar mặc định.
        -   [x] Cải thiện hiển thị avatar và tên/ngày trong comment.
    -   [x] Chức năng Đặt Tour (Booking):
        -   [x] Trang Booking chuyên biệt (`user/booking/index.jsp`) với giao diện chuyên nghiệp.
        -   [x] Tính năng chọn Loại phòng (Standard, Deluxe...) và tự động tính tổng tiền.
        -   [x] Tính năng chọn Phương thức thanh toán (Thẻ tín dụng/ghi nợ, Thanh toán điện tử/Paypal) và tự động tính tổng tiền.
        -   [x] Validate form: Tự động định dạng ngày hết hạn thẻ, giới hạn CVC.
        -   [x] Sửa lỗi nút "Gửi Yêu Cầu" không click được (do xung đột JS template).
        -   [x] Sửa lỗi truncate code đơn hàng.

### ⚠️ Đang thực hiện
    -   [ ] **Hoàn thiện chức năng Duyệt/Hủy Đơn Hàng (Admin):**
        -   [ ] Cập nhật giao diện `webapp/admin/quanlydonhang/detail.jsp` để có các nút (hoặc dropdown) cho phép Admin thay đổi trạng thái đơn hàng (Duyệt, Hủy).
        -   [ ] Đảm bảo `controller.admin.OrderServlet` xử lý đúng logic cập nhật trạng thái đơn hàng.

---

## 3. Kế Hoạch Tiếp Theo

### 🛡️ Quản Trị Nâng Cao (Admin Dashboard)
-   [ ] **Cải tiến Dashboard:**
    -   [ ] Cập nhật Servlet Dashboard để lấy dữ liệu thống kê dynamic (Doanh thu, số đơn hàng, số khách).
    -   [ ] Cập nhật biểu đồ doanh thu và phân tích đơn hàng với dữ liệu thật từ DB.
-   [ ] **Quản Lý Đánh Giá (Reviews):**
    -   [ ] Tạo `dal.admin.TourReviewDAO` (hoặc mở rộng `dal.user.TourReviewDAO`) để lấy danh sách reviews cho Admin.
    -   [ ] Tạo `controller.admin.ReviewServlet`: Xử lý hiển thị danh sách reviews, duyệt/ẩn (toggle status).
    -   [ ] Tạo giao diện `webapp/admin/quanlydanhgia/index.jsp`: Hiển thị bảng reviews, có nút duyệt/ẩn.
-   [ ] **Quản Lý Danh Mục Tour:**
    -   [ ] Tạo `dal.admin.TourCategoryDAO`.
    -   [ ] Tạo `controller.admin.TourCategoryServlet`.
    -   [ ] Tạo các trang `webapp/admin/quanlydanhmuc/index.jsp`, `create.jsp`, `edit.jsp`.
-   [ ] **Quản Lý Người Dùng:** (Chức năng đăng nhập/đăng ký ở phía User cũng sẽ liên quan)
    -   [ ] Tạo `dal.admin.AccountDAO` (quản lý Admin user) và `dal.user.CustomerDAO` (quản lý khách hàng).
    -   [ ] Tạo `controller.admin.UserServlet`: Hiển thị danh sách user, phân quyền, khóa/mở khóa.
    -   [ ] Tạo các trang `webapp/admin/quanlynguoidung/index.jsp`, `edit.jsp`.

### 🚀 Giao Diện Người Dùng (Frontend - Public)
-   [ ] Trang Tin Tức (Blog): Chỉnh sửa lại các trang blog để hiển thị thông tin động.
-   [ ] Trang Liên Hệ: Xây dựng form liên hệ và xử lý gửi về Admin.
-   [ ] Chức năng Tìm kiếm & Lọc Tour nâng cao.
-   [ ] Đăng nhập / Đăng ký thành viên: Hoàn thiện chức năng đăng nhập, đăng ký, quản lý hồ sơ.