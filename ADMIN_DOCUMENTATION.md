# TÀI LIỆU KỸ THUẬT CHI TIẾT HỆ THỐNG QUẢN TRỊ (DEEP DIVE)

Tài liệu này cung cấp giải thích chi tiết **từng dòng lệnh (Line-by-Line)** cho các module quan trọng nhất trong hệ thống Admin. Mục tiêu giúp lập trình viên hiểu sâu về logic xử lý, luồng dữ liệu và các kỹ thuật Java Web (Servlet/JSP/JDBC) được sử dụng.

---

## 1. MODULE BẢO MẬT & PHÂN QUYỀN (`AdminFilter`)

File: `src/main/java/controller/filter/AdminFilter.java`

Đây là "cánh cổng" đầu tiên mà mọi request vào `/admin/*` đều phải đi qua.

```java
@WebFilter(filterName = "AdminFilter", urlPatterns = {"/admin/*"}) 
// @WebFilter: Annotation khai báo Filter.
// urlPatterns = {"/admin/*"}: Mọi URL bắt đầu bằng /admin/ đều bị Filter này chặn lại xử lý trước.

public class AdminFilter implements Filter { 
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException { 
        
        // 1. Ép kiểu request/response về dạng HTTP để dùng các phương thức của Web (session, redirect)
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // 2. Lấy Session hiện tại.
        // getSession(false): Nếu chưa có session thì trả về null (không tạo mới).
        // Dùng false để tối ưu hiệu năng và kiểm tra chính xác trạng thái đăng nhập.
        HttpSession session = httpRequest.getSession(false);

        // 3. Kiểm tra logic đăng nhập
        // Điều kiện: Session phải tồn tại (khác null) VÀ attribute "admin" phải có dữ liệu.
        // Attribute "admin" được set tại LoginServlet khi đăng nhập thành công.
        boolean isLoggedIn = (session != null && session.getAttribute("admin") != null);

        if (isLoggedIn) { 
            // 4. Kiểm tra phân quyền (Authorization)
            Account adminAccount = (Account) session.getAttribute("admin");
            
            // Giả định: RoleId = 1 là Admin, RoleId = 2 là Staff.
            if (adminAccount.getRoleId() == 1 || adminAccount.getRoleId() == 2) { 
                 // Hợp lệ: Cho phép request đi tiếp đến Servlet đích (chain.doFilter)
                 chain.doFilter(request, response);
            } else { 
                 // Đã đăng nhập nhưng không phải Admin (ví dụ User thường mò vào link admin)
                 // Redirect về trang Login kèm thông báo lỗi
                 httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=unauthorized");
            }
        } else { 
            // 5. Chưa đăng nhập
            // Redirect ngay lập tức về trang Login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
        }
    }
}
```

---

## 2. MODULE QUẢN LÝ TOUR (Sản phẩm & Upload Ảnh)

### 2.1. Lớp DAO (`dal.admin.TourDAO.java`)

Chịu trách nhiệm tương tác trực tiếp với Database.

**Hàm `getAllTours()` - Lấy danh sách:**

```java
public List<Tour> getAllTours() { 
    List<Tour> list = new ArrayList<>(); // Khởi tạo list rỗng để chứa kết quả
    String sql = "SELECT * FROM tb_Tour"; // Query đơn giản lấy toàn bộ bảng
    try { 
        // connection: Biến kế thừa từ lớp cha DBContext, đã mở kết nối SQL Server
        PreparedStatement st = connection.prepareStatement(sql);
        
        // Thực thi câu lệnh SQL, trả về ResultSet (bảng kết quả tạm thời)
        ResultSet rs = st.executeQuery();
        
        // rs.next(): Di chuyển con trỏ xuống từng dòng. Trả về false nếu hết dữ liệu.
        while (rs.next()) { 
            Tour t = new Tour(); // Tạo object mới cho mỗi dòng
            
            // Map dữ liệu từ cột SQL sang thuộc tính Java
            // Lưu ý: Tên cột trong getString() phải khớp chính xác với DB
            t.setTourId(rs.getInt("TourId"));
            t.setTitle(rs.getString("Title"));
            // ... (các dòng set khác tương tự)
            t.setImage(rs.getString("Image")); // Chỉ lấy tên file (vd: "abc.jpg"), không lấy đường dẫn full
            
            list.add(t); // Thêm object vào list
        }
    } catch (SQLException e) { 
        System.out.println(e); // In lỗi ra console nếu SQL sai cú pháp hoặc mất kết nối
    }
    return list; // Trả về danh sách (có thể rỗng nhưng không bao giờ null)
}
```

**Hàm `toggleStatus(int id)` - Kỹ thuật XOR Bitwise:**

