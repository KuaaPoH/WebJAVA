# TÀI LIỆU PHÂN TÍCH CODE CHI TIẾT (LINE-BY-LINE) - HỆ THỐNG ADMIN

Tài liệu này giải thích chi tiết từng dòng lệnh, logic nghiệp vụ trong các file mã nguồn của hệ thống Admin.

---

## 1. CORE SYSTEM (LÕI HỆ THỐNG)

### 1.1. Security Filter (`controller.filter.AdminFilter.java`)
**Mục đích:** Chặn và kiểm soát quyền truy cập vào tất cả các link bắt đầu bằng `/admin/`.

```java
@WebFilter(filterName = "AdminFilter", urlPatterns = {"/admin/*"})
// @WebFilter: Khai báo class này là một Filter.
// urlPatterns = {"/admin/*"}: Bất kỳ request nào vào đường dẫn con của /admin/ đều phải đi qua hàm doFilter dưới đây.

public class AdminFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) ... {
        // 1. Ép kiểu ServletRequest sang HttpServletRequest để dùng được các hàm HTTP (session, cookie...)
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 2. Lấy Session hiện tại. Tham số 'false' nghĩa là:
        // - Nếu session đang có -> Trả về session đó.
        // - Nếu chưa có session -> Trả về null (Không tạo mới).
        // Dùng 'false' để kiểm tra chính xác người dùng đã đăng nhập hay chưa.
        HttpSession session = httpRequest.getSession(false);

        // 3. Kiểm tra logic đăng nhập:
        // - session != null: Phải có session.
        // - session.getAttribute("admin") != null: Trong session phải có key "admin" (được set lúc login thành công).
        boolean isLoggedIn = (session != null && session.getAttribute("admin") != null);

        if (isLoggedIn) {
            // 4. Lấy đối tượng Account từ session ra để kiểm tra quyền (Role)
            Account adminAccount = (Account) session.getAttribute("admin");
            
            // 5. Kiểm tra RoleId. Giả sử DB quy định: 1=Admin, 2=Nhân viên.
            if (adminAccount.getRoleId() == 1 || adminAccount.getRoleId() == 2) {
                 // Hợp lệ: Cho phép request đi tiếp đến Servlet đích hoặc JSP đích.
                 chain.doFilter(request, response);
            } else {
                 // Đã đăng nhập nhưng không phải quyền Admin -> Đuổi về Login kèm mã lỗi.
                 httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=unauthorized");
            }
        } else {
            // Chưa đăng nhập -> Đuổi về trang Login.
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
}
```

---

## 2. MODULE DASHBOARD (THỐNG KÊ)

### 2.1. DAO (`dal.admin.DashboardDAO.java`)

**Hàm `getMonthlyRevenue(int year)` - Biểu đồ doanh thu:**
```java
public List<Double> getMonthlyRevenue(int year) {
    List<Double> list = new ArrayList<>();
    // Vòng lặp khởi tạo List có 12 phần tử là 0.0.
    // Để đảm bảo tháng nào không có doanh thu thì hiển thị là 0 thay vì null/bỏ qua.
    for (int i = 0; i < 12; i++) {
        list.add(0.0);
    }
    
    // SQL: Tính tổng (SUM) TotalAmount gom nhóm theo Tháng (MONTH).
    // Điều kiện: Chỉ lấy trong năm được truyền vào (WHERE YEAR = ?).
    String sql = "SELECT MONTH(CreatedDate) as Month, SUM(TotalAmount) as Total " +
                 "FROM tb_Order WHERE YEAR(CreatedDate) = ? GROUP BY MONTH(CreatedDate)";
    
    // ... Thực thi query ...
    while (rs.next()) {
        int month = rs.getInt("Month");   // Lấy tháng (1-12)
        double total = rs.getDouble("Total"); // Lấy tổng tiền
        
        // Cập nhật giá trị vào List.
        // Lưu ý: List index bắt đầu từ 0, nên phải lấy (month - 1).
        // Ví dụ: Tháng 1 -> index 0.
        if (month >= 1 && month <= 12) {
            list.set(month - 1, total);
        }
    }
    return list;
}
```

### 2.2. Servlet (`controller.admin.DashboardServlet.java`)

