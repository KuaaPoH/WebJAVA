<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chi Tiết Đơn Hàng #${order.code} - Travelin</title>
    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/travelin/images/favicon.png">
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/assets/travelin/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <!--Custom CSS-->
    <link href="${pageContext.request.contextPath}/assets/travelin/css/style.css" rel="stylesheet" type="text/css">
    <!--Plugin CSS-->
    <link href="${pageContext.request.contextPath}/assets/travelin/css/plugin.css" rel="stylesheet" type="text/css">
    <!--Font Awesome-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/travelin/fonts/line-icons.css" type="text/css">
</head>

<body>

    <!-- Header -->
    <jsp:include page="/user/components/header.jsp" />
    <!-- Header Ends -->

    <!-- banner starts -->
    <section class="banner pt-10 pb-0 overflow-hidden" style="background-image:url(${pageContext.request.contextPath}/assets/travelin/images/testimonial.png);">
        <div class="container">
            <div class="banner-in">
                <div class="breadcrumb-content text-center">
                    <h1 class="mb-0 white">Chi Tiết Đơn Hàng</h1>
                    <nav aria-label="breadcrumb" class="d-block">
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/profile">Hồ Sơ</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Đơn Hàng #${order.code}</li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </section>
    <!-- banner ends -->

    <!-- Order Detail Section -->
    <section class="dashboard pt-6 pb-6">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="dashboard-box">
                        <!-- Message Notification -->
                        <c:if test="${not empty sessionScope.message}">
                            <div class="alert alert-${sessionScope.messageType} alert-dismissible fade show" role="alert">
                                ${sessionScope.message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <% request.getSession().removeAttribute("message"); %>
                            <% request.getSession().removeAttribute("messageType"); %>
                        </c:if>

                        <!-- Header Thông tin -->
                        <div class="d-flex justify-content-between align-items-center mb-4 border-b pb-2">
                            <h3 class="mb-0">Đơn Hàng: <span class="theme">#${order.code}</span></h3>
                            <a href="${pageContext.request.contextPath}/profile" class="nir-btn-outline"><i class="fa fa-arrow-left"></i> Quay Lại</a>
                        </div>
                        
                        <!-- Thông tin chung -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <h5 class="border-b pb-1 mb-2">Thông Tin Khách Hàng</h5>
                                <p class="mb-1"><strong>Họ Tên:</strong> ${order.customerName}</p>
                                <p class="mb-1"><strong>Email:</strong> ${order.email}</p>
                                <p class="mb-1"><strong>Số Điện Thoại:</strong> ${order.phone}</p>
                                <p class="mb-1"><strong>Ghi Chú/Địa Chỉ:</strong> ${order.address}</p>
                            </div>
                            <div class="col-md-6 text-md-end">
                                <h5 class="border-b pb-1 mb-2">Trạng Thái Đơn Hàng</h5>
                                <p class="mb-1"><strong>Ngày Đặt:</strong> <fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy"/></p>
                                <p class="mb-1">
                                    <strong>Trạng Thái: </strong>
                                    <c:choose>
                                        <c:when test="${order.orderStatusId == 5}"><span class="badge bg-warning text-dark">${order.statusName}</span></c:when>
                                        <c:when test="${order.orderStatusId == 6}"><span class="badge bg-success">${order.statusName}</span></c:when>
                                        <c:when test="${order.orderStatusId == 7}"><span class="badge bg-danger">${order.statusName}</span></c:when>
                                        <c:when test="${order.orderStatusId == 1008}"><span class="badge bg-info text-dark">${order.statusName}</span></c:when>
                                        <c:otherwise><span class="badge bg-secondary">${order.statusName}</span></c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>

                        <!-- Bảng chi tiết -->
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead class="bg-light">
                                    <tr>
                                        <th>Tour</th>
                                        <th>Ngày Khởi Hành</th>
                                        <th>Đơn Giá</th>
                                        <th>Số Khách</th>
                                        <th class="text-end">Thành Tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${order.orderDetails}" var="detail">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <img src="${pageContext.request.contextPath}/assets/images/products/${detail.image}" 
                                                         alt="${detail.tourName}" 
                                                         style="width: 80px; height: 60px; object-fit: cover; margin-right: 15px;"
                                                         class="rounded"
                                                         onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/trending/trending2.jpg'">
                                                    <div>
                                                        <a href="${pageContext.request.contextPath}/tour-detail?id=${detail.tourId}" class="fw-bold text-dark hover-theme">
                                                            ${detail.tourName}
                                                        </a>
                                                    </div>
                                                </div>
                                            </td>
                                            <td><fmt:formatDate value="${detail.departureDate}" pattern="dd/MM/yyyy"/></td>
                                            <td><fmt:formatNumber value="${detail.price}" pattern="#,###"/>₫</td>
                                            <td>${detail.quantity}</td>
                                            <td class="text-end fw-bold"><fmt:formatNumber value="${detail.price * detail.quantity}" pattern="#,###"/>₫</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="4" class="text-end fw-bold fs-5">Tổng Cộng:</td>
                                        <td class="text-end fw-bold fs-5 theme"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/>₫</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        
                        <!-- Actions -->
                        <c:if test="${order.orderStatusId == 5}">
                            <div class="mt-4 text-end">
                                <form action="order-detail" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn yêu cầu hủy đơn hàng này không?');">
                                    <input type="hidden" name="action" value="cancel_request">
                                    <input type="hidden" name="id" value="${order.orderId}">
                                    <button type="submit" class="btn btn-danger">Yêu Cầu Hủy Đơn</button>
                                </form>
                            </div>
                        </c:if>
                        
                        <c:if test="${order.orderStatusId == 1008}">
                            <div class="mt-4 text-end">
                                <button class="btn btn-secondary" disabled>Đã gửi yêu cầu hủy</button>
                                <p class="text-muted small mt-1">Yêu cầu của bạn đang được Admin xem xét.</p>
                            </div>
                        </c:if>

                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Order Detail Section Ends -->

    <!-- footer starts -->
    <footer class="pt-20 pb-4" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/background_pattern.png);">
        <div class="section-shape top-0" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/shape8.png);"></div>
        <div class="footer-copyright">
            <div class="container">
                <div class="copyright-inner rounded p-3 d-md-flex align-items-center justify-content-between">
                    <div class="copyright-text">
                        <p class="m-0 white">2025 Travelin. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </div>
        <div id="particles-js"></div>
    </footer>
    <!-- footer ends -->

    <!-- *Scripts* -->
    <script src="${pageContext.request.contextPath}/assets/travelin/js/jquery-3.5.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/travelin/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/travelin/js/plugin.js"></script>
    <script src="${pageContext.request.contextPath}/assets/travelin/js/main.js"></script>
</body>
</html>