```java
public void toggleStatus(int id) { 
    // Logic: Đảo trạng thái Ẩn (0) <-> Hiện (1) mà không cần Select trước.
    // CASE WHEN: Cú pháp chuẩn SQL (If-Else).
    // Nếu đang là 1 thì set thành 0, ngược lại thì set thành 1.
    String sql = "UPDATE [dbo].[tb_Tour] SET [IsActive] = CASE WHEN [IsActive] = 1 THEN 0 ELSE 1 END WHERE TourId = ?";
    
    // Cách tối ưu hơn (nếu DB hỗ trợ toán tử Bitwise ^):
    // String sql = "UPDATE tb_Tour SET IsActive = IsActive ^ 1 WHERE TourId = ?";
    
    try { 
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id); // Gán tham số id vào dấu ? đầu tiên
        st.executeUpdate(); // Dùng executeUpdate cho INSERT/UPDATE/DELETE (trả về số dòng bị ảnh hưởng)
    } catch (SQLException e) { ... }
}
```

### 2.2. Lớp Controller (`controller.admin.TourServlet.java`)

**Cấu hình Upload File (`@MultipartConfig`):**

```java
@WebServlet(name = "TourServlet", urlPatterns = {"/admin/quanlytour"})
@MultipartConfig // [BẮT BUỘC] Annotation này báo cho Container biết Servlet này có xử lý file upload
public class TourServlet extends HttpServlet { ... }
```

**Hàm `insertTour` - Xử lý Upload "Dual Save" (Lưu kép):**

```java
private void insertTour(HttpServletRequest request, HttpServletResponse response) 
        throws IOException, ServletException { 
    
    // 1. Nhận các trường text thông thường
    String title = request.getParameter("title");
    // ...
    boolean isActive = "on".equals(request.getParameter("active")); // Checkbox trả về "on" nếu được tick

    // 2. Xử lý File Ảnh
    Part filePart = request.getPart("imageFile"); // Lấy part file từ form (name="imageFile")
    // Lấy tên file gốc (vd: "mua-thu-ha-noi.jpg")
    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
    
    if (fileName != null && !fileName.isEmpty()) { 
        
        // --- GIAI ĐOẠN 1: Lưu vào thư mục Deploy (Server đang chạy) ---
        // Mục đích: Để ảnh hiển thị NGAY LẬP TỨC trên trình duyệt mà không cần restart server.
        // getRealPath: Trả về đường dẫn vật lý thực tế của folder webapp trên ổ cứng server
        String deployedUploadPath = getServletContext().getRealPath("/assets/images/products");
        Path deployedPath = Paths.get(deployedUploadPath, fileName);
        
        // Tạo thư mục nếu chưa có
        Files.createDirectories(deployedPath.getParent()); 
        // Ghi file từ luồng input (InputStream) ra ổ cứng
        try (InputStream input = filePart.getInputStream()) { 
            Files.copy(input, deployedPath, StandardCopyOption.REPLACE_EXISTING);
        }

        // --- GIAI ĐOẠN 2: Lưu vào thư mục Source Code (Backup) ---
        // Mục đích: Để khi Re-build/Redeploy dự án, ảnh không bị mất (vì folder Deploy sẽ bị xóa sạch khi build lại).
        // Lưu ý: Đường dẫn này HARDCODE theo máy developer, cần sửa khi deploy thật.
        try { 
            String sourceProjectPath = "D:\\hai\\WebJAVA"; // Root dự án
            String sourceUploadPath = Paths.get(sourceProjectPath, "src", "main", "webapp", "assets", "images", "products").toString();
            Path sourcePath = Paths.get(sourceUploadPath, fileName);
            
            Files.createDirectories(sourcePath.getParent());
            // Copy file từ folder Deploy sang folder Source
            Files.copy(deployedPath, sourcePath, StandardCopyOption.REPLACE_EXISTING);
        } catch (Exception e) { ... }
    }

    // 3. Gọi DAO lưu thông tin vào DB
    Tour newTour = new Tour();
    newTour.setImage(fileName); // Chỉ lưu tên file vào DB
    // ... set các thuộc tính khác ...
    
    dao.insert(newTour);
    
    // 4. Redirect về trang danh sách (PRG Pattern: Post-Redirect-Get)
    // Để tránh việc người dùng F5 làm gửi lại form (Duplicate submission)
    response.sendRedirect(request.getContextPath() + "/admin/quanlytour");
}
```

---

## 3. MODULE QUẢN LÝ ĐƠN HÀNG (Logic Phức tạp & JOIN)

### 3.1. Lớp DAO (`dal.admin.OrderDAO.java`)