**Xử lý dữ liệu cho Biểu đồ Tròn (Pie Chart) - Phân tích trạng thái đơn hàng:**
```java
// Gọi DAO lấy Map<Tên trạng thái, Số lượng>
Map<String, Integer> statusCounts = dao.getOrderStatusCounts();

// Khởi tạo 3 StringBuilder để xây dựng chuỗi JSON Array thủ công cho Javascript
StringBuilder orderLabels = new StringBuilder("["); // Tên (vd: 'Mới', 'Hủy')
StringBuilder orderData = new StringBuilder("[");   // Số liệu (vd: 5, 2)
StringBuilder orderColors = new StringBuilder("["); // Màu sắc (vd: '#ccc', 'red')

for (Map.Entry<String, Integer> entry : statusCounts.entrySet()) {
    // Logic gán màu tự động (Heuristic) dựa trên từ khóa trong tên trạng thái
    String lowerName = entry.getKey().toLowerCase(); // Chuyển về chữ thường để so sánh
    String color = "#6b7280"; // Màu mặc định (Xám)

    if (lowerName.contains("hủy")) { 
        color = "#ef4444"; // Nếu tên có chữ "hủy" -> Màu Đỏ
    } else if (lowerName.contains("chờ")) {
        color = "#f59e0b"; // Nếu tên có chữ "chờ" -> Màu Vàng
    } else if (lowerName.contains("hoàn thành") || lowerName.contains("duyệt")) {
        color = "#22c55e"; // Nếu tên có chữ "hoàn thành"/"duyệt" -> Màu Xanh lá
    }
    
    // Append vào chuỗi JSON
    orderLabels.append("'").append(entry.getKey()).append("',");
    orderData.append(entry.getValue()).append(",");
    orderColors.append("'").append(color).append("',");
}
// Kết quả trả về JSP dạng chuỗi: "['Mới', 'Hủy']" ...
```

### 2.3. View (`admin/index.jsp`)
Sử dụng thư viện ApexCharts để vẽ.

```javascript
// Lấy dữ liệu từ Servlet đẩy sang bằng EL Expression ${}
var orderOptions = {
    series: ${orderData},  // Dữ liệu số: [10, 5, 3]
    labels: ${orderLabels}, // Nhãn: ['Đã duyệt', 'Hủy', 'Mới']
    colors: ${orderColors}, // Màu: ['#22c55e', '#ef4444', '#f59e0b']
    chart: {
        type: 'donut', // Loại biểu đồ: Bánh rán
    },
    // ... config khác ...
};
var oChart = new ApexCharts(document.querySelector("#orderChart"), orderOptions);
oChart.render(); // Vẽ lên màn hình
```

---

## 3. MODULE TOUR (QUẢN LÝ SẢN PHẨM)

### 3.1. DAO (`dal.admin.TourDAO.java`)

**Hàm `toggleStatus(int id)` - Ẩn/Hiện Tour:**
```java
public void toggleStatus(int id) {
    // Sử dụng kỹ thuật toán học để đảo trạng thái ngay trong SQL:
    // CASE WHEN [IsActive] = 1 THEN 0 ELSE 1 END
    // Nghĩa là: Nếu đang là 1 (Hiện) thì thành 0 (Ẩn), và ngược lại.
    // Cách này nhanh hơn việc: Select ra check -> If Java -> Update lại.
    String sql = "UPDATE [dbo].[tb_Tour] SET [IsActive] = CASE WHEN [IsActive] = 1 THEN 0 ELSE 1 END WHERE TourId = ?";
    
    PreparedStatement st = connection.prepareStatement(sql);
    st.setInt(1, id);
    st.executeUpdate();
}
```

### 3.2. Servlet (`controller.admin.TourServlet.java`)

**Xử lý Upload Ảnh & Dual Save (Lưu Kép) trong hàm `insertTour`:**
```java
// Lấy file từ form input có name="imageFile"
Part filePart = request.getPart("imageFile");
String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

if (fileName != null && !fileName.isEmpty()) {
    // --- BƯỚC 1: Lưu vào thư mục DEPLOY (Server Runtime) ---
    // getRealPath("/assets..."): Trả về đường dẫn thực tế nơi Tomcat đang chạy ứng dụng.
    // Việc này giúp ảnh hiển thị NGAY LẬP TỨC sau khi upload.
    String deployedUploadPath = getServletContext().getRealPath("/assets/images/products");
    Path deployedPath = Paths.get(deployedUploadPath, fileName);
    Files.copy(filePart.getInputStream(), deployedPath, StandardCopyOption.REPLACE_EXISTING);

    // --- BƯỚC 2: Lưu vào thư mục SOURCE CODE (Local Disk) ---
    // Đường dẫn này là đường dẫn cứng (Hardcoded) trỏ đến folder project của bạn.
    // Mục đích: Khi bạn Clean/Build lại Project, thư mục Deploy (Bước 1) sẽ bị xóa sạch.
    // Việc lưu vào đây giúp giữ lại file ảnh vĩnh viễn trong source code.
    String sourceProjectPath = "D:\\hai\\WebJAVA"; 
    String sourceUploadPath = Paths.get(sourceProjectPath, "src", "main", "webapp", "assets", "images", "products").toString();
    Files.copy(deployedPath, Paths.get(sourceUploadPath, fileName), ...);
}
```

