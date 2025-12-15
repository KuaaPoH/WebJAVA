<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en" class="dark" data-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Khách Hàng</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/favicon.png" sizes="16x16">
    <!-- google fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=re" rel="stylesheet">
    <!-- remix icon font css  -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/remixicon.css">
    <!-- Data Table css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lib/dataTables.min.css">
    <!-- main css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <!-- Iconify Font js -->
    <script src="${pageContext.request.contextPath}/assets/js/lib/iconify-icon.min.js"></script>
</head>

<body class="dark:bg-neutral-800 bg-neutral-100 dark:text-white">

    <%@include file="/admin/components/sidebar.jsp" %>


    <main class="dashboard-main">

        <%@include file="/admin/components/header.jsp" %>

        <div class="dashboard-main-body">
            
            <div class="flex flex-wrap items-center justify-between gap-2 mb-6">
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Danh Sách Khách Hàng</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="${pageContext.request.contextPath}/admin" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Trang Chủ
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Quản Lý Khách Hàng</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12">
                <div class="col-span-12">
                    <div class="card border-0 overflow-hidden">
                        <div class="card-header flex items-center justify-between">
                            <h6 class="card-title mb-0 text-lg">Dữ Liệu Khách Hàng</h6>
                        </div>
                        <div class="card-body">
                            <table id="customer-table" class="table border border-neutral-200 dark:border-neutral-600 rounded-lg border-separate">
                                <thead>
                                    <tr>
                                        <th scope="col" class="text-neutral-800 dark:text-white">ID</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Avatar</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Tên Đăng Nhập</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Email</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">SĐT</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Trạng Thái</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${customers}" var="customer">
                                        <tr>
                                            <td>${customer.customerId}</td>
                                            <td>
                                                <img src="${pageContext.request.contextPath}/assets/images/users/${customer.avatar != null ? customer.avatar : 'default-admin.png'}" 
                                                     alt="avatar" 
                                                     class="w-10 h-10 object-fit-cover rounded-full" 
                                                     onerror="this.src='${pageContext.request.contextPath}/assets/images/user.png'">
                                            </td>
                                            <td>${customer.username}</td>
                                            <td>${customer.email}</td>
                                            <td>${customer.phone != null ? customer.phone : 'N/A'}</td>
                                            <td>
                                                <span class="
                                                    <c:choose>
                                                        <c:when test="${customer.isActive}">bg-success-100 text-success-600 dark:bg-success-600/25 dark:text-success-400</c:when>
                                                        <c:otherwise>bg-danger-100 text-danger-600 dark:bg-danger-600/25 dark:text-danger-400</c:otherwise>
                                                    </c:choose>
                                                    px-4 py-1 rounded-full font-medium text-sm">
                                                    <c:if test="${customer.isActive}">Đang hoạt động</c:if>
                                                    <c:if test="${!customer.isActive}">Đã khóa</c:if>
                                                </span>
                                            </td>
                                            <td>
                                                <div class="flex items-center justify-center gap-2">
                                                    <c:if test="${customer.isActive}">
                                                        <a href="${pageContext.request.contextPath}/admin/customers?action=lock&id=${customer.customerId}" 
                                                           class="w-8 h-8 bg-danger-100 dark:bg-danger-600/25 text-danger-600 dark:text-danger-400 rounded-full inline-flex items-center justify-center" 
                                                           title="Khóa tài khoản"
                                                           onclick="return confirm('Xác nhận khóa tài khoản ${customer.username}?');">
                                                            <iconify-icon icon="solar:lock-bold"></iconify-icon>
                                                        </a>
                                                    </c:if>
                                                    <c:if test="${!customer.isActive}">
                                                        <a href="${pageContext.request.contextPath}/admin/customers?action=unlock&id=${customer.customerId}" 
                                                           class="w-8 h-8 bg-success-100 dark:bg-success-600/25 text-success-600 dark:text-success-400 rounded-full inline-flex items-center justify-center" 
                                                           title="Mở khóa tài khoản"
                                                           onclick="return confirm('Xác nhận mở khóa tài khoản ${customer.username}?');">
                                                            <iconify-icon icon="solar:unlock-bold"></iconify-icon>
                                                        </a>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Content End -->
        
        </div>
        
        <footer class="d-footer">
            <div class="flex items-center justify-between gap-3">
                <p class="mb-0">© 2025. All Rights Reserved.</p>
            </div>
        </footer>

    </main>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/lib/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/lib/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/lib/simple-datatables.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/flowbite.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    
    <script>
        // Khởi tạo DataTable với cấu hình tiếng Việt
        let table = new simpleDatatables.DataTable('#customer-table', {
            labels: {
                placeholder: "Tìm kiếm...",
                perPage: "Hiển thị mục",
                noRows: "Không tìm thấy dữ liệu",
                info: "Hiển thị {start} đến {end} của {rows} mục",
            }
        });
    </script>

</body>
</html>
