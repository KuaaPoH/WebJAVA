<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" >

<head>
    <%@include file="/admin/components/theme_loader.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiáº¿t ÄÆ¡n HĂ ng #${order.code}</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/favicon.png" sizes="16x16">
    <!-- google fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=re" rel="stylesheet">
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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Chi Tiáº¿t ÄÆ¡n HĂ ng #${order.code}</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="${pageContext.request.contextPath}/admin" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Trang Chá»§
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="font-medium">
                        <a href="${pageContext.request.contextPath}/admin/orders" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            Quáº£n LĂ½ ÄÆ¡n HĂ ng
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Chi Tiáº¿t</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12 gap-6">
                <div class="col-span-12 lg:col-span-8">
                    <div class="card border-0">
                        <div class="card-header">
                            <h6 class="card-title mb-0 text-lg">ThĂ´ng Tin ÄÆ¡n HĂ ng</h6>
                        </div>
                        <div class="card-body">
                            <ul class="space-y-3">
                                <li class="flex justify-between items-center">
                                    <span class="font-medium text-neutral-600 dark:text-neutral-300">MĂ£ ÄÆ¡n:</span>
                                    <span class="text-neutral-800 dark:text-neutral-200">${order.code}</span>
                                </li>
                                <li class="flex justify-between items-center">
                                    <span class="font-medium text-neutral-600 dark:text-neutral-300">KhĂ¡ch HĂ ng:</span>
                                    <span class="text-neutral-800 dark:text-neutral-200">${order.customerName}</span>
                                </li>
                                <li class="flex justify-between items-center">
                                    <span class="font-medium text-neutral-600 dark:text-neutral-300">Email:</span>
                                    <span class="text-neutral-800 dark:text-neutral-200">${order.email}</span>
                                </li>
                                <li class="flex justify-between items-center">
                                    <span class="font-medium text-neutral-600 dark:text-neutral-300">Sá»‘ Äiá»‡n Thoáº¡i:</span>
                                    <span class="text-neutral-800 dark:text-neutral-200">${order.phone}</span>
                                </li>
                                <li class="flex justify-between items-center">
                                    <span class="font-medium text-neutral-600 dark:text-neutral-300">Äá»‹a Chá»‰ / Chi Tiáº¿t ThĂªm:</span>
                                    <span class="text-neutral-800 dark:text-neutral-200">${order.address}</span>
                                </li>
                                <li class="flex justify-between items-center">
                                    <span class="font-medium text-neutral-600 dark:text-neutral-300">Tá»•ng Sá»‘ KhĂ¡ch:</span>
                                    <span class="text-neutral-800 dark:text-neutral-200">${order.quanlity}</span>
                                </li>
                                <li class="flex justify-between items-center">
                                    <span class="font-medium text-neutral-600 dark:text-neutral-300">NgĂ y Äáº·t:</span>
                                    <span class="text-neutral-800 dark:text-neutral-200">
                                        <fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </span>
                                </li>
                                <li class="flex justify-between items-center">
                                    <span class="font-medium text-neutral-600 dark:text-neutral-300">Tá»•ng Tiá»n:</span>
                                    <span class="text-neutral-800 dark:text-neutral-200 font-semibold">
                                        <fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>â‚«
                                    </span>
                                </li>
                                <li class="flex justify-between items-center">
                                    <span class="font-medium text-neutral-600 dark:text-neutral-300">Tráº¡ng ThĂ¡i:</span>
                                    <span class="
                                        <c:choose>
                                            <c:when test="${order.statusName == 'Pending'}">bg-warning-100 text-warning-600 dark:bg-warning-600/25 dark:text-warning-400</c:when>
                                            <c:when test="${order.statusName == 'Confirmed'}">bg-success-100 text-success-600 dark:bg-success-600/25 dark:text-success-400</c:when>
                                            <c:when test="${order.statusName == 'Cancelled'}">bg-danger-100 text-danger-600 dark:bg-danger-600/25 dark:text-danger-400</c:when>
                                            <c:otherwise>bg-neutral-100 text-neutral-600 dark:bg-neutral-600/25 dark:text-neutral-400</c:otherwise>
                                        </c:choose>
                                        px-3 py-1 rounded-full font-medium text-sm">
                                        ${order.statusName}
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="card border-0 mt-6">
                        <div class="card-header">
                            <h6 class="card-title mb-0 text-lg">Chi Tiáº¿t Tour ÄĂ£ Äáº·t</h6>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty order.orderDetails}">
                                <c:forEach var="detail" items="${order.orderDetails}">
                                    <div class="flex items-start gap-4 mb-4 pb-4 border-b border-neutral-200 dark:border-neutral-700">
                                        <div class="flex flex-col items-center gap-2" style="min-width: 120px;">
                                            <img src="${pageContext.request.contextPath}/assets/images/products/${detail.image}" 
                                                 alt="${detail.tourName}" 
                                                 class="w-24 h-24 object-cover rounded-lg"
                                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/logo-icon.png'">
                                            <h6 class="text-sm font-semibold text-neutral-800 dark:text-white text-center">${detail.tourName}</h6>
                                        </div>
                                        <div class="flex-grow pt-2">
                                            <p class="text-sm text-neutral-600 dark:text-neutral-300 mb-1">
                                                NgĂ y khá»Ÿi hĂ nh: <fmt:formatDate value="${detail.departureDate}" pattern="dd/MM/yyyy"/>
                                            </p>
                                            <p class="text-sm text-neutral-600 dark:text-neutral-300 mb-1">
                                                GiĂ¡/khĂ¡ch: <fmt:formatNumber value="${detail.price}" pattern="#,###"/>â‚«
                                            </p>
                                            <p class="text-sm text-neutral-600 dark:text-neutral-300 mb-0">
                                                Sá»‘ lÆ°á»£ng khĂ¡ch: ${detail.quantity}
                                            </p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty order.orderDetails}">
                                <p class="text-neutral-600 dark:text-neutral-300">KhĂ´ng cĂ³ chi tiáº¿t tour cho Ä‘Æ¡n hĂ ng nĂ y.</p>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="col-span-12 lg:col-span-4">
                    <div class="card border-0">
                        <div class="card-header">
                            <h6 class="card-title mb-0 text-lg">Cáº­p Nháº­t Tráº¡ng ThĂ¡i</h6>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/admin/orders" method="post">
                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="orderId" value="${order.orderId}">
                                <div class="form-group mb-4">
                                    <label for="statusSelect" class="block mb-2 text-sm font-medium text-neutral-800 dark:text-white">Tráº¡ng ThĂ¡i ÄÆ¡n HĂ ng:</label>
                                    <select id="statusSelect" name="statusId" class="py-2.5 px-4 block w-full border border-neutral-200 rounded-lg text-sm focus:border-primary-500 focus:ring-primary-500 dark:bg-neutral-800 dark:border-neutral-700 dark:text-neutral-400">
                                        <c:forEach var="status" items="${statuses}">
                                            <option value="${status.orderStatusId}" ${order.orderStatusId == status.orderStatusId ? 'selected' : ''}>
                                                ${status.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary-600 hover:bg-primary-700 text-white px-4 py-2 rounded-lg w-full">Cáº­p Nháº­t Tráº¡ng ThĂ¡i</button>
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