### 3.3. JSP (`admin/quanlytour/index.jsp`)

**Hiển thị bảng và trạng thái:**
```jsp
<c:forEach items="${listT}" var="t"> <!-- Duyệt qua danh sách Tour -->
    <tr>
        <td>
            <!-- Hiển thị ảnh. Đường dẫn gồm: ContextPath + Folder + Tên file từ DB -->
            <img src="${pageContext.request.contextPath}/assets/images/products/${t.image}" width="50">
        </td>
        <td>${t.title}</td>
        <td>
            <!-- Logic hiển thị Badge trạng thái -->
            <!-- Nếu t.active == true -->
            <c:if test="${t.active}">
                <span class="text-success">Hiện</span>
            </c:if>
            <!-- Nếu t.active == false -->
            <c:if test="${!t.active}">
                <span class="text-danger">Ẩn</span>
            </c:if>
        </td>
        <td>
            <!-- Nút Toggle gọi Servlet qua GET request -->
            <a href="quanlytour?action=toggle&id=${t.tourId}">Đổi trạng thái</a>
        </td>
    </tr>
</c:forEach>
```

---

## 4. MODULE ORDER (QUẢN LÝ ĐƠN HÀNG)

### 4.1. DAO (`dal.admin.OrderDAO.java`)

**Hàm `getAllOrders` - Kỹ thuật JOIN bảng:**
```java
public List<Order> getAllOrders(Integer statusId) {
    // Cần lấy thêm tên Status (từ bảng tb_OrderStatus) và tên Khách (từ bảng tb_Customer)
    // Thay vì chỉ hiển thị ID vô nghĩa (vd: StatusId=5, CustomerId=10).
    String sql = "SELECT o.*, os.Name AS OrderStatusName, c.Fullname " +
                 "FROM tb_Order o " +
                 "JOIN tb_OrderStatus os ON o.OrderStatusId = os.OrderStatusId " + // Nối bảng Trạng thái
                 "JOIN tb_Customer c ON o.CustomerId = c.CustomerId ";          // Nối bảng Khách hàng
    
    // Logic lọc động (Dynamic Filter):
    // Nếu tham số statusId được truyền vào (khác null), thì cộng thêm điều kiện WHERE.
    if (statusId != null) {
        sql += "WHERE o.OrderStatusId = ? ";
    }
    
    sql += "ORDER BY o.CreatedDate DESC"; // Sắp xếp đơn mới nhất lên đầu
    
    // ... Map dữ liệu ...
    while (rs.next()) {
        Order order = new Order();
        // ... set các cột cơ bản ...
        order.setStatusName(rs.getString("OrderStatusName")); // Set tên trạng thái lấy từ JOIN
        list.add(order);
    }
}
```

### 4.2. Servlet (`controller.admin.OrderServlet.java`)

**Xử lý Filter và Action:**
```java
String action = request.getParameter("action");

if ("list".equals(action)) {
    // 1. Nhận tham số status từ URL (vd: ?status=5)
    String statusStr = request.getParameter("status");
    Integer statusId = null;
    if (statusStr != null) statusId = Integer.parseInt(statusStr);

    // 2. Gọi DAO lấy danh sách đã lọc
    List<Order> orders = orderDAO.getAllOrders(statusId);
    
    // 3. Đẩy dữ liệu sang JSP
    request.setAttribute("orders", orders);
    request.setAttribute("currentStatus", statusId); // Để JSP biết nút nào đang Active
    request.getRequestDispatcher("/admin/quanlydonhang/index.jsp").forward(request, response);
} 
else if ("updateStatus".equals(action)) {
    // Xử lý cập nhật nhanh trạng thái
    int orderId = Integer.parseInt(request.getParameter("orderId"));
    int statusId = Integer.parseInt(request.getParameter("statusId"));
    dao.updateOrderStatus(orderId, statusId);
    
    // Redirect lại trang danh sách để thấy thay đổi
    response.sendRedirect("orders?action=list");
}
```

---

## 5. MODULE BLOG (QUẢN LÝ BÀI VIẾT)

### 5.1. DAO (`dal.admin.BlogDAO.java`)

