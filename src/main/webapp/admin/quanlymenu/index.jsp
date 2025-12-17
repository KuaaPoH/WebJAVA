<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en" >

<head>
    <%@include file="/admin/components/theme_loader.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quáº£n LĂ½ Menu</title>
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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Danh SĂ¡ch Menu</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="javascript:void(0)" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Trang Chá»§
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Quáº£n LĂ½ Menu</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12">
                <div class="col-span-12">
                    <div class="card border-0 overflow-hidden">
                        <div class="card-header flex items-center justify-between">
                            <h6 class="card-title mb-0 text-lg">Dá»¯ Liá»‡u Menu</h6>
                            <a href="${pageContext.request.contextPath}/admin/quanlymenu?action=create" class="btn btn-primary-600 hover:bg-primary-700 text-white px-4 py-2 rounded-lg flex items-center gap-2">
                                <iconify-icon icon="mingcute:add-line" class="text-xl"></iconify-icon> ThĂªm Má»›i
                            </a>
                        </div>
                        <div class="card-body">
                            <table id="selection-table" class="table border border-neutral-200 dark:border-neutral-600 rounded-lg border-separate">
                                <thead>
                                    <tr>
                                        <th scope="col" class="text-neutral-800 dark:text-white">ID</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">TiĂªu Äá»</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Alias</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Vá»‹ TrĂ­</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">ParentID</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Cáº¥p</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Tráº¡ng ThĂ¡i</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">HĂ nh Äá»™ng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listM}" var="m">
                                        <tr>
                                            <td>${m.menuId}</td>
                                            <td><h6 class="text-base mb-0 font-medium whitespace-normal">${m.title}</h6></td>
                                            <td>${m.alias}</td>
                                            <td>${m.position}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${m.parentId == 0}">
                                                        <span class="text-neutral-500">-- KhĂ´ng cĂ³ --</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${menuMap[m.parentId]} <span class="text-neutral-500 text-xs">[ID: ${m.parentId}]</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${m.levels}</td>
                                            <td>
                                                <c:if test="${m.active}">
                                                    <span class="bg-success-100 dark:bg-success-600/25 text-success-600 dark:text-success-400 px-4 py-1 rounded-full font-medium text-sm">Hiá»‡n</span>
                                                </c:if>
                                                <c:if test="${!m.active}">
                                                    <span class="bg-danger-100 dark:bg-danger-600/25 text-danger-600 dark:text-danger-400 px-4 py-1 rounded-full font-medium text-sm">áº¨n</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <div class="flex items-center justify-center gap-2">
                                                    <!-- Toggle Status -->
                                                    <a href="${pageContext.request.contextPath}/admin/quanlymenu?action=toggle&id=${m.menuId}" class="w-8 h-8 bg-primary-50 dark:bg-primary-600/10 text-primary-600 dark:text-primary-400 rounded-full inline-flex items-center justify-center" title="${m.active ? 'áº¨n' : 'Hiá»‡n'}">
                                                        <iconify-icon icon="${m.active ? 'iconamoon:eye-light' : 'iconamoon:eye-off-light'}"></iconify-icon>
                                                    </a>
                                                    
                                                    <!-- Edit Button -->
                                                    <a href="${pageContext.request.contextPath}/admin/quanlymenu?action=edit&id=${m.menuId}" class="w-8 h-8 bg-success-100 dark:bg-success-600/25 text-success-600 dark:text-success-400 rounded-full inline-flex items-center justify-center">
                                                        <iconify-icon icon="lucide:edit"></iconify-icon>
                                                    </a>
                                                    
                                                    <!-- Delete Button -->
                                                    <a href="${pageContext.request.contextPath}/admin/quanlymenu?action=delete&id=${m.menuId}" onclick="return confirm('Báº¡n cĂ³ cháº¯c muá»‘n xĂ³a má»¥c menu nĂ y khĂ´ng?')" class="w-8 h-8 bg-danger-100 dark:bg-danger-600/25 text-danger-600 dark:text-danger-400 rounded-full inline-flex items-center justify-center">
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
                <p class="mb-0">Â© 2025. All Rights Reserved.</p>
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
                placeholder: "TĂ¬m kiáº¿m...",
                perPage: "Hiá»ƒn thá»‹ má»¥c",
                noRows: "KhĂ´ng tĂ¬m tháº¥y dá»¯ liá»‡u",
                info: "Hiá»ƒn thá»‹ {start} Ä‘áº¿n {end} cá»§a {rows} má»¥c",
            }
        });
    </script>

</body>
</html>

