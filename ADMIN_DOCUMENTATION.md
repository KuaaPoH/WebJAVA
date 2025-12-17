# TÀI LIỆU PHÂN TÍCH CODE CHI TIẾT (LINE-BY-LINE ANATOMY)

Tài liệu này đi sâu vào giải thích từng dòng lệnh trong mã nguồn hệ thống Admin, bao gồm Logic Java (DAO/Servlet), Câu lệnh SQL và Giao diện JSP.

---

## 1. MODULE BẢO MẬT (SECURITY)

### File: `controller.filter.AdminFilter.java`

```java
@WebFilter(filterName = "AdminFilter", urlPatterns = {"/admin/*"})
// Annotation @WebFilter: Khai báo class này là một Filter (bộ lọc) trong Java Web.
// urlPatterns = {"/admin/*"}: Quy định Filter này sẽ chặn TẤT CẢ các request gửi đến đường dẫn bắt đầu bằng "/admin/".
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        // Ép kiểu (Casting) từ ServletRequest (interface cha) sang HttpServletRequest (giao thức HTTP) 
        // để sử dụng được các phương thức đặc thù của HTTP như getSession(), sendRedirect().
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // httpRequest.getSession(false):
        // - Tham số 'false': Chỉ lấy session nếu nó ĐÃ TỒN TẠI.
        // - Nếu chưa có session (người dùng chưa đăng nhập hoặc session hết hạn), trả về NULL.
        // - Không dùng 'true' để tránh việc tạo session rác cho người dùng chưa đăng nhập.
        HttpSession session = httpRequest.getSession(false);

        // Logic kiểm tra đăng nhập:
        // 1. session != null: Session phải tồn tại.
        // 2. session.getAttribute("admin") != null: Phải có đối tượng "admin" được lưu trong session (xảy ra khi login thành công).
        boolean isLoggedIn = (session != null && session.getAttribute("admin") != null);

        if (isLoggedIn) {
            // Lấy đối tượng Account từ session ra để kiểm tra quyền hạn (Role).
            Account adminAccount = (Account) session.getAttribute("admin");
            
            // Kiểm tra RoleId:
            // - Giả định RoleId = 1 là Admin (Quản trị viên cao cấp).
            // - Giả định RoleId = 2 là Staff (Nhân viên).
            if (adminAccount.getRoleId() == 1 || adminAccount.getRoleId() == 2) {
                 // chain.doFilter: Cho phép request đi tiếp đến đích (Servlet hoặc JSP mong muốn).
                 // Đây là dòng quan trọng nhất để "mở cổng".
                 chain.doFilter(request, response);
            } else {
                 // Đã đăng nhập nhưng Role không hợp lệ -> Chuyển hướng về trang Login kèm thông báo lỗi "unauthorized".
                 httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=unauthorized");
            }
        } else {
            // Trường hợp chưa đăng nhập (Session null hoặc không có attribute admin).
            // Chuyển hướng ngay lập tức về trang Login.
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
}
```

---

## 2. MODULE DASHBOARD (THỐNG KÊ)

### File: `dal.admin.DashboardDAO.java`

**Hàm: `getMonthlyRevenue(int year)`**

