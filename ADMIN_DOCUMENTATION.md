# TÀI LIỆU GIẢI PHẪU MÃ NGUỒN (CODE ANATOMY) - TOÀN TẬP

Tài liệu này giải thích chi tiết ý nghĩa và tác dụng của từng dòng code trong **TOÀN BỘ** các module hệ thống Admin.

---

## 1. CORE SYSTEM (LÕI HỆ THỐNG)

### 1.1. Security Filter (`controller.filter.AdminFilter.java`)
**Chức năng:** Chặn và kiểm soát quyền truy cập vào thư mục `/admin`.

```java
@WebFilter(filterName = "AdminFilter", urlPatterns = {"/admin/*"})
// @WebFilter: Khai báo class này là một Filter chặn request.
// urlPatterns = {"/admin/*"}: Bất kỳ request nào vào đường dẫn con của /admin/ đều phải đi qua hàm doFilter.

public class AdminFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        // Ép kiểu request/response về dạng HTTP để dùng các hàm getSession, sendRedirect.

        HttpSession session = httpRequest.getSession(false);
        // Lấy Session hiện tại. Tham số 'false' nghĩa là KHÔNG tạo mới session nếu chưa có.
        // Đây là cách kiểm tra chính xác người dùng đã đăng nhập hay chưa.

        boolean isLoggedIn = (session != null && session.getAttribute("admin") != null);
        // isLoggedIn = True nếu session tồn tại VÀ có key "admin" bên trong.

        if (isLoggedIn) {
            Account adminAccount = (Account) session.getAttribute("admin");
            // Lấy đối tượng Account từ session để kiểm tra quyền hạn.
            
            if (adminAccount.getRoleId() == 1 || adminAccount.getRoleId() == 2) {
                 // Nếu RoleId là 1 (Admin) hoặc 2 (Nhân viên) -> Hợp lệ.
                 chain.doFilter(request, response); // Cho phép request đi tiếp đến đích.
            } else {
                 // Đã login nhưng không đủ quyền -> Chuyển hướng về trang lỗi.
                 httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=unauthorized");
            }
        } else {
            // Chưa đăng nhập -> Chuyển hướng về trang Login.
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
}
```

---

## 2. MODULE DASHBOARD (THỐNG KÊ)

### 2.1. DAO (`dal.admin.DashboardDAO.java`)

**Hàm `getMonthlyRevenue(int year)`:**
```java
    public List<Double> getMonthlyRevenue(int year) {
        List<Double> list = new ArrayList<>();
        for (int i = 0; i < 12; i++) {
            list.add(0.0); // Khởi tạo trước 12 số 0.0 cho 12 tháng.
        }
        
        // Query tính tổng tiền theo tháng trong năm chỉ định.
        String sql = "SELECT MONTH(CreatedDate) as Month, SUM(TotalAmount) as Total " +
                     "FROM tb_Order WHERE YEAR(CreatedDate) = ? GROUP BY MONTH(CreatedDate)";
    
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, year);
        ResultSet rs = st.executeQuery();
        
        while (rs.next()) {
            int month = rs.getInt("Month");
            double total = rs.getDouble("Total");
            if (month >= 1 && month <= 12) {
                // Gán doanh thu vào đúng index trong list (Tháng 1 -> index 0).
                list.set(month - 1, total);
            }
        }
        return list;
    }
```

### 2.2. Servlet (`controller.admin.DashboardServlet.java`)

