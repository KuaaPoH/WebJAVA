<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en" >

<head>
    <%@include file="/admin/components/theme_loader.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${slide != null ? 'Cáº­p Nháº­t Banner' : 'ThĂªm Má»›i Banner'}</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/favicon.png" sizes="16x16">
    <!-- google fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=swap" rel="stylesheet">
    <!-- remix icon font css  -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/remixicon.css">
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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">${slide != null ? 'Cáº­p Nháº­t Banner' : 'ThĂªm Má»›i Banner'}</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium"><a href="${pageContext.request.contextPath}/admin" class="text-neutral-500">Trang Chá»§</a></li>
                    <li class="text-neutral-500">-</li>
                    <li class="font-medium"><a href="${pageContext.request.contextPath}/admin/quanlyslide" class="text-neutral-500">Banner</a></li>
                </ul>
            </div>

            <div class="grid grid-cols-12 gap-6">
                <div class="col-span-12">
                    <div class="card border-0">
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/quanlyslide" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="${slide != null ? 'update' : 'insert'}">
                                <c:if test="${slide != null}">
                                    <input type="hidden" name="id" value="${slide.slideID}">
                                    <input type="hidden" name="currentImage" value="${slide.image}">
                                </c:if>

                                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                    
                                    <!-- Title -->
                                    <div class="col-span-2">
                                        <label class="form-label">TiĂªu Äá» <span class="text-danger-600">*</span></label>
                                        <input type="text" name="title" class="form-control" value="${slide.title}" required placeholder="Nháº­p tiĂªu Ä‘á» banner">
                                    </div>

                                    <!-- Alias -->
                                    <div class="col-span-2 lg:col-span-1">
                                        <label class="form-label">Alias (URL)</label>
                                        <input type="text" name="alias" class="form-control" value="${slide.alias}" placeholder="Tá»± Ä‘á»™ng táº¡o náº¿u Ä‘á»ƒ trá»‘ng">
                                        <small class="text-neutral-500">VĂ­ dá»¥: banner-mua-he (khĂ´ng dáº¥u, cĂ¡ch nhau bá»Ÿi gáº¡ch ngang)</small>
                                    </div>

                                    <!-- Status -->
                                    <div class="col-span-2 lg:col-span-1">
                                        <label class="form-label">Tráº¡ng ThĂ¡i</label>
                                        <div class="flex items-center gap-4 mt-2">
                                            <div class="flex items-center">
                                                <input type="checkbox" id="isActive" name="isActive" class="form-check-input w-5 h-5" ${slide == null || slide.active ? 'checked' : ''}>
                                                <label for="isActive" class="ml-2">Hiá»ƒn thá»‹</label>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Image Upload -->
                                    <div class="col-span-2">
                                        <label class="form-label">HĂ¬nh áº¢nh</label>
                                        <input type="file" name="image" class="form-control" accept="image/*">
                                        
                                        <c:if test="${slide != null && slide.image != null && not empty slide.image}">
                                            <div class="mt-3">
                                                <p class="mb-2 text-sm">áº¢nh hiá»‡n táº¡i:</p>
                                                <img src="${pageContext.request.contextPath}/assets/images/${slide.image}" class="h-32 rounded border border-neutral-200" onerror="this.src='https://placehold.co/400x200?text=No+Image'">
                                            </div>
                                        </c:if>
                                    </div>

                                </div>

                                <div class="flex items-center gap-4 mt-8">
                                    <button type="submit" class="btn btn-primary-600">
                                        <iconify-icon icon="mingcute:save-line" class="text-xl mr-2"></iconify-icon> LÆ°u Láº¡i
                                    </button>
                                    <a href="${pageContext.request.contextPath}/admin/quanlyslide" class="btn btn-danger-600 bg-red-100 text-red-600 hover:bg-red-200 border-none">Há»§y Bá»</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="${pageContext.request.contextPath}/assets/js/lib/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/lib/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/flowbite.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>