```java
public List<Double> getMonthlyRevenue(int year) {
    // Khởi tạo List để chứa doanh thu của 12 tháng.
    List<Double> list = new ArrayList<>();
    
    // Vòng lặp for chạy 12 lần (tương ứng 12 tháng).
    // add(0.0): Khởi tạo giá trị mặc định là 0 cho tất cả các tháng.
    // Tại sao? Vì câu lệnh SQL chỉ trả về các tháng CÓ doanh thu. Nếu tháng 5 không bán được gì, SQL sẽ không trả về dòng nào cho tháng 5.
    // Nếu không khởi tạo trước, List sẽ bị thiếu tháng và lệch index.
    for (int i = 0; i < 12; i++) {
        list.add(0.0);
    }
    
    // Câu lệnh SQL:
    // - MONTH(CreatedDate): Hàm SQL lấy số tháng (1-12).
    // - SUM(TotalAmount): Hàm SQL tính tổng tiền.
    // - WHERE YEAR(...) = ?: Chỉ lấy dữ liệu của năm được truyền vào.
    // - GROUP BY MONTH(...): Gom nhóm các đơn hàng cùng tháng lại để tính tổng.
    String sql = "SELECT MONTH(CreatedDate) as Month, SUM(TotalAmount) as Total " +
                 "FROM tb_Order WHERE YEAR(CreatedDate) = ? GROUP BY MONTH(CreatedDate)";
    
    try {
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, year); // Gán tham số năm vào dấu ?
        ResultSet rs = st.executeQuery(); // Thực thi câu lệnh
        
        while (rs.next()) {
            int month = rs.getInt("Month");   // Lấy cột Month (1-12)
            double total = rs.getDouble("Total"); // Lấy cột Total (Tổng tiền) 
            
            // Logic mapping vào List:
            // - Tháng trong thực tế: 1 đến 12.
            // - Index trong List Java: 0 đến 11.
            // => Phải lấy (month - 1) để ra index đúng.
            // Ví dụ: Tháng 1 -> index 0. Tháng 12 -> index 11.
            if (month >= 1 && month <= 12) {
                list.set(month - 1, total); // Dùng hàm set() để ghi đè lên giá trị 0.0 ban đầu.
            }
        }
    } catch (SQLException e) { ... } // TODO: Handle exception properly
    return list;
}
```

### File: `controller.admin.DashboardServlet.java`

**Logic: Tạo dữ liệu màu sắc cho biểu đồ (Chart Colors)**

```java
// Gọi DAO lấy dữ liệu thống kê trạng thái đơn hàng (Map<Tên trạng thái, Số lượng>)
Map<String, Integer> statusCounts = dao.getOrderStatusCounts();

// StringBuilder dùng để nối chuỗi hiệu năng cao.
// Ta đang tự tay xây dựng một chuỗi JSON Array (ví dụ: "['#f00', '#0f0']") để gửi sang Javascript.
StringBuilder orderColors = new StringBuilder("["); 

for (Map.Entry<String, Integer> entry : statusCounts.entrySet()) {
    // Lấy tên trạng thái, xóa khoảng trắng thừa (trim) và chuyển về chữ thường (toLowerCase)
    // Mục đích: Để so sánh chuỗi dễ dàng, không phân biệt hoa thường.
    String lowerName = entry.getKey().trim().toLowerCase();
    
    String color = "#6b7280"; // Khởi tạo màu mặc định là Xám (Gray).

    // Logic Heuristic (Suy đoán): Dựa vào từ khóa trong tên để gán màu ý nghĩa.
    // - Nếu tên chứa "yêu cầu" -> Màu Tím (Info).
    if (lowerName.contains("yêu cầu")) {
        color = "#a855f7"; 
    } 
    // - Nếu tên chứa "hủy", "từ chối" -> Màu Đỏ (Danger).
    else if (lowerName.contains("hủy") || lowerName.contains("cancel")) {
        color = "#ef4444"; 
    } 
    // - Nếu tên chứa "chờ" -> Màu Vàng (Warning).
    else if (lowerName.contains("chờ") || lowerName.contains("pending")) {
        color = "#f59e0b"; 
    } 
    // - Nếu tên chứa "xác nhận", "duyệt", "hoàn thành" -> Màu Xanh lá (Success).
    else if (lowerName.contains("xác nhận") || lowerName.contains("hoàn thành")) {
        color = "#22c55e"; 
    }
    
    // Nối màu đã chọn vào chuỗi JSON. 
    // Thêm dấu nháy đơn (') bao quanh mã màu.
    orderColors.append("'").append(color).append("'").append(",");
}
// Kết thúc vòng lặp, ta sẽ có chuỗi kiểu: "['#ef4444','#22c55e',..."
// Biến này sau đó được setAttribute để JSP sử dụng.
request.setAttribute("orderColors", orderColors.toString() + "]");
```