**Xử lý màu sắc biểu đồ (Heuristic Logic):**
```java
        Map<String, Integer> statusCounts = dao.getOrderStatusCounts();
        StringBuilder orderColors = new StringBuilder("["); // Xây dựng chuỗi JSON Array thủ công.

        for (Map.Entry<String, Integer> entry : statusCounts.entrySet()) {
            String lowerName = entry.getKey().trim().toLowerCase();
            String color = "#6b7280"; // Màu xám mặc định.

            // Logic đoán màu dựa trên từ khóa trong tên trạng thái:
            if (lowerName.contains("yêu cầu")) color = "#a855f7"; // Tím
            else if (lowerName.contains("hủy")) color = "#ef4444"; // Đỏ
            else if (lowerName.contains("chờ")) color = "#f59e0b"; // Vàng
            else if (lowerName.contains("hoàn thành")) color = "#22c55e"; // Xanh
            
            orderColors.append("'" + color + "',");
        }
        // Kết quả trả về JSP: request.setAttribute("orderColors", "['#f59e0b', '#22c55e']");
```

---

## 3. MODULE TOUR (SẢN PHẨM)

### 3.1. DAO (`dal.admin.TourDAO.java`)

**Hàm `toggleStatus(int id)`:**
```java
    public void toggleStatus(int id) {
        // Sử dụng CASE WHEN để đảo giá trị 0 <-> 1 trực tiếp trong SQL.
        // Không cần Select ra rồi mới Update -> Tối ưu hiệu năng.
        String sql = "UPDATE [dbo].[tb_Tour] SET [IsActive] = CASE WHEN [IsActive] = 1 THEN 0 ELSE 1 END WHERE TourId = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        st.executeUpdate();
    }
```

### 3.2. Servlet (`controller.admin.TourServlet.java`)

**Hàm `insertTour` - Xử lý Upload Dual-Save:**
```java
    @MultipartConfig // Bắt buộc để nhận file upload.
    public void insertTour(...) {
        Part filePart = request.getPart("imageFile"); // Lấy file từ form.
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        if (fileName != null && !fileName.isEmpty()) {
            // 1. Lưu vào thư mục DEPLOY (Server Runtime)
            // Để ảnh hiện ngay lập tức mà không cần restart server.
            String deployedUploadPath = getServletContext().getRealPath("/assets/images/products");
            Path deployedPath = Paths.get(deployedUploadPath, fileName);
            Files.copy(filePart.getInputStream(), deployedPath, StandardCopyOption.REPLACE_EXISTING);

            // 2. Lưu vào thư mục SOURCE CODE (Máy Dev)
            // Để giữ file vĩnh viễn, tránh bị mất khi Clean/Build lại project.
            String sourceProjectPath = "D:\\hai\\WebJAVA"; 
            String sourceUploadPath = Paths.get(sourceProjectPath, "src", "main", "webapp", "assets", "images", "products").toString();
            Files.copy(deployedPath, Paths.get(sourceUploadPath, fileName), ...);
        }
    }
```

### 3.3. JSP (`admin/quanlytour/index.jsp`)
```jsp
    <c:forEach items="${listT}" var="t">
        <!-- Hiển thị ảnh kèm fallback nếu lỗi -->
        <img src="${pageContext.request.contextPath}/assets/images/products/${t.image}" 
             onerror="this.src='.../no-image.png'">
        
        <!-- Badge trạng thái -->
        <c:if test="${t.active}"><span class="text-success">Hiện</span></c:if>
        <c:if test="${!t.active}"><span class="text-danger">Ẩn</span></c:if>
        
        <!-- Nút gọi Action Toggle -->
        <a href="quanlytour?action=toggle&id=${t.tourId}">Đổi trạng thái</a>
    </c:forEach>
```

---

## 4. MODULE ORDER (ĐƠN HÀNG)

### 4.1. DAO (`dal.admin.OrderDAO.java`)

