<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en" >

<head>
    <%@include file="/admin/components/theme_loader.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quáº£n LĂ½ ÄÆ¡n HĂ ng</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/favicon.png" sizes="16x16">
    <!-- google fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&display=re" rel="stylesheet">
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
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Danh SĂ¡ch ÄÆ¡n HĂ ng</h6>
                <ul class="flex items-center gap-[6px]">
                    <li class="font-medium">
                        <a href="javascript:void(0)" class="flex items-center gap-2 hover:text-primary-600 text-neutral-500 dark:text-neutral-400">
                            <iconify-icon icon="solar:home-smile-angle-outline" class="icon text-lg"></iconify-icon>
                            Trang Chá»§
                        </a>
                    </li>
                    <li class="text-neutral-500 dark:text-neutral-400">-</li>
                    <li class="text-neutral-500 dark:text-neutral-400 font-medium">Quáº£n LĂ½ ÄÆ¡n HĂ ng</li>
                </ul>
            </div>

            <!-- Content Start -->
            <div class="grid grid-cols-12">
                <div class="col-span-12">
                    <div class="card border-0 overflow-hidden">
                        <div class="card-header flex items-center justify-between">
                            <h6 class="card-title mb-0 text-lg">Dá»¯ Liá»‡u ÄÆ¡n HĂ ng</h6>
                            <!-- <a href="${pageContext.request.contextPath}/admin/orders?action=create" class="btn btn-primary-600 hover:bg-primary-700 text-white px-4 py-2 rounded-lg flex items-center gap-2">
                                <iconify-icon icon="mingcute:add-line" class="text-xl"></iconify-icon> ThĂªm Má»›i
                            </a> -->
                        </div>
                        <div class="card-body">
                            <!-- Filter Buttons -->
                            <div class="flex flex-wrap gap-2 mb-4">
                                <a href="${pageContext.request.contextPath}/admin/orders?action=list" 
                                   class="px-4 py-2 rounded-lg text-sm font-medium border transition-colors ${empty currentStatus ? 'bg-primary-600 text-white border-primary-600' : 'bg-white text-neutral-600 border-neutral-200 hover:bg-neutral-50 dark:bg-neutral-800 dark:border-neutral-600 dark:text-neutral-300'}">
                                    Táº¥t cáº£
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/orders?action=list&status=5" 
                                   class="px-4 py-2 rounded-lg text-sm font-medium border transition-colors ${currentStatus == 5 ? 'bg-warning-500 text-white border-warning-500' : 'bg-white text-neutral-600 border-neutral-200 hover:bg-neutral-50 dark:bg-neutral-800 dark:border-neutral-600 dark:text-neutral-300'}">
                                    Chá» xĂ¡c nháº­n
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/orders?action=list&status=1008" 
                                   class="px-4 py-2 rounded-lg text-sm font-medium border transition-colors ${currentStatus == 1008 ? 'bg-purple-600 text-white border-purple-600' : 'bg-white text-purple-600 border-purple-200 hover:bg-purple-50 dark:bg-neutral-800 dark:border-neutral-600 dark:text-purple-400'}">
                                    YĂªu cáº§u há»§y
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/orders?action=list&status=6" 
                                   class="px-4 py-2 rounded-lg text-sm font-medium border transition-colors ${currentStatus == 6 ? 'bg-success-600 text-white border-success-600' : 'bg-white text-neutral-600 border-neutral-200 hover:bg-neutral-50 dark:bg-neutral-800 dark:border-neutral-600 dark:text-neutral-300'}">
                                    ÄĂ£ xĂ¡c nháº­n
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/orders?action=list&status=7" 
                                   class="px-4 py-2 rounded-lg text-sm font-medium border transition-colors ${currentStatus == 7 ? 'bg-danger-600 text-white border-danger-600' : 'bg-white text-neutral-600 border-neutral-200 hover:bg-neutral-50 dark:bg-neutral-800 dark:border-neutral-600 dark:text-neutral-300'}">
                                    ÄĂ£ há»§y
                                </a>
                            </div>

                            <table id="selection-table" class="table border border-neutral-200 dark:border-neutral-600 rounded-lg border-separate">
                                <thead>
                                    <tr>
                                        <th scope="col" class="text-neutral-800 dark:text-white">MĂ£ ÄÆ¡n</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">KhĂ¡ch HĂ ng</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Tá»•ng Tiá»n</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Sá»‘ LÆ°á»£ng KhĂ¡ch</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">NgĂ y Äáº·t</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">Tráº¡ng ThĂ¡i</th>
                                        <th scope="col" class="text-neutral-800 dark:text-white">HĂ nh Äá»™ng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orders}" var="order">
                                        <tr>
                                            <td>${order.code}</td>
                                            <td>
                                                <h6 class="text-base mb-0 font-medium whitespace-normal">${order.customerName}</h6>
                                                <small>${order.email}</small>
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>â‚«
                                            </td>
                                            <td>${order.quanlity}</td>
                                            <td><fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                                            <td>
                                                <span class="
                                                    <c:choose>
                                                        <c:when test="${order.orderStatusId == 5}">bg-warning-100 text-warning-600 dark:bg-warning-600/25 dark:text-warning-400</c:when>
                                                        <c:when test="${order.orderStatusId == 6}">bg-success-100 text-success-600 dark:bg-success-600/25 dark:text-success-400</c:when>
                                                        <c:when test="${order.orderStatusId == 7}">bg-danger-100 text-danger-600 dark:bg-danger-600/25 dark:text-danger-400</c:when>
                                                        <c:when test="${order.orderStatusId == 1008}">bg-purple-100 text-purple-600 dark:bg-purple-600/25 dark:text-purple-400</c:when>
                                                        <c:otherwise>bg-neutral-100 text-neutral-600 dark:bg-neutral-600/25 dark:text-neutral-400</c:otherwise>
                                                    </c:choose>
                                                    px-4 py-1 rounded-full font-medium text-sm">
                                                    ${order.statusName}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="flex items-center justify-center gap-2">
                                                    <!-- View Details Button -->
                                                    <a href="${pageContext.request.contextPath}/admin/orders?action=view&id=${order.orderId}" class="w-8 h-8 bg-primary-50 dark:bg-primary-600/10 text-primary-600 dark:text-primary-400 rounded-full inline-flex items-center justify-center" title="Xem chi tiáº¿t">
                                                        <iconify-icon icon="solar:eye-bold"></iconify-icon>
                                                    </a>
                                                    
                                                    <c:choose>
                                                        <%-- CASE: YĂªu cáº§u há»§y (1008) --%>
                                                        <c:when test="${order.orderStatusId == 1008}">
                                                            <!-- Cháº¥p nháº­n há»§y (Chuyá»ƒn sang ID 7 - ÄĂ£ há»§y) -->
                                                            <a href="${pageContext.request.contextPath}/admin/orders?action=updateStatus&orderId=${order.orderId}&statusId=7&from=list" 
                                                               class="w-8 h-8 bg-success-100 dark:bg-success-600/25 text-success-600 dark:text-success-400 rounded-full inline-flex items-center justify-center" 
                                                               title="Cháº¥p nháº­n yĂªu cáº§u há»§y"
                                                               onclick="return confirm('Cháº¥p nháº­n há»§y Ä‘Æ¡n hĂ ng nĂ y theo yĂªu cáº§u cá»§a khĂ¡ch?');">
                                                                <iconify-icon icon="mingcute:check-fill"></iconify-icon>
                                                            </a>
                                                            
                                                            <!-- Tá»« chá»‘i há»§y (KhĂ´i phá»¥c vá» ID 5 - Chá» xĂ¡c nháº­n) -->
                                                            <a href="${pageContext.request.contextPath}/admin/orders?action=updateStatus&orderId=${order.orderId}&statusId=5&from=list" 
                                                               class="w-8 h-8 bg-warning-100 dark:bg-warning-600/25 text-warning-600 dark:text-warning-400 rounded-full inline-flex items-center justify-center" 
                                                               title="Tá»« chá»‘i há»§y (KhĂ´i phá»¥c Ä‘Æ¡n)"
                                                               onclick="return confirm('Tá»« chá»‘i yĂªu cáº§u há»§y vĂ  khĂ´i phá»¥c Ä‘Æ¡n hĂ ng vá» tráº¡ng thĂ¡i Chá»?');">
                                                                <iconify-icon icon="mingcute:back-2-fill"></iconify-icon>
                                                            </a>
                                                        </c:when>
                                                        
                                                        <%-- CASE: CĂ¡c tráº¡ng thĂ¡i bĂ¬nh thÆ°á»ng (ChÆ°a hoĂ n thĂ nh) --%>
                                                        <c:when test="${order.orderStatusId != 6 && order.orderStatusId != 7}">
                                                            <a href="${pageContext.request.contextPath}/admin/orders?action=updateStatus&orderId=${order.orderId}&statusId=6&from=list" 
                                                               class="w-8 h-8 bg-success-100 dark:bg-success-600/25 text-success-600 dark:text-success-400 rounded-full inline-flex items-center justify-center" 
                                                               title="Duyá»‡t Ä‘Æ¡n hĂ ng"
                                                               onclick="return confirm('XĂ¡c nháº­n duyá»‡t Ä‘Æ¡n hĂ ng nĂ y?');">
                                                                <iconify-icon icon="mingcute:check-fill"></iconify-icon>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/admin/orders?action=updateStatus&orderId=${order.orderId}&statusId=7&from=list" 
                                                               class="w-8 h-8 bg-danger-100 dark:bg-danger-600/25 text-danger-600 dark:text-danger-400 rounded-full inline-flex items-center justify-center" 
                                                               title="Há»§y Ä‘Æ¡n hĂ ng"
                                                               onclick="return confirm('XĂ¡c nháº­n há»§y Ä‘Æ¡n hĂ ng nĂ y?');">
                                                                <iconify-icon icon="mingcute:close-fill"></iconify-icon>
                                                            </a>
                                                        </c:when>
                                                    </c:choose>
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
        // Khá»Ÿi táº¡o DataTable vá»›i cáº¥u hĂ¬nh tiáº¿ng Viá»‡t
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