---

## 3. MODULE QUẢN LÝ TOUR

### File: `dal.admin.TourDAO.java`

**Hàm: `toggleStatus(int id)`**

```java
public void toggleStatus(int id) {
    // Câu lệnh SQL này sử dụng logic điều kiện (Conditional Logic) ngay trong database.
    // UPDATE [tb_Tour]: Cập nhật bảng Tour.
    // SET [IsActive] = CASE WHEN [IsActive] = 1 THEN 0 ELSE 1 END:
    // - Kiểm tra giá trị hiện tại của cột IsActive.
    // - Nếu đang là 1 (Active) -> Gán thành 0.
    // - Ngược lại (đang là 0) -> Gán thành 1.
    // Lợi ích: Thực hiện việc đảo trạng thái (Toggle) chỉ bằng 1 câu lệnh duy nhất, không cần SELECT dữ liệu về Java xử lý rồi mới UPDATE lại.
    String sql = "UPDATE [dbo].[tb_Tour] SET [IsActive] = CASE WHEN [IsActive] = 1 THEN 0 ELSE 1 END WHERE TourId = ?";
    
    try {
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id); // Truyền ID tour cần đảo trạng thái.
        st.executeUpdate(); // Thực thi Update.
    } catch (SQLException e) { ... } // TODO: Handle exception properly
}
```

### File: `controller.admin.TourServlet.java`

**Hàm: `insertTour(...)` - Xử lý Dual Save (Lưu ảnh 2 nơi)**

```java
// @MultipartConfig: Bắt buộc phải có Annotation này thì Servlet mới đọc được dữ liệu file từ form (enctype="multipart/form-data").
private void insertTour(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    
    // Lấy phần dữ liệu file từ request theo name input="imageFile".
    Part filePart = request.getPart("imageFile");
    
    // Lấy tên file gốc (ví dụ "anh-du-lich.jpg") từ header Content-Disposition.
    // Sử dụng Paths.get().getFileName() để loại bỏ đường dẫn thư mục (nếu trình duyệt gửi kèm).
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    
    if (fileName != null && !fileName.isEmpty()) {
        // --- VỊ TRÍ 1: THƯ MỤC DEPLOY (Runtime) ---
        // getServletContext().getRealPath("/assets..."): Lấy đường dẫn tuyệt đối tới thư mục webapp trong server Tomcat đang chạy.
        // Ví dụ: C:\Tomcat\webapps\ROOT\assets\images\products
        String deployedUploadPath = getServletContext().getRealPath("/assets/images/products");
        
        // Tạo đối tượng Path.
        Path deployedPath = Paths.get(deployedUploadPath, fileName);
        
        // Tạo thư mục nếu chưa tồn tại.
        Files.createDirectories(deployedPath.getParent());
        
        // Ghi dữ liệu từ luồng input (InputStream) của file upload vào đường dẫn đích.
        // StandardCopyOption.REPLACE_EXISTING: Nếu file đã tồn tại thì ghi đè.
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, deployedPath, StandardCopyOption.REPLACE_EXISTING);
        }

        // --- VỊ TRÍ 2: THƯ MỤC SOURCE CODE (Development) ---
        // Đây là đường dẫn cứng (Hardcoded) trỏ tới thư mục mã nguồn dự án trên máy tính của Developer.
        // D:\hai\WebJAVA\src\main\webapp\assets\images\products
        // Mục đích: Khi Developer clean/build lại dự án, thư mục DEPLOY (Vị trí 1) sẽ bị xóa sạch.
        // Việc lưu vào Vị trí 2 đảm bảo file ảnh không bị mất, nó sẽ được copy lại vào Vị trí 1 trong lần build sau.
        try {
            String sourceProjectPath = "D:\\hai\\WebJAVA"; // Note: Backslashes need to be escaped in string literals
            String sourceUploadPath = Paths.get(sourceProjectPath, "src", "main", "webapp", "assets", "images", "products").toString();
            Path sourcePath = Paths.get(sourceUploadPath, fileName);
            
            Files.createDirectories(sourcePath.getParent());
            // Copy file từ thư mục Deploy sang thư mục Source.
            Files.copy(deployedPath, sourcePath, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException | InterruptedException e) { 
            // TODO: Handle exception properly
            e.printStackTrace(); 
        }
    }
    
    // Tạo đối tượng Tour và lưu tên file ảnh vào Database (chỉ lưu tên file, không lưu đường dẫn full).
    Tour newTour = new Tour();
    newTour.setImage(fileName);
    // ... gọi DAO insert ...
}
```