**Hàm `getAllOrders` - Kỹ thuật SQL JOIN:**
```java
    public List<Order> getAllOrders(Integer statusId) {
        // JOIN 3 bảng để lấy đầy đủ thông tin hiển thị (Tên khách, Tên trạng thái).
        String sql = "SELECT o.*, os.Name AS OrderStatusName, c.Fullname " +
                     "FROM tb_Order o " +
                     "JOIN tb_OrderStatus os ON o.OrderStatusId = os.OrderStatusId " + 
                     "JOIN tb_Customer c ON o.CustomerId = c.CustomerId "; 
        
        // SQL Động: Chỉ thêm WHERE khi có tham số lọc.
        if (statusId != null) {
            sql += "WHERE o.OrderStatusId = ? ";
        }
        // ... Map dữ liệu vào Order Object (bao gồm cả các trường phụ OrderStatusName) ...
    }
```

### 4.2. Servlet (`controller.admin.OrderServlet.java`)

**Xử lý Filter & Update:**
```java
    if ("list".equals(action)) {
        // Nhận statusId từ URL (?status=5).
        String statusStr = request.getParameter("status");
        Integer statusId = (statusStr != null) ? Integer.parseInt(statusStr) : null;
        
        // Gọi DAO lấy list đã lọc.
        List<Order> orders = orderDAO.getAllOrders(statusId);
        
        request.setAttribute("orders", orders);
        request.setAttribute("currentStatus", statusId); // Truyền lại để JSP highlight nút đang chọn.
        request.getRequestDispatcher("/admin/quanlydonhang/index.jsp").forward(...);
    } 
    else if ("updateStatus".equals(action)) {
        // Cập nhật nhanh trạng thái đơn hàng.
        dao.updateOrderStatus(orderId, statusId);
        // Redirect về trang list để refresh dữ liệu.
        response.sendRedirect("orders?action=list");
    }
```

---

## 5. MODULE BLOG (BÀI VIẾT)

### 5.1. DAO (`dal.admin.BlogDAO.java`)

**Hàm `delete(int id)` - Xử lý Khóa Ngoại:**
```java
    public void delete(int id) {
        // Quy tắc DB: Không được xóa Blog nếu đang có Comment con.
        
        // Bước 1: Xóa hết comment của Blog này trước.
        String deleteCommentsSql = "DELETE FROM [dbo].[tb_BlogComment] WHERE BlogId = ?";
        PreparedStatement stComments = connection.prepareStatement(deleteCommentsSql);
        stComments.setInt(1, id);
        stComments.executeUpdate();

        // Bước 2: Sau khi sạch comment mới được xóa Blog.
        String sql = "DELETE FROM [dbo].[tb_Blog] WHERE BlogId = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        st.executeUpdate();
    }
```

### 5.2. Servlet (`controller.admin.BlogServlet.java`)
(Logic Upload ảnh và CRUD tương tự module Tour).

---

## 6. MODULE MENU (CẤU HÌNH MENU)

### 6.1. DAO (`dal.admin.MenuDAO.java`)

**Hàm `getAllMenus`:**
```java
    // Sắp xếp theo Position (thứ tự hiển thị) -> ID.
    String sql = "SELECT * FROM tb_Menu ORDER BY Position ASC, MenuId ASC";
    // Các cột quan trọng:
    // - ParentId: ID menu cha (0 = Root).
    // - Levels: Độ sâu menu (dùng để thụt lề UI).
```

### 6.2. JSP (`admin/quanlymenu/index.jsp`)

**Logic hiển thị phân cấp:**
```jsp
    <c:forEach items="${listM}" var="m">
        <tr>
            <td>${m.title}</td>
            <td>
                <!-- Hiển thị cấp độ -->
                <c:if test="${m.levels == 1}">Menu Gốc</c:if>
                <c:if test="${m.levels > 1}">Menu Con (Cấp ${m.levels})</c:if>
            </td>
            <td>
                <!-- Hiển thị tên Menu Cha bằng cách tra cứu Map -->
                <!-- menuMap được Servlet chuẩn bị sẵn: Map<ID, Name> -->
                ${menuMap[m.parentId]} 
            </td>
        </tr>
    </c:forEach>
```

---

## 7. MODULE REVIEW (ĐÁNH GIÁ & FEEDBACK)

