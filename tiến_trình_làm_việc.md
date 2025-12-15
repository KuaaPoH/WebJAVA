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

## 4. Các Vấn Đề Đang Xử Lý

### 🔴 Lỗi hiển thị Header Widget (Ngày: 16/12/2025)

**Mô tả:**
Người dùng báo cáo widget đồng hồ/ngày tháng và lời chào "Xin chào, [Username]!" trên header của trang Admin không hiển thị đúng.
- Đồng hồ chỉ hiện "::".
- Widget chỉ hiện "Trời quang", không luân phiên hiển thị ngày tháng.
- Lời chào Admin không hiển thị.
- Console của trình duyệt không báo lỗi hoặc hiển thị bất kỳ log nào liên quan đến script của widget.

**Các bước đã thực hiện:**
1.  Đã tạo component header chung (`src/main/webapp/admin/components/header.jsp`) để đồng bộ hóa header trên toàn bộ các trang Admin.
2.  Đã tích hợp widget đồng hồ/thông tin ngày tháng/thời tiết giả lập và lời chào Admin vào `header.jsp`.
3.  Đã căn giữa widget và điều chỉnh responsive cho các phần tử trong header.
4.  Đã đổi màu nền header theo yêu cầu người dùng (`#273142`).
5.  Đã thêm `console.log()` vào script JavaScript để gỡ lỗi, kiểm tra luồng thực thi và sự tồn tại của các phần tử DOM.

**Các bước debug đã thử & kết quả:**
- Thêm `console.log()`: Console của trình duyệt hoàn toàn trống, không có bất kỳ log nào, kể cả log từ chính script của widget.

**Giả thuyết nguyên nhân:**
- Script JavaScript không được thực thi trên trang, có thể do:
    - Lỗi cú pháp JavaScript nghiêm trọng (ít khả năng vì script khá đơn giản và đã được kiểm tra).
    - File `header.jsp` không được include đúng cách vào các trang Admin, dẫn đến việc mã HTML và JavaScript của header không bao giờ được gửi đến trình duyệt.
    - Có lỗi trong HTML/JSP của trang mẹ (ví dụ: `index.jsp`, `profile.jsp`) trước thẻ include `header.jsp` làm hỏng quá trình phân tích cú pháp HTML/JSP của server hoặc trình duyệt.

**Kế hoạch tiếp theo:**
- Hướng dẫn người dùng kiểm tra mã nguồn trang (View page source) trực tiếp trên trình duyệt để xác minh liệu nội dung của `header.jsp` (bao gồm `<div class="admin-header">` và script JavaScript) có xuất hiện trong mã HTML mà trình duyệt nhận được hay không.