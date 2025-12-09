<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %> 

<!DOCTYPE html>
<html lang="en" class="dark" data-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Tour Du Lịch</title>
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

    <!-- ..::  Sidebar Start ::.. -->
    <aside class="sidebar">
        <button type="button" class="sidebar-close-btn !mt-4">
            <iconify-icon icon="radix-icons:cross-2"></iconify-icon>
        </button>
        <div>
            <a href="${pageContext.request.contextPath}/admin/quanlytour" class="sidebar-logo">
                <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="site logo" class="light-logo">
                <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" alt="site logo" class="dark-logo">
                <img src="${pageContext.request.contextPath}/assets/images/logo-icon.png" alt="site logo" class="logo-icon">
            </a>
        </div>
        <div class="sidebar-menu-area">
            <ul class="sidebar-menu" id="sidebar-menu">
                <li>
                    <a href="${pageContext.request.contextPath}/admin">
                        <iconify-icon icon="solar:home-smile-angle-outline" class="menu-icon"></iconify-icon>
                        <span>Trang Chủ</span>
                    </a>
                </li>
                
                <li class="sidebar-menu-group-title">Quản Lý</li>
                
                <li>
                    <a href="${pageContext.request.contextPath}/admin/quanlytour" class="active">
                        <iconify-icon icon="mingcute:storage-line" class="menu-icon"></iconify-icon>
                        <span>Quản Lý Tour</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/quanlyblog">
                        <iconify-icon icon="icon-park-outline:writing-fluently" class="menu-icon"></iconify-icon>
                        <span>Quản Lý Blog</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/quanlylienhe">
                        <iconify-icon icon="fluent:contact-card-20-regular" class="menu-icon"></iconify-icon>
                        <span>Quản Lý Liên Hệ</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/quanlymenu">
                        <iconify-icon icon="mingcute:menu-line" class="menu-icon"></iconify-icon>
                        <span>Quản Lý Menu</span>
                    </a>
                </li>
            </ul>
        </div>
    </aside>
    <!-- ..::  Sidebar End ::.. -->

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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Danh Sách Tour</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="javascript:void(0)" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Trang Chủ
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Quản Lý Tour</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12">
                <div class="col-span-12">
                    <div class="card border-0 overflow-hidden">
                        <div class="card-header flex items-center justify-between">
                            <h6 class="card-title mb-0 text-lg">Dữ Liệu Tour</h6>
                            <a href="${pageContext.request.contextPath}/admin/quanlytour?action=create" class="btn btn-primary-600 hover:bg-primary-700 text-white px-4 py-2 rounded-lg flex items-center gap-2">
                                <iconify-icon icon="mingcute:add-line" class="text-xl"></iconify-icon> Thêm Mới
                            </a>
                        </div>
                        <div class="card-body">
                            <table id="selection-table" class="table border border-neutral-200 dark:border-neutral-600 rounded-lg border-separate">
                                <thead>
                                    <tr>
                                        <th scope="col" class="text-neutral-800 dark:text-white">
                                            <div class="form-check style-check flex items-center">
                                                <input class="form-check-input" id="serial" type="checkbox">
                                                <label class="ms-2 form-check-label" for="serial">ID</label>
                                            </div>
                                        </th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">
                                            <div class="flex items-center gap-2">Tên Tour</div>
                                        </th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">
                                            <div class="flex items-center gap-2">Giá ($)</div>
                                        </th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">
                                            <div class="flex items-center gap-2">Thời Gian</div>
                                        </th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">
                                            <div class="flex items-center gap-2">Địa Điểm</div>
                                        </th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">
                                            <div class="flex items-center gap-2">Trạng Thái</div>
                                        </th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">
                                            <div class="flex items-center gap-2">Hành Động</div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listT}" var="t">
                                        <tr>
                                            <td>
                                                <div class="form-check style-check flex items-center">
                                                    <input class="form-check-input" type="checkbox">
                                                    <label class="ms-2 form-check-label">${t.tourId}</label>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="flex items-center">
                                                    <img src="${pageContext.request.contextPath}/assets/images/products/${t.image}" alt="${t.title}" class="shrink-0 me-3 rounded-lg w-12 h-12 object-cover" onerror="this.src='${pageContext.request.contextPath}/assets/images/logo-icon.png'">
                                                    <h6 class="text-base mb-0 font-medium whitespace-normal" style="max-width: 250px;">${t.title}</h6>
                                                </div>
                                            </td>
                                            <td>$${t.price}</td>
                                            <td>${t.timeTravel} ngày</td>
                                            <td>${t.location}</td>
                                            <td>
                                                    <c:if test="${t.active}">
                                                        <span class="bg-success-100 dark:bg-success-600/25 text-success-600 dark:text-success-400 px-4 py-1 rounded-full font-medium text-sm">Hiện</span>
                                                    </c:if>
                                                    <c:if test="${!t.active}">
                                                        <span class="bg-danger-100 dark:bg-danger-600/25 text-danger-600 dark:text-danger-400 px-4 py-1 rounded-full font-medium text-sm">Ẩn</span>
                                                    </c:if>
                                            </td>
                                            <td>
                                                <div class="flex items-center justify-center gap-2">
                                                    <!-- Nút Toggle Status -->
                                                    <a href="${pageContext.request.contextPath}/admin/quanlytour?action=toggle&id=${t.tourId}" 
                                                       class="w-8 h-8 bg-primary-50 dark:bg-primary-600/10 text-primary-600 dark:text-primary-400 rounded-full inline-flex items-center justify-center"
                                                       title="${t.active ? 'Ẩn tour này' : 'Hiện tour này'}">
                                                        <c:if test="${t.active}">
                                                            <iconify-icon icon="iconamoon:eye-light"></iconify-icon>
                                                        </c:if>
                                                        <c:if test="${!t.active}">
                                                            <iconify-icon icon="iconamoon:eye-off-light"></iconify-icon>
                                                        </c:if>
                                                    </a>
                                                    
                                                    <!-- Nút sửa -->
                                                    <a href="${pageContext.request.contextPath}/admin/quanlytour?action=edit&id=${t.tourId}" class="w-8 h-8 bg-success-100 dark:bg-success-600/25 text-success-600 dark:text-success-400 rounded-full inline-flex items-center justify-center">
                                                        <iconify-icon icon="lucide:edit"></iconify-icon>
                                                    </a>
                                                    
                                                    <!-- Nút xóa -->
                                                    <a href="${pageContext.request.contextPath}/admin/quanlytour?action=delete&id=${t.tourId}" onclick="return confirm('Bạn có chắc muốn xóa tour này không?')" class="w-8 h-8 bg-danger-100 dark:bg-danger-600/25 text-danger-600 dark:text-danger-400 rounded-full inline-flex items-center justify-center">
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