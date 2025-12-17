<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en" >

<head>
    <%@include file="/admin/components/theme_loader.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xem Chi Tiáº¿t LiĂªn Há»‡</title>
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
                <li><a href="${pageContext.request.contextPath}/admin"><iconify-icon icon="solar:home-smile-angle-outline" class="menu-icon"></iconify-icon><span>Trang Chá»§</span></a></li>
                <li class="sidebar-menu-group-title">Quáº£n LĂ½</li>
                <li><a href="${pageContext.request.contextPath}/admin/quanlytour"><iconify-icon icon="mingcute:storage-line" class="menu-icon"></iconify-icon><span>Quáº£n LĂ½ Tour</span></a></li>
                <li><a href="${pageContext.request.contextPath}/admin/quanlyblog"><iconify-icon icon="icon-park-outline:writing-fluently" class="menu-icon"></iconify-icon><span>Quáº£n LĂ½ Blog</span></a></li>
                <li class="active">
                    <a href="${pageContext.request.contextPath}/admin/quanlylienhe">
                        <iconify-icon icon="fluent:contact-card-20-regular" class="menu-icon"></iconify-icon>
                        <span>Quáº£n LĂ½ LiĂªn Há»‡</span>
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/quanlymenu">
                        <iconify-icon icon="mingcute:menu-line" class="menu-icon"></iconify-icon>
                        <span>Quáº£n LĂ½ Menu</span>
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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Chi Tiáº¿t Tin Nháº¯n</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="${pageContext.request.contextPath}/admin/quanlylienhe" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="fluent:contact-card-20-regular" class="icon text-lg"></iconify-icon>
                            Danh SĂ¡ch LiĂªn Há»‡
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Xem Tin Nháº¯n</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12">
                <div class="col-span-12">
                    <div class="card border-0">
                        <div class="card-header flex items-center justify-between">
                            <h5 class="text-lg font-semibold mb-0">Tá»«: ${contact.name}</h5>
                            <a href="${pageContext.request.contextPath}/admin/quanlylienhe" class="btn btn-primary-600 hover:bg-primary-700 text-white px-4 py-2 rounded-lg flex items-center gap-2">
                                <iconify-icon icon="iconoir:arrow-left" class="text-xl"></iconify-icon> Quay Láº¡i
                            </a>
                        </div>
                        <div class="card-body">
                            <div class="space-y-4">
                                <div class="flex items-center gap-4">
                                    <strong class="w-24 text-neutral-500">Email:</strong>
                                    <p class="mb-0">${contact.email}</p>
                                </div>
                                <div class="flex items-center gap-4">
                                    <strong class="w-24 text-neutral-500">Äiá»‡n thoáº¡i:</strong>
                                    <p class="mb-0">${contact.phone}</p>
                                </div>
                                <div class="flex items-center gap-4">
                                    <strong class="w-24 text-neutral-500">NgĂ y gá»­i:</strong>
                                    <p class="mb-0"><fmt:formatDate value="${contact.createdDate}" pattern="HH:mm 'ngĂ y' dd/MM/yyyy" /></p>
                                </div>
                                <hr class="dark:border-neutral-700">
                                <div>
                                    <strong class="text-neutral-500">Ná»™i dung tin nháº¯n:</strong>
                                    <div class="mt-2 p-4 bg-neutral-100 dark:bg-neutral-900 rounded-lg whitespace-pre-wrap">${contact.message}</div>
                                </div>
                            </div>
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

