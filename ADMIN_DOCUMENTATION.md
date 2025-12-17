# TÀI LIỆU GIẢI PHẪU MÃ NGUỒN (CODE ANATOMY) - LINE BY LINE

Tài liệu này giải thích chi tiết ý nghĩa và tác dụng của từng dòng code trong hệ thống Admin.

---

## 1. CORE SYSTEM (LÕI HỆ THỐNG)

### 1.1. File: `controller.filter.AdminFilter.java`
**Chức năng:** Chặn và kiểm soát quyền truy cập vào thư mục `/admin`.

```java
@WebFilter(filterName = "AdminFilter", urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {
```
*   `@WebFilter(...)`: Annotation khai báo class này là Filter.
*   `urlPatterns = {"/admin/*"}`: Quy định Filter này sẽ bắt tất cả các request có đường dẫn bắt đầu bằng `/admin/`.

```java
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
```
*   `doFilter`: Phương thức chính xử lý logic lọc.
*   `HttpServletRequest httpRequest = ...`: Ép kiểu `ServletRequest` (giao diện chung) sang `HttpServletRequest` (giao thức HTTP) để có thể sử dụng các phương thức như `getSession()`, `getContextPath()`.
*   `HttpServletResponse httpResponse = ...`: Tương tự, ép kiểu để dùng `sendRedirect()`.

```java
        HttpSession session = httpRequest.getSession(false);
```
*   `httpRequest.getSession(false)`: Lấy đối tượng Session hiện tại. Tham số `false` cực kỳ quan trọng: nó bảo hệ thống **không tạo mới** session nếu chưa có. Nếu người dùng chưa đăng nhập, biến `session` sẽ là `null`.

```java
        boolean isLoggedIn = (session != null && session.getAttribute("admin") != null);
```
*   `session != null`: Kiểm tra xem session có tồn tại không.
*   `session.getAttribute("admin") != null`: Kiểm tra xem trong session có thuộc tính `admin` không (thuộc tính này được lưu khi login thành công).
*   Kết quả `isLoggedIn` là `true` nếu người dùng đã đăng nhập hợp lệ.

```java
        if (isLoggedIn) {
            Account adminAccount = (Account) session.getAttribute("admin");
            if (adminAccount.getRoleId() == 1 || adminAccount.getRoleId() == 2) {
                 chain.doFilter(request, response);
            } else {
                 httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=unauthorized");
            }
```
*   `if (isLoggedIn)`: Nếu đã đăng nhập, tiến hành kiểm tra quyền.
*   `Account adminAccount = ...`: Lấy đối tượng `Account` từ session ra để xem thông tin user.
*   `if (adminAccount.getRoleId() == 1 ...)`: Kiểm tra vai trò. Giả định `1` là Admin cao cấp, `2` là Quản lý.
*   `chain.doFilter(...)`: Quan trọng nhất. Lệnh này cho phép request **đi tiếp** đến đích (Servlet hoặc JSP mong muốn).
*   `else`: Nếu không phải Admin/Quản lý -> Chuyển hướng về trang Login kèm lỗi "unauthorized".

```java
        } else {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
}
```
*   `else` (của `isLoggedIn`): Nếu chưa đăng nhập -> Chuyển hướng ngay lập tức về trang Login.

---

## 2. MODULE DASHBOARD (BẢNG ĐIỀU KHIỂN)

### 2.1. File: `dal.admin.DashboardDAO.java`

**Hàm `getMonthlyRevenue(int year)`:**
```java
    public List<Double> getMonthlyRevenue(int year) {
        List<Double> list = new ArrayList<>();
        for (int i = 0; i < 12; i++) {
            list.add(0.0);
        }
```
*   `List<Double> list`: Tạo danh sách chứa doanh thu của 12 tháng.
*   `for (...) list.add(0.0)`: Khởi tạo trước 12 giá trị `0.0`. Điều này đảm bảo list luôn có đủ 12 phần tử (từ index 0 đến 11). Nếu không làm bước này, khi query SQL chỉ trả về tháng 1 và tháng 12, ta sẽ khó gán đúng vị trí.

```java
        String sql = "SELECT MONTH(CreatedDate) as Month, SUM(TotalAmount) as Total " +
                     "FROM tb_Order WHERE YEAR(CreatedDate) = ? GROUP BY MONTH(CreatedDate)";
```
*   `SELECT MONTH(...)`: Lấy số tháng (1-12) từ ngày tạo đơn.
*   `SUM(TotalAmount)`: Cộng tổng tiền của các đơn hàng.
*   `WHERE YEAR(...) = ?`: Chỉ tính trong năm được truyền vào.
*   `GROUP BY ...`: Nhóm các đơn hàng cùng tháng lại để tính tổng.

