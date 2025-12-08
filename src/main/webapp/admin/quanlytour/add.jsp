<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %> 

<!DOCTYPE html>
<html lang="en" class="dark" data-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Mới Tour - Quản Lý Tour Du Lịch</title>
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
                    <a href="javascript:void(0)">
                        <iconify-icon icon="solar:home-smile-angle-outline" class="menu-icon"></iconify-icon>
                        <span>Trang Chủ</span>
                    </a>
                </li>
                
                <li class="sidebar-menu-group-title">Quản Lý</li>
                
                <li>
                    <a href="${pageContext.request.contextPath}/admin/quanlytour">
                        <iconify-icon icon="mingcute:storage-line" class="menu-icon"></iconify-icon>
                        <span>Danh Sách Tour</span>
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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Thêm Mới Tour</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="${pageContext.request.contextPath}/admin/quanlytour" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="mingcute:storage-line" class="icon text-lg"></iconify-icon>
                            Danh Sách Tour
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Thêm Mới</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12 gap-5">
                <div class="col-span-12">
                    <div class="card border-0">
                        <div class="card-header">
                            <h5 class="text-lg font-semibold mb-0">Thông Tin Tour Mới</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/quanlytour" method="post">
                                <input type="hidden" name="action" value="insert">
                                
                                <div class="grid grid-cols-12 gap-4">
                                    <!-- Tên Tour -->
                                    <div class="col-span-12">
                                        <label class="form-label">Tên Tour</label>
                                        <input type="text" name="title" class="form-control" placeholder="Nhập tên tour..." required>
                                    </div>
                                    
                                    <!-- Giá và Thời gian -->
                                    <div class="md:col-span-6 col-span-12">
                                        <label class="form-label">Giá ($)</label>
                                        <input type="number" name="price" class="form-control" placeholder="0" required>
                                    </div>
                                    <div class="md:col-span-6 col-span-12">
                                        <label class="form-label">Thời Gian (Ngày)</label>
                                        <input type="number" name="timeTravel" class="form-control" placeholder="Số ngày đi..." required>
                                    </div>
                                    
                                    <!-- Địa điểm -->
                                    <div class="col-span-12">
                                        <label class="form-label">Địa Điểm</label>
                                        <input type="text" name="location" class="form-control" placeholder="Nhập địa điểm..." required>
                                    </div>

                                    <!-- Ảnh -->
                                    <div class="col-span-12">
                                        <label class="form-label">Hình Ảnh (Tên file)</label>
                                        <div class="icon-field">
                                            <span class="icon">
                                                <iconify-icon icon="solar:gallery-wide-linear"></iconify-icon>
                                            </span>
                                            <input type="text" name="image" class="form-control" placeholder="Ví dụ: nhatban.jpg">
                                        </div>
                                        <small class="text-neutral-500">Lưu ý: Chỉ nhập tên file đã có trong thư mục assets/images/products/</small>
                                    </div>
                                    
                                    <!-- Mô tả ngắn -->
                                    <div class="col-span-12">
                                        <label class="form-label">Mô tả ngắn</label>
                                        <textarea name="description" class="form-control" rows="3" placeholder="Mô tả ngắn gọn..."></textarea>
                                    </div>
                                    
                                    <!-- Chi tiết -->
                                    <div class="col-span-12">
                                        <label class="form-label">Chi tiết</label>
                                        <textarea name="detail" class="form-control" rows="5" placeholder="Chi tiết lịch trình..."></textarea>
                                    </div>
                                    
                                    <!-- Trạng thái -->
                                    <div class="col-span-12">
                                        <div class="flex items-center gap-2">
                                            <input class="form-check-input rounded-full" type="checkbox" name="active" value="true" id="activeCheck" checked>
                                            <label class="form-check-label" for="activeCheck">Kích hoạt (Hiển thị ngay)</label>
                                        </div>
                                    </div>
                                    
                                    <!-- Buttons -->
                                    <div class="col-span-12 flex gap-3 mt-4">
                                        <button type="submit" class="btn btn-primary-600">Lưu Tour Mới</button>
                                        <a href="${pageContext.request.contextPath}/admin/quanlytour" class="btn btn-danger-600">Hủy Bỏ</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Content End -->
        
        </div>
        
        <!-- ..::  Footer Start ::.. -->
        <footer class="d-footer">
            <div class="flex items-center justify-between gap-3">
                <p class="mb-0">© 2025. All Rights Reserved.</p>
            </div>
        </footer>
        <!-- ..::  Footer End ::.. -->

    </main>

    <!-- ..::  scripts  start ::.. -->
    <script src="${pageContext.request.contextPath}/assets/js/lib/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/lib/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/flowbite.min.js"></script>
    <!-- main js -->
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    <!-- ..::  scripts  end ::.. -->

</body>

</html>