**Hàm `delete(int id)` - Xử lý ràng buộc khóa ngoại (Foreign Key Constraint):**
```java
public void delete(int id) {
    // Trong Database, bảng Comment có khóa ngoại trỏ về bảng Blog.
    // Nếu xóa Blog trực tiếp, SQL sẽ báo lỗi vì còn tồn tại Comment con.
    
    // Bước 1: Xóa toàn bộ Comment của Blog này trước.
    String deleteCommentsSql = "DELETE FROM [dbo].[tb_BlogComment] WHERE BlogId = ?";
    PreparedStatement stComments = connection.prepareStatement(deleteCommentsSql);
    stComments.setInt(1, id);
    stComments.executeUpdate();

    // Bước 2: Sau khi sạch Comment, mới xóa Blog.
    String sql = "DELETE FROM [dbo].[tb_Blog] WHERE BlogId = ?";
    PreparedStatement st = connection.prepareStatement(sql);
    st.setInt(1, id);
    st.executeUpdate();
}
```

### 5.2. Servlet (`controller.admin.BlogServlet.java`)
Logic tương tự module Tour: Cũng có `showCreateForm`, `insertBlog` (xử lý upload ảnh), `deleteBlog`, `toggleStatus`.

---

## 6. MODULE MENU (QUẢN LÝ MENU)

### 6.1. DAO (`dal.admin.MenuDAO.java`)

**Hàm `getAllMenus()` - Sắp xếp hiển thị:**
```java
// Menu cần hiển thị theo thứ tự người dùng cài đặt (Position).
// Nếu cùng Position thì xếp theo ID.
String sql = "SELECT * FROM tb_Menu ORDER BY Position ASC, MenuId ASC";

// Các cột quan trọng:
// - ParentId: ID của menu cha. Nếu = 0 là menu gốc.
// - Levels: Cấp độ sâu của menu (Level 1, Level 2). Dùng để thụt đầu dòng hiển thị UI.
```

### 6.2. JSP (`admin/quanlymenu/index.jsp`)
Hiển thị Menu cha con.

```jsp
<c:forEach items="${listM}" var="m">
    <tr>
        <td>${m.title}</td>
        <td>
            <!-- Hiển thị cột Level -->
            <c:if test="${m.levels == 1}">Menu Gốc</c:if>
            <c:if test="${m.levels > 1}">Menu Con (Cấp ${m.levels})</c:if>
        </td>
        <td>
            <!-- Hiển thị tên Menu Cha -->
            <!-- Dùng Map để tra cứu nhanh: map.get(id_cha) -> ra tên cha -->
            ${menuMap[m.parentId]} 
        </td>
    </tr>
</c:forEach>
```

---

## 7. MODULE CONTACT (LIÊN HỆ)

### 7.1. DAO (`dal.admin.ContactDAO.java`)

**Hàm `getAllContacts()` - Sắp xếp theo trạng thái Đã đọc/Chưa đọc:**
```java
// Ưu tiên hiển thị tin chưa đọc (IsRead=0) lên đầu.
// Sau đó mới sắp xếp theo ngày gửi mới nhất.
String sql = "SELECT * FROM tb_Contact ORDER BY IsRead ASC, CreatedDate DESC";
```

### 7.2. Servlet (`controller.admin.ContactServlet.java`)

**Hàm `viewContact` - Đánh dấu đã đọc:**
```java
private void viewContact(...) {
    int id = Integer.parseInt(request.getParameter("id"));
    
    // Ngay khi Admin bấm vào xem chi tiết:
    // Gọi DAO update cột IsRead = 1.
    dao.markAsRead(id);
    
    // Sau đó lấy dữ liệu contact trả về JSP view.jsp
    Contact contact = dao.getContactById(id);
    request.setAttribute("contact", contact);
    request.getRequestDispatcher("...view.jsp").forward(...);
}
```

---

## 8. MODULE PROFILE (HỒ SƠ ADMIN)

### 8.1. Servlet (`controller.admin.ProfileServlet.java`)

**Hàm `doPost` - Xử lý đổi mật khẩu:**
```java
if ("changePass".equals(action)) {
    // 1. Lấy dữ liệu form
    String currentPass = request.getParameter("currentPass");
    String newPass = request.getParameter("newPass");
    String confirmPass = request.getParameter("confirmPass");

    // 2. Validate (Kiểm tra dữ liệu)
    // So sánh mật khẩu hiện tại nhập vào với mật khẩu trong Session (hoặc DB)
    if (!admin.getPassword().equals(currentPass)) {
        request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
    } 
    // Kiểm tra mật khẩu mới và xác nhận có khớp nhau không
    else if (!newPass.equals(confirmPass)) {
        request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
    } 
    else {
        // 3. Nếu OK -> Gọi DAO update pass mới vào DB
        dao.changePassword(admin.getAccountId(), newPass);
        
        // 4. Cập nhật lại thông tin trong Session để đồng bộ
        admin.setPassword(newPass);
        session.setAttribute("admin", admin);
        
        request.setAttribute("message", "Đổi mật khẩu thành công!");
    }
}
```