```java
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, year);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int month = rs.getInt("Month");
                double total = rs.getDouble("Total");
                if (month >= 1 && month <= 12) {
                    list.set(month - 1, total);
                }
            }
        } ...
        return list;
    }
```
*   `st.setInt(1, year)`: Gán giá trị năm vào dấu `?`.
*   `list.set(month - 1, total)`: Đây là dòng logic quan trọng. Tháng trong SQL là 1-12, nhưng Index trong List Java là 0-11. Nên phải trừ đi 1. Ví dụ: Tháng 1 sẽ gán vào index 0.

### 2.2. File: `controller.admin.DashboardServlet.java`

**Đoạn code xử lý màu sắc biểu đồ (Dynamic Color Logic):**
```java
        Map<String, Integer> statusCounts = dao.getOrderStatusCounts();
        StringBuilder orderColors = new StringBuilder("[");

        for (Map.Entry<String, Integer> entry : statusCounts.entrySet()) {
            String lowerName = entry.getKey().trim().toLowerCase();
            String color = "#6b7280"; // Màu xám (Mặc định)

            if (lowerName.contains("yêu cầu")) {
                color = "#a855f7"; // Màu Tím (Request)
            } else if (lowerName.contains("hủy") || lowerName.contains("cancel")) {
                color = "#ef4444"; // Màu Đỏ (Danger)
            } else if (lowerName.contains("chờ") || lowerName.contains("pending")) {
                color = "#f59e0b"; // Màu Vàng (Warning)
            } else if (lowerName.contains("xác nhận") || lowerName.contains("hoàn thành")) {
                color = "#22c55e"; // Màu Xanh lá (Success)
            }
            
            orderColors.append("'").append(color).append("'").append(",");
        }
```
*   `statusCounts`: Map chứa dữ liệu từ DB (Ví dụ: "Đã hủy" -> 5, "Mới" -> 2).
*   `lowerName`: Chuyển tên trạng thái về chữ thường để so sánh chính xác hơn.
*   Các dòng `if/else`: Đây là logic "Heuristic" (dựa trên kinh nghiệm). Hệ thống đoán màu sắc dựa trên từ khóa trong tên trạng thái. Ví dụ thấy chữ "hủy" thì gán màu đỏ.
*   `orderColors.append(...)`: Ghép chuỗi để tạo ra mảng JSON String (ví dụ: `['#ef4444', '#22c55e']`) để gửi sang Javascript vẽ biểu đồ.

---

## 3. MODULE QUẢN LÝ TOUR (SẢN PHẨM)

### 3.1. File: `dal.admin.TourDAO.java`

**Hàm `toggleStatus(int id)`:**
```java
    public void toggleStatus(int id) {
        String sql = "UPDATE [dbo].[tb_Tour] SET [IsActive] = CASE WHEN [IsActive] = 1 THEN 0 ELSE 1 END WHERE TourId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } ...
    }
```
*   `UPDATE ... SET [IsActive] = CASE WHEN ...`: Đây là kỹ thuật xử lý logic ngay tại tầng Database.
    *   `CASE WHEN [IsActive] = 1 THEN 0`: Nếu giá trị hiện tại là 1 -> Gán thành 0.
    *   `ELSE 1`: Ngược lại (đang là 0) -> Gán thành 1.
*   Lợi ích: Chỉ cần 1 query duy nhất. Không cần tốn 2 query (1 SELECT lấy giá trị cũ, 1 UPDATE giá trị mới).

### 3.2. File: `controller.admin.TourServlet.java`

**Hàm `insertTour` - Xử lý File Upload (Line-by-Line):**
```java
    @MultipartConfig // Bắt buộc có để Servlet đọc được request upload file
    public class TourServlet ... {
    
    private void insertTour(...) {
        // ... (Lấy các trường text bình thường) ...

        Part filePart = request.getPart("imageFile");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
```
*   `request.getPart("imageFile")`: Lấy đối tượng file được gửi lên từ form có `name="imageFile"`.
*   `Paths.get(...).getFileName()`: Trích xuất tên file gốc (ví dụ "hanoi.jpg") từ đường dẫn đầy đủ mà trình duyệt gửi lên (một số trình duyệt gửi cả path C:\...). 

