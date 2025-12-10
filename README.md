# Hướng Dẫn Cài Đặt và Chạy Dự Án

Tài liệu này bao gồm các bước cần thiết để cài đặt môi trường và chạy dự án Web Quản Lý Tour Du Lịch trên máy tính cá nhân.

## 1. Yêu Cầu Môi Trường
- **IDE:** Eclipse IDE for Enterprise Java and Web Developers (đã tích hợp Web Tools Platform).
- **Server:** Apache Tomcat (phiên bản 10.0 trở lên).
- **Database:** Microsoft SQL Server (2019 trở lên).
- **Tool Quản lý DB:** SQL Server Management Studio (SSMS).
- **Hệ thống quản lý phiên bản:** Git.

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

---

## 5. 🛠️ Quy trình làm việc với Git (Dành cho Đồng Đội)

Dự án này sử dụng hai script tiện ích (`.cmd`) để tự động hóa một số tác vụ Git quan trọng, giúp đồng bộ hóa mã nguồn và tuân thủ quy trình làm việc.

### 5.1. `check_version.cmd` - Kiểm tra và Đồng bộ phiên bản

**Mục đích:** Đảm bảo bạn luôn làm việc trên phiên bản mã nguồn mới nhất từ GitHub. Script này sẽ kiểm tra xem code của bạn có đang bị cũ hơn so với nhánh `main` trên remote (origin) hay không, và đề xuất cập nhật.

**Cách hoạt động:**
1.  **Kiểm tra môi trường:** Đảm bảo Git đã được cài đặt và thư mục hiện tại là một Git repository.
2.  **Chuyển nhánh:** Tự động chuyển về nhánh `main` (nếu có).
3.  **Kiểm tra cập nhật:** `git fetch origin` để lấy thông tin commit mới nhất từ remote nhưng chưa merge.
4.  **So sánh:** So sánh commit hiện tại của nhánh `main` local với commit mới nhất của `origin/main`.
5.  **Đề xuất cập nhật:**
    *   Nếu code của bạn đã mới nhất: Hiển thị thông báo "Bạn đang dùng phiên bản mới nhất".
    *   Nếu code của bạn cũ hơn: Hiển thị cảnh báo và hỏi bạn có muốn cập nhật hay không.
6.  **Cập nhật (nếu đồng ý):** Nếu bạn chọn "Y" (Yes), script sẽ thực hiện `git pull --ff-only origin main`.
    *   Nếu pull thành công: Code của bạn sẽ được đồng bộ.
    *   Nếu pull thất bại (ví dụ: có thay đổi chưa commit hoặc xung đột): Script sẽ báo lỗi và gợi ý cách giải quyết (sử dụng `git stash` hoặc giải quyết xung đột thủ công).

**Khi nào sử dụng:** Nên chạy `check_version.cmd` **mỗi khi bạn bắt đầu làm việc** hoặc **trước khi bạn push code lên GitHub** để đảm bảo bạn đang làm việc trên nền tảng mới nhất.

### 5.2. `feature_flow.cmd` - Quy trình làm việc trên nhánh tính năng

**Mục đích:** Tự động hóa các bước `git add`, `git commit`, `git push` và đảm bảo bạn làm việc trên một nhánh tính năng riêng biệt, không push trực tiếp vào `main`/`master`. Sau khi push, nó sẽ tự động mở trang tạo Pull Request trên GitHub.

**Cách hoạt động:**
1.  **Kiểm tra môi trường:** Đảm bảo Git đã được cài đặt và thư mục hiện tại là một Git repository.
2.  **Kiểm tra nhánh hiện tại:**
    *   Nếu bạn đang ở nhánh `main` hoặc `master`: Script sẽ yêu cầu bạn nhập tên một nhánh tính năng mới (ví dụ: `feature-login`, `bugfix-navbar`). Nếu nhánh này chưa tồn tại, script sẽ tự động tạo và chuyển sang nhánh đó. Nếu đã tồn tại, nó sẽ chuyển sang nhánh đó.
    *   Nếu bạn đã ở một nhánh khác `main`/`master`: Script sẽ tiếp tục làm việc trên nhánh đó.
3.  **Nhập thông điệp Commit:** Yêu cầu bạn nhập một thông điệp commit rõ ràng.
4.  **Thêm và Commit:** Thực hiện `git add .` (thêm tất cả thay đổi) và `git commit -m "[Thông điệp của bạn]"`.
5.  **Push lên GitHub:** Thực hiện `git push` lên nhánh tương ứng trên remote. Script sẽ tự động thiết lập `upstream` nếu đây là lần push đầu tiên của nhánh đó.
6.  **Mở trang tạo Pull Request:** Sau khi push thành công, script sẽ tự động mở trình duyệt đến trang tạo Pull Request trên GitHub, giúp bạn dễ dàng yêu cầu đồng đội review code của mình.

**Khi nào sử dụng:** Chạy `feature_flow.cmd` **mỗi khi bạn hoàn thành một phần công việc** trên nhánh tính năng của mình và muốn đẩy code lên GitHub.

---