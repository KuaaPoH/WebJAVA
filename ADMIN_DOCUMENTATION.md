# TÀI LIỆU CHI TIẾT HỆ THỐNG QUẢN TRỊ (ADMIN)

Tài liệu này phân tích chi tiết mã nguồn (Source Code), luồng dữ liệu (Data Flow) và logic nghiệp vụ của từng chức năng trong trang Admin theo mô hình MVC.

---

## 1. TỔNG QUAN KIẾN TRÚC
*   **DAO (Data Access Object - Model):** Chuyên trách giao tiếp với SQL Server. Chứa các câu lệnh SQL.
*   **Servlet (Controller):** Nhận yêu cầu từ người dùng, gọi DAO xử lý, và điều hướng kết quả.
*   **JSP (View):** Hiển thị dữ liệu lên trình duyệt sử dụng JSTL/EL.

---

## 2. PHÂN TÍCH CHI TIẾT TỪNG MODULE

### 2.1. MODULE QUẢN LÝ TOUR (`QuanLyTour`)

Chức năng cốt lõi và phức tạp nhất vì xử lý thông tin sản phẩm và **Upload ảnh**.

#### A. Lớp DAO (`dal.admin.TourDAO.java`)
**Chức năng:** Thao tác với bảng `tb_Tour`.

**1. Lấy danh sách (`getAllTours`):
```java
public List<Tour> getAllTours() {
    List<Tour> list = new ArrayList<>();
    // SQL: Lấy tất cả cột, sắp xếp ID giảm dần (mới nhất lên đầu)
    String sql = "SELECT * FROM tb_Tour ORDER BY TourId DESC";
    
    try {
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery(); // Thực thi câu lệnh
        
        while (rs.next()) { // Duyệt qua từng dòng kết quả
            Tour t = new Tour();
            t.setTourId(rs.getInt("TourId"));
            t.setTitle(rs.getString("Title"));
            t.setPrice(rs.getInt("Price"));
            t.setImage(rs.getString("Image")); // Lưu ý: Chỉ lấy tên file (vd: tour1.jpg)
            t.setActive(rs.getBoolean("IsActive"));
            list.add(t);
        }
    } catch (SQLException e) { ... }
    return list;
}
```

**2. Ẩn/Hiện Tour (`toggleStatus`):
```java
public void toggleStatus(int id) {
    // Logic: Dùng phép XOR (^) để đảo ngược bit. 
    // Nếu đang 1 (Hiện) ^ 1 = 0 (Ẩn). Nếu đang 0 (Ẩn) ^ 1 = 1 (Hiện).
    // Cách này tối ưu hơn việc phải Select ra check rồi mới Update.
    String sql = "UPDATE tb_Tour SET IsActive = IsActive ^ 1 WHERE TourId = ?";
    PreparedStatement st = connection.prepareStatement(sql);
    st.setInt(1, id);
    st.executeUpdate();
}
```

#### B. Lớp Servlet (`controller.admin.TourServlet.java`)
**Chức năng:** Xử lý file upload và điều phối.

**1. Cấu hình & Xử lý tiếng Việt:
```java
@MultipartConfig // [BẮT BUỘC] Để Servlet có thể nhận file từ form
public class TourServlet extends HttpServlet {
    protected void doPost(...) {
        // [QUAN TRỌNG] Phải đặt đầu tiên để đọc đúng tiếng Việt từ form
        request.setCharacterEncoding("UTF-8"); 
        // ...
    }
}
```

**2. Logic Upload Ảnh (Dual Save):
```java
private void insertTour(...) {
    // 1. Lấy dữ liệu text
    String title = request.getParameter("title");
    
    // 2. Lấy file ảnh
    Part filePart = request.getPart("imageFile"); // "imageFile" là name bên JSP
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    
    // 3. Lưu vào thư mục Deploy (Server) - Để hiển thị ngay
    String deployPath = getServletContext().getRealPath("/assets/images/products");
    filePart.write(deployPath + File.separator + fileName);

    // 4. Lưu vào thư mục Source Code (Local) - Để giữ file vĩnh viễn
    // (Lưu ý: Đường dẫn này đang hardcode, cần cấu hình đúng với máy dev)
    String sourcePath = "D:\\hai\\WebJAVA\\src\\main\\webapp\\assets\\images\\products";
    // Code copy file từ deployPath sang sourcePath...

    // 5. Gọi DAO lưu thông tin vào DB
    Tour t = new Tour(title, ... fileName ...); // Chỉ lưu tên file
    dao.insert(t);
    
    // 6. Redirect để tránh resubmit form khi F5
    response.sendRedirect("quanlytour");
}
```

