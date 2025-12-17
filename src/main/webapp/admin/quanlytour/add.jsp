<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %> 

<!DOCTYPE html>
<html lang="en">

<head>
    <%@include file="/admin/components/theme_loader.jsp" %>
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

    <%@include file="/admin/components/sidebar.jsp" %>


    <main class="dashboard-main">

        <%@include file="/admin/components/header.jsp" %>

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
                            <form action="${pageContext.request.contextPath}/admin/quanlytour" method="post" enctype="multipart/form-data">
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
                                        <label class="form-label">Hình Ảnh</label>
                                        <div class="flex items-center">
                                            <label for="imageFile" class="btn btn-secondary-600 cursor-pointer rounded-r-none flex items-center gap-2">
                                                <iconify-icon icon="solar:upload-outline" class="text-lg"></iconify-icon>
                                                <span>Chọn tệp</span>
                                            </label>
                                            <span id="fileName" class="text-neutral-500 bg-neutral-100 dark:bg-neutral-700 h-11 flex items-center px-4 rounded-r-lg border border-l-0 border-neutral-300 dark:border-neutral-600 max-w-64 overflow-hidden text-ellipsis whitespace-nowrap">Chưa có tệp nào được chọn</span>
                                        </div>
                                        <input type="file" name="imageFile" id="imageFile" class="hidden" accept="image/*">
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
    
    <script>
        document.getElementById('imageFile').addEventListener('change', function() {
            var fileName = this.files[0] ? this.files[0].name : 'Chưa có tệp nào được chọn';
            document.getElementById('fileName').textContent = fileName;
        });
    </script>
    <!-- ..::  scripts  end ::.. -->

</body>

</html>