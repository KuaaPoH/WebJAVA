# Tài Liệu Kỹ Thuật

Tài liệu này ghi lại các giải pháp kỹ thuật và kinh nghiệm được áp dụng trong quá trình phát triển dự án.

## 1. 📘 HƯỚNG DẪN: CHUYỂN ĐỔI TEMPLATE (LARAVEL/PHP -> JSP)
*Kinh nghiệm rút ra từ việc chuyển đổi giao diện WowDash (Laravel) và Travelin (HTML/CSS/JS tĩnh).*

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

## 3. DASHBOARD & BIỂU ĐỒ THỐNG KÊ (Admin)

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

---

## 4. 🗂️ QUẢN LÝ ADMIN SIDEBAR MENU (Refactoring)

### Vấn đề
Ban đầu, mã HTML cho thanh điều hướng bên (sidebar menu) của trang Admin được đặt lặp đi lặp lại trong nhiều file JSP (ví dụ: `admin/quanlytour/index.jsp`, `admin/quanlyblog/index.jsp`, `admin/quanlydonhang/index.jsp`,...). Điều này gây khó khăn cho việc bảo trì, cập nhật, và mở rộng menu.

### Giải pháp
Tạo một Component JSP dùng chung (`sidebar.jsp`) và sử dụng lệnh `<%@include file="..." %>` để nhúng vào tất cả các trang Admin cần thiết.

### Chi tiết kỹ thuật
-   **File Component:** `src/main/webapp/admin/components/sidebar.jsp`
-   **Logic Active:** Trạng thái "active" của menu item được xác định động dựa vào URI của request hiện tại. Điều này cho phép mục menu tương ứng sáng lên khi người dùng điều hướng đến trang đó.
    ```jsp
    <li class="${request.getRequestURI().contains("/admin/orders") ? "active" : ""}">
        <a href="${pageContext.request.contextPath}/admin/orders">
            <iconify-icon icon="solar:bag-bold" class="menu-icon"></iconify-icon>
            <span>Quản Lý Đơn Hàng</span>
        </a>
    </li>
    ```
    -   `request.getRequestURI()`: Lấy đường dẫn URI của request.
    -   `.contains(...)`: Kiểm tra xem URI có chứa chuỗi của đường dẫn menu hay không.
    -   `"active"`: Class CSS mà template WowDash sử dụng để highlight mục menu đang được chọn.
-   **Taglibs:** Đảm bảo các `taglib` cần thiết (`jakarta.tags.core` cho `<c:*>`, `http://java.sun.com/jsp/jstl/fmt` cho `<fmt:*>`) được khai báo đầy đủ trong cả `sidebar.jsp` và các file JSP nhúng nó.
-   **Lợi ích:** Dễ dàng thêm, sửa, xóa mục menu từ một nơi duy nhất.

---

## 5. 🛒 CHỨC NĂNG ĐẶT TOUR (Booking) & REVIEW TOUR (User Side)

### 5.1. Chức năng Đặt Tour (User Side)

#### a. Trang Booking chuyên biệt (`user/booking/index.jsp`)
-   **Giao diện:** Thiết kế lại form đặt tour theo template `booking.html` để có trải nghiệm người dùng tốt hơn so với form nhỏ trên trang chi tiết tour.
-   **Luồng:** Nút "Tiến Hành Đặt Tour" trên trang chi tiết tour sẽ điều hướng người dùng đến trang này (`/booking-page?id=...`).
-   **Backend (`BookingPageServlet`):** Xử lý request `/booking-page`, lấy thông tin `Tour` từ DB và truyền vào `booking/index.jsp`.

#### b. Chọn Loại Phòng & Tính toán giá
-   **Frontend (`booking/index.jsp`):**
    -   Thêm dropdown `select` cho phép người dùng chọn loại phòng (Standard, Deluxe, Suite, Single).
    -   Mỗi `<option>` có thuộc tính `data-surcharge` để lưu phụ phí phòng.
    -   **JavaScript:** Viết script để lắng nghe sự kiện thay đổi của "Số lượng khách" và "Loại phòng".
    -   **Tính toán Real-time:** Tổng tiền = (Giá Tour Cơ bản + Phụ phí phòng) * Số lượng khách. Kết quả được cập nhật ngay lập tức ở phần "Tóm Tắt Giá" bên phải.
-   **Backend (`BookingServlet`):**
    -   Nhận tham số `roomType` từ form.
    -   Tính toán lại phụ phí và tổng tiền dựa trên `roomType` (để tránh Frontend gửi giá sai).
    -   Lưu `roomType` và `paymentMethod` vào cột `Address` của `tb_Order` dưới dạng chuỗi ghi chú (ví dụ: "Địa chỉ... (Room: Deluxe, Payment: CreditCard)") do Database hiện tại chưa có cột riêng cho các thông tin này.

