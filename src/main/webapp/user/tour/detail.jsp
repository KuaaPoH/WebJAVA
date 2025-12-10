<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${tour.title} - Travelin</title>
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

    <!-- Preloader -->
    <div id="preloader">
        <div id="status"></div>
    </div>

    <!-- HEADER -->
    <header class="main_header_area">
        <div class="header-content py-1 bg-theme">
            <div class="container d-flex align-items-center justify-content-between">
                <div class="links">
                    <ul>
                        <li><a href="#" class="white"><i class="icon-calendar white"></i> Thứ Năm, 10 Tháng 12, 2025</a></li>
                        <li><a href="#" class="white"><i class="icon-location-pin white"></i> Hà Nội, Việt Nam</a></li>
                        <li><a href="#" class="white"><i class="icon-clock white"></i> T2-T6: 10 AM – 5 PM</a></li>
                    </ul>
                </div>
                <div class="links float-right">
                    <ul>
                        <li><a href="#" class="white"><i class="fab fa-facebook" aria-hidden="true"></i></a></li>
                        <li><a href="#" class="white"><i class="fab fa-twitter" aria-hidden="true"></i></a></li>
                        <li><a href="#" class="white"><i class="fab fa-instagram" aria-hidden="true"></i></a></li>
                        <li><a href="#" class="white"><i class="fab fa-linkedin " aria-hidden="true"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="header_menu" id="header_menu">
            <nav class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-flex d-flex align-items-center justify-content-between w-100 pb-3 pt-3">
                        <div class="navbar-header">
                            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                                <img src="${pageContext.request.contextPath}/assets/travelin/images/logo.png" alt="image">
                            </a>
                        </div>
                        <div class="navbar-collapse1 d-flex align-items-center" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav" id="responsive-menu">
                                <li><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                                <li><a href="${pageContext.request.contextPath}/about.html">Giới Thiệu</a></li>
                                <li class="submenu dropdown active">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Tours <i class="icon-arrow-down" aria-hidden="true"></i></a> 
                                    <ul class="dropdown-menu">
                                        <li><a href="${pageContext.request.contextPath}/tours?category=domestic">Trong Nước</a></li>
                                        <li><a href="${pageContext.request.contextPath}/tours?category=international">Nước Ngoài</a></li>
                                    </ul> 
                                </li>
                                <li><a href="${pageContext.request.contextPath}/blogs">Tin Tức</a></li>
                                <li><a href="${pageContext.request.contextPath}/contact">Liên Hệ</a></li>
                            </ul>
                        </div>
                        <div class="register-login d-flex align-items-center">
                            <a href="#" data-bs-toggle="modal" data-bs-target="#exampleModal" class="me-3">
                                <i class="icon-user"></i> Đăng Nhập
                            </a>
                            <a href="#" class="nir-btn white">Đặt Ngay</a>
                        </div>
                        <div id="slicknav-mobile"></div>
                    </div>
                </div>
            </nav>
        </div>
    </header>

    <!-- BANNER -->
    <div class="banner trending overflow-hidden">
        <div class="section-shape section-shape1 top-inherit bottom-0" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/shape8.png);"></div>
        <div class="banner-slide">
            <div class="row shop-slider">
                <div class="col-lg-4 p-0">
                    <div class="trend-item1 box-shadow bg-white text-center">
                        <div class="trend-image position-relative">
                            <img src="${pageContext.request.contextPath}/assets/travelin/images/new-deal/deal1.jpg" alt="image" class="">
                            <div class="overlay"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 p-0">
                    <div class="trend-item1 box-shadow bg-white text-center">
                        <div class="trend-image position-relative">
                            <img src="${pageContext.request.contextPath}/assets/travelin/images/new-deal/deal2.jpg" alt="image" class="">
                            <div class="overlay"></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 p-0">
                    <div class="trend-item1 box-shadow bg-white text-center">
                        <div class="trend-image position-relative">
                            <img src="${pageContext.request.contextPath}/assets/travelin/images/new-deal/deal3.jpg" alt="image" class="">
                            <div class="overlay"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="banner-breadcrum position-absolute top-50 mx-auto w-50 start-50 text-center translate-middle">
            <div class="breadcrumb-content text-center">
                <h1 class="mb-0 white">Chi Tiết Tour</h1>
                <nav aria-label="breadcrumb" class="d-block">
                    <ul class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">${tour.title}</li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <!-- TOUR CONTENT -->
    <section class="trending pt-6 pb-0 bg-lgrey">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="single-content">
                        <div id="highlight">
                            <div class="single-full-title border-b mb-2 pb-2">
                                <div class="single-title">
                                    <h2 class="mb-1">${tour.title}</h2>
                                    <div class="rating-main d-md-flex align-items-center">
                                        <p class="mb-0 me-2"><i class="icon-location-pin"></i> ${tour.location}</p>
                                        <div class="rating me-2">
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                            <span class="fa fa-star checked"></span>
                                        </div>
                                        <span>(${tour.star} Đánh giá)</span>
                                    </div>
                                </div>
                            </div>

                            <div class="description-images mb-4">
                                <img src="${pageContext.request.contextPath}/assets/images/products/${tour.image != null ? tour.image : 'no-image.png'}" alt="${tour.title}" class="w-100 rounded" onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/trending/trending-large.jpg'">
                            </div>

                            <div class="description mb-2">
                                <h4>Mô Tả</h4>
                                <p>${tour.description}</p>
                            </div>

                            <div class="tour-includes mb-4">
                                <table>
                                    <tbody>
                                        <tr>
                                            <td><i class="fa fa-clock-o pink mr-1" aria-hidden="true"></i> ${tour.timeTravel} Ngày</td>
                                            <td><i class="fa fa-group pink mr-1" aria-hidden="true"></i> Tối đa : 20 Người</td>
                                            <td><i class="fa fa-calendar pink mr-1" aria-hidden="true"></i> Khởi hành hàng tuần</td>
                                        </tr>
                                        <tr>
                                            <td><i class="fa fa-user pink mr-1" aria-hidden="true"></i> Giá: 
                                                <span class="theme fw-bold">
                                                    <fmt:formatNumber value="${tour.priceSale > 0 ? tour.priceSale : tour.price}" pattern="#,###"/>₫
                                                </span>
                                            </td>
                                            <td><i class="fa fa-map-signs pink mr-1" aria-hidden="true"></i> Phương tiện: Xe/Máy bay</td>
                                            <td><i class="fa fa-file-alt pink mr-1" aria-hidden="true"></i> Ngôn ngữ: Tiếng Việt</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="description mb-4">
                                <h4>Chi Tiết Lịch Trình</h4>
                                <div>${tour.detail}</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 ps-lg-4">
                    <div class="sidebar-sticky sticky1">
                        <div class="tabs-navbar bg-lgrey mb-4 bordernone rounded overflow-hidden">
                            <div class="row">
                                <div class="col-md-12">
                                    <ul id="tabs" class="nav nav-tabs bordernone mb-0">
                                        <li class="active">
                                            <a data-toggle="tab" href="#highlight" class="rounded box-shadow mb-2 border-all">Thông Tin</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
                        <!-- BOOKING FORM -->
                        <div class="desc-box bg-grey p-4 rounded mb-4">
                            <h4 class="mb-2">Đặt Tour Ngay</h4>
                            <form action="${pageContext.request.contextPath}/booking" method="post">
                                <input type="hidden" name="tourId" value="${tour.tourId}">
                                <div class="form-group mb-2">
                                    <input type="text" name="fullname" class="form-control" placeholder="Họ và tên" required>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="email" name="email" class="form-control" placeholder="Email" required>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="tel" name="phone" class="form-control" placeholder="Số điện thoại" required>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="number" name="guests" class="form-control" placeholder="Số lượng khách" min="1" required>
                                </div>
                                <div class="form-group mb-2">
                                    <input type="date" name="date" class="form-control" required>
                                </div>
                                <button type="submit" class="nir-btn w-100">Gửi Yêu Cầu</button>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FOOTER -->
    <footer class="pt-20 pb-4" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/background_pattern.png);">
        <div class="section-shape top-0" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/shape8.png);"></div>
        <div class="footer-upper pb-4">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6 col-sm-12 mb-4 pe-4">
                        <div class="footer-about">
                            <img src="${pageContext.request.contextPath}/assets/travelin/images/logo-white.png" alt="">
                            <p class="mt-3 mb-3 white">Travelin - Đồng hành cùng bạn trên mọi nẻo đường.</p>
                            <ul>
                                <li class="white"><strong>Hotline:</strong> +84 123 456 789</li>
                                <li class="white"><strong>Email:</strong> info@Travelin.com</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                         <div class="footer-links">
                            <h3 class="white">Liên Kết Nhanh</h3>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                                <li><a href="${pageContext.request.contextPath}/tours">Danh Sách Tour</a></li>
                                <li><a href="${pageContext.request.contextPath}/blogs">Tin Tức</a></li>
                                <li><a href="${pageContext.request.contextPath}/contact">Liên Hệ</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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

    <!-- Scripts -->
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