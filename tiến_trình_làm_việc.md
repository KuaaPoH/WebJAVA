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

## 2. Trạng Thái Hiện Tại (15/12/2025)

### ✅ Đã Hoàn Thành

-   **Backend (Admin):**
    -   [x] Setup & Database: Hoàn thiện kịch bản SQL, hướng dẫn cài đặt CSDL và môi trường Eclipse.
    -   [x] Hoàn thiện đầy đủ Model, DAO, Servlet cho các chức năng: Quản lý Tour, Blog, Liên hệ.
    -   [x] Tích hợp chức năng Upload ảnh, tự động lưu vào thư mục source.
    -   [x] **Quản Lý Đơn Hàng:**
        -   [x] Tạo `dal.admin.OrderDAO`: Lấy danh sách đơn hàng, chi tiết đơn, cập nhật trạng thái.
        -   [x] Tạo `controller.admin.OrderServlet`: Xử lý request xem danh sách, chi tiết, duyệt/hủy.
        -   [x] Cập nhật Models `Order` và `OrderDetail`.
        -   [x] Sửa logic tạo đơn hàng: Luôn gán ID trạng thái mặc định là 5 (Chờ) thay vì tạo mới trạng thái "Pending".
        -   [x] Tool fix DB: Tạo tính năng cập nhật tên trạng thái đơn hàng sang Tiếng Việt trong DB.
    -   [x] **Bảo Mật Admin:**
        -   [x] Tạo `AdminFilter`: Chặn truy cập trái phép vào `/admin/*`. Chỉ cho phép session Admin.
    -   [x] **Quản Lý Người Dùng (Admin):**
        -   [x] Tạo `dal.admin.CustomerDAO` để lấy danh sách và cập nhật trạng thái.
        -   [x] Tạo `controller.admin.CustomerServlet` để xử lý danh sách và khóa/mở khóa.
        -   [x] Tạo giao diện `webapp/admin/quanlynguoidung/index.jsp` để hiển thị và thao tác.
        -   [x] Cập nhật sidebar Admin.
    -   [x] **Quản Lý Đánh Giá (Reviews) - Admin:**
        -   [x] Tách biệt quản lý Đánh giá Tour và Bình luận Blog thành 2 trang riêng biệt để tránh xung đột.
        -   [x] Tạo `dal.admin.ReviewDAO`: Lấy danh sách đánh giá Tour và Blog Comments.
        -   [x] Tạo `controller.admin.ReviewServlet` (Tour) và `BlogReviewServlet` (Blog).
        -   [x] Cập nhật Model `TourReview` và `BlogComment`: Thêm `getIsActive()` và các trường JOIN (`tourName`, `blogTitle`).
        -   [x] Sửa lỗi hiển thị dữ liệu 500/404 và lỗi nháy giao diện.
        -   [x] Thêm tính năng "Xem Chi Tiết" (View Modal) cho nội dung dài.
        -   [x] Cập nhật CSS tùy chỉnh thanh cuộn (Scrollbar) cho giao diện Admin.
    -   [x] **Quản Lý Banner (Slide) - Admin:**
        -   [x] Tạo `dal.admin.SlideDAO` với đầy đủ CRUD.
        -   [x] Tạo `controller.admin.SlideServlet`: Xử lý thêm/sửa/xóa và Upload ảnh banner.
        -   [x] Tạo giao diện `admin/quanlyslide/index.jsp` (List) và `form.jsp` (Add/Edit).
        -   [x] Cập nhật Sidebar Admin thêm menu "Quản lý Banner".

-   **Frontend (Admin):**
    -   [x] Template WowDash, CRUD Tour/Blog/Liên hệ.
    -   [x] **Quản Lý Đơn Hàng:**
        -   [x] Hiển thị danh sách với màu sắc trạng thái động theo ID (5: Vàng, 6: Xanh, 7: Đỏ).
        -   [x] Hiển thị tên trạng thái tiếng Việt (lấy từ DB).
        -   [x] Chi tiết đơn hàng: Cải thiện bố cục, đưa tên tour xuống dưới ảnh tour.
        -   [x] Nút Duyệt/Hủy hoạt động ổn định thông qua GET link.

-   **Backend (User):**
    -   [x] **Xác Thực (Authentication):**
        -   [x] `AccountDAO` (Admin) & `CustomerDAO` (User).
        -   [x] `LoginServlet`: Xử lý đăng nhập kép (Admin vào Dashboard, User vào Home). Hỗ trợ redirect back sau khi login.
        -   [x] `RegisterServlet`: Đăng ký tài khoản khách hàng mới.
    -   [x] **Đặt Tour (Booking):**
        -   [x] `BookingPageServlet`: Yêu cầu đăng nhập trước khi đặt tour. Nếu chưa, chuyển hướng sang Login và lưu lại URL.
    -   [x] **Slide/Banner:**
        -   [x] Cập nhật các Servlet (`TourList`, `Blog`, `BlogDetail`, `Contact`, `Profile`, `TourDetail`) để lấy danh sách Active Slide.

