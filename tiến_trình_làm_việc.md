# Tiến Trình Phát Triển Dự Án Web Quản Lý Tour Du Lịch

## 1. Thông Tin Dự Án
- **Mục tiêu:** Xây dựng website quản lý tour du lịch.
- **Công nghệ:** Java Servlet, JSP, JSTL, SQL Server.
- **Database:** SQL Server (Database: `Travel1`).

## 2. Trạng Thái Hiện Tại (08/12/2025)
### ✅ Đã Hoàn Thành
- [x] **Database:** Có script `QLTour.sql` và đã tạo DB thành công.
- [x] **Thư viện:** Đã thêm `mssql-jdbc-12.6.1.jre11.jar`.
- [x] **Backend:** Hoàn thiện `Tour.java`, `DBContext.java`, `TourDAO.java`, `TourServlet.java`.
- [x] **Frontend:** Hoàn thiện `list.jsp`.
- [x] **Kết nối:** Đã kết nối thành công Java với SQL Server.

---

## 3. 📖 HƯỚNG DẪN CHI TIẾT KẾT NỐI CSDL (SQL SERVER)
Đây là quy trình chuẩn để xử lý lỗi "Connection refused" và kết nối thành công.

### BƯỚC 1: Cài đặt thư viện (JDBC Driver)
1. Tải file `mssql-jdbc-xx.x.x.jre11.jar`.
2. Copy file này vào thư mục: `src/main/webapp/WEB-INF/lib/` của dự án Eclipse.
3. Trong Eclipse, chuột phải vào Project -> **Refresh** (F5).

### BƯỚC 2: Cấu hình Mạng SQL Server (QUAN TRỌNG NHẤT)
*Bước này sửa lỗi "The TCP/IP connection to the host... has failed".*

1. Mở **SQL Server Configuration Manager**.
2. Chọn mục **SQL Server Network Configuration** -> **Protocols for SQLEXPRESS** (hoặc tên máy chủ của bạn).
3. **Bật TCP/IP:**
   - Nhìn sang phải, dòng **TCP/IP** phải là **Enabled**. Nếu chưa, chuột phải chọn *Enable*.
4. **Cấu hình Cổng (Port):**
   - Chuột phải vào **TCP/IP** -> chọn **Properties**.
   - Chọn tab **IP Addresses**.
   - Kéo xuống dưới cùng, tìm mục **IPAll**.
   - **TCP Dynamic Ports:** Xóa trắng (để trống hoàn toàn).
   - **TCP Port:** Điền `1433`.
   - Ấn OK.
5. **Khởi động lại Service:**
   - Chọn mục **SQL Server Services**.
   - Chuột phải vào **SQL Server (SQLEXPRESS)** -> **Restart**.

### BƯỚC 3: Cấu hình Tài khoản đăng nhập (sa)
*Bước này để Java có quyền truy cập vào DB.*

1. Mở **SQL Server Management Studio (SSMS)**, đăng nhập bằng Windows Authentication.
2. **Bật chế độ đăng nhập bằng mật khẩu:**
   - Chuột phải vào tên Server (dòng đầu tiên bên trái) -> **Properties**.
   - Mục **Security** -> Tích chọn **SQL Server and Windows Authentication mode**. -> OK.
3. **Cài đặt tài khoản 'sa':**
   - Vào thư mục **Security** -> **Logins**.
   - Chuột phải vào **sa** -> **Properties**.
   - Thẻ **General**: Đặt Password là `123` (hoặc mật khẩu bạn muốn).
   - Thẻ **Status**: Mục *Login* chọn **Enabled**. -> OK.
4. **Restart Server** (Chuột phải vào tên Server -> Restart).

### BƯỚC 4: Cấu hình Code Java (`DBContext.java`)
Sử dụng đoạn code sau để kết nối:

```java
public class DBContext {
    protected Connection connection;
    public DBContext() {
        try {
            String user = "sa";
            String password = "123"; // Mật khẩu đã đặt ở Bước 3
            String url = "jdbc:sqlserver://localhost:1433;databaseName=Travel1;encrypt=true;trustServerCertificate=true";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, password);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
```

---

## 5. Cập Nhật Lớn: Thay Đổi Giao Diện & Tính Năng (09/12/2025)

### 🎨 Giao Diện Mới (WowDash Template)
-   **Chuyển đổi toàn diện:** Thay thế giao diện cũ bằng template **WowDash** (Laravel/Tailwind style).
-   **Dark Mode:** Kích hoạt chế độ tối mặc định cho toàn bộ trang Admin.
-   **Việt Hóa:** Dịch toàn bộ Menu, Breadcrumb, Bảng dữ liệu sang Tiếng Việt.
-   **Data Table:** Tích hợp thư viện `simple-datatables` với cấu hình tiếng Việt (Tìm kiếm, Phân trang, Sắp xếp).