#### C. Lớp JSP (`admin/quanlytour/index.jsp`)
**Chức năng:** Hiển thị danh sách.

```jsp
<!-- Form tìm kiếm / Bảng dữ liệu -->
<c:forEach items="${listT}" var="t">
    <tr>
        <td>${t.tourId}</td>
        <td>
            <!-- Hiển thị ảnh: ContextPath + Đường dẫn cứng + Tên file từ DB -->
            <!-- onerror: Fallback nếu ảnh bị lỗi -->
            <img src="${pageContext.request.contextPath}/assets/images/products/${t.image}" 
                 onerror="this.src='.../no-image.png'" width="50">
        </td>
        <td>${t.title}</td>
        <td>
            <!-- Logic hiển thị trạng thái bằng màu sắc -->
            <c:if test="${t.active}">
                <span class="text-success">Hiện</span>
            </c:if>
            <c:if test="${!t.active}">
                <span class="text-danger">Ẩn</span>
            </c:if>
        </td>
        <td>
            <!-- Nút Toggle gọi qua GET request -->
            <a href="quanlytour?action=toggle&id=${t.tourId}">Ẩn/Hiện</a>
        </td>
    </tr>
</c:forEach>
```

---

### 2.2. MODULE QUẢN LÝ ĐƠN HÀNG (`QuanLyDonHang`)

Chức năng xử lý nghiệp vụ bán hàng, cần JOIN nhiều bảng.

#### A. Lớp DAO (`dal.admin.OrderDAO.java`)
**Chức năng:** Tổng hợp dữ liệu đơn hàng.

```java
public List<Order> getAllOrders(Integer statusId) {
    // [SQL JOIN]: Kết nối 3 bảng để lấy đầy đủ thông tin hiển thị
    // tb_Order (o): Thông tin đơn
    // tb_Customer (c): Lấy Fullname khách hàng
    // tb_OrderStatus (s): Lấy StatusName (Tiếng Việt)
    String sql = "SELECT o.*, c.Fullname, s.StatusName " +
                 "FROM tb_Order o " +
                 "JOIN tb_Customer c ON o.CustomerId = c.CustomerId " +
                 "JOIN tb_OrderStatus s ON o.OrderStatusId = s.OrderStatusId ";
                 
    // [Dynamic Query]: Nếu có lọc theo trạng thái thì cộng thêm điều kiện WHERE
    if (statusId != null) {
        sql += " WHERE o.OrderStatusId = " + statusId;
    }
    
    // ... Thực thi query ...
    // Khi map dữ liệu:
    // order.setCustomerName(rs.getString("Fullname")); // Set vào trường phụ
    // order.setStatusName(rs.getString("StatusName")); // Set vào trường phụ
}
```

#### B. Lớp Servlet (`controller.admin.OrderServlet.java`)
**Chức năng:** Xử lý lọc và cập nhật trạng thái.

```java
// GET Method
protected void doGet(...) {
    String action = request.getParameter("action");
    
    // 1. Chức năng Lọc (Filter)
    if (action.equals("list")) {
        String statusStr = request.getParameter("status"); // Lấy param từ URL (?status=5)
        Integer statusId = (statusStr != null) ? Integer.parseInt(statusStr) : null;
        
        List<Order> list = dao.getAllOrders(statusId);
        request.setAttribute("orders", list); // Đẩy data sang JSP
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    
    // 2. Chức năng Cập nhật trạng thái nhanh (Action Button)
    else if (action.equals("updateStatus")) {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int statusId = Integer.parseInt(request.getParameter("statusId"));
        
        dao.updateOrderStatus(orderId, statusId); // 6=Duyệt, 7=Hủy
        response.sendRedirect("orders?action=list"); // Load lại trang
    }
}
```

#### C. Lớp JSP (`admin/quanlydonhang/index.jsp`)
**Chức năng:** Hiển thị format dữ liệu.