### 7.1. DAO (`dal.admin.ReviewDAO.java`)

**Hàm `getAllReviews` - LEFT JOIN:**
```java
    public List<TourReview> getAllReviews() {
        // Lấy thông tin Review kèm theo Tên Tour (Title).
        // Dùng LEFT JOIN phòng trường hợp Tour đã bị xóa thì Review vẫn hiện (dù TourName = null).
        String sql = "SELECT r.*, t.Title AS TourName " +
                     "FROM tb_TourReview r " +
                     "LEFT JOIN tb_Tour t ON r.ProductId = t.TourId " +
                     "ORDER BY r.CreatedDate DESC";
        // ... Map dữ liệu ...
    }
```

### 7.2. Servlet (`controller.admin.ReviewServlet.java`)

**Các Action xử lý:**
```java
    if (action.equals("hide")) {
        // Ẩn đánh giá (ví dụ spam, tục tĩu).
        dao.updateStatus(id, false); 
        response.sendRedirect("reviews");
    } else if (action.equals("show")) {
        // Hiện đánh giá lại.
        dao.updateStatus(id, true);
        response.sendRedirect("reviews");
    }
```

### 7.3. JSP (`admin/quanlydanhgia/index.jsp`)

**Kỹ thuật Modal Xem Chi Tiết:**
```jsp
    <!-- Nút mở Modal -->
    <button onclick="openViewModal(this)">Xem</button>

    <!-- Các thẻ chứa dữ liệu ẩn (Hidden Data) trong từng dòng bảng -->
    <span class="data-content hidden" title="${r.detail}">${r.detail}</span>
    <span class="data-user hidden">${r.name}</span>

    <script>
        function openViewModal(btn) {
            // Tìm dòng tr chứa nút bấm.
            const row = btn.closest('tr');
            // Lấy dữ liệu từ các thẻ ẩn trong dòng đó.
            const content = row.querySelector('.data-content').getAttribute('title');
            // Gán vào Modal và hiển thị lên.
            document.getElementById('modal-content').innerText = content;
            document.getElementById('viewModal').classList.remove('hidden');
        }
    </script>
```

---

## 8. MODULE SLIDE (BANNER QUẢNG CÁO)

### 8.1. Servlet (`controller.admin.SlideServlet.java`)

**Hàm `toSlug` - Tạo Alias tự động:**
```java
    public static String toSlug(String input) {
        // 1. Chuẩn hóa NFD để tách dấu tiếng Việt.
        String normalized = Normalizer.normalize(input, Normalizer.Form.NFD);
        // 2. Dùng Regex xóa các dấu vừa tách.
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(normalized).replaceAll("")
                      .toLowerCase() // Chuyển chữ thường
                      .replaceAll(" ", "-"); // Thay khoảng trắng bằng gạch ngang
    }
    
    // Sử dụng trong doPost:
    if (alias == null || alias.isEmpty()) {
        alias = toSlug(title); // "Du Lịch Hè" -> "du-lich-he"
    }
```

---

## 9. MODULE PROFILE (HỒ SƠ ADMIN)

### 9.1. Servlet (`controller.admin.ProfileServlet.java`)

**Logic Đổi Mật Khẩu:**
```java
    if ("changePass".equals(action)) {
        // Kiểm tra mật khẩu cũ.
        if (!admin.getPassword().equals(currentPass)) {
            request.setAttribute("error", "Mật khẩu cũ sai!");
        } 
        // Kiểm tra xác nhận mật khẩu mới.
        else if (!newPass.equals(confirmPass)) {
            request.setAttribute("error", "Xác nhận mật khẩu không khớp!");
        } 
        else {
            // Cập nhật DB.
            dao.changePassword(admin.getAccountId(), newPass);
            // QUAN TRỌNG: Cập nhật lại Session để đồng bộ.
            admin.setPassword(newPass);
            session.setAttribute("admin", admin);
        }
    }
```
