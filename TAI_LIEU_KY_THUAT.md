# Tài Liệu Kỹ Thuật

Tài liệu này ghi lại các giải pháp kỹ thuật và kinh nghiệm được áp dụng trong quá trình phát triển dự án.

## 1. 📘 HƯỚNG DẪN: CHUYỂN ĐỔI TEMPLATE (LARAVEL/PHP -> JSP)
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

## 2. 📸 TÍNH NĂNG UPLOAD ẢNH

### Luồng Hoạt Động
Để giải quyết vấn đề chia sẻ ảnh qua Git và hiển thị ảnh ngay lập tức sau khi upload, hệ thống sử dụng cơ chế "Lưu Kép" (Dual Save).

Khi người dùng upload một file ảnh:

1.  **Lưu vào Thư mục Tạm của Server:**
    -   **Mục đích:** Để ảnh có thể được hiển thị ngay lập tức trên trang web sau khi upload.
    -   **Cách thức:** Servlet sử dụng `getServletContext().getRealPath("/assets/images/...")` để lấy đường dẫn đến thư mục triển khai tạm thời của Tomcat và lưu file ảnh vào đó.
    -   **Lưu ý:** File ở đây sẽ bị mất nếu "Clean" server.

2.  **Lưu vào Thư mục Nguồn của Dự án:**
    -   **Mục đích:** Để file ảnh trở thành một phần của mã nguồn, có thể được commit và chia sẻ qua Git cho các thành viên khác.
    -   **Cách thức:** Servlet ngay lập tức sao chép file ảnh từ vị trí tạm thời ở bước 1 vào thư mục `src/main/webapp/assets/images/...` của dự án.
    -   **Yêu cầu:** Giải pháp này yêu cầu tất cả thành viên trong nhóm phải đặt dự án ở cùng một đường dẫn tuyệt đối đã được định sẵn trong code. Xem `HUONG_DAN_CAI_DAT.md` để biết thêm chi tiết.

### Xử lý File trùng lặp
-   Nếu người dùng upload một ảnh có tên trùng với một ảnh đã có, file ảnh mới sẽ **ghi đè** lên file cũ.
-   **Cách thức:** Sử dụng `StandardCopyOption.REPLACE_EXISTING` trong phương thức `Files.copy()`.

### Code tham khảo (`TourServlet.java`)
```java
// ...
Part filePart = request.getPart("imageFile");
String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

if (fileName != null && !fileName.isEmpty()) {
    // 1. Save to temporary deployment directory
    String deployedUploadPath = getServletContext().getRealPath("/assets/images/products");
    Path deployedPath = Paths.get(deployedUploadPath, fileName);
    Files.createDirectories(deployedPath.getParent());
    try (InputStream input = filePart.getInputStream()) {
        Files.copy(input, deployedPath, StandardCopyOption.REPLACE_EXISTING);
    }

    // 2. Save to source directory
    try {
        String sourceProjectPath = "D:\\hai\\WebJAVA";
        String sourceUploadPath = Paths.get(sourceProjectPath, "src", "main", "webapp", "assets", "images", "products").toString();
        Path sourcePath = Paths.get(sourceUploadPath, fileName);
        Files.createDirectories(sourcePath.getParent());
        Files.copy(deployedPath, sourcePath, StandardCopyOption.REPLACE_EXISTING);
    } catch (Exception e) {
        System.err.println("Could not save file to source directory: " + e.getMessage());
    }
// ...
}
```

---

## 3. DASHBOARD & BIỂU ĐỒ THỐNG KÊ

### Kiến Trúc Kỹ Thuật
Hệ thống Dashboard hoạt động theo mô hình MVC tiêu chuẩn:
1.  **Model (DAO):** `DashboardDAO` thực hiện các truy vấn SQL (`COUNT`, `SUM`, `GROUP BY`) để lấy số liệu thô từ database.
2.  **Controller (Servlet):** `DashboardServlet` gọi DAO, tổng hợp dữ liệu, và quan trọng nhất là **chuyển đổi dữ liệu danh sách sang định dạng JSON String** để Frontend có thể sử dụng.
3.  **View (JSP):** `admin/index.jsp` nhận các biến và sử dụng thư viện JavaScript để vẽ biểu đồ.

### Xử Lý Dữ Liệu Biểu Đồ
Để vẽ biểu đồ doanh thu theo tháng, dữ liệu cần được xử lý đặc biệt:

1.  **Tại Database (SQL):**
    Truy vấn tổng doanh thu theo tháng trong năm hiện tại:
    ```sql
    SELECT MONTH(CreatedDate), SUM(TotalAmount) 
    FROM tb_Order 
    WHERE YEAR(CreatedDate) = ? 
    GROUP BY MONTH(CreatedDate)
    ```

2.  **Tại Java (Servlet):**
    Kết quả SQL trả về có thể bị khuyết các tháng không có doanh thu. Servlet sẽ:
    -   Khởi tạo một list có 12 phần tử có giá trị 0.0.
    -   Điền giá trị doanh thu vào đúng vị trí index (tháng 1 -> index 0).
    -   **Quan trọng:** Chuyển đổi List này thành chuỗi String dạng mảng JSON thủ công (hoặc dùng thư viện GSON/Jackson nếu có).
    
    *Ví dụ output:* `"[0.0, 1500.0, 0.0, 2000.0, ...]"`

### Tích Hợp ApexCharts
Sử dụng thư viện **ApexCharts** qua CDN để vẽ biểu đồ tương tác.

-   **Biểu đồ Doanh Thu (Area Chart):** Sử dụng dữ liệu thực tế từ bảng `tb_Order`.
-   **Biểu đồ Đơn Hàng (Donut Chart):** *Lưu ý:* Hiện tại đang sử dụng dữ liệu giả lập (mock data `[44, 55, 13]`) trực tiếp trong file JSP để hiển thị giao diện demo. Khi hệ thống vận hành thực tế, cần cập nhật để lấy dữ liệu đếm từ cột `OrderStatusId` trong bảng `tb_Order`.

-   **Cấu hình:** Biểu đồ được cấu hình để hỗ trợ giao diện tối (Dark Mode) bằng cách chỉnh màu chữ (`labels.style.colors: '#9ca3af'`) và lưới (`grid.borderColor`).
-   **Xử lý Dark Mode Nâng Cao:**
    -   **Tự động nhận diện:** Kiểm tra class `dark` trên thẻ `html` khi tải trang để chọn bảng màu phù hợp (`#e5e7eb` cho text sáng trên nền tối).
    -   **Reactive Switching:** Lắng nghe sự kiện click nút đổi theme để cập nhật lại cấu hình biểu đồ (màu lưới, tooltip theme) theo thời gian thực.
-   **An Toàn & Fallback:**
    -   Toàn bộ logic khởi tạo được bọc trong `try-catch` để tránh lỗi JS làm treo trang.
    -   Kiểm tra dữ liệu từ Server (`${revenueData}`), nếu null hoặc rỗng sẽ tự động sử dụng mảng dữ liệu mặc định (toàn số 0).
-   **Binding dữ liệu:** Dữ liệu từ Servlet được inject trực tiếp vào JavaScript thông qua Expression Language (EL):
    ```javascript
    series: [{
        name: 'Doanh Thu',
        data: revenueDataArray // Biến mảng JS đã được parse an toàn
    }]
    ```