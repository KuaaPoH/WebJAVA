<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" class="dark" data-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Đơn Hàng</title>
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

        <!-- ..::  Navbar Start ::.. -->
        <div class="navbar-header border-b border-neutral-200 dark:border-neutral-600">
            <div class="flex items-center justify-between">
                <div class="col-auto">
                    <div class="flex flex-wrap items-center gap-[16px]">
                        <button type="button" class="sidebar-toggle">
                            <iconify-icon icon="heroicons:bars-3-solid" class="icon non-active"></iconify-icon>
                            <iconify-icon icon="iconoir:arrow-right" class="icon active"></iconify-icon>
                        </button>
                    </div>
                </div>
                <div class="col-auto">
                    <div class="flex flex-wrap items-center gap-3">
                        <button type="button" id="theme-toggle" class="w-10 h-10 bg-neutral-200 dark:bg-neutral-700 dark:text-white rounded-full flex justify-center items-center">
                            <span id="theme-toggle-dark-icon" class="hidden">
                                <i class="ri-sun-line"></i>
                            </span>
                            <span id="theme-toggle-light-icon" class="hidden">
                                <i class="ri-moon-line"></i>
                            </span>
                        </button>
                        
                        <button data-dropdown-toggle="dropdownProfile" class="flex justify-center items-center rounded-full" type="button">
                            <img src="${pageContext.request.contextPath}/assets/images/user.png" alt="image" class="w-10 h-10 object-fit-cover rounded-full">
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- ..::  Navbar End ::.. -->

        <div class="dashboard-main-body">
            
            <div class="flex flex-wrap items-center justify-between gap-2 mb-6">
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Danh Sách Đơn Hàng</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="javascript:void(0)" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Trang Chủ
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Quản Lý Đơn Hàng</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12">
                <div class="col-span-12">
                    <div class="card border-0 overflow-hidden">
                        <div class="card-header flex items-center justify-between">
                            <h6 class="card-title mb-0 text-lg">Dữ Liệu Đơn Hàng</h6>
                            <!-- <a href="${pageContext.request.contextPath}/admin/orders?action=create" class="btn btn-primary-600 hover:bg-primary-700 text-white px-4 py-2 rounded-lg flex items-center gap-2">
                                <iconify-icon icon="mingcute:add-line" class="text-xl"></iconify-icon> Thêm Mới
                            </a> -->
                        </div>
                        <div class="card-body">
                            <table id="selection-table" class="table border border-neutral-200 dark:border-neutral-600 rounded-lg border-separate">
                                <thead>
                                    <tr>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Mã Đơn</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Khách Hàng</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Tổng Tiền</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Số Lượng Khách</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Ngày Đặt</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Trạng Thái</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orders}" var="order">
                                        <tr>
                                            <td>${order.code}</td>
                                            <td>
                                                <h6 class="text-base mb-0 font-medium whitespace-normal">${order.customerName}</h6>
                                                <small>${order.email}</small>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>₫
                                            </td>
                                            <td>${order.quanlity}</td>
                                            <td><fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                            <td>
                                                <span class="
                                                    <c:choose>
                                                        <c:when test="${order.statusName == 'Pending'}">bg-warning-100 text-warning-600 dark:bg-warning-600/25 dark:text-warning-400</c:when>
                                                        <c:when test="${order.statusName == 'Confirmed'}">bg-success-100 text-success-600 dark:bg-success-600/25 dark:text-success-400</c:when>
                                                        <c:when test="${order.statusName == 'Cancelled'}">bg-danger-100 text-danger-600 dark:bg-danger-600/25 dark:text-danger-400</c:when>
                                                        <c:otherwise>bg-neutral-100 text-neutral-600 dark:bg-neutral-600/25 dark:text-neutral-400</c:otherwise>
                                                    </c:choose>
                                                    px-4 py-1 rounded-full font-medium text-sm">
                                                    ${order.statusName}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="flex items-center justify-center gap-2">
                                                    <!-- View Details Button -->
                                                    <a href="${pageContext.request.contextPath}/admin/orders?action=view&id=${order.orderId}" class="w-8 h-8 bg-primary-50 dark:bg-primary-600/10 text-primary-600 dark:text-primary-400 rounded-full inline-flex items-center justify-center" title="Xem chi tiết">
                                                        <iconify-icon icon="solar:eye-bold"></iconify-icon>
                                                    </a>
                                                    
                                                    <!-- Edit Button (nếu muốn chỉnh sửa trực tiếp trên list) -->
                                                    <%-- <a href="${pageContext.request.contextPath}/admin/orders?action=edit&id=${order.orderId}" class="w-8 h-8 bg-success-100 dark:bg-success-600/25 text-success-600 dark:text-success-400 rounded-full inline-flex items-center justify-center">
                                                        <iconify-icon icon="lucide:edit"></iconify-icon>
                                                    </a> --%>
                                                    
                                                    <!-- Delete Button (cần cân nhắc vì chỉ nên hủy chứ không xóa) -->
                                                    <%-- <a href="${pageContext.request.contextPath}/admin/orders?action=delete&id=${order.orderId}" onclick="return confirm('Bạn có chắc muốn xóa đơn hàng này không?')" class="w-8 h-8 bg-danger-100 dark:bg-danger-600/25 text-danger-600 dark:text-danger-400 rounded-full inline-flex items-center justify-center">
                                                        <iconify-icon icon="mingcute:delete-2-line"></iconify-icon>
                                                    </a> --%>
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
        let table = new simpleDatatables.DataTable('#selection-table', {
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