### File: `webapp/admin/quanlytour/index.jsp`

```jsp
    <!-- Vòng lặp forEach của JSTL để duyệt qua danh sách Tour -->
    <c:forEach items="${listT}" var="t">
        <tr>
            <td>${t.tourId}</td> <!-- Hiển thị ID -->
            <td>
                <!-- Thẻ img hiển thị ảnh sản phẩm. -->
                <!-- ${pageContext.request.contextPath}: Lấy đường dẫn gốc của ứng dụng (ví dụ: /WebJAVA). -->
                <!-- onerror="...": Sự kiện Javascript. Nếu ảnh không tải được (lỗi 404), nó sẽ tự động thay thế src bằng ảnh 'no-image.png'. -->
                <img src="${pageContext.request.contextPath}/assets/images/products/${t.image}" 
                     onerror="this.src='${pageContext.request.contextPath}/assets/images/no-image.png'" width="50">
            </td>
            <td>${t.title}</td>
            <td>
                <!-- Logic hiển thị trạng thái bằng màu sắc -->
                <!-- Nếu t.active là true -->
                <c:if test="${t.active}">
                    <span class="text-success">Hiện</span> <!-- Class text-success thường là màu xanh -->
                </c:if>
                <!-- Nếu t.active là false -->
                <c:if test="${!t.active}">
                    <span class="text-danger">Ẩn</span> <!-- Class text-danger thường là màu đỏ -->
                </c:if>
            </td>
            <td>
                <!-- Nút hành động. Gửi GET request kèm tham số action=toggle và id của tour -->
                <a href="quanlytour?action=toggle&id=${t.tourId}">Đổi trạng thái</a>
            </td>
        </tr>
    </c:forEach>
```

---

## 4. MODULE QUẢN LÝ ĐƠN HÀNG (ORDER)

### File: `dal.admin.OrderDAO.java`

**Hàm: `getAllOrders(Integer statusId)`**

```java
public List<Order> getAllOrders(Integer statusId) {
    // Câu lệnh SQL sử dụng JOIN để kết hợp dữ liệu từ 3 bảng:
    // 1. tb_Order (o): Bảng chính chứa thông tin đơn hàng.
    // 2. tb_OrderStatus (os): Để lấy tên trạng thái (Name) thay vì chỉ lấy ID.
    // 3. tb_Customer (c): Để lấy tên khách hàng (Fullname).
    String sql = "SELECT o.*, os.Name AS OrderStatusName, c.Fullname " +
                 "FROM tb_Order o " +
                 "JOIN tb_OrderStatus os ON o.OrderStatusId = os.OrderStatusId " +
                 "JOIN tb_Customer c ON o.CustomerId = c.CustomerId "; 
    
    // Logic SQL động (Dynamic SQL):
    // Nếu biến statusId khác null (tức là người dùng có chọn bộ lọc trên giao diện),
    // ta nối thêm điều kiện WHERE vào câu lệnh SQL.
    if (statusId != null) {
        sql += "WHERE o.OrderStatusId = ? ";
    }
    
    sql += "ORDER BY o.CreatedDate DESC"; // Luôn sắp xếp đơn mới nhất lên đầu.

    // ... (Thực thi query) ...

    while (rs.next()) {
        Order order = new Order();
        // Map các cột từ DB vào Object.
        order.setOrderId(rs.getInt("OrderId"));
        
        // Cột "OrderStatusName" là cột ảo do ta đặt Alias trong câu SQL (os.Name AS ...).
        // Ta lấy giá trị này và set vào thuộc tính phụ (transient field) trong class Order để hiển thị ra View.
        order.setStatusName(rs.getString("OrderStatusName"));
        order.setCustomerName(rs.getString("Fullname"));
        
        list.add(order);
    }
    return list;
}
```

