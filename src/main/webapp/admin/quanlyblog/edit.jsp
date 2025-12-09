<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %> 

<!DOCTYPE html>
<html lang="en" class="dark" data-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Bài Viết - Quản Lý Blog</title>
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
                <li class="active">
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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Chỉnh Sửa Bài Viết</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="${pageContext.request.contextPath}/admin/quanlyblog" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="icon-park-outline:writing-fluently" class="icon text-lg"></iconify-icon>
                            Danh Sách Blog
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Sửa: ${blog.title}</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12 gap-5">
                <div class="col-span-12">
                    <div class="card border-0">
                        <div class="card-header">
                            <h5 class="text-lg font-semibold mb-0">Cập nhật thông tin bài viết</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/quanlyblog" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="id" value="${blog.blogId}">
                                <input type="hidden" name="currentImage" value="${blog.image}">
                                
                                <div class="grid grid-cols-12 gap-4">
                                    <!-- Tiêu đề -->
                                    <div class="col-span-12">
                                        <label class="form-label">Tiêu Đề</label>
                                        <input type="text" name="title" class="form-control" value="${blog.title}" required>
                                    </div>

                                    <!-- Ảnh -->
                                    <div class="col-span-12">
                                        <label class="form-label">Tải Lên Ảnh Mới (Tùy chọn)</label>
                                        <div class="flex items-center">
                                            <label for="imageFile" class="btn btn-secondary-600 cursor-pointer rounded-r-none flex items-center gap-2">
                                                <iconify-icon icon="solar:upload-outline" class="text-lg"></iconify-icon>
                                                <span>Chọn tệp</span>
                                            </label>
                                            <span id="fileName" class="text-neutral-500 bg-neutral-100 dark:bg-neutral-700 h-11 flex items-center px-4 rounded-r-lg border border-l-0 border-neutral-300 dark:border-neutral-600 max-w-64 overflow-hidden text-ellipsis whitespace-nowrap">Chưa có tệp nào được chọn</span>
                                        </div>
                                        <input type="file" name="imageFile" id="imageFile" class="hidden" accept="image/*">
                                        
                                         <div class="mt-2">
                                            <span class="text-sm text-neutral-500">Ảnh hiện tại:</span>
                                            <c:if test="${not empty blog.image}">
                                                <img src="${pageContext.request.contextPath}/assets/images/blogs/${blog.image}" alt="Current Image" class="w-20 h-20 object-cover rounded-lg border mt-1">
                                            </c:if>
                                            <c:if test="${empty blog.image}">
                                                <span class="text-sm text-neutral-500 italic">Chưa có ảnh</span>
                                            </c:if>
                                        </div>
                                    </div>
                                    
                                    <!-- Mô tả ngắn -->
                                    <div class="col-span-12">
                                        <label class="form-label">Mô tả ngắn</label>
                                        <textarea name="description" class="form-control" rows="3">${blog.description}</textarea>
                                    </div>
                                    
                                    <!-- Nội dung chi tiết -->
                                    <div class="col-span-12">
                                        <label class="form-label">Nội dung chi tiết</label>
                                        <textarea name="detail" class="form-control" rows="8">${blog.detail}</textarea>
                                    </div>
                                    
                                    <!-- Trạng thái -->
                                    <div class="col-span-12">
                                        <div class="flex items-center gap-2">
                                            <input class="form-check-input rounded-full" type="checkbox" name="active" value="on" id="activeCheck" ${blog.active ? 'checked' : ''}>
                                            <label class="form-check-label" for="activeCheck">Kích hoạt (Hiển thị)</label>
                                        </div>
                                    </div>
                                    
                                    <!-- Buttons -->
                                    <div class="col-span-12 flex gap-3 mt-4">
                                        <button type="submit" class="btn btn-primary-600">Lưu Thay Đổi</button>
                                        <a href="${pageContext.request.contextPath}/admin/quanlyblog" class="btn btn-danger-600">Hủy Bỏ</a>
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
    
    <script>
        document.getElementById('imageFile').addEventListener('change', function() {
            var fileName = this.files[0] ? this.files[0].name : 'Chưa có tệp nào được chọn';
            document.getElementById('fileName').textContent = fileName;
        });
    </script>

</body>

</html>