-   **Frontend (User - Public):**
    -   [x] Template Travelin.
    -   [x] **Header Component:** Tách header thành `user/components/header.jsp` dùng chung.
        -   [x] Hiển thị trạng thái đăng nhập: "Xin chào, [User]" hoặc "Đăng Nhập/Đăng Ký".
        -   [x] Khắc phục lỗi trùng lặp Preloader khi include.
    -   [x] **Trang Đăng Nhập / Đăng Ký:**
        -   [x] Tách riêng `login.jsp` và `register.jsp` với giao diện chuyên nghiệp.
        -   [x] Thông báo lỗi/thành công rõ ràng.
    -   [x] Đăng nhập / Đăng ký thành viên: Hoàn thiện chức năng đăng nhập, đăng ký, quản lý hồ sơ.
    -   [x] **Chức năng Tìm kiếm & Lọc Tour:**
        -   [x] Sidebar lọc theo danh mục, từ khóa và khoảng giá.
        -   [x] Pagination (Phân trang) cho danh sách tour.
    -   [x] **Trang Hồ Sơ Cá Nhân (Profile):**
        -   [x] Tạo `controller.user.ProfileServlet` và giao diện `webapp/user/profile.jsp`.
        -   [x] Hiển thị Lịch sử đơn hàng và Thông tin cá nhân.
        -   [x] **Quản lý Avatar:** Cho phép upload, đổi avatar (Lưu kép + Fallback).
        -   [x] **Chi Tiết Đơn Hàng:** Xem chi tiết tour, giá tiền từng món (`/order-detail`).
        -   [x] **Yêu Cầu Hủy:** Cho phép user gửi yêu cầu hủy đơn (Status ID 1008).
    -   [x] **Trang Tin Tức (Blog):**
        -   [x] Tạo `dal.user.BlogDAO`, `BlogCommentDAO`.
        -   [x] Tạo `controller.user.BlogServlet` (List) & `BlogDetailServlet` (Detail).
        -   [x] Tạo giao diện `webapp/user/blog.jsp` & `blog_detail.jsp`.
        -   [x] Tính năng bình luận bài viết.
    -   [x] **Trang Liên Hệ:**
        -   [x] Tạo `dal.user.ContactDAO`, `controller.user.ContactServlet`.
        -   [x] Tạo giao diện `webapp/user/contact.jsp`.
        -   [x] Xử lý form gửi liên hệ lưu vào Database.
    -   [x] **Hệ Thống Session (Nâng Cao):**
        -   [x] Chế độ chạy song song (Dual Session): Admin và User login cùng lúc trên 1 trình duyệt.
        -   [x] Tách biệt `LogoutServlet` xử lý theo role.
    -   [x] **Giao Diện (UI) & Slider:**
        -   [x] **Trang Chủ:** Giữ banner tĩnh theo yêu cầu.
        -   [x] **Các Trang Con (Tour, Blog, Contact, Profile...):** Tích hợp Slider (Bootstrap Carousel) thay thế banner tĩnh cũ.
        -   [x] Banner Slider hiển thị ảnh và tiêu đề động lấy từ Database.
        -   [x] Fallback: Tự động hiển thị banner tĩnh nếu không có slide nào được kích hoạt.

### ⚠️ Đang thực hiện
    -   [ ] Admin: Quản Lý Danh Mục (Categories).
    -   [ ] Admin: Báo cáo doanh thu (Reports).

---

## 3. Kế Hoạch Tiếp Theo

### 🛡️ Quản Trị Nâng Cao (Admin Dashboard)
-   [ ] **Quản Lý Danh Mục Tour:**
    -   [ ] CRUD Danh mục tour.
-   [ ] **Thống Kê Báo Cáo:**
    -   [ ] Xuất báo cáo doanh thu ra Excel.

---

## 4. Gợi Ý Phát Triển Tương Lai (Wishlist)

Dưới đây là các tính năng được đề xuất để nâng cấp hệ thống trong các giai đoạn tiếp theo:

1.  **📧 Quên Mật Khẩu (Forgot Password):**
    -   Cho phép người dùng reset mật khẩu thông qua Email xác thực.
2.  **🎟️ Mã Giảm Giá (Voucher/Coupon):**
    -   Hệ thống quản lý mã giảm giá cho Admin.
    -   Cho phép User áp dụng mã giảm giá tại bước thanh toán.
3.  **💳 Thanh Toán Online (Payment Gateway):**
    -   Tích hợp cổng thanh toán thực tế (VNPAY, Momo, PayPal API) để xử lý giao dịch tự động.
4.  **💬 Chat Trực Tuyến (Live Chat):**
    -   Tích hợp widget chat (Facebook Messenger, Tawk.to) để hỗ trợ khách hàng realtime.
5.  **📨 Email Automation:**
    -   Tự động gửi email xác nhận khi: Đăng ký thành công, Đặt tour thành công, Đơn hàng bị hủy, v.v.
6.  **📊 Báo Cáo & Xuất File:**
    -   Cho phép Admin xuất báo cáo doanh thu, danh sách đơn hàng ra file Excel hoặc PDF.
7.  **🌍 Đa Ngôn Ngữ (Multi-language):**
    -   Hỗ trợ chuyển đổi ngôn ngữ Tiếng Việt / Tiếng Anh cho toàn bộ trang web.