```jsp
<!-- Import thư viện Format -->
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 1. Định dạng tiền tệ (1000000 -> 1,000,000) -->
<fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/> đ

<!-- 2. Định dạng ngày tháng (Date Object -> String dd/MM/yyyy) -->
<fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm"/>

<!-- 3. Badge trạng thái -->
<!-- Sử dụng StatusId để quyết định màu (Vàng/Xanh/Đỏ/Tím) -->
<span class="
    <c:choose>
        <c:when test="${order.orderStatusId == 5}">bg-warning</c:when> <!-- Chờ -->
        <c:when test="${order.orderStatusId == 6}">bg-success</c:when> <!-- Duyệt -->
        <c:when test="${order.orderStatusId == 7}">bg-danger</c:when>  <!-- Hủy -->
        <c:when test="${order.orderStatusId == 1008}">bg-purple</c:when> <!-- Yêu cầu hủy -->
    </c:choose>
">
    ${order.statusName} <!-- Tên tiếng Việt lấy từ DB -->
</span>
```

---

### 2.3. MODULE QUẢN LÝ SLIDE/BANNER (`QuanLySlide`)

Chức năng tạo URL thân thiện (SEO Friendly).

#### A. Lớp Servlet (`controller.admin.SlideServlet.java`)
**Chức năng:** Tự động tạo Alias (Slug).

```java
protected void doPost(...) {
    String title = request.getParameter("title"); // vd: "Du Lịch Hè"
    String alias = request.getParameter("alias");
    
    // Nếu người dùng lười không nhập Alias, hệ thống tự tạo
    if (alias == null || alias.isEmpty()) {
        alias = toSlug(title); // Kết quả: "du-lich-he"
    }
    // ... Lưu vào DB ...
}

// Hàm Utility: Chuyển tiếng Việt có dấu thành không dấu gạch ngang
public static String toSlug(String input) {
    // Bước 1: Chuẩn hóa NFD để tách dấu (dấu sắc, huyền...) ra khỏi ký tự gốc
    String normalized = Normalizer.normalize(input, Normalizer.Form.NFD);
    
    // Bước 2: Dùng Regex xóa sạch các dấu vừa tách
    Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
    String noAccent = pattern.matcher(normalized).replaceAll("");
    
    // Bước 3: Chuyển thường và thay khoảng trắng bằng "-"
    return noAccent.toLowerCase().replaceAll(" ", "-");
}
```

---

### 2.4. MODULE QUẢN LÝ ĐÁNH GIÁ (`QuanLyDanhGia`)

Chức năng xem nội dung chi tiết mà không làm vỡ giao diện bảng.

#### A. Lớp JSP (`admin/quanlydanhgia/index.jsp`)
**Chức năng:** UI Modal Popup.

```jsp
<!-- 1. Hiển thị cắt gọn trên bảng -->
<!-- Class truncate của Tailwind sẽ thêm dấu "..." nếu dài quá -->
<div class="truncate max-w-[200px]" title="${r.detail}">
    ${r.detail}
</div>

<!-- 2. Nút Xem chi tiết -->
<button onclick="openViewModal(this)">Xem</button>

<!-- 3. Dữ liệu ẩn (Hidden Data) trong dòng -->
<span class="data-content hidden">${r.detail}</span>

<!-- 4. Script xử lý Modal -->
<script>
function openViewModal(btn) {
    // Tìm dòng (tr) chứa nút bấm
    const row = btn.closest('tr');
    // Lấy nội dung full từ thẻ ẩn
    const content = row.querySelector('.data-content').innerText;
    // Gán vào Modal và hiện lên
    document.getElementById('modal-content').innerText = content;
    document.getElementById('viewModal').classList.remove('hidden');
}
</script>
```

---

## 3. CÁC THÀNH PHẦN KỸ THUẬT CHUNG

### 3.1. Sidebar Component (`admin/components/sidebar.jsp`)
**Mục đích:** Tái sử dụng code menu cho tất cả các trang Admin.

```jsp
<!-- Logic Active Menu: Kiểm tra xem URL hiện tại có chứa link của menu không -->
<li class="${request.getRequestURI().contains('/admin/quanlytour') ? 'active' : ''}">
    <a href="quanlytour">Quản Lý Tour</a>
</li>
```

### 3.2. AdminFilter (`controller.filter.AdminFilter`)
**Mục đích:** Bảo mật, chặn truy cập trái phép.

```java
@WebFilter(urlPatterns = {"/admin/*"}) // Chặn mọi link bắt đầu bằng /admin/
public void doFilter(...) {
    HttpSession session = request.getSession();
    // Kiểm tra session "admin" (được tạo lúc đăng nhập)
    if (session.getAttribute("admin") == null) {
        // Nếu chưa đăng nhập -> Đá về trang Login
        response.sendRedirect("../login");
    } else {
        // Nếu ok -> Cho phép đi tiếp vào Servlet/JSP đích
        chain.doFilter(request, response);
    }
}
```
