<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en" class="dark" data-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Bình Luận Blog</title>
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
                        <span class="text-neutral-500 dark:text-neutral-400 font-medium">Xin chào, ${sessionScope.admin.username}!</span>
                        <button type="button" id="theme-toggle" class="w-10 h-10 bg-neutral-200 dark:bg-neutral-700 dark:text-white rounded-full flex justify-center items-center">
                            <span id="theme-toggle-dark-icon" class="hidden">
                                <i class="ri-sun-line"></i>
                            </span>
                            <span id="theme-toggle-light-icon" class="hidden">
                                <i class="ri-moon-line"></i>
                            </span>
                        </button>
                        
                        <button data-dropdown-toggle="dropdownProfile" data-dropdown-placement="bottom-end" class="flex justify-center items-center rounded-full" type="button">
                            <img src="${pageContext.request.contextPath}/assets/images/users/${sessionScope.admin.image != null ? sessionScope.admin.image : 'default-admin.png'}" alt="admin avatar" class="w-10 h-10 object-fit-cover rounded-full" onerror="this.src='${pageContext.request.contextPath}/assets/images/user.png'">
                        </button>
                        <%@include file="/admin/components/profile_dropdown.jsp" %>
                    </div>
                </div>
            </div>
        </div>
        <!-- ..::  Navbar End ::.. -->

        <div class="dashboard-main-body">
            
            <div class="flex flex-wrap items-center justify-between gap-2 mb-6">
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Quản Lý Bình Luận Blog</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="${pageContext.request.contextPath}/admin" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Trang Chủ
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Bình Luận Blog</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12">
                <div class="col-span-12">
                    <div class="card border-0 overflow-hidden">
                        <div class="card-header flex items-center justify-between">
                            <h6 class="card-title mb-0 text-lg">Danh Sách Bình Luận (${blogComments != null ? blogComments.size() : 0})</h6>
                        </div>
                        <div class="card-body">
                            
                            <c:if test="${empty blogComments}">
                                <div class="p-4 text-center text-neutral-500 dark:text-neutral-400">
                                    Không có bình luận blog nào.
                                </div>
                            </c:if>
                            <c:if test="${not empty blogComments}">
                                <div class="table-responsive">
                                    <table id="blog-table" class="table border border-neutral-200 dark:border-neutral-600 rounded-lg border-separate w-full">
                                        <thead>
                                            <tr>
                                                <th scope="col" class="text-neutral-800 dark:text-white">ID</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">Bài Viết</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">Người Dùng</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">Nội Dung</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">Ngày</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">Trạng Thái</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">Hành Động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${blogComments}" var="c">
                                                <tr class="border-b border-neutral-200 dark:border-neutral-700 hover:bg-neutral-100 dark:hover:bg-neutral-700/50">
                                                    <td class="p-3">${c.commentId}</td>
                                                    <td class="p-3" style="max-width: 200px;" title="${c.blogTitle}">
                                                        <div class="truncate data-blog">${c.blogTitle}</div>
                                                    </td>
                                                    <td class="p-3">
                                                        <div class="flex items-center gap-2">
                                                            <img src="${pageContext.request.contextPath}/assets/images/users/${c.image != null ? c.image : 'reviewer/1.jpg'}" 
                                                                 alt="avatar" 
                                                                 class="w-8 h-8 rounded-full object-cover"
                                                                 onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/reviewer/1.jpg'">
                                                            <div class="flex flex-col">
                                                                <span class="font-medium text-sm text-neutral-800 dark:text-white data-user">${c.name}</span>
                                                                <span class="text-xs text-neutral-500 data-email">${c.email}</span>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="p-3">
                                                        <div class="truncate max-w-[300px] data-content" title="${c.detail}">
                                                            ${c.detail}
                                                        </div>
                                                    </td>
                                                    <td class="p-3 whitespace-nowrap data-date">
                                                        <fmt:formatDate value="${c.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </td>
                                                    <td class="p-3">
                                                        <span class="
                                                            <c:choose>
                                                                <c:when test="${c.active}">bg-success-100 text-success-600 dark:bg-success-600/25 dark:text-success-400</c:when>
                                                                <c:otherwise>bg-danger-100 text-danger-600 dark:bg-danger-600/25 dark:text-danger-400</c:otherwise>
                                                            </c:choose>
                                                            px-4 py-1 rounded-full font-medium text-xs">
                                                            <c:if test="${c.active}">Hiển thị</c:if>
                                                            <c:if test="${!c.active}">Đã ẩn</c:if>
                                                        </span>
                                                    </td>
                                                    <td class="p-3">
                                                        <div class="flex items-center justify-center gap-2">
                                                            <button type="button" onclick="openViewModal(this)" 
                                                                class="text-primary-600 hover:bg-primary-100 p-1 rounded" title="Xem chi tiết">
                                                                <iconify-icon icon="solar:eye-bold" width="20"></iconify-icon>
                                                            </button>

                                                            <c:if test="${c.active}">
                                                                <a href="${pageContext.request.contextPath}/admin/blog-reviews?action=hide&id=${c.commentId}" 
                                                                   class="w-8 h-8 bg-warning-100 dark:bg-warning-600/25 text-warning-600 dark:text-warning-400 rounded-full inline-flex items-center justify-center" 
                                                                   title="Ẩn">
                                                                    <iconify-icon icon="solar:eye-closed-bold"></iconify-icon>
                                                                </a>
                                                            </c:if>
                                                            <c:if test="${!c.active}">
                                                                <a href="${pageContext.request.contextPath}/admin/blog-reviews?action=show&id=${c.commentId}" 
                                                                   class="w-8 h-8 bg-success-100 dark:bg-success-600/25 text-success-600 dark:text-success-400 rounded-full inline-flex items-center justify-center" 
                                                                   title="Hiện">
                                                                    <iconify-icon icon="solar:eye-bold"></iconify-icon>
                                                                </a>
                                                            </c:if>
                                                            <a href="${pageContext.request.contextPath}/admin/blog-reviews?action=delete&id=${c.commentId}" 
                                                               class="w-8 h-8 bg-danger-100 dark:bg-danger-600/25 text-danger-600 dark:text-danger-400 rounded-full inline-flex items-center justify-center" 
                                                               title="Xóa"
                                                               onclick="return confirm('Bạn có chắc chắn muốn xóa bình luận này?');">
                                                                <iconify-icon icon="solar:trash-bin-trash-bold"></iconify-icon>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>

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

    <!-- View Detail Modal -->
    <div id="viewModal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full bg-gray-900/50 backdrop-blur-sm">
        <div class="relative p-4 w-full max-w-2xl max-h-full">
            <!-- Modal content -->
            <div class="relative bg-white rounded-lg shadow dark:bg-neutral-800">
                <!-- Modal header -->
                <div class="flex items-center justify-between p-4 md:p-5 border-b rounded-t dark:border-neutral-700">
                    <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
                        Chi Tiết Bình Luận
                    </h3>
                    <button type="button" onclick="closeViewModal()" class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-neutral-600 dark:hover:text-white">
                        <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
                        </svg>
                        <span class="sr-only">Close modal</span>
                    </button>
                </div>
                <!-- Modal body -->
                <div class="p-4 md:p-5 space-y-4">
                    <div class="grid grid-cols-2 gap-4">
                        <div class="col-span-2">
                            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Bài viết Blog</label>
                            <div id="modal-blog" class="p-2.5 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg dark:bg-neutral-700 dark:border-neutral-600 dark:text-white"></div>
                        </div>
                        <div>
                            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Người dùng</label>
                            <div id="modal-user" class="p-2.5 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg dark:bg-neutral-700 dark:border-neutral-600 dark:text-white"></div>
                        </div>
                        <div>
                            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Email</label>
                            <div id="modal-email" class="p-2.5 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg dark:bg-neutral-700 dark:border-neutral-600 dark:text-white"></div>
                        </div>
                        <div class="col-span-2">
                            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Ngày bình luận</label>
                            <div id="modal-date" class="p-2.5 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg dark:bg-neutral-700 dark:border-neutral-600 dark:text-white"></div>
                        </div>
                        <div class="col-span-2">
                            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Nội dung chi tiết</label>
                            <div id="modal-content" class="p-4 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg dark:bg-neutral-700 dark:border-neutral-600 dark:text-white min-h-[100px] whitespace-pre-wrap"></div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="flex items-center p-4 md:p-5 border-t border-gray-200 rounded-b dark:border-neutral-700">
                    <button type="button" onclick="closeViewModal()" class="text-white bg-primary-600 hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/lib/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/lib/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/lib/simple-datatables.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/flowbite.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    
    <script>
        // Init DataTable for Blog Comments only
        const tableEl = document.querySelector('#blog-table');
        if (tableEl) {
            let table = new simpleDatatables.DataTable('#blog-table', {
                labels: {
                    placeholder: "Tìm kiếm...",
                    perPage: "Hiển thị mục",
                    noRows: "Không tìm thấy dữ liệu",
                    info: "Hiển thị {start} đến {end} của {rows} mục",
                },
                perPage: 10
            });
        }

        // View Modal Logic
        function openViewModal(btn) {
            const row = btn.closest('tr');
            
            // Extract data from the row using classes
            const blog = row.querySelector('.data-blog').innerText;
            const user = row.querySelector('.data-user').innerText;
            const email = row.querySelector('.data-email').innerText;
            // Get full content from the 'title' attribute which is not truncated
            const content = row.querySelector('.data-content').getAttribute('title');
            const date = row.querySelector('.data-date').innerText;

            // Populate Modal
            document.getElementById('modal-blog').innerText = blog;
            document.getElementById('modal-user').innerText = user;
            document.getElementById('modal-email').innerText = email;
            document.getElementById('modal-content').innerText = content;
            document.getElementById('modal-date').innerText = date;

            // Show Modal (using flex to center)
            const modal = document.getElementById('viewModal');
            modal.classList.remove('hidden');
            modal.classList.add('flex');
        }

        function closeViewModal() {
            const modal = document.getElementById('viewModal');
            modal.classList.add('hidden');
            modal.classList.remove('flex');
        }
    </script>

</body>
</html>