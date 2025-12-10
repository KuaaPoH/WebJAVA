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

-   **Frontend (Admin):**
    -   [x] Áp dụng template WowDash cho toàn bộ trang quản trị.
    -   [x] Hoàn thiện giao diện CRUD (Thêm, Sửa, Xóa, Xem) cho Tour, Blog.
    -   [x] Hoàn thiện giao diện xem và xóa cho Liên hệ.
    -   [x] Giao diện responsive, có dark mode, và đã được Việt hóa.
    -   [x] Tích hợp thư viện `simple-datatables` với cấu hình tiếng Việt.
    
-   **Tái cấu trúc Module Admin:**
    -   [x] Di chuyển tất cả Admin Servlet vào package `controller.admin`.
    -   [x] Di chuyển tất cả Admin DAO vào package `dal.admin`.
    -   [x] Cập nhật `package` và `import` trong tất cả các file liên quan.

-   **Tích hợp Giao diện người dùng (User Frontend - Travelin Template):**
    -   [x] Copy các tài nguyên (assets: CSS, JS, Images, Fonts) của template "Travelin" vào `src/main/webapp/assets/travelin`.
    -   [x] Xóa bỏ assets của template cũ (`gowilds`).

-   **Cấu trúc thư mục View User:**
    -   [x] Tạo thư mục `src/main/webapp/user/`, `user/tour/`, `user/booking/`.
    -   [x] Di chuyển `home.jsp` vào `src/main/webapp/user/index.jsp`.
    -   [x] Di chuyển `tour-detail.jsp` vào `src/main/webapp/user/tour/detail.jsp`.
    -   [x] Di chuyển `booking-success.jsp` vào `src/main/webapp/user/booking/success.jsp`.
    -   [x] Cập nhật các đường dẫn assets trong các JSP sang đường dẫn tuyệt đối `${pageContext.request.contextPath}/assets/travelin/...`.
    -   [x] Cập nhật đường dẫn các Servlet trong các JSP.

-   **Backend (User):**
    -   [x] Tạo package `dal.user` và `controller.user`.
    -   [x] Tạo `dal.user.TourDAO` với các phương thức `getTopTours` và `getTourById`, `getAllTours`.
    -   [x] Tạo `controller.user.HomeServlet` xử lý request `/home` và `/`, forward tới `user/index.jsp`.
    -   [x] Tạo `controller.user.TourDetailServlet` xử lý request `/tour-detail`, forward tới `user/tour/detail.jsp`.
    -   [x] Tạo `controller.user.TourListServlet` xử lý request `/tours`, forward tới `user/tour/index.jsp`.

-   **Chức năng Đặt tour (Booking):**
    -   [x] Cập nhật Database: Thêm cột `Email` vào `tb_Order` và `DepartureDate` vào `tb_OrderDetail`.
    -   [x] Cập nhật Model: Thêm field `email` vào `Order.java` và `departureDate` vào `OrderDetail.java`.
    -   [x] Tạo `dal.user.OrderDAO` với phương thức `insertOrder` có hỗ trợ Transaction.
    -   [x] Tạo `controller.user.BookingServlet` xử lý POST request `/booking`, nhận dữ liệu form, tính toán, gọi DAO và forward tới `user/booking/success.jsp`.
    -   [x] Tạo `src/main/webapp/user/booking/success.jsp` để thông báo đặt tour thành công.

### ⚠️ Đang thực hiện / Cần kiểm tra

-   [ ] **Debug lỗi nút "Gửi Yêu Cầu" không click được** trên trang `user/tour/detail.jsp`.
    -   **Triệu chứng:** Khi di chuột qua nút, màu thay đổi (xanh -> vàng), nhưng không thể nhấp chuột vào nút.
    -   **Kiểm tra ban đầu:**
        -   Form có `action="${pageContext.request.contextPath}/booking"` và `method="post"` chính xác.
        -   Tạm thời comment các script `plugin.js` và `main.js` dẫn đến trang bị kẹt ở màn hình preloader, cho thấy các script này là cần thiết cho giao diện.
    -   **Giả thuyết:** Có thể do một JavaScript event handler đang chặn sự kiện click, hoặc một phần tử trong suốt đang nằm đè lên nút, hoặc script vô hiệu hóa nút một cách gián tiếp.
    -   **Các bước debug cần thực hiện:** Kiểm tra tab "Elements" (cây DOM, thuộc tính `disabled`, `pointer-events`), tab "Event Listeners" trong Developer Tools của trình duyệt để xác định nguyên nhân chính xác.

---

## 3. Kế Hoạch Tiếp Theo (Đã Cập Nhật)

### 🚀 Giao Diện Người Dùng (Frontend - Public)
-   [ ] Xây dựng các trang khác: Giới thiệu, Liên hệ, Tin tức.
-   [ ] Triển khai chức năng lọc, tìm kiếm, phân trang cho danh sách tour.
-   [ ] Tích hợp Login/Register.

### 🛡️ Quản Trị Nâng Cao (Admin Dashboard)
-   [ ] **Quản Lý Đơn Hàng (Booking):** Xem danh sách khách đặt, duyệt đơn, hủy đơn.
-   [ ] **Quản Lý Danh Mục:** Thêm/Sửa/Xóa loại tour (Trong nước, Nước ngoài...).
-   [ ] **Quản Lý Người Dùng:** Phân quyền Admin/Khách hàng.