<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en" >

<head>
    <%@include file="/admin/components/theme_loader.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Liên Hệ</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/favicon.png" sizes="16x16">
    <!-- google fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap" rel="stylesheet">
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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Hòm Thư Liên Hệ</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="javascript:void(0)" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Trang Chủ
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Quản Lý Liên Hệ</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12">
                <div class="col-span-12">
                    <div class="card border-0 overflow-hidden">
                        <div class="card-header">
                            <h6 class="card-title mb-0 text-lg">Danh Sách Tin Nhắn</h6>
                        </div>
                        <div class="card-body">
                            <table id="selection-table" class="table border border-neutral-200 dark:border-neutral-600 rounded-lg border-separate">
                                <thead>
                                    <tr>
                                        <th scope="col" class="text-neutral-800 dark:text-white">ID</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Người Gửi</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Email</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Ngày Gửi</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Trạng Thái</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listC}" var="c">
                                        <tr class="${c.isRead == 0 ? 'font-bold' : 'font-normal'}">
                                            <td>${c.contactId}</td>
                                            <td>${c.name}</td>
                                            <td>${c.email}</td>
                                            <td>
                                                <fmt:formatDate value="${c.createdDate}" pattern="HH:mm dd/MM/yyyy" />
                                            </td>
                                            <td>
                                                <c:if test="${c.isRead == 1}">
                                                    <span class="bg-neutral-100 dark:bg-neutral-600/25 text-neutral-600 dark:text-neutral-400 px-4 py-1 rounded-full font-medium text-sm">Đã đọc</span>
                                                </c:if>
                                                <c:if test="${c.isRead == 0}">
                                                    <span class="bg-success-100 dark:bg-success-600/25 text-success-600 dark:text-success-400 px-4 py-1 rounded-full font-medium text-sm">Mới</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <div class="flex items-center justify-center gap-2">
                                                    <!-- View Button -->
                                                    <a href="${pageContext.request.contextPath}/admin/quanlylienhe?action=view&id=${c.contactId}" class="w-8 h-8 bg-primary-50 dark:bg-primary-600/10 text-primary-600 dark:text-primary-400 rounded-full inline-flex items-center justify-center" title="Xem chi tiết">
                                                        <iconify-icon icon="iconamoon:eye-light"></iconify-icon>
                                                    </a>
                                                    
                                                    <!-- Delete Button -->
                                                    <a href="${pageContext.request.contextPath}/admin/quanlylienhe?action=delete&id=${c.contactId}" onclick="return confirm('Bạn có chắc muốn xóa tin nhắn này không?')" class="w-8 h-8 bg-danger-100 dark:bg-danger-600/25 text-danger-600 dark:text-danger-400 rounded-full inline-flex items-center justify-center">
                                                        <iconify-icon icon="mingcute:delete-2-line"></iconify-icon>
                                                    </a>
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
        let table = new simpleDatatables.DataTable('#selection-table', {
            labels: {
                placeholder: "Tìm kiếm...",
                perPage: "Hiển thị mục",
                noRows: "Không có tin nhắn nào",
                info: "Hiển thị {start} đến {end} của {rows} mục",
            }
        });
    </script>

</body>
</html>