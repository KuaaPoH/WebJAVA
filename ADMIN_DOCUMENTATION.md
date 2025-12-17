# TÀI LIỆU KỸ THUẬT TOÀN TẬP HỆ THỐNG ADMIN (DEEP DIVE LINE-BY-LINE)

Tài liệu này cung cấp phân tích sâu sắc nhất về mã nguồn, logic nghiệp vụ và kỹ thuật lập trình cho **TOÀN BỘ** các module trong hệ thống quản trị (Admin). Tài liệu dành cho lập trình viên muốn hiểu cặn kẽ từng dòng code từ Backend (Java/SQL) đến Frontend (JSP/JS).

---

## MỤC LỤC
1.  [Kiến Trúc Tổng Quan & Core Components](#1-kien-truc-tong-quan--core-components)
2.  [Module 1: Dashboard & Thống Kê](#2-module-1-dashboard--thong-ke)
3.  [Module 2: Bảo Mật & Quản Lý Người Dùng](#3-module-2-bao-mat--quan-ly-nguoi-dung)
4.  [Module 3: Quản Lý Sản Phẩm (Tour)](#4-module-3-quan-ly-san-pham-tour)
5.  [Module 4: Quản Lý Đơn Hàng (Order)](#5-module-4-quan-ly-don-hang-order)
6.  [Module 5: Quản Lý Nội Dung (Blog)](#6-module-5-quan-ly-noi-dung-blog)
7.  [Module 6: Hệ Thống (Menu, Contact)](#7-module-6-he-thong-menu-contact)

---

## 1. KIẾN TRÚC TỔNG QUAN & CORE COMPONENTS

### 1.1. Mô hình MVC (Model-View-Controller)
*   **Model (DAL/DAO):** Nằm trong `dal.admin.*`. Chứa các class giao tiếp trực tiếp với SQL Server thông qua `DBContext`.
*   **Controller (Servlet):** Nằm trong `controller.admin.*`. Nhận request, xử lý logic, gọi DAO và điều hướng (forward/redirect).
*   **View (JSP):** Nằm trong `webapp/admin/*`. Hiển thị giao diện HTML, sử dụng JSTL (`<c:forEach>`, `<c:if>`) và EL (`${variable}`).

### 1.2. AdminFilter (`controller.filter.AdminFilter`) - "Cánh Cổng Bảo Mật"
Class này chặn mọi truy cập vào thư mục `/admin/*` để đảm bảo chỉ Admin đã đăng nhập mới được vào.

```java
@WebFilter(filterName = "AdminFilter", urlPatterns = {"/admin/*"}) // Chặn mọi URL bắt đầu bằng /admin/
public class AdminFilter implements Filter {
    @Override
    public void doFilter(...) {
        // Lấy session hiện tại (false: không tạo mới nếu chưa có)
        HttpSession session = httpRequest.getSession(false);
        
        // Kiểm tra logic đăng nhập: Session phải tồn tại VÀ có attribute "admin"
        boolean isLoggedIn = (session != null && session.getAttribute("admin") != null);

        if (isLoggedIn) {
            // Kiểm tra phân quyền (Role)
            Account adminAccount = (Account) session.getAttribute("admin");
            if (adminAccount.getRoleId() == 1 || adminAccount.getRoleId() == 2) { // 1=Admin, 2=Staff
                 chain.doFilter(request, response); // Hợp lệ -> Cho qua
            } else {
                 // Đã login nhưng không đủ quyền -> Redirect về Login
                 httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=unauthorized");
            }
        } else {
            // Chưa login -> Redirect về Login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
}
```

---

## 2. MODULE 1: DASHBOARD & THỐNG KÊ

### 2.1. DashboardDAO (`dal.admin.DashboardDAO`)
Chứa các câu lệnh SQL tổng hợp dữ liệu (COUNT, SUM) cho báo cáo.

**Logic biểu đồ doanh thu (`getMonthlyRevenue`):**
```java
public List<Double> getMonthlyRevenue(int year) {
    List<Double> list = new ArrayList<>();
    // Khởi tạo list với 12 số 0.0 (tương ứng 12 tháng)
    for (int i = 0; i < 12; i++) list.add(0.0);
    
    // SQL: Nhóm theo Tháng và Tính tổng tiền
    String sql = "SELECT MONTH(CreatedDate) as Month, SUM(TotalAmount) as Total " +
                 "FROM tb_Order WHERE YEAR(CreatedDate) = ? GROUP BY MONTH(CreatedDate)";
    // ...
    while (rs.next()) {
        int month = rs.getInt("Month");
        // Gán giá trị vào đúng vị trí index (tháng 1 -> index 0)
        list.set(month - 1, rs.getDouble("Total"));
    }
    return list;
}
```

### 2.2. DashboardServlet (`controller.admin.DashboardServlet`)
Xử lý dữ liệu Java thành chuỗi JSON String để Javascript có thể đọc được.

```java
// Logic tạo màu sắc động cho biểu đồ tròn (Pie Chart) dựa trên tên trạng thái
StringBuilder orderColors = new StringBuilder("[");
for (...) {
    String lowerName = statusName.toLowerCase();
    String color = "#6b7280"; // Mặc định màu Xám

    // Dùng từ khóa để gán màu ngữ nghĩa
    if (lowerName.contains("hủy")) color = "#ef4444"; // Đỏ (Hủy)
    else if (lowerName.contains("chờ")) color = "#f59e0b"; // Vàng (Chờ)
    else if (lowerName.contains("hoàn thành")) color = "#22c55e"; // Xanh (Thành công)
    
    orderColors.append("'").append(color).append("'");
}
// Kết quả trả về JSP: request.setAttribute("orderColors", "['#ef4444', '#22c55e', ...]");
```

### 2.3. View (`admin/index.jsp`)
Sử dụng thư viện `ApexCharts` để vẽ biểu đồ.

```javascript
// Lấy dữ liệu từ Servlet thông qua EL Expression
var revenueOptions = {
    series: [{
        name: 'Doanh Thu',
        data: ${revenueData} // Ví dụ: [0, 1500000, 2000000, ...]
    }],
    // ... Cấu hình Chart.js ...
};
```

---

## 3. MODULE 2: BẢO MẬT & QUẢN LÝ NGƯỜI DÙNG

### 3.1. ProfileServlet (`controller.admin.ProfileServlet`)
Tính năng đặc biệt: **Dual Save (Lưu Kép)** khi upload Avatar.

```java
// Khi người dùng upload ảnh đại diện mới:
if (filePart != null && filePart.getSize() > 0) {
    // 1. Lưu vào thư mục DEPLOY (Server đang chạy)
    // Mục đích: Để ảnh hiển thị ngay lập tức (Hot Reload).
    String uploadPath = getServletContext().getRealPath("") + ...;
    Files.copy(..., deployedPath, ...);

    // 2. Lưu vào thư mục SOURCE CODE (Ổ cứng máy Dev)
    // Mục đích: Để giữ file không bị mất khi Clean/Build lại dự án.
    // Lưu ý: Đường dẫn này HARDCODE theo máy developer.
    String sourcePathStr = "D:\\hai\\WebJAVA\\src\\main\\webapp\\assets\\images\\users";
    Files.copy(deployedPath, sourcePath, ...);
}
```

### 3.2. CustomerDAO (`dal.admin.CustomerDAO`)
Tính năng khóa tài khoản khách hàng.

```java
public boolean updateStatus(int customerId, boolean isActive) {
    // Update cờ IsActive. False = Khóa, True = Mở.
    String sql = "UPDATE tb_Customer SET IsActive = ? WHERE CustomerId = ?";
    // ...
}
```

---

## 4. MODULE 3: QUẢN LÝ SẢN PHẨM (TOUR)

### 4.1. TourDAO (`dal.admin.TourDAO`)
Sử dụng kỹ thuật **XOR Bitwise** để tối ưu hóa việc bật/tắt trạng thái.

```java
public void toggleStatus(int id) {
    // Logic: Nếu 1 -> 0, Nếu 0 -> 1.
    // CASE WHEN: Cú pháp SQL chuẩn.
    String sql = "UPDATE tb_Tour SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE TourId = ?";
    st.executeUpdate();
}
```

### 4.2. TourServlet (`controller.admin.TourServlet`)
Xử lý `@MultipartConfig` bắt buộc cho form có upload file.

```java
@MultipartConfig // Annotation bắt buộc để Servlet hiểu request dạng multipart/form-data
public class TourServlet extends HttpServlet {
    protected void doPost(...) {
        request.setCharacterEncoding("UTF-8"); // Bắt buộc để đọc tiếng Việt
        
        // Lấy file từ form
        Part filePart = request.getPart("imageFile");
        // ... Logic Dual Save tương tự Profile ...
    }
}
```

---

## 5. MODULE 4: QUẢN LÝ ĐƠN HÀNG (ORDER)

### 5.1. OrderDAO (`dal.admin.OrderDAO`)
Sử dụng **SQL JOIN** phức tạp để lấy thông tin hiển thị đầy đủ.

```java
public List<Order> getAllOrders(Integer statusId) {
    // Cần lấy Tên khách hàng (tb_Customer) và Tên trạng thái (tb_OrderStatus)
    String sql = "SELECT o.*, c.Fullname, s.StatusName " +
                 "FROM tb_Order o " +
                 "JOIN tb_Customer c ON o.CustomerId = c.CustomerId " + // JOIN bảng Khách
                 "JOIN tb_OrderStatus s ON o.OrderStatusId = s.OrderStatusId "; // JOIN bảng Trạng thái
                 
    // Dynamic Query: Chỉ thêm WHERE nếu có filter
    if (statusId != null) sql += " WHERE o.OrderStatusId = " + statusId;
    
    // Khi Map dữ liệu, Order Object có thêm các thuộc tính phụ (transient) để chứa tên Customer/Status
    order.setCustomerName(rs.getString("Fullname"));
    order.setStatusName(rs.getString("StatusName"));
}
```

### 5.2. View (`admin/quanlydonhang/index.jsp`)
Sử dụng **JSTL `c:choose`** để hiển thị Badge màu trạng thái.

```jsp
<span class="badge 
    <c:choose>
        <c:when test="${order.orderStatusId == 5}">bg-warning</c:when> <!-- Chờ: Vàng -->
        <c:when test="${order.orderStatusId == 6}">bg-success</c:when> <!-- Duyệt: Xanh -->
        <c:when test="${order.orderStatusId == 7}">bg-danger</c:when>  <!-- Hủy: Đỏ -->
    </c:choose>
">
    ${order.statusName}
</span>
```

---

## 6. MODULE 5: QUẢN LÝ NỘI DUNG (BLOG)

### 6.1. BlogDAO (`dal.admin.BlogDAO`)
Logic xóa phức tạp do ràng buộc khóa ngoại (Foreign Key).

```java
public void delete(int id) {
    // Quy tắc DB: Không thể xóa Blog nếu Blog đó đang có Comment.
    
    // Bước 1: Xóa hết comment của Blog này trước
    String deleteCommentsSql = "DELETE FROM tb_BlogComment WHERE BlogId = ?";
    stComments.executeUpdate();

    // Bước 2: Mới được phép xóa Blog
    String sql = "DELETE FROM tb_Blog WHERE BlogId = ?";
    st.executeUpdate();
}
```

---

## 7. MODULE 6: HỆ THỐNG (MENU, CONTACT)

### 7.1. MenuDAO (`dal.admin.MenuDAO`)
Quản lý cấu trúc Menu phân cấp (Cha - Con).

```java
// Sắp xếp theo vị trí (Position) để hiển thị đúng thứ tự trên menu bar
String sql = "SELECT * FROM tb_Menu ORDER BY Position ASC, MenuId ASC";
// Cột ParentId: Nếu = 0 là menu cha, > 0 là menu con của ID đó.
// Cột Levels: Độ sâu của menu (Level 1, Level 2...)
```

### 7.2. ContactServlet (`controller.admin.ContactServlet`)
Logic đánh dấu "Đã đọc" khi xem chi tiết.

```java
private void viewContact(...) {
    // Khi Admin bấm vào xem chi tiết liên hệ
    // Tự động update trạng thái IsRead = 1 trong DB
    dao.markAsRead(id);
    
    // Sau đó mới lấy dữ liệu hiển thị
    Contact contact = dao.getContactById(id);
    // ...
}
```