# Tiến Trình Phát Triển Dự Án Web Quản Lý Tour Du Lịch

Tài liệu này ghi lại tiến độ, các chức năng đã hoàn thành và kế hoạch phát triển cho dự án.

- Để xem hướng dẫn cài đặt môi trường, vui lòng xem file `HUONG_DAN_CAI_DAT.md`.
- Để xem tài liệu về các kỹ thuật đã sử dụng, vui lòng xem file `TAI_LIEU_KY_THUAT.md`.

---

## 1. Thông Tin Dự Án
- **Mục tiêu:** Xây dựng website quản lý tour du lịch.
- **Công nghệ:** Java Servlet, JSP, JSTL, SQL Server.
- **Database:** SQL Server (Database: `Travel1`).

## 2. Trạng Thái Hiện Tại (09/12/2025)
### ✅ Đã Hoàn Thành
- [x] **Setup & Database:** Hoàn thiện kịch bản SQL, hướng dẫn cài đặt CSDL và môi trường Eclipse.
- [x] **Backend (Admin):**
    - [x] Hoàn thiện đầy đủ Model, DAO, Servlet cho các chức năng: Quản lý Tour, Blog, Liên hệ.
    - [x] Tích hợp chức năng Upload ảnh, tự động lưu vào thư mục source.
- [x] **Frontend (Admin):**
    - [x] Áp dụng template WowDash cho toàn bộ trang quản trị.
    - [x] Hoàn thiện giao diện CRUD (Thêm, Sửa, Xóa, Xem) cho Tour, Blog.
    - [x] Hoàn thiện giao diện xem và xóa cho Liên hệ.
    - [x] Giao diện responsive, có dark mode, và đã được Việt hóa.

---

## 3. Cập Nhật Lớn: Chức Năng Đã Hoàn Thiện

### 🎨 Giao Diện Mới (WowDash Template)
-   **Chuyển đổi toàn diện:** Thay thế giao diện cũ bằng template **WowDash**.
-   **Dark Mode:** Kích hoạt chế độ tối mặc định cho toàn bộ trang Admin.
-   **Việt Hóa:** Dịch toàn bộ Menu, Breadcrumb, Bảng dữ liệu sang Tiếng Việt.
-   **Data Table:** Tích hợp thư viện `simple-datatables` với cấu hình tiếng Việt.

### 🛠️ Chức Năng Quản Trị
-   **Dashboard Thống Kê & Biểu Đồ:** Hiển thị tổng quan số liệu và biểu đồ doanh thu trực quan.
-   **Quản Lý Tour (Full CRUD):** Xem danh sách, thêm, sửa, xóa, bật/tắt trạng thái tour. Tích hợp upload ảnh.
-   **Quản Lý Blog (Full CRUD):** Xem danh sách, thêm, sửa, xóa, bật/tắt trạng thái bài viết. Tích hợp upload ảnh.
-   **Quản Lý Liên Hệ:** Xem danh sách tin nhắn (phân biệt tin mới/đã đọc), xem chi tiết, xóa tin nhắn.
-   **Quản Lý Menu (Full CRUD):** Cấu hình menu đa cấp cho trang người dùng.

---

## 4. Kế Hoạch Tiếp Theo

### 🚀 Giao Diện Người Dùng (Frontend - Public)
- [ ] **Trang Chủ (Home):** Hiển thị banner, tour nổi bật, tour mới nhất.
- [ ] **Danh Sách Tour:** Bộ lọc tìm kiếm (theo giá, địa điểm), phân trang.
- [ ] **Chi Tiết Tour:** Hiển thị thông tin đầy đủ, lịch trình, hình ảnh và form đặt tour.
- [ ] **Giỏ Hàng / Đặt Tour:** Chức năng booking đơn giản.

### 🛡️ Quản Trị Nâng Cao (Admin Dashboard)
- [ ] **Quản Lý Danh Mục:** Thêm/Sửa/Xóa loại tour (Trong nước, Nước ngoài...).
- [ ] **Quản Lý Đơn Hàng (Booking):** Xem danh sách khách đặt, duyệt đơn, hủy đơn.
- [ ] **Quản Lý Người Dùng:** Phân quyền Admin/Khách hàng.
- [x] **Báo Cáo Thống Kê:** Biểu đồ doanh thu, số lượng khách theo tháng.