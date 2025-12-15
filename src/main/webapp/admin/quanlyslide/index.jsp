<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en" class="dark" data-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Banner (Slide)</title>
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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Quản Lý Banner</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="${pageContext.request.contextPath}/admin" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Trang Chủ
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Banner</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12">
                <div class="col-span-12">
                    <div class="card border-0 overflow-hidden">
                        <div class="card-header flex items-center justify-between">
                            <h6 class="card-title mb-0 text-lg">Danh Sách Banner</h6>
                            <a href="${pageContext.request.contextPath}/admin/quanlyslide?action=add" class="btn btn-primary-600 flex items-center gap-2">
                                <iconify-icon icon="mingcute:add-line" class="text-xl"></iconify-icon> Thêm Mới
                            </a>
                        </div>
                        <div class="card-body">
                            <table id="slide-table" class="table border border-neutral-200 dark:border-neutral-600 rounded-lg border-separate">
                                <thead>
                                    <tr>
                                        <th scope="col" class="text-neutral-800 dark:text-white">ID</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Hình Ảnh</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Tiêu Đề</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Alias</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Trạng Thái</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${slides}" var="s">
                                        <tr>
                                            <td>${s.slideID}</td>
                                            <td>
                                                <div class="w-32 h-16 rounded overflow-hidden">
                                                    <img src="${pageContext.request.contextPath}/assets/images/${s.image}" 
                                                         alt="${s.title}" 
                                                         class="w-full h-full object-cover"
                                                         onerror="this.src='https://placehold.co/400x200?text=No+Image'">
                                                </div>
                                            </td>
                                            <td>${s.title}</td>
                                            <td>${s.alias}</td>
                                            <td>
                                                <span class="${s.active ? 'bg-success-100 text-success-600 dark:bg-success-600/25 dark:text-success-400' : 'bg-danger-100 text-danger-600 dark:bg-danger-600/25 dark:text-danger-400'} px-4 py-1 rounded-full font-medium text-xs">
                                                    ${s.active ? 'Hoạt động' : 'Tạm ẩn'}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="flex items-center justify-center gap-2">
                                                    <a href="${pageContext.request.contextPath}/admin/quanlyslide?action=edit&id=${s.slideID}" class="w-8 h-8 bg-primary-100 dark:bg-primary-600/25 text-primary-600 dark:text-primary-400 rounded-full inline-flex items-center justify-center">
                                                        <iconify-icon icon="solar:pen-bold"></iconify-icon>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/admin/quanlyslide?action=delete&id=${s.slideID}" 
                                                       class="w-8 h-8 bg-danger-100 dark:bg-danger-600/25 text-danger-600 dark:text-danger-400 rounded-full inline-flex items-center justify-center"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa banner này?');">
                                                        <iconify-icon icon="solar:trash-bin-trash-bold"></iconify-icon>
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
        const tableEl = document.querySelector('#slide-table');
        if (tableEl) {
            let table = new simpleDatatables.DataTable('#slide-table', {
                labels: {
                    placeholder: "Tìm kiếm...",
                    perPage: "Hiển thị mục",
                    noRows: "Không tìm thấy dữ liệu",
                    info: "Hiển thị {start} đến {end} của {rows} mục",
                },
                perPage: 10
            });
        }
    </script>

</body>
</html>