#### c. Phương Thức Thanh Toán
-   **Frontend (`booking/index.jsp`):**
    -   Tích hợp giao diện tab "Credit/Debit card" và "Digital Payment" (Paypal) giống hệt template gốc.
    -   Sử dụng một `input type="hidden"` (`id="paymentMethodInput"`) để lưu phương thức thanh toán được chọn. JavaScript sẽ cập nhật giá trị này khi người dùng chuyển đổi tab.
    -   **Việt hóa:** Toàn bộ phần thanh toán được dịch sang tiếng Việt.
-   **Backend (`BookingServlet`):** Nhận tham số `paymentMethod` và lưu vào `Address` của `tb_Order`.

#### d. Cải thiện UX Form nhập liệu
-   **Trường "Ngày Hết Hạn" (Expiry Date):**
    -   Sử dụng JavaScript để tự động thêm dấu `/` sau khi người dùng nhập đủ 2 ký tự đầu tiên (MM).
    -   Giới hạn độ dài tối đa là 5 ký tự (`MM/YY`).
-   **Trường "Mã Bảo Mật" (CVC/CVV):**
    -   Giới hạn tối đa 3 ký tự.
    -   Chỉ cho phép nhập liệu là số.
-   **Khắc phục lỗi form submit:** Xóa đoạn JavaScript trong `main.js` của template gây chặn submit tất cả các form (thường là code demo).
-   **Khắc phục lỗi Truncate Code:** Rút gọn mã đơn hàng (`ORD` + 6 chữ số cuối của timestamp) để đảm bảo độ dài không vượt quá giới hạn của cột `Code` trong `tb_Order` (`nchar(10)`).

### 5.2. Chức năng Đánh giá Tour (User Side)

#### a. Trang Chi Tiết Tour (`user/tour/detail.jsp`)
-   **Bản đồ (Map):** Tích hợp Google Maps iframe.
-   **Hiển thị đánh giá:**
    -   **Backend (`TourDetailServlet`):**
        -   Sử dụng `dal.user.TourReviewDAO` để lấy danh sách đánh giá (`List<TourReview>`) cho tour hiện tại.
        -   Tính toán điểm đánh giá trung bình.
        -   Truyền danh sách đánh giá và điểm trung bình vào request để hiển thị trên JSP.
    -   **Frontend (`detail.jsp`):**
        -   Sử dụng `<c:forEach>` để lặp và hiển thị từng đánh giá.
        -   **Logic Avatar/Tên:**
            -   Nếu `review.name` rỗng/null, hiển thị "Ẩn Danh".
            -   Avatar mặc định cho ẩn danh: `reviewer/avatar-1.jpg`.
            -   Xử lý đường dẫn ảnh avatar linh hoạt (URL đầy đủ hoặc tên file cục bộ).
            -   Cập nhật kích thước avatar hiển thị (90x100px) và layout để tên/ngày tháng không bị chèn.

#### b. Form Gửi Đánh Giá
-   **Frontend (`detail.jsp`):**
    -   Thêm form "Viết Đánh Giá" với các trường: Tên, Email, Nội dung, và **chọn số sao**.
    -   **Star Rating Widget:** Thay thế dropdown chọn sao bằng giao diện 5 ngôi sao tương tác (dùng FontAwesome và JavaScript). Người dùng có thể click hoặc hover để chọn số sao.
-   **Backend (`TourDetailServlet` - doPost):**
    -   Nhận các tham số `tourId`, `name`, `email`, `detail`, `star` từ form.
    -   Nếu `name` rỗng/null, đặt `name` là "Ẩn Danh" và gán avatar mặc định (`reviewer/avatar-1.jpg`).
    -   Sử dụng `dal.user.TourReviewDAO.insertReview()` để lưu đánh giá vào `tb_TourReview`.
    -   Redirect lại trang chi tiết tour để hiển thị đánh giá mới và tránh lỗi resubmit form.

---

## 6. 🗄️ QUẢN LÝ ĐƠN HÀNG (Admin)

### Kiến Trúc & Luồng
-   **Models mở rộng:** `model.Order.java` và `model.OrderDetail.java` được bổ sung các trường phụ trợ (`statusName`, `tourName`, `image`) để dễ dàng hiển thị dữ liệu JOIN từ các bảng khác mà không cần sửa cấu trúc Database. Khắc phục lỗi thiếu `import java.util.List;`.
-   **DAO:** `dal.admin.OrderDAO.java` chứa các phương thức:
    -   `getAllOrders()`: Lấy danh sách Order với tên trạng thái.
    -   `getOrderById(int orderId)`: Lấy chi tiết Order bao gồm cả OrderDetail và thông tin Tour liên quan.
    -   `updateOrderStatus(int orderId, int statusId)`: Cập nhật trạng thái đơn hàng.
    -   `getAllOrderStatuses()`: Lấy danh sách các trạng thái Order có sẵn.
-   **Servlet:** `controller.admin.OrderServlet.java` (đổi tên từ OrderController để tuân thủ quy ước đặt tên)
    -   Xử lý `GET /admin/orders` (hiển thị danh sách hoặc chi tiết).
    -   Xử lý `POST /admin/orders` (cập nhật trạng thái đơn hàng).
