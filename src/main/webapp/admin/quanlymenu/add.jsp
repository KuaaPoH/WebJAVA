<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %> 

<!DOCTYPE html>
<html lang="en" >

<head>
    <%@include file="/admin/components/theme_loader.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ThĂªm Má»›i Menu</title>
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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">ThĂªm Menu Má»›i</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="${pageContext.request.contextPath}/admin/quanlymenu" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                           <iconify-icon icon="material-symbols:menu-outline" class="icon text-lg"></iconify-icon>
                            Danh SĂ¡ch Menu
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">ThĂªm Má»›i</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12 gap-5">
                <div class="col-span-12">
                    <div class="card border-0">
                        <div class="card-header">
                            <h5 class="text-lg font-semibold mb-0">ThĂ´ng Tin Menu</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/quanlymenu" method="post">
                                <input type="hidden" name="action" value="insert">
                                
                                <div class="grid grid-cols-12 gap-4">
                                    <div class="col-span-12 md:col-span-6">
                                        <label class="form-label">TiĂªu Äá»</label>
                                        <input type="text" name="title" class="form-control" placeholder="TiĂªu Ä‘á» hiá»ƒn thá»‹..." required>
                                    </div>
                                    <div class="col-span-12 md:col-span-6">
                                        <label class="form-label">Alias</label>
                                        <input type="text" name="alias" class="form-control" placeholder="VD: /trang-chu, /lien-he..." required>
                                    </div>

                                    <div class="col-span-12 md:col-span-4">
                                        <label class="form-label">Vá»‹ TrĂ­</label>
                                        <input type="number" name="position" class="form-control" placeholder="Thá»© tá»± hiá»ƒn thá»‹" value="1" required>
                                    </div>
                                    <div class="col-span-12 md:col-span-4">
                                        <label class="form-label">Cáº¥p</label>
                                        <input type="number" name="levels" class="form-control" placeholder="Cáº¥p menu" value="1" required>
                                    </div>
                                    <div class="col-span-12 md:col-span-4">
                                        <label class="form-label">Menu Cha</label>
                                        <select name="parentId" class="form-control dark:bg-neutral-700 dark:text-white">
                                            <option value="0">-- KhĂ´ng cĂ³ (LĂ  menu gá»‘c) --</option>
                                            <c:forEach items="${allMenus}" var="m">
                                                <option value="${m.menuId}">${m.title}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="col-span-12">
                                        <div class="flex items-center gap-2">
                                            <input class="form-check-input rounded-full" type="checkbox" name="active" value="on" id="activeCheck" checked>
                                            <label class="form-check-label" for="activeCheck">KĂ­ch hoáº¡t (Hiá»ƒn thá»‹ ngay)</label>
                                        </div>
                                    </div>
                                    
                                    <div class="col-span-12 flex gap-3 mt-4">
                                        <button type="submit" class="btn btn-primary-600">LÆ°u Menu</button>
                                        <a href="${pageContext.request.contextPath}/admin/quanlymenu" class="btn btn-danger-600">Há»§y Bá»</a>
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
                <p class="mb-0">Â© 2025. All Rights Reserved.</p>
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