```java
        if (fileName != null && !fileName.isEmpty()) {
            // 1. Lưu vào thư mục DEPLOY (Server Runtime)
            String deployedUploadPath = getServletContext().getRealPath("/assets/images/products");
            Path deployedPath = Paths.get(deployedUploadPath, fileName);
            Files.createDirectories(deployedPath.getParent());
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, deployedPath, StandardCopyOption.REPLACE_EXISTING);
            }
```
*   `getServletContext().getRealPath(...)`: Trả về đường dẫn vật lý tuyệt đối tới thư mục webapp đang chạy trên server (Ví dụ: `D:\tomcat\webapps\ROOT\assets...`).
*   `Files.copy(...)`: Copy luồng dữ liệu từ file upload vào đường dẫn đích. `REPLACE_EXISTING` nghĩa là nếu file trùng tên thì ghi đè.
*   **Mục đích:** Để ảnh hiển thị được ngay lập tức trên trình duyệt người dùng.

```java
            // 2. Lưu vào thư mục SOURCE CODE (Ổ cứng máy Dev)
            try {
                String sourceProjectPath = "D:\\hai\\WebJAVA";
                String sourceUploadPath = Paths.get(sourceProjectPath, "src", "main", "webapp", "assets", "images", "products").toString();
                Path sourcePath = Paths.get(sourceUploadPath, fileName);
                Files.copy(deployedPath, sourcePath, StandardCopyOption.REPLACE_EXISTING);
            } ...
```
*   `sourceProjectPath`: Đường dẫn cứng trỏ tới thư mục code gốc.
*   `Files.copy(deployedPath, sourcePath...)`: Copy file vừa lưu ở server sang thư mục code.
*   **Mục đích:** Để khi lập trình viên Clean & Build lại dự án (hành động này xóa sạch thư mục Deploy), file ảnh không bị mất đi.

### 3.3. File: `admin/quanlytour/index.jsp`

```jsp
<c:forEach items="${listT}" var="t">
    <tr>
        <td>${t.tourId}</td>
        <td>
            <img src="${pageContext.request.contextPath}/assets/images/products/${t.image}" 
                 onerror="this.src='${pageContext.request.contextPath}/assets/images/no-image.png'" width="50">
        </td>
```
*   `<c:forEach ...>`: Vòng lặp JSTL duyệt qua danh sách Tour.
*   `src="${pageContext...}/.../${t.image}"`: Đường dẫn ảnh = Đường dẫn gốc (ContextPath) + Thư mục chứa ảnh + Tên file ảnh trong DB.
*   `onerror="this.src='...no-image.png'"`: Sự kiện Javascript. Nếu ảnh chính bị lỗi (404 Not Found), tự động thay thế bằng ảnh mặc định `no-image.png`.

```java
        <td>
            <c:if test="${t.active}">
                <span class="text-success">Hiện</span>
            </c:if>
            <c:if test="${!t.active}">
                <span class="text-danger">Ẩn</span>
            </c:if>
        </td>
        <td>
            <a href="quanlytour?action=toggle&id=${t.tourId}">Ẩn/Hiện</a>
        </td>
```
*   `c:if test="${t.active}"`: Kiểm tra thuộc tính `isActive` của đối tượng Tour.
*   Link `href="quanlytour?action=toggle..."`: Gửi GET request về Servlet với tham số `action=toggle` để gọi hàm đảo trạng thái.

---

## 4. MODULE QUẢN LÝ ĐƠN HÀNG (ORDER)

### 4.1. File: `dal.admin.OrderDAO.java`

**Hàm `getAllOrders` - Kỹ thuật SQL JOIN:**
```java
    public List<Order> getAllOrders(Integer statusId) {
        String sql = "SELECT o.*, os.Name AS OrderStatusName " +
                     "FROM tb_Order o " +
                     "JOIN tb_OrderStatus os ON o.OrderStatusId = os.OrderStatusId ";
```
*   `SELECT o.*`: Lấy tất cả cột bảng Order.
*   `os.Name AS OrderStatusName`: Lấy cột `Name` từ bảng `tb_OrderStatus` và đặt bí danh (Alias) là `OrderStatusName`.
*   `JOIN ... ON ...`: Kết nối 2 bảng dựa trên khóa ngoại `OrderStatusId`. Nếu không JOIN, ta chỉ có ID trạng thái (số 5, 6) chứ không biết tên nó là gì ("Chờ xử lý", "Đã hủy").

```java
        if (statusId != null) {
            sql += "WHERE o.OrderStatusId = ? ";
        }
```
*   Đây là **SQL động (Dynamic SQL)**.
*   Nếu biến `statusId` khác null (tức là người dùng đang chọn bộ lọc), ta nối thêm chuỗi `WHERE` vào câu lệnh SQL.