### 🛠️ Chức Năng Đã Hoàn Thiện (Full CRUD)
1.  **Xem Danh Sách (Read):**
    -   Hiển thị danh sách tour dưới dạng bảng hiện đại.
    -   Có cột hình ảnh thumbnail, badge trạng thái màu sắc.
2.  **Thêm Mới (Create):**
    -   Tạo trang `add.jsp` với form nhập liệu Vertical.
    -   Xử lý lưu dữ liệu vào SQL Server.
3.  **Chỉnh Sửa (Update):**
    -   Tạo trang `edit.jsp`, tự động điền dữ liệu cũ.
    -   Cập nhật thông tin tour thành công.
4.  **Xóa (Delete):**
    -   Xóa tour theo ID.
    -   Có hộp thoại xác nhận (Confirm) trước khi xóa.
5.  **Chuyển Trạng Thái Nhanh (Toggle Status):**
    -   Bấm vào icon **Con Mắt** để Bật/Tắt trạng thái Tour (Hiện/Ẩn) ngay lập tức.
    -   Icon thay đổi tương ứng (Mắt mở/Mắt nhắm).

### 📂 Cấu Trúc Dự Án Mới
-   `src/main/webapp/admin/quanlytour/`: Chứa `index.jsp`, `add.jsp`, `edit.jsp`.
-   `src/main/webapp/assets/`: Chứa toàn bộ tài nguyên CSS/JS/Images của WowDash.
-   `TourServlet`: Đã nâng cấp để xử lý đa luồng (`create`, `insert`, `edit`, `update`, `delete`, `toggle`).

---

## 6. 📘 HƯỚNG DẪN: CHUYỂN ĐỔI TEMPLATE (LARAVEL/PHP -> JSP)
*Kinh nghiệm rút ra từ việc chuyển đổi giao diện WowDash (Laravel).*

### Nguyên Tắc Cốt Lõi
Tomcat không chạy được file `.php` hay cú pháp Blade (`@extends`, `{{ asset }}`). Cần trích xuất HTML/CSS/JS tĩnh và nhúng vào JSP.

### Quy Trình 4 Bước
**BƯỚC 1: Di Chuyển Tài Nguyên (Assets)**
-   Tìm thư mục chứa CSS/JS/Images trong template gốc (thường là `public/assets` hoặc `dist`).
-   Copy toàn bộ vào `src/main/webapp/assets`.

**BƯỚC 2: Ghép File HTML (Layout)**
-   Template hiện đại thường chia nhỏ file (Header, Sidebar, Navbar, Footer).
-   Trong Laravel, tìm trong `resources/views/components` hoặc `layouts`.
-   **Thao tác:** Mở từng file component -> Copy code HTML -> Dán gộp vào file `index.jsp` theo đúng thứ tự (Head -> Body -> Sidebar -> Navbar -> Content -> Footer -> Script).

**BƯỚC 3: Sửa Đường Dẫn (Quan Trọng)**
-   Đường dẫn cũ (Laravel): `{{ asset('assets/css/style.css') }}`
-   **Sửa thành (JSP):** `${pageContext.request.contextPath}/assets/css/style.css`
-   Áp dụng cho tất cả thẻ `<link href="...">`, `<script src="...">`, `<img src="...">`.

**BƯỚC 4: Xử Lý Logic & Cleanup**
-   Xóa các cú pháp lạ của PHP/Blade (ví dụ: `@if`, `@foreach`).
-   Thay thế bằng JSTL của Java (`<c:if>`, `<c:forEach>`).
-   **Lưu ý Dark Mode:** Với Tailwind CSS, nếu theme tối không hiện, hãy thêm class cứng vào thẻ html: `<html class="dark">`.
-   **Lưu ý JS:** Nếu Eclipse báo lỗi đỏ ở file JS thư viện (do cú pháp ES6), hãy tắt Validate hoặc kệ nó, miễn trình duyệt chạy đúng.

---

## 7. Kế Hoạch Tiếp Theo

### 🚀 Giao Diện Người Dùng (Frontend - Public)
- [ ] **Trang Chủ (Home):** Hiển thị banner, tour nổi bật, tour mới nhất.
- [ ] **Danh Sách Tour:** Bộ lọc tìm kiếm (theo giá, địa điểm), phân trang.
- [ ] **Chi Tiết Tour:** Hiển thị thông tin đầy đủ, lịch trình, hình ảnh và form đặt tour.
- [ ] **Giỏ Hàng / Đặt Tour:** Chức năng booking đơn giản.

### 🛡️ Quản Trị Nâng Cao (Admin Dashboard)
- [ ] **Quản Lý Danh Mục:** Thêm/Sửa/Xóa loại tour (Trong nước, Nước ngoài...).
- [ ] **Quản Lý Đơn Hàng (Booking):** Xem danh sách khách đặt, duyệt đơn, hủy đơn.
- [ ] **Quản Lý Người Dùng:** Phân quyền Admin/Khách hàng.
- [ ] **Báo Cáo Thống Kê:** Biểu đồ doanh thu, số lượng khách theo tháng.