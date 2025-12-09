# Hướng Dẫn Cài Đặt và Chạy Dự Án

Tài liệu này bao gồm các bước cần thiết để cài đặt môi trường và chạy dự án Web Quản Lý Tour Du Lịch trên máy tính cá nhân.

## 1. Yêu Cầu Môi Trường
- **IDE:** Eclipse IDE for Enterprise Java and Web Developers (đã tích hợp Web Tools Platform).
- **Server:** Apache Tomcat (phiên bản 10.0 trở lên).
- **Database:** Microsoft SQL Server (2019 trở lên).
- **Tool Quản lý DB:** SQL Server Management Studio (SSMS).

---

## 2. Cài Đặt Cơ sở dữ liệu (SQL Server)

Đây là quy trình chuẩn để cài đặt và cấu hình CSDL.

### BƯỚC 1: Tạo Database
1. Mở SSMS và kết nối tới SQL Server của bạn.
2. Mở file `sql/QLTour.sql` trong dự án.
3. Bôi đen toàn bộ nội dung file và nhấn **Execute** để tạo database `Travel1` cùng toàn bộ bảng và dữ liệu mẫu.

### BƯỚC 2: Cấu hình Tài khoản & Kết nối Mạng
*Bước này quan trọng để ứng dụng Java có thể kết nối tới SQL Server.*

1. **Mở SQL Server Configuration Manager.**
2. **Bật kết nối TCP/IP:**
   - Tìm đến **SQL Server Network Configuration** -> **Protocols for [Tên Server của bạn]** (ví dụ: SQLEXPRESS).
   - Chuột phải vào **TCP/IP** và chọn **Enable**.
   - Chuột phải vào **TCP/IP** -> **Properties** -> tab **IP Addresses**.
   - Kéo xuống mục **IPAll**, xóa trống ô `TCP Dynamic Ports` và điền `1433` vào ô `TCP Port`.
3. **Bật chế độ xác thực hỗn hợp (Mixed Mode):**
   - Trong SSMS, chuột phải vào tên Server -> **Properties** -> **Security**.
   - Tích chọn **SQL Server and Windows Authentication mode**.
4. **Kích hoạt và đặt mật khẩu cho tài khoản `sa`:**
   - Trong SSMS, vào **Security** -> **Logins**.
   - Chuột phải vào `sa` -> **Properties**.
   - Tại tab **General**, đặt mật khẩu là `123`.
   - Tại tab **Status**, đảm bảo mục *Login* được chọn là **Enabled**.
5. **Khởi động lại SQL Server:**
   - Trong Configuration Manager, vào **SQL Server Services**.
   - Chuột phải vào dịch vụ SQL Server của bạn và chọn **Restart**.

---

## 3. Cài Đặt Dự Án Trên Eclipse

### BƯỚC 1: Import Dự Án
1. Mở Eclipse, vào menu **File** -> **Import...**.
2. Chọn **General** -> **Existing Projects into Workspace**.
3. Tại `Select root directory`, trỏ đến thư mục gốc của dự án (`D:\hai\WebJAVA`).
4. Nhấn **Finish**.

### BƯỚC 2: Cấu Hình Server
1. Mở view **Servers** (`Window` -> `Show View` -> `Servers`).
2. Nếu chưa có server, hãy tạo một server Tomcat mới.
3. Chuột phải vào server Tomcat -> **Add and Remove...**.
4. Chuyển dự án từ cột "Available" sang "Configured".
5. Nhấn **Finish**.

### BƯỚC 3: Chạy Dự Án
- Chuột phải vào project trong Project Explorer -> **Run As** -> **Run on Server**.

---

## 4. ⚠️ LƯU Ý QUAN TRỌNG VỀ MÔI TRƯỜNG PHÁT TRIỂN

Để tính năng **tự động lưu ảnh upload vào thư mục code** (nhằm mục đích đưa lên Git) hoạt động chính xác cho tất cả thành viên, toàn bộ nhóm cần tuân thủ quy tắc sau:

-   **Thư mục gốc của dự án phải được đặt chính xác tại đường dẫn:** `D:\hai\WebJAVA`

Nếu dự án được đặt ở một vị trí khác, chức năng upload ảnh vẫn hiển thị bình thường trên web, nhưng file ảnh sẽ không được tự động sao chép vào thư mục `src` để commit lên Git.
