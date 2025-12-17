<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en" >

<head>
    <%@include file="/admin/components/theme_loader.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quáº£n LĂ½ ÄĂ¡nh GiĂ¡ Tour</title>
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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Quáº£n LĂ½ ÄĂ¡nh GiĂ¡ Tour</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="${pageContext.request.contextPath}/admin" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Trang Chá»§
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">ÄĂ¡nh GiĂ¡ Tour</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12">
                <div class="col-span-12">
                    <div class="card border-0 overflow-hidden">
                        <div class="card-header flex items-center justify-between">
                            <h6 class="card-title mb-0 text-lg">Danh SĂ¡ch ÄĂ¡nh GiĂ¡ (${reviews != null ? reviews.size() : 0})</h6>
                        </div>
                        <div class="card-body">
                            
                            <c:if test="${empty reviews}">
                                <div class="p-4 text-center text-neutral-500 dark:text-neutral-400">
                                    KhĂ´ng cĂ³ Ä‘Ă¡nh giĂ¡ tour nĂ o.
                                </div>
                            </c:if>
                            <c:if test="${not empty reviews}">
                                <div class="table-responsive">
                                    <table id="review-table" class="table border border-neutral-200 dark:border-neutral-600 rounded-lg border-separate w-full">
                                        <thead>
                                            <tr>
                                                <th scope="col" class="text-neutral-800 dark:text-white">ID</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">Tour</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">NgÆ°á»i DĂ¹ng</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">Äiá»ƒm</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">Ná»™i Dung</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">NgĂ y</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">Tráº¡ng ThĂ¡i</th>
                                                <th scope="col" class="text-neutral-800 dark:text-white">HĂ nh Äá»™ng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${reviews}" var="r">
                                                <tr class="border-b border-neutral-200 dark:border-neutral-700 hover:bg-neutral-100 dark:hover:bg-neutral-700/50">
                                                    <td class="p-3">${r.productReviewId}</td>
                                                    <td class="p-3" style="max-width: 200px;" title="${r.tourName}">
                                                        <div class="truncate data-tour">${r.tourName}</div>
                                                    </td>
                                                    <td class="p-3">
                                                        <div class="flex items-center gap-2">
                                                            <img src="${pageContext.request.contextPath}/assets/images/users/${r.image != null ? r.image : 'reviewer/1.jpg'}" 
                                                                 alt="avatar" 
                                                                 class="w-8 h-8 rounded-full object-cover"
                                                                 onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/reviewer/1.jpg'">
                                                            <div class="flex flex-col">
                                                                <span class="font-medium text-sm text-neutral-800 dark:text-white data-user">${r.name}</span>
                                                                <span class="text-xs text-neutral-500 data-email">${r.email}</span>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="p-3">
                                                        <div class="flex items-center gap-1 text-warning-600">
                                                            <span class="font-semibold data-star">${r.star}</span> <i class="ri-star-fill"></i>
                                                        </div>
                                                    </td>
                                                    <td class="p-3">
                                                        <div class="truncate max-w-[200px] data-content" title="${r.detail}">
                                                            ${r.detail}
                                                        </div>
                                                    </td>
                                                    <td class="p-3 whitespace-nowrap data-date">
                                                        <fmt:formatDate value="${r.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                                                    </td>
                                                    <td class="p-3">
                                                        <span class="
                                                            <c:choose>
                                                                <c:when test="${r.isActive}">bg-success-100 text-success-600 dark:bg-success-600/25 dark:text-success-400</c:when>
                                                                <c:otherwise>bg-danger-100 text-danger-600 dark:bg-danger-600/25 dark:text-danger-400</c:otherwise>
                                                            </c:choose>
                                                            px-4 py-1 rounded-full font-medium text-xs">
                                                            <c:if test="${r.isActive}">Hiá»ƒn thá»‹</c:if>
                                                            <c:if test="${!r.isActive}">ÄĂ£ áº©n</c:if>
                                                        </span>
                                                    </td>
                                                    <td class="p-3">
                                                        <div class="flex items-center justify-center gap-2">
                                                            <button type="button" onclick="openViewModal(this)" 
                                                                class="text-primary-600 hover:bg-primary-100 p-1 rounded" title="Xem chi tiáº¿t">
                                                                <iconify-icon icon="solar:eye-bold" width="20"></iconify-icon>
                                                            </button>

                                                            <c:if test="${r.isActive}">
                                                                <a href="${pageContext.request.contextPath}/admin/reviews?action=hide&id=${r.productReviewId}" 
                                                                   class="text-warning-600 hover:bg-warning-100 p-1 rounded" title="áº¨n">
                                                                    <iconify-icon icon="solar:eye-closed-bold" width="20"></iconify-icon>
                                                                </a>
                                                            </c:if>
                                                            <c:if test="${!r.isActive}">
                                                                <a href="${pageContext.request.contextPath}/admin/reviews?action=show&id=${r.productReviewId}" 
                                                                   class="text-success-600 hover:bg-success-100 p-1 rounded" title="Hiá»‡n">
                                                                    <iconify-icon icon="solar:eye-bold" width="20"></iconify-icon>
                                                                </a>
                                                            </c:if>
                                                            <a href="${pageContext.request.contextPath}/admin/reviews?action=delete&id=${r.productReviewId}" 
                                                               class="text-danger-600 hover:bg-danger-100 p-1 rounded" 
                                                               title="XĂ³a"
                                                               onclick="return confirm('Báº¡n cĂ³ cháº¯c cháº¯n muá»‘n xĂ³a Ä‘Ă¡nh giĂ¡ nĂ y?');">
                                                                <iconify-icon icon="solar:trash-bin-trash-bold" width="20"></iconify-icon>
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
                <p class="mb-0">Â© 2025. All Rights Reserved.</p>
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
                        Chi Tiáº¿t ÄĂ¡nh GiĂ¡
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
                            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tour</label>
                            <div id="modal-tour" class="p-2.5 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg dark:bg-neutral-700 dark:border-neutral-600 dark:text-white"></div>
                        </div>
                        <div>
                            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">NgÆ°á»i dĂ¹ng</label>
                            <div id="modal-user" class="p-2.5 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg dark:bg-neutral-700 dark:border-neutral-600 dark:text-white"></div>
                        </div>
                        <div>
                            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Email</label>
                            <div id="modal-email" class="p-2.5 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg dark:bg-neutral-700 dark:border-neutral-600 dark:text-white"></div>
                        </div>
                        <div>
                            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Äiá»ƒm Ä‘Ă¡nh giĂ¡</label>
                            <div class="p-2.5 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg dark:bg-neutral-700 dark:border-neutral-600 dark:text-white flex items-center gap-1">
                                <span id="modal-star" class="font-bold"></span> <i class="ri-star-fill text-warning-600"></i>
                            </div>
                        </div>
                        <div>
                            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">NgĂ y Ä‘Ă¡nh giĂ¡</label>
                            <div id="modal-date" class="p-2.5 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg dark:bg-neutral-700 dark:border-neutral-600 dark:text-white"></div>
                        </div>
                        <div class="col-span-2">
                            <label class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Ná»™i dung chi tiáº¿t</label>
                            <div id="modal-content" class="p-4 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg dark:bg-neutral-700 dark:border-neutral-600 dark:text-white min-h-[100px] whitespace-pre-wrap"></div>
                        </div>
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="flex items-center p-4 md:p-5 border-t border-gray-200 rounded-b dark:border-neutral-700">
                    <button type="button" onclick="closeViewModal()" class="text-white bg-primary-600 hover:bg-primary-700 focus:ring-4 focus:outline-none focus:ring-primary-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-primary-600 dark:hover:bg-primary-700 dark:focus:ring-primary-800">ÄĂ³ng</button>
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
        // Init DataTable for Tour Reviews only, only if table exists
        const tableEl = document.querySelector('#review-table');
        if (tableEl) {
            let table = new simpleDatatables.DataTable('#review-table', {
                labels: {
                    placeholder: "TĂ¬m kiáº¿m...",
                    perPage: "Hiá»ƒn thá»‹ má»¥c",
                    noRows: "KhĂ´ng tĂ¬m tháº¥y dá»¯ liá»‡u",
                    info: "Hiá»ƒn thá»‹ {start} Ä‘áº¿n {end} cá»§a {rows} má»¥c",
                },
                perPage: 10
            });
        }

        // View Modal Logic
        function openViewModal(btn) {
            const row = btn.closest('tr');
            
            // Extract data from the row using classes
            const tour = row.querySelector('.data-tour').innerText;
            const user = row.querySelector('.data-user').innerText;
            const email = row.querySelector('.data-email').innerText;
            const star = row.querySelector('.data-star').innerText;
            // Get full content from the 'title' attribute which is not truncated
            const content = row.querySelector('.data-content').getAttribute('title');
            const date = row.querySelector('.data-date').innerText;

            // Populate Modal
            document.getElementById('modal-tour').innerText = tour;
            document.getElementById('modal-user').innerText = user;
            document.getElementById('modal-email').innerText = email;
            document.getElementById('modal-star').innerText = star;
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
