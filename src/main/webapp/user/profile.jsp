<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hồ Sơ Của Tôi - Travelin</title>
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
    <c:choose>
        <c:when test="${not empty slides}">
            <div id="profileBannerCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach items="${slides}" var="s" varStatus="status">
                        <div class="carousel-item ${status.first ? 'active' : ''}">
                            <section class="breadcrumb-main pb-20 pt-14" style="background-image:url(${pageContext.request.contextPath}/assets/images/${s.image}); background-size: cover; background-position: center;">
                                <div class="section-shape section-shape1 top-inherit bottom-0" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/shape8.png);"></div>
                                <div class="breadcrumb-outer">
                                    <div class="container">
                                        <div class="breadcrumb-content text-center">
                                            <h1 class="mb-1 white" style="text-shadow: 2px 2px 4px rgba(0,0,0,0.5);">Hồ Sơ Cá Nhân</h1>
                                            <h3 class="white theme mb-3" style="text-shadow: 1px 1px 2px rgba(0,0,0,0.5);">${s.title}</h3>
                                            <nav aria-label="breadcrumb" class="d-block">
                                                <ul class="breadcrumb">
                                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                                                    <li class="breadcrumb-item active" aria-current="page">Hồ Sơ</li>
                                                </ul>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                                <div class="dot-overlay"></div>
                            </section>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <section class="breadcrumb-main pb-20 pt-14" style="background-image:url(${pageContext.request.contextPath}/assets/travelin/images/testimonial.png);">
                <div class="section-shape section-shape1 top-inherit bottom-0" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/shape8.png);"></div>
                <div class="breadcrumb-outer">
                    <div class="container">
                        <div class="breadcrumb-content text-center">
                            <h1 class="mb-3 white">Hồ Sơ Cá Nhân</h1>
                            <nav aria-label="breadcrumb" class="d-block">
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Hồ Sơ</li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
                <div class="dot-overlay"></div>
            </section>
        </c:otherwise>
    </c:choose>
    <!-- banner ends -->

    <!-- Dashboard -->
    <section class="dashboard pt-6 pb-6">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-12 mb-4">
                    <div class="dashboard-sidebar p-4 rounded box-shadow">
                        <div class="profile-sec text-center mb-4 border-b pb-4">
                            <div class="profile-image mb-3">
                                <img src="${pageContext.request.contextPath}/assets/images/users/${sessionScope.user.avatar}" 
                                     alt="Image" 
                                     class="rounded-circle" 
                                     style="width: 150px; height: 150px; object-fit: cover;"
                                     onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/reviewer/1.jpg'">
                            </div>
                            <h4 class="mb-0">${sessionScope.user.username}</h4>
                            <p class="mb-0">${sessionScope.user.email}</p>
                            
                            <!-- Avatar Upload Form -->
                            <form action="profile" method="post" enctype="multipart/form-data" class="mt-3">
                                <div class="d-flex justify-content-center align-items-center flex-column">
                                    <label for="avatarFile" class="btn btn-sm btn-outline-primary mb-2" style="cursor: pointer;">
                                        <i class="fa fa-camera"></i> Đổi Ảnh
                                    </label>
                                    <input type="file" name="avatarFile" id="avatarFile" style="display: none;" onchange="this.form.submit()">
                                </div>
                            </form>
                        </div>
                        <div class="dashboard-menu">
                            <ul class="nav nav-tabs flex-column" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" id="dashboard-tab" data-bs-toggle="tab" href="#dashboard" role="tab" aria-controls="dashboard" aria-selected="true"><i class="fa fa-list"></i> Lịch Sử Đơn Hàng</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" id="profile-tab" data-bs-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false"><i class="fa fa-user"></i> Thông Tin Cá Nhân</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout?role=user"><i class="fa fa-sign-out-alt"></i> Đăng Xuất</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8 col-md-12 mb-4">
                    <div class="dashboard-content">
                        <!-- Message Notification -->
                        <c:if test="${not empty sessionScope.message}">
                            <div class="alert alert-${sessionScope.messageType} alert-dismissible fade show mb-4" role="alert">
                                ${sessionScope.message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <% request.getSession().removeAttribute("message"); %>
                            <% request.getSession().removeAttribute("messageType"); %>
                        </c:if>

                        <div class="tab-content">
                            <!-- Order History Tab -->
                            <div class="tab-pane fade show active" id="dashboard" role="tabpanel" aria-labelledby="dashboard-tab">
                                <div class="dashboard-box">
                                    <h4 class="border-b pb-2 mb-4">Lịch Sử Đơn Hàng</h4>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Mã Đơn</th>
                                                    <th>Ngày Đặt</th>
                                                    <th>Tổng Tiền</th>
                                                    <th>Số Lượng</th>
                                                    <th>Trạng Thái</th>
                                                    <th>Chi Tiết</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:if test="${empty orderList}">
                                                    <tr>
                                                        <td colspan="6" class="text-center">Bạn chưa có đơn hàng nào.</td>
                                                    </tr>
                                                </c:if>
                                                <c:forEach items="${orderList}" var="o">
                                                    <tr>
                                                        <td><strong>#${o.code}</strong></td>
                                                        <td>${o.createdDate}</td>
                                                        <td><fmt:formatNumber value="${o.totalAmount}" pattern="#,###"/>₫</td>
                                                        <td>${o.quanlity}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${o.orderStatusId == 5}">
                                                                    <span class="badge bg-warning text-dark">${o.statusName}</span>
                                                                </c:when>
                                                                <c:when test="${o.orderStatusId == 6}">
                                                                    <span class="badge bg-success">${o.statusName}</span>
                                                                </c:when>
                                                                <c:when test="${o.orderStatusId == 7}">
                                                                    <span class="badge bg-danger">${o.statusName}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-secondary">${o.statusName}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td><a href="${pageContext.request.contextPath}/order-detail?id=${o.orderId}" class="btn btn-sm btn-primary"><i class="fa fa-eye"></i></a></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- Profile Info Tab -->
                            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                <div class="dashboard-box">
                                    <h4 class="border-b pb-2 mb-4">Thông Tin Cá Nhân</h4>
                                    <form action="profile" method="post">
                                        <div class="row">
                                            <div class="col-lg-6 mb-2">
                                                <div class="form-group">
                                                    <label>Tên Đăng Nhập</label>
                                                    <input type="text" class="form-control" value="${sessionScope.user.username}" readonly>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 mb-2">
                                                <div class="form-group">
                                                    <label>Email</label>
                                                    <input type="email" class="form-control" value="${sessionScope.user.email}" readonly>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 mb-2">
                                                <div class="form-group">
                                                    <label>Số Điện Thoại</label>
                                                    <input type="text" name="phone" class="form-control" value="${sessionScope.user.phone}" placeholder="Nhập số điện thoại (10 số)" required>
                                                </div>
                                            </div>
                                            <div class="col-lg-6 mb-2">
                                                <div class="form-group">
                                                    <label>Ngày Sinh</label>
                                                    <input type="date" name="birthday" class="form-control" value="${sessionScope.user.birthday}" required>
                                                </div>
                                            </div>
                                            <div class="col-lg-12 mt-3">
                                                <button type="submit" class="nir-btn">Lưu Thay Đổi</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Dashboard Ends -->

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
    <script src="${pageContext.request.contextPath}/assets/travelin/js/particles.js"></script>
    <script src="${pageContext.request.contextPath}/assets/travelin/js/particlerun.js"></script>
    <script src="${pageContext.request.contextPath}/assets/travelin/js/plugin.js"></script>
    <script src="${pageContext.request.contextPath}/assets/travelin/js/main.js"></script>
    <script src="${pageContext.request.contextPath}/assets/travelin/js/custom-swiper.js"></script>
    <script src="${pageContext.request.contextPath}/assets/travelin/js/custom-nav.js"></script>
</body>
</html>