**Hàm `getAllOrders` - Kỹ thuật SQL JOIN:**

```java
public List<Order> getAllOrders(Integer statusId) { 
    // Câu lệnh SQL nối 2 bảng: tb_Order và tb_OrderStatus
    // Mục đích: Lấy ra tên trạng thái (Name) thay vì chỉ lấy ID vô nghĩa.
    String sql = "SELECT o.*, os.Name AS OrderStatusName " + 
                 "FROM tb_Order o " + 
                 "JOIN tb_OrderStatus os ON o.OrderStatusId = os.OrderStatusId ";
    
    // Dynamic Query: Chỉ thêm điều kiện WHERE nếu người dùng có chọn filter
    if (statusId != null) { 
        sql += "WHERE o.OrderStatusId = ? ";
    }
    
    sql += "ORDER BY o.CreatedDate DESC"; // Sắp xếp mới nhất lên đầu
    
    // ... Thực thi query ...
    
    while (rs.next()) { 
        Order order = new Order();
        // Map các cột cơ bản
        order.setOrderId(rs.getInt("OrderId"));
        
        // Map cột từ bảng JOIN (Quan trọng)
        // OrderStatusName là cột ảo được tạo ra từ "os.Name AS ..." trong câu SQL
        order.setStatusName(rs.getString("OrderStatusName")); 
        
        list.add(order);
    }
    return list;
}
```

**Hàm `getOrderById` - Lấy Master-Detail:**
Logic ở đây phức tạp hơn vì cần lấy 1 Đơn hàng (Master) và danh sách các Chi tiết đơn hàng (Detail/Items).

```java
public Order getOrderById(int orderId) { 
    // 1. Query lấy thông tin Đơn hàng (Master)
    String sqlOrder = "SELECT ... FROM tb_Order ... WHERE OrderId = ?";
    
    // 2. Query lấy thông tin Chi tiết (Detail) + Thông tin Tour (Product)
    // Cần JOIN với tb_Tour để lấy Tên Tour và Ảnh Tour
    String sqlOrderDetail = "SELECT od.*, t.Title AS TourTitle, t.Image AS TourImage " + 
                            "FROM tb_OrderDetail od " + 
                            "JOIN tb_Tour t ON od.TourId = t.TourId " + 
                            "WHERE od.OrderId = ?";
                            
    // ... Thực thi sqlOrder trước ...
    if (rsOrder.next()) { 
        // Map thông tin Master
        order = new Order();
        // ...
        
        // ... Thực thi sqlOrderDetail ...
        List<OrderDetail> details = new ArrayList<>();
        while (rsDetail.next()) { 
            OrderDetail od = new OrderDetail();
            // Map thông tin Detail
            od.setTourName(rsDetail.getString("TourTitle")); // Lấy tên tour từ bảng Tour
            details.add(od);
        }
        
        // Gán list Detail vào object Master
        order.setOrderDetails(details);
    }
    return order;
}
```

### 3.2. Lớp Servlet (`controller.admin.OrderServlet.java`)

**Xử lý Filter và Action:**

```java
protected void doGet(...) { 
    String action = request.getParameter("action");
    
    // Case 1: Liệt kê danh sách (mặc định)
    if (action == null || action.equals("list")) { 
        // Lấy tham số status từ URL (vd: orders?status=5)
        String statusStr = request.getParameter("status");
        Integer statusId = null;
        
        // Parse String sang Integer an toàn
        if (statusStr != null && !statusStr.isEmpty()) { 
            try { 
                statusId = Integer.parseInt(statusStr);
            } catch (NumberFormatException e) {} 
        }

        // Gọi DAO
        List<Order> orders = orderDAO.getAllOrders(statusId);
        
        // Đẩy dữ liệu sang JSP
        request.setAttribute("orders", orders);
        request.setAttribute("currentStatus", statusId); // Để JSP biết đang filter theo cái gì mà highlight nút
        
        // Forward sang trang giao diện
        request.getRequestDispatcher("/admin/quanlydonhang/index.jsp").forward(request, response);
    } 
    
    // Case 2: Cập nhật trạng thái nhanh
    else if (action.equals("updateStatus")) { 
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int statusId = Integer.parseInt(request.getParameter("statusId"));
        
        // Gọi DAO update
        orderDAO.updateOrderStatus(orderId, statusId);
        
        // Redirect thông minh:
        // Nếu đang ở trang list -> Quay lại list
        // Nếu đang xem chi tiết -> Quay lại chi tiết
        String from = request.getParameter("from");
        if ("list".equals(from)) { 
            response.sendRedirect("orders?action=list");
        } else { 
            response.sendRedirect("orders?action=view&id=" + orderId);
        }
    }
}
```