-   **Views:**
    -   `src/main/webapp/admin/quanlydonhang/index.jsp`: Hiển thị danh sách đơn hàng trong bảng DataTables (WowDash template) với thông tin cơ bản, trạng thái màu sắc và nút "Xem chi tiết".
    -   `src/main/webapp/admin/quanlydonhang/detail.jsp`: Hiển thị chi tiết đơn hàng, thông tin khách hàng, tour đã đặt và form cập nhật trạng thái sử dụng dropdown.

---

## 7. 🔐 XÁC THỰC & BẢO MẬT (Authentication & Security)

### 7.1. Cơ chế Đăng Nhập Kép (Dual Login)
Hệ thống hỗ trợ 2 loại tài khoản đăng nhập trên cùng một form:
1.  **Admin (Quản trị viên):** Lưu trong bảng `tb_Account`.
2.  **User (Khách hàng):** Lưu trong bảng `tb_Customer`.

**Logic xử lý (`LoginServlet`):**
-   Đầu tiên kiểm tra tài khoản trong bảng `tb_Account`. Nếu đúng -> Tạo session `admin` -> Chuyển hướng vào `/admin`.
-   Nếu không tìm thấy, kiểm tra tiếp trong bảng `tb_Customer`. Nếu đúng -> Tạo session `user` -> Chuyển hướng về `/home` (hoặc trang trước đó).

### 7.2. Bảo Mật Admin (Servlet Filter)
Sử dụng **Filter** (`controller.filter.AdminFilter`) để bảo vệ toàn bộ thư mục `/admin/*`.
-   Mọi request vào đường dẫn bắt đầu bằng `/admin/` sẽ bị chặn lại kiểm tra.
-   Nếu session `admin` không tồn tại -> Chuyển hướng về trang `/login`.
-   Giải pháp này an toàn và triệt để hơn việc kiểm tra thủ công trong từng file JSP.

### 7.3. Luồng Đặt Tour Yêu Cầu Đăng Nhập
Để đảm bảo đơn hàng luôn gắn liền với một khách hàng cụ thể:
1.  Khi người dùng nhấn "Tiến hành đặt tour" (`/booking-page`).
2.  `BookingPageServlet` kiểm tra session `user`.
3.  Nếu chưa đăng nhập:
    -   Lưu URL hiện tại vào session attribute `redirectUrl`.
    -   Chuyển hướng sang trang Login.
4.  Tại `LoginServlet`, sau khi đăng nhập thành công:
    -   Kiểm tra xem có `redirectUrl` không.
    -   Nếu có -> Chuyển hướng người dùng quay lại trang đặt tour để tiếp tục.

---

## 8. 🧩 HEADER COMPONENT & JSP INCLUDE

### Vấn đề
Việc lặp lại code Header (Logo, Menu, Nút Login/Logout) ở nhiều file JSP (`index.jsp`, `tour/detail.jsp`...) gây khó khăn khi muốn sửa đổi giao diện hoặc logic hiển thị (ví dụ: đổi từ "Đăng nhập" sang "Xin chào User").

### Giải pháp
-   Tách toàn bộ phần Header ra thành file riêng: `src/main/webapp/user/components/header.jsp`.
-   Sử dụng `<jsp:include page="/user/components/header.jsp" />` để nhúng vào các trang con.

### Xử lý xung đột JS (Preloader)
-   Trong template gốc, mỗi trang đều có một thẻ `<div id="preloader">`.
-   Khi tách Header (vốn cũng chứa Preloader), nếu trang con không xóa Preloader cũ đi -> **Sẽ có 2 Preloader trùng ID**.
-   **Hậu quả:** File JS (`main.js`) chỉ ẩn được 1 cái, cái còn lại vẫn hiển thị -> Trang web bị che khuất và xoay mãi mãi.
-   **Khắc phục:** Xóa toàn bộ khối Preloader trong các file JSP con (`index.jsp`, `detail.jsp`) và chỉ giữ lại duy nhất 1 cái trong `header.jsp`.

---

## 9. ⚙️ QUY TRÌNH CHUẨN HÓA TRẠNG THÁI ĐƠN HÀNG

### Vấn đề
Ban đầu, hệ thống tự động tạo mới trạng thái "Pending" mỗi khi không tìm thấy, dẫn đến rác dữ liệu và không đồng bộ ID.

### Giải pháp
Thống nhất sử dụng bộ ID cố định cho quy trình đơn hàng:
-   **ID 5:** Chờ xác nhận (Pending) - Mặc định khi khách mới đặt.
-   **ID 6:** Đã xác nhận (Confirmed) - Admin duyệt.
-   **ID 7:** Đã hủy (Cancelled) - Admin hoặc khách hủy.

**Cập nhật Code:**
-   Trong `dal.user.OrderDAO`: Xóa logic "tự động tạo status". Thay vào đó, gán cứng `statusId = 5` khi insert đơn hàng mới.
-   **Tool Fix DB:** Tạo phương thức `fixStatusNamesToVietnamese()` trong `OrderDAO` (kích hoạt qua action `fix_db` của Admin) để chuẩn hóa tên trạng thái trong Database sang tiếng Việt.

```