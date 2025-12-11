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

## 2. Trạng Thái Hiện Tại (11/12/2025)

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

-   **Frontend (User - Public):**
    -   [x] Template Travelin.
    -   [x] **Header Component:** Tách header thành `user/components/header.jsp` dùng chung.
        -   [x] Hiển thị trạng thái đăng nhập: "Xin chào, [User]" hoặc "Đăng Nhập/Đăng Ký".
        -   [x] Khắc phục lỗi trùng lặp Preloader khi include.
    -   [x] **Trang Đăng Nhập / Đăng Ký:**
        -   [x] Tách riêng `login.jsp` và `register.jsp` với giao diện chuyên nghiệp.
        -   [x] Thông báo lỗi/thành công rõ ràng.
    -   [x] Đăng nhập / Đăng ký thành viên: Hoàn thiện chức năng đăng nhập, đăng ký, quản lý hồ sơ.

### ⚠️ Đang thực hiện
    -   [ ] **Chức năng Tìm kiếm & Lọc Tour:**
        -   [ ] Sidebar lọc theo khoảng giá, địa điểm.
        -   [ ] Pagination (Phân trang) cho danh sách tour.

---

## 3. Kế Hoạch Tiếp Theo

### 🚀 Giao Diện Người Dùng (Frontend - Public)
-   [ ] **Trang Hồ Sơ Cá Nhân (Profile):**
    -   [ ] Tạo `controller.user.ProfileServlet`: Lấy thông tin khách hàng và lịch sử đơn hàng.
    -   [ ] Tạo giao diện `webapp/user/profile.jsp`: Hiển thị thông tin cá nhân, danh sách đơn hàng đã đặt và trạng thái từng đơn.
    -   [ ] Cập nhật link "Xin chào, [User]" trong Header để trỏ đến trang Profile.
    -   [ ] Cho phép user cập nhật thông tin cá nhân (email, phone, avatar...)
-   [ ] Trang Tin Tức (Blog): Hoàn thiện hiển thị chi tiết bài viết.
-   [ ] Trang Liên Hệ: Xử lý form gửi liên hệ về Admin.

### 🛡️ Quản Trị Nâng Cao (Admin Dashboard)
-   [ ] **Quản Lý Đánh Giá (Reviews):**
    -   [ ] Tạo `controller.admin.ReviewServlet`: Duyệt/ẩn bình luận.
    -   [ ] Tạo giao diện `webapp/admin/quanlydanhgia/index.jsp`.
-   [ ] **Quản Lý Danh Mục Tour:**
    -   [ ] CRUD Danh mục tour.
-   [ ] **Quản Lý Người Dùng:**
    -   [ ] Quản lý danh sách khách hàng và nhân viên.