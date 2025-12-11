<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en" class="dark" data-theme="dark">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Quản Trị Hệ Thống</title>
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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Tổng Quan Hệ Thống</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="${pageContext.request.contextPath}/admin" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Dashboard
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Dashboard Widgets Start -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-6">
                <!-- Widget 1: Revenue -->
                <div class="card border-0 shadow-none bg-white dark:bg-neutral-800 rounded-lg p-5 flex items-center justify-between">
                    <div>
                        <p class="text-neutral-500 dark:text-neutral-400 text-sm mb-1">Tổng Doanh Thu</p>
                        <h4 class="text-2xl font-bold mb-0 text-neutral-800 dark:text-white">
                            <fmt:formatNumber value="${revenue}" type="currency" currencySymbol="$" maxFractionDigits="0"/>
                        </h4>
                    </div>
                    <div class="w-12 h-12 rounded-full bg-primary-50 dark:bg-primary-600/10 flex items-center justify-center text-primary-600 dark:text-primary-400">
                        <iconify-icon icon="solar:wallet-money-outline" class="text-2xl"></iconify-icon>
                    </div>
                </div>

                <!-- Widget 2: Orders -->
                <div class="card border-0 shadow-none bg-white dark:bg-neutral-800 rounded-lg p-5 flex items-center justify-between">
                    <div>
                        <p class="text-neutral-500 dark:text-neutral-400 text-sm mb-1">Tổng Đơn Hàng</p>
                        <h4 class="text-2xl font-bold mb-0 text-neutral-800 dark:text-white">${totalOrders}</h4>
                    </div>
                    <div class="w-12 h-12 rounded-full bg-success-50 dark:bg-success-600/10 flex items-center justify-center text-success-600 dark:text-success-400">
                        <iconify-icon icon="solar:bag-check-outline" class="text-2xl"></iconify-icon>
                    </div>
                </div>

                <!-- Widget 3: Tours -->
                <div class="card border-0 shadow-none bg-white dark:bg-neutral-800 rounded-lg p-5 flex items-center justify-between">
                    <div>
                        <p class="text-neutral-500 dark:text-neutral-400 text-sm mb-1">Tour Hoạt Động</p>
                        <h4 class="text-2xl font-bold mb-0 text-neutral-800 dark:text-white">${totalTours}</h4>
                    </div>
                    <div class="w-12 h-12 rounded-full bg-warning-50 dark:bg-warning-600/10 flex items-center justify-center text-warning-600 dark:text-warning-400">
                        <iconify-icon icon="mingcute:storage-line" class="text-2xl"></iconify-icon>
                    </div>
                </div>

                <!-- Widget 4: Cancel Requests -->
                <div class="card border-0 shadow-none bg-white dark:bg-neutral-800 rounded-lg p-5 flex items-center justify-between">
                    <div>
                        <p class="text-neutral-500 dark:text-neutral-400 text-sm mb-1">Yêu Cầu Hủy</p>
                        <h4 class="text-2xl font-bold mb-0 text-neutral-800 dark:text-white">${cancelRequests}</h4>
                    </div>
                    <div class="w-12 h-12 rounded-full bg-danger-50 dark:bg-danger-600/10 flex items-center justify-center text-danger-600 dark:text-danger-400">
                        <iconify-icon icon="solar:bell-bing-bold-duotone" class="text-2xl"></iconify-icon>
                    </div>
                </div>
            </div>

            <!-- Charts Section -->
            <div class="grid grid-cols-12 gap-6 mb-6">
                <!-- Revenue Chart -->
                <div class="col-span-12 lg:col-span-8">
                    <div class="card border-0 shadow-none bg-white dark:bg-neutral-800 rounded-lg h-full">
                        <div class="card-header border-b border-neutral-200 dark:border-neutral-700 p-4 flex items-center justify-between">
                            <h6 class="text-lg font-semibold mb-0 text-neutral-800 dark:text-white">Báo Cáo Doanh Thu Năm ${currentYear}</h6>
                        </div>
                        <div class="card-body p-4">
                            <div id="revenueChart" class="w-full h-[350px]"></div>
                        </div>
                    </div>
                </div>

                <!-- Order Analytics Chart -->
                <div class="col-span-12 lg:col-span-4">
                    <div class="card border-0 shadow-none bg-white dark:bg-neutral-800 rounded-lg h-full">
                        <div class="card-header border-b border-neutral-200 dark:border-neutral-700 p-4">
                            <h6 class="text-lg font-semibold mb-0 text-neutral-800 dark:text-white">Phân Tích Đơn Hàng</h6>
                        </div>
                        <div class="card-body p-4 flex flex-col justify-center items-center">
                            <div id="orderChart" class="w-full"></div>
                            <div class="mt-4 text-center">
                                <p class="text-neutral-500 dark:text-neutral-400 text-sm">Tỷ lệ đơn hàng theo trạng thái</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Recent Orders Section -->
            <div class="grid grid-cols-12 gap-6 mb-6">
                <div class="col-span-12">
                    <div class="card border-0 shadow-none bg-white dark:bg-neutral-800 rounded-lg h-full">
                        <div class="card-header border-b border-neutral-200 dark:border-neutral-700 p-4 flex items-center justify-between">
                            <h6 class="text-lg font-semibold mb-0 text-neutral-800 dark:text-white">Đơn Hàng Mới Nhất</h6>
                            <a href="${pageContext.request.contextPath}/admin/orders" class="text-primary-600 hover:text-primary-700 font-medium text-sm">Xem tất cả</a>
                        </div>
                        <div class="card-body p-0 overflow-x-auto">
                            <table class="table w-full text-left border-collapse">
                                <thead>
                                    <tr class="bg-neutral-50 dark:bg-neutral-700/30 border-b border-neutral-200 dark:border-neutral-700">
                                        <th class="p-4 font-medium text-neutral-500 dark:text-neutral-300">Mã Đơn</th>
                                        <th class="p-4 font-medium text-neutral-500 dark:text-neutral-300">Khách Hàng</th>
                                        <th class="p-4 font-medium text-neutral-500 dark:text-neutral-300">Tổng Tiền</th>
                                        <th class="p-4 font-medium text-neutral-500 dark:text-neutral-300">Ngày Đặt</th>
                                        <th class="p-4 font-medium text-neutral-500 dark:text-neutral-300">Trạng Thái</th>
                                        <th class="p-4 font-medium text-neutral-500 dark:text-neutral-300 text-center">Chi Tiết</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${recentOrders}" var="order">
                                        <tr class="border-b border-neutral-200 dark:border-neutral-700 last:border-0 hover:bg-neutral-100 dark:hover:bg-neutral-700 transition">
                                            <td class="p-4 font-medium dark:text-white">#${order.code}</td>
                                            <td class="p-4 dark:text-white">${order.customerName}</td>
                                            <td class="p-4 font-bold text-primary-600"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>₫</td>
                                            <td class="p-4 text-neutral-500 dark:text-neutral-400"><fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy"/></td>
                                            <td class="p-4">
                                                <span class="px-3 py-1 rounded-full text-xs font-medium
                                                    <c:choose>
                                                        <c:when test="${order.orderStatusId == 5}">bg-warning-100 text-warning-600 dark:bg-warning-600/25 dark:text-warning-400</c:when>
                                                        <c:when test="${order.orderStatusId == 6}">bg-success-100 text-success-600 dark:bg-success-600/25 dark:text-success-400</c:when>
                                                        <c:when test="${order.orderStatusId == 7}">bg-danger-100 text-danger-600 dark:bg-danger-600/25 dark:text-danger-400</c:when>
                                                        <c:when test="${order.orderStatusId == 1008}">bg-purple-100 text-purple-600 dark:bg-purple-600/25 dark:text-purple-400</c:when>
                                                        <c:otherwise>bg-neutral-100 text-neutral-600 dark:bg-neutral-600/25 dark:text-neutral-400</c:otherwise>
                                                    </c:choose>">
                                                    ${order.statusName}
                                                </span>
                                            </td>
                                            <td class="p-4 text-center">
                                                <a href="${pageContext.request.contextPath}/admin/orders?action=view&id=${order.orderId}" class="w-8 h-8 inline-flex items-center justify-center rounded-full bg-primary-50 text-primary-600 hover:bg-primary-100 transition dark:bg-primary-600/10 dark:text-primary-400 dark:hover:bg-primary-600/20" title="Xem chi tiết">
                                                    <iconify-icon icon="solar:eye-bold"></iconify-icon>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Quick Links / Shortcuts -->
            <div class="grid grid-cols-12 gap-6">
                <div class="col-span-12 lg:col-span-8">
                    <div class="card h-full border-0">
                        <div class="card-header border-b border-neutral-200 dark:border-neutral-700 p-4">
                            <h5 class="text-lg font-semibold mb-0">Hệ Thống Quản Lý</h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                                <a href="${pageContext.request.contextPath}/admin/quanlytour" class="p-4 rounded-lg bg-neutral-50 dark:bg-neutral-800 border border-transparent dark:border-neutral-700 hover:bg-neutral-100 dark:hover:bg-neutral-700 transition flex flex-col items-center gap-3 text-center">
                                    <div class="w-10 h-10 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center">
                                        <iconify-icon icon="mingcute:storage-line" class="text-xl"></iconify-icon>
                                    </div>
                                    <span class="font-medium text-neutral-700 dark:text-neutral-200">Quản Lý Tour</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/quanlyblog" class="p-4 rounded-lg bg-neutral-50 dark:bg-neutral-800 border border-transparent dark:border-neutral-700 hover:bg-neutral-100 dark:hover:bg-neutral-700 transition flex flex-col items-center gap-3 text-center">
                                    <div class="w-10 h-10 rounded-full bg-purple-100 text-purple-600 flex items-center justify-center">
                                        <iconify-icon icon="icon-park-outline:writing-fluently" class="text-xl"></iconify-icon>
                                    </div>
                                    <span class="font-medium text-neutral-700 dark:text-neutral-200">Quản Lý Blog</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/quanlylienhe" class="p-4 rounded-lg bg-neutral-50 dark:bg-neutral-800 border border-transparent dark:border-neutral-700 hover:bg-neutral-100 dark:hover:bg-neutral-700 transition flex flex-col items-center gap-3 text-center">
                                    <div class="w-10 h-10 rounded-full bg-red-100 text-red-600 flex items-center justify-center">
                                        <iconify-icon icon="fluent:contact-card-20-regular" class="text-xl"></iconify-icon>
                                    </div>
                                    <span class="font-medium text-neutral-700 dark:text-neutral-200">Liên Hệ</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/quanlymenu" class="p-4 rounded-lg bg-neutral-50 dark:bg-neutral-800 border border-transparent dark:border-neutral-700 hover:bg-neutral-100 dark:hover:bg-neutral-700 transition flex flex-col items-center gap-3 text-center">
                                    <div class="w-10 h-10 rounded-full bg-green-100 text-green-600 flex items-center justify-center">
                                        <iconify-icon icon="mingcute:menu-line" class="text-xl"></iconify-icon>
                                    </div>
                                    <span class="font-medium text-neutral-700 dark:text-neutral-200">Cấu Hình Menu</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-span-12 lg:col-span-4">
                    <div class="card h-full border-0 bg-primary-600 text-white relative overflow-hidden">
                        <div class="card-body p-6 flex flex-col justify-between h-full relative z-10">
                            <div>
                                <h5 class="text-xl font-bold mb-2">Xin chào, Admin!</h5>
                                <p class="text-primary-100">Chúc bạn một ngày làm việc hiệu quả.</p>
                            </div>
                            <div class="mt-4">
                                <p class="text-sm text-primary-200 mb-1">Thời gian server</p>
                                <h3 class="text-3xl font-bold">
                                    <fmt:formatDate value="<%=new java.util.Date()%>" pattern="HH:mm"/>
                                </h3>
                                <p class="text-primary-100"><fmt:formatDate value="<%=new java.util.Date()%>" pattern="dd/MM/yyyy"/></p>
                            </div>
                        </div>
                        <!-- Decorative shapes -->
                        <div class="absolute top-0 right-0 -mr-8 -mt-8 w-32 h-32 rounded-full bg-white opacity-10"></div>
                        <div class="absolute bottom-0 left-0 -ml-8 -mb-8 w-24 h-24 rounded-full bg-white opacity-10"></div>
                    </div>
                </div>
            </div>
            <!-- Dashboard Widgets End -->
        
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
    
    <!-- ApexCharts -->
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            try {
                const isDark = document.documentElement.classList.contains('dark');
                
                // Safe data handling
                let revenueDataRaw = "${revenueData}";
                let revenueDataArray = [];
                
                if (revenueDataRaw && revenueDataRaw.length > 2) {
                    revenueDataArray = JSON.parse(revenueDataRaw);
                } else {
                    console.warn("No revenue data from server, using default.");
                    revenueDataArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                }
                
                console.log("Revenue Data:", revenueDataArray);

                // --- Revenue Chart ---
                var revenueOptions = {
                    series: [{
                        name: 'Doanh Thu',
                        data: revenueDataArray
                    }],
                    chart: {
                        height: 350,
                        type: 'area',
                        toolbar: { show: false },
                        fontFamily: 'Inter, sans-serif'
                    },
                    colors: ['#487fff'],
                    dataLabels: { enabled: false },
                    stroke: { curve: 'smooth', width: 2 },
                    xaxis: {
                        categories: ['Th1', 'Th2', 'Th3', 'Th4', 'Th5', 'Th6', 'Th7', 'Th8', 'Th9', 'Th10', 'Th11', 'Th12'],
                        labels: { style: { colors: '#9ca3af' } },
                        axisBorder: { show: false },
                        axisTicks: { show: false }
                    },
                    yaxis: {
                        labels: {
                            style: { colors: '#9ca3af' },
                            formatter: function (value) {
                                return "$" + value.toLocaleString();
                            }
                        }
                    },
                    grid: {
                        borderColor: isDark ? '#374151' : '#e5e7eb',
                        strokeDashArray: 4,
                        yaxis: { lines: { show: true } }
                    },
                    fill: {
                        type: 'gradient',
                        gradient: {
                            shadeIntensity: 1,
                            opacityFrom: 0.7,
                            opacityTo: 0.3,
                            stops: [0, 90, 100]
                        }
                    },
                    tooltip: { theme: isDark ? 'dark' : 'light' }
                };
                var rChart = new ApexCharts(document.querySelector("#revenueChart"), revenueOptions);
                rChart.render();

                // --- Order Chart ---
                var orderOptions = {
                    series: ${orderData},
                    labels: ${orderLabels},
                    colors: ${orderColors}, // Use dynamic colors
                    chart: {
                        type: 'donut',
                        height: 300,
                        fontFamily: 'Inter, sans-serif'
                    },
                    plotOptions: {
                        pie: {
                            donut: {
                                size: '75%',
                                labels: {
                                    show: true,
                                    total: {
                                        show: true,
                                        label: 'Tổng',
                                        fontSize: '16px',
                                        color: '#9ca3af'
                                    },
                                    value: {
                                        color: isDark ? '#e5e7eb' : '#374151',
                                        fontSize: '24px',
                                        fontWeight: 600,
                                        show: true
                                    }
                                }
                            }
                        }
                    },
                    dataLabels: { enabled: false },
                    legend: {
                        position: 'bottom',
                        itemMargin: { horizontal: 10, vertical: 5 },
                        labels: { colors: '#9ca3af' }
                    },
                    stroke: { show: false },
                    tooltip: { theme: isDark ? 'dark' : 'light' }
                };
                var oChart = new ApexCharts(document.querySelector("#orderChart"), orderOptions);
                oChart.render();
                
                // Theme Toggle Listener
                const themeToggleBtn = document.getElementById('theme-toggle');
                if(themeToggleBtn) {
                    themeToggleBtn.addEventListener('click', function() {
                        setTimeout(() => {
                            const isNowDark = document.documentElement.classList.contains('dark');
                            
                            rChart.updateOptions({
                                grid: { borderColor: isNowDark ? '#374151' : '#e5e7eb' },
                                tooltip: { theme: isNowDark ? 'dark' : 'light' }
                            });
                            
                            oChart.updateOptions({
                                plotOptions: {
                                    pie: {
                                        donut: {
                                            labels: {
                                                value: {
                                                    color: isNowDark ? '#e5e7eb' : '#374151'
                                                }
                                            }
                                        }
                                    }
                                },
                                tooltip: { theme: isNowDark ? 'dark' : 'light' }
                            });
                        }, 100);
                    });
                }

            } catch (error) {
                console.error("Chart Render Error:", error);
            }
        });
    </script>
</body>
</html>