<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Liên Hệ - Travelin</title>
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
            <div id="contactBannerCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach items="${slides}" var="s" varStatus="status">
                        <div class="carousel-item ${status.first ? 'active' : ''}">
                            <section class="breadcrumb-main pb-20 pt-14" style="background-image:url(${pageContext.request.contextPath}/assets/images/${s.image}); background-size: cover; background-position: center;">
                                <div class="section-shape section-shape1 top-inherit bottom-0" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/shape8.png);"></div>
                                <div class="breadcrumb-outer">
                                    <div class="container">
                                        <div class="breadcrumb-content text-center">
                                            <h1 class="mb-1 white" style="text-shadow: 2px 2px 4px rgba(0,0,0,0.5);">Liên Hệ Với Chúng Tôi</h1>
                                            <h3 class="white theme mb-3" style="text-shadow: 1px 1px 2px rgba(0,0,0,0.5);">${s.title}</h3>
                                            <nav aria-label="breadcrumb" class="d-block">
                                                <ul class="breadcrumb">
                                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                                                    <li class="breadcrumb-item active" aria-current="page">Liên Hệ</li>
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
                            <h1 class="mb-3 white">Liên Hệ Với Chúng Tôi</h1>
                            <nav aria-label="breadcrumb" class="d-block">
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Liên Hệ</li>
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

    <!-- contact starts -->
    <section class="contact-main pt-10 pb-10">
        <div class="container">
            <div class="contact-info">
                <div class="row">
                    <div class="col-lg-6 col-md-12 col-sm-12 mb-4">
                        <div class="contact-info-content">
                            <h3 class="mb-2">Thông Tin Liên Hệ</h3>
                            <p class="mb-4">Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ với chúng tôi qua thông tin dưới đây hoặc điền vào biểu mẫu.</p>
                            
                            <div class="contact-info-item mb-4">
                                <h5 class="mb-1"><i class="fa fa-map-marker-alt theme me-2"></i> Địa Chỉ</h5>
                                <p class="mb-0">Số 1 Đại Cồ Việt, Hai Bà Trưng, Hà Nội</p>
                            </div>
                            <div class="contact-info-item mb-4">
                                <h5 class="mb-1"><i class="fa fa-phone theme me-2"></i> Điện Thoại</h5>
                                <p class="mb-0">+84 123 456 789</p>
                            </div>
                            <div class="contact-info-item mb-4">
                                <h5 class="mb-1"><i class="fa fa-envelope theme me-2"></i> Email</h5>
                                <p class="mb-0">support@travelin.com</p>
                            </div>

                            <div class="map mt-4">
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.636976694318!2d105.84117131540203!3d21.00217598601275!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ac76ccab6dd7%3A0x55e92a5b07a97d03!2zxJDhuqFpIGjhu41jIELDoWNoIGtob2EgSMOgIE7hu5lp!5e0!3m2!1svi!2s!4v1626082498453!5m2!1svi!2s" width="100%" height="300" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-6 col-md-12 col-sm-12 mb-4">
                        <div class="contact-form-main bg-light p-5 rounded">
                            <h3 class="mb-2">Gửi Tin Nhắn</h3>
                            <p class="mb-4">Chúng tôi sẽ phản hồi bạn trong thời gian sớm nhất.</p>

                            <c:if test="${not empty message}">
                                <div class="alert alert-${messageType} alert-dismissible fade show mb-4" role="alert">
                                    ${message}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>

                            <form action="contact" method="post">
                                <div class="row">
                                    <div class="col-lg-6 mb-3">
                                        <div class="form-group">
                                            <input type="text" name="name" class="form-control" placeholder="Họ tên *" required value="${sessionScope.user.username}">
                                        </div>
                                    </div>
                                    <div class="col-lg-6 mb-3">
                                        <div class="form-group">
                                            <input type="email" name="email" class="form-control" placeholder="Email *" required value="${sessionScope.user.email}">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 mb-3">
                                        <div class="form-group">
                                            <input type="text" name="phone" class="form-control" placeholder="Số điện thoại" value="${sessionScope.user.phone}">
                                        </div>
                                    </div>
                                    <div class="col-lg-12 mb-3">
                                        <div class="form-group">
                                            <textarea name="message" class="form-control" rows="5" placeholder="Nội dung tin nhắn *" required></textarea>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <button type="submit" class="nir-btn">Gửi Tin Nhắn</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- contact ends -->

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
    <script src="${pageContext.request.contextPath}/assets/travelin/js/custom-nav.js"></script>
</body>
</html>