### File: `webapp/admin/quanlydonhang/index.jsp`

**Logic: Hiển thị Badge trạng thái đơn hàng**

```jsp
    <!-- Sử dụng thẻ <c:choose> của JSTL (tương đương switch-case trong Java) -->
    <span class="badge 
        <c:choose>
            <c:when test="${order.orderStatusId == 5}">bg-warning</c:when> <!-- ID 5: Chờ xác nhận -> Class màu Vàng -->
            <c:when test="${order.orderStatusId == 6}">bg-success</c:when> <!-- ID 6: Đã xác nhận -> Class màu Xanh lá -->
            <c:when test="${order.orderStatusId == 7}">bg-danger</c:when>  <!-- ID 7: Đã hủy -> Class màu Đỏ -->
            <c:when test="${order.orderStatusId == 1008}">bg-purple</c:when> <!-- ID 1008: Yêu cầu hủy -> Class màu Tím -->
            <c:otherwise>bg-secondary</c:otherwise> <!-- Các trạng thái khác -> Class màu Xám -->
        </c:choose>
    ">
        <!-- Hiển thị tên trạng thái (lấy từ SQL JOIN) -->
        ${order.statusName}
    </span>
```

---

## 5. MODULE PROFILE (HỒ SƠ ADMIN)

### File: `controller.admin.ProfileServlet.java`

**Hàm: `doPost` (Xử lý đổi mật khẩu)**

```java
if ("changePass".equals(action)) {
    // Lấy 3 trường dữ liệu từ form đổi mật khẩu.
    String currentPass = request.getParameter("currentPass");
    String newPass = request.getParameter("newPass");
    String confirmPass = request.getParameter("confirmPass");

    // Validation 1: Kiểm tra mật khẩu hiện tại nhập vào có khớp với mật khẩu trong Session không.
    // admin.getPassword(): Lấy mật khẩu đang lưu trong đối tượng Session.
    if (!admin.getPassword().equals(currentPass)) {
        request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
    } 
    // Validation 2: Kiểm tra mật khẩu mới và xác nhận mật khẩu có trùng nhau không.
    else if (!newPass.equals(confirmPass)) {
        request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
    } 
    else {
        // Nếu tất cả hợp lệ:
        // 1. Gọi DAO để thực hiện câu lệnh UPDATE Password trong Database.
        dao.changePassword(admin.getAccountId(), newPass);
        
        // 2. CẬP NHẬT SESSION (Rất quan trọng):
        // Phải cập nhật lại mật khẩu mới vào đối tượng admin đang lưu trong Session.
        // Nếu không làm bước này, người dùng vẫn đang giữ session với mật khẩu cũ, 
        // dẫn đến lần kiểm tra sau sẽ bị sai hoặc gây lỗi khi reload.
        admin.setPassword(newPass);
        session.setAttribute("admin", admin); 
        
        request.setAttribute("message", "Đổi mật khẩu thành công!");
    }
}
```

---

## 6. MODULE MENU (QUẢN LÝ MENU)