```java
            while (rs.next()) {
                Order order = new Order();
                // ... set các cột cơ bản ...
                order.setStatusName(rs.getString("OrderStatusName")); 
                list.add(order);
            }
```
*   `rs.getString("OrderStatusName")`: Lấy giá trị của cột bí danh ta vừa tạo ở trên.
*   `order.setStatusName(...)`: Gán vào thuộc tính `statusName` (thuộc tính này trong class `Order` thường không map với DB, mà chỉ dùng để hiển thị).

### 4.2. File: `admin/quanlydonhang/index.jsp`

**Hiển thị Badge trạng thái:**
```jsp
<span class="
    <c:choose>
        <c:when test="${order.orderStatusId == 5}">bg-warning</c:when>
        <c:when test="${order.orderStatusId == 6}">bg-success</c:when>
        <c:when test="${order.orderStatusId == 7}">bg-danger</c:when>
        <c:when test="${order.orderStatusId == 1008}">bg-purple</c:when>
    </c:choose>
">
    ${order.statusName}
</span>
```
*   `<c:choose> / <c:when>`: Cấu trúc Switch-Case của JSTL.
*   Kiểm tra `orderStatusId` để quyết định class CSS (màu sắc) cho thẻ `span`.
    *   5 -> `bg-warning` (Vàng - Chờ).
    *   6 -> `bg-success` (Xanh - Duyệt).
    *   7 -> `bg-danger` (Đỏ - Hủy).
    *   1008 -> `bg-purple` (Tím - Yêu cầu hủy).

---

## 5. MODULE PROFILE (HỒ SƠ CÁ NHÂN)

### 5.1. File: `controller.admin.ProfileServlet.java`

**Hàm xử lý đổi mật khẩu:**
```java
        if ("changePass".equals(action)) {
            String currentPass = request.getParameter("currentPass");
            String newPass = request.getParameter("newPass");
            String confirmPass = request.getParameter("confirmPass");

            if (!admin.getPassword().equals(currentPass)) {
                request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
            } 
```
*   `!admin.getPassword().equals(currentPass)`: So sánh chuỗi mật khẩu người dùng nhập vào (`currentPass`) với mật khẩu đang lưu trong Session (`admin.getPassword()`).

```java
            else if (!newPass.equals(confirmPass)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            } else {
                dao.changePassword(admin.getAccountId(), newPass);
                admin.setPassword(newPass);
                session.setAttribute("admin", admin); 
                request.setAttribute("message", "Đổi mật khẩu thành công!");
            }
        }
```
*   `dao.changePassword(...)`: Gọi DAO update xuống DB.
*   `admin.setPassword(newPass)`: Cập nhật object Java.
*   `session.setAttribute("admin", admin)`: **Cực kỳ quan trọng**. Phải cập nhật lại object `admin` trong Session. Nếu không, lần sau người dùng đăng nhập lại hoặc chuyển trang, Session vẫn giữ mật khẩu cũ -> Gây lỗi logic.

---

## 6. MODULE MENU (QUẢN LÝ MENU)

### 6.1. File: `dal.admin.MenuDAO.java`

**Hàm `getAllMenus`:**
```java
    String sql = "SELECT * FROM tb_Menu ORDER BY Position ASC, MenuId ASC";
```
*   `ORDER BY Position ASC`: Sắp xếp theo vị trí hiển thị (số nhỏ đứng trước).
*   `MenuId ASC`: Nếu cùng vị trí, ai có ID nhỏ hơn (tạo trước) sẽ đứng trước.

### 6.2. File: `admin/quanlymenu/index.jsp`

**Logic hiển thị phân cấp:**
```jsp
        <td>
            <c:if test="${m.levels == 1}">Menu Gốc</c:if>
            <c:if test="${m.levels > 1}">Menu Con (Cấp ${m.levels})</c:if>
        </td>
        <td>
            ${menuMap[m.parentId]} 
        </td>
```
*   `m.levels`: Thuộc tính quy định cấp độ (1 là cha, 2 là con, 3 là cháu).
*   `${menuMap[m.parentId]}`: Sử dụng EL để truy xuất vào Map.
    *   `menuMap`: Là một `HashMap<Integer, String>` được Servlet tạo ra, map từ ID -> Tên Menu.
    *   `m.parentId`: ID của menu cha.
    *   Cú pháp này tương đương `menuMap.get(m.getParentId())` trong Java. Nó giúp hiển thị tên menu cha mà không cần query lại DB.

```