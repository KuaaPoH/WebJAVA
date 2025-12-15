<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %> 

<!DOCTYPE html>
<html lang="en" class="dark" data-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Menu</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/favicon.png" sizes="16x16">
    
    <!-- google fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap" rel="stylesheet">
    <!-- remix icon font css  -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/remixicon.css">
    <!-- Iconify Font js -->
    <script src="${pageContext.request.contextPath}/assets/js/lib/iconify-icon.min.js"></script>
    <!-- main css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
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
                    <a href="${pageContext.request.contextPath}/admin/quanlytour">
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
                <li class="active">
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

                <%@include file="/admin/components/header.jsp" %>

        <div class="dashboard-main-body">
            
            <div class="flex flex-wrap items-center justify-between gap-2 mb-6">
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Chỉnh Sửa Menu</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="${pageContext.request.contextPath}/admin/quanlymenu" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                           <iconify-icon icon="material-symbols:menu-outline" class="icon text-lg"></iconify-icon>
                            Danh Sách Menu
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Sửa: ${menu.title}</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12 gap-5">
                <div class="col-span-12">
                    <div class="card border-0">
                        <div class="card-header">
                            <h5 class="text-lg font-semibold mb-0">Cập nhật thông tin Menu</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/quanlymenu" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${menu.menuId}">
                                
                                <div class="grid grid-cols-12 gap-4">
                                    <div class="col-span-12 md:col-span-6">
                                        <label class="form-label">Tiêu Đề</label>
                                        <input type="text" name="title" class="form-control" value="${menu.title}" required>
                                    </div>
                                    <div class="col-span-12 md:col-span-6">
                                        <label class="form-label">Alias</label>
                                        <input type="text" name="alias" class="form-control" value="${menu.alias}" required>
                                    </div>

                                    <div class="col-span-12 md:col-span-4">
                                        <label class="form-label">Vị Trí</label>
                                        <input type="number" name="position" class="form-control" value="${menu.position}" required>
                                    </div>
                                    <div class="col-span-12 md:col-span-4">
                                        <label class="form-label">Cấp</label>
                                        <input type="number" name="levels" class="form-control" value="${menu.levels}" required>
                                    </div>
                                    <div class="col-span-12 md:col-span-4">
                                        <label class="form-label">Menu Cha</label>
                                        <select name="parentId" class="form-control dark:bg-neutral-700 dark:text-white">
                                            <option value="0">-- Không có (Là menu gốc) --</option>
                                            <c:forEach items="${allMenus}" var="m">
                                                <c:if test="${m.menuId != menu.menuId}">
                                                    <option value="${m.menuId}" ${m.menuId == menu.parentId ? 'selected' : ''}>${m.title}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="col-span-12">
                                        <div class="flex items-center gap-2">
                                            <input class="form-check-input rounded-full" type="checkbox" name="active" value="on" id="activeCheck" ${menu.active ? 'checked' : ''}>
                                            <label class="form-check-label" for="activeCheck">Kích hoạt (Hiển thị ngay)</label>
                                        </div>
                                    </div>
                                    
                                    <div class="col-span-12 flex gap-3 mt-4">
                                        <button type="submit" class="btn btn-primary-600">Lưu Thay Đổi</button>
                                        <a href="${pageContext.request.contextPath}/admin/quanlymenu" class="btn btn-danger-600">Hủy Bỏ</a>
                                    </div>
                                </div>
                            </form>
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
    <script src="${pageContext.request.contextPath}/assets/js/flowbite.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>

</body>

</html>