### File: `dal.admin.MenuDAO.java`

**Hàm: `getAllMenus()`**

```java
// Câu lệnh SQL lấy danh sách Menu.
// ORDER BY Position ASC: Sắp xếp ưu tiên theo cột Position (thứ tự hiển thị người dùng cài đặt).
// MenuId ASC: Nếu cùng Position, thì cái nào tạo trước (ID nhỏ hơn) sẽ đứng trước.
String sql = "SELECT * FROM tb_Menu ORDER BY Position ASC, MenuId ASC";
```

### File: `webapp/admin/quanlymenu/index.jsp`

**Logic: Hiển thị tên Menu cha (Parent Lookup)**

```jsp
    <c:forEach items="${listM}" var="m">
        <tr>
            <td>${m.title}</td>
            <td>
                <!-- Kiểm tra cột Levels để hiển thị cấp độ menu -->
                <c:if test="${m.levels == 1}">Menu Gốc</c:if>
                <c:if test="${m.levels > 1}">Menu Con (Cấp ${m.levels})</c:if>
            </td>
            <td>
                <!-- Kỹ thuật tra cứu Map trong EL (Expression Language) -->
                <!-- ${menuMap}: Là một HashMap<Integer, String> mapping từ ID -> Tên Menu. -->
                <!-- ${m.parentId}: Là ID của menu cha của dòng hiện tại. -->
                <!-- ${menuMap[m.parentId]}: Tương đương menuMap.get(id) trong Java. -->
                <!-- Giúp hiển thị tên menu cha mà không cần thực hiện query SQL lồng nhau. -->
                ${menuMap[m.parentId]} 
            </td>
        </tr>
    </c:forEach>
```

---

## 7. MODULE CONTACT (LIÊN HỆ)

### File: `controller.admin.ContactServlet.java`

**Hàm: `viewContact` (Xem chi tiết liên hệ)**

```java
private void viewContact(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    int id = Integer.parseInt(request.getParameter("id"));
    ContactDAO dao = new ContactDAO();
    
    // Logic nghiệp vụ: Khi Admin bấm vào xem chi tiết một liên hệ.
    // Hệ thống tự động đánh dấu liên hệ đó là "Đã đọc" (IsRead = 1).
    dao.markAsRead(id); 
    
    // Sau khi update xong, mới lấy dữ liệu chi tiết lên để hiển thị.
    Contact contact = dao.getContactById(id);
    
    request.setAttribute("contact", contact);
    request.getRequestDispatcher("/admin/quanlylienhe/view.jsp").forward(request, response);
}
```

---

## 8. MODULE BLOG (BÀI VIẾT)

### File: `dal.admin.BlogDAO.java`

**Hàm: `delete(int id)` - Xử lý ràng buộc toàn vẹn (Constraints)**

```java
public void delete(int id) {
    // Vấn đề: Trong Database, bảng tb_BlogComment có khóa ngoại (Foreign Key) tham chiếu đến tb_Blog.
    // Nếu ta cố xóa một Blog đang có Comment, SQL Server sẽ chặn lại và báo lỗi Constraint Violation.
    
    // Giải pháp: Phải xóa dữ liệu con trước.
    
    // Bước 1: Xóa toàn bộ bình luận (Comments) thuộc về Blog này.
    String deleteCommentsSql = "DELETE FROM [dbo].[tb_BlogComment] WHERE BlogId = ?";
    PreparedStatement stComments = connection.prepareStatement(deleteCommentsSql);
    stComments.setInt(1, id);
    stComments.executeUpdate();

    // Bước 2: Sau khi đã sạch sẽ dữ liệu liên quan, mới tiến hành xóa Blog.
    String sql = "DELETE FROM [dbo].[tb_Blog] WHERE BlogId = ?";
    PreparedStatement st = connection.prepareStatement(sql);
    st.setInt(1, id);
    st.executeUpdate();
}
```