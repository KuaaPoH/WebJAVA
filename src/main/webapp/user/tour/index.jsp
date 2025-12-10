<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Danh Sách Tour - Travelin</title>
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
    <!-- Preloader Ends -->

    <!-- header starts -->
    <header class="main_header_area">
        <div class="header-content py-1 bg-theme">
            <div class="container d-flex align-items-center justify-content-between">
                <div class="links">
                    <ul>
                        <li><a href="#" class="white"><i class="icon-calendar white"></i> Thứ Năm, 10 Tháng 12, 2025</a>
                        </li>
                        <li><a href="#" class="white"><i class="icon-location-pin white"></i> Hà Nội, Việt Nam</a>
                        </li>
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
        <!-- Navigation Bar -->
        <div class="header_menu" id="header_menu">
            <nav class="navbar navbar-default">
                <div class="container">
                    <div class="navbar-flex d-flex align-items-center justify-content-between w-100 pb-3 pt-3">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="navbar-header">
                            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                                <img src="${pageContext.request.contextPath}/assets/travelin/images/logo.png" alt="image">
                            </a>
                        </div>
                        <!-- Collect the nav links, forms, and other content for toggling -->
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
                                <li class="search-main"><a href="#search1" class="mt_search"><i class="fa fa-search"></i></a></li>
                            </ul>
                        </div><!-- /.navbar-collapse -->  
                        <div class="register-login d-flex align-items-center">
                            <a href="#" data-bs-toggle="modal" data-bs-target="#exampleModal" class="me-3">
                                <i class="icon-user"></i> Đăng Nhập
                            </a>
                            <a href="#" class="nir-btn white">Đặt Ngay</a>
                        </div>

                        <div id="slicknav-mobile"></div>
                    </div>
                </div><!-- /.container-fluid -->
            </nav>
        </div>
        <!-- Navigation Bar Ends -->
    </header>
    <!-- header ends -->

    <!-- banner starts -->
    <section class="banner pt-10 pb-0 overflow-hidden" style="background-image:url(${pageContext.request.contextPath}/assets/travelin/images/testimonial.png);">
        <div class="container">
            <div class="banner-in">
                <div class="breadcrumb-content text-center">
                    <h1 class="mb-0 white">Danh Sách Tour</h1>
                    <nav aria-label="breadcrumb" class="d-block">
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Tours</li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </section>
    <!-- banner ends -->

    <!-- Tour Grid starts -->
    <section class="trending pt-6 pb-0">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <c:forEach items="${listT}" var="tour">
                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="trend-item rounded box-shadow">
                                    <div class="trend-image position-relative">
                                        <img src="${pageContext.request.contextPath}/assets/images/products/${tour.image != null ? tour.image : 'no-image.png'}" 
                                             alt="${tour.title}" 
                                             class="img-fluid"
                                             style="height: 250px; object-fit: cover; width: 100%;"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/trending/trending2.jpg'">
                                        <div class="color-overlay"></div>
                                    </div>
                                    <div class="trend-content p-4 pt-5 position-relative">
                                        <div class="trend-meta bg-theme white px-3 py-2 rounded">
                                            <div class="entry-author">
                                                <i class="icon-calendar"></i>
                                                <span class="fw-bold"> ${tour.timeTravel} Ngày</span>
                                            </div>
                                        </div>
                                        <h5 class="theme mb-1"><i class="flaticon-location-pin"></i> ${tour.location}</h5>
                                        <h3 class="mb-1"><a href="${pageContext.request.contextPath}/tour-detail?id=${tour.tourId}" title="${tour.title}">${tour.title}</a></h3>
                                        <div class="rating-main d-flex align-items-center pb-2">
                                            <div class="rating">
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                            </div>
                                            <span class="ms-2">(${tour.star != 0 ? tour.star : 5} Đánh giá)</span>
                                        </div>
                                        <p class=" border-b pb-2 mb-2 text-truncate" style="max-height: 50px; overflow: hidden;">${tour.description}</p>
                                        <div class="entry-meta">
                                            <div class="entry-author d-flex align-items-center">
                                                <p class="mb-0">
                                                    <span class="theme fw-bold fs-5"> 
                                                        <fmt:formatNumber value="${tour.priceSale > 0 ? tour.priceSale : tour.price}" pattern="#,###"/>₫
                                                    </span> | Người
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Tour Grid ends -->

    <!-- footer starts -->
    <footer class="pt-20 pb-4" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/background_pattern.png);">
        <div class="section-shape top-0" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/shape8.png);"></div>
        
        <div class="footer-upper pb-4">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6 col-sm-12 mb-4 pe-4">
                        <div class="footer-about">
                            <img src="${pageContext.request.contextPath}/assets/travelin/images/logo-white.png" alt="">
                            <p class="mt-3 mb-3 white">
                                Travelin - Đồng hành cùng bạn trên mọi nẻo đường. Khám phá vẻ đẹp thế giới cùng chúng tôi.
                            </p>
                            <ul>
                                <li class="white"><strong>Hotline:</strong> +84 123 456 789</li>
                                <li class="white"><strong>Địa chỉ:</strong> 123 Đường ABC, Hà Nội</li>
                                <li class="white"><strong>Email:</strong> info@Travelin.com</li>
                                <li class="white"><strong>Website:</strong> www.Travelin.com</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12 mb-4">
                        <div class="footer-links">
                            <h3 class="white">Liên Kết Nhanh</h3>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/about.html">Về Chúng Tôi</a></li>
                                <li><a href="#">Chính Sách</a></li>
                                <li><a href="#">Điều Khoản</a></li>
                                <li><a href="#">Tuyển Dụng</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-6 col-sm-12 mb-4">
                        <div class="footer-links">
                            <h3 class="white">Danh Mục</h3>
                            <ul>
                                <li><a href="#">Du Lịch</a></li>
                                <li><a href="#">Công Nghệ</a></li>
                                <li><a href="#">Phong Cách Sống</a></li>
                                <li><a href="#">Điểm Đến</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                        <div class="footer-links">
                            <h3 class="white">Đăng Ký Nhận Tin</h3>
                            <div class="newsletter-form ">
                                <p class="mb-3">Nhận thông tin khuyến mãi và tin tức du lịch mới nhất.</p>
                                <form action="#" method="get" accept-charset="utf-8"
                                    class="border-0 d-flex align-items-center">
                                    <input type="text" placeholder="Email của bạn">
                                    <button class="nir-btn ms-2">Gửi</button>
                                </form>
                            </div>
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
                    <div class="social-links">
                        <ul>
                            <li><a href="#"><i class="fab fa-facebook" aria-hidden="true"></i></a></li>
                            <li><a href="#"><i class="fab fa-twitter" aria-hidden="true"></i></a></li>
                            <li><a href="#"><i class="fab fa-instagram" aria-hidden="true"></i></a></li>
                            <li><a href="#"><i class="fab fa-linkedin" aria-hidden="true"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div id="particles-js"></div>
    </footer>
    <!-- footer ends -->

    <!-- Back to top start -->
    <div id="back-to-top">
        <a href="#"></a>
    </div>
    <!-- Back to top ends -->

    <!-- search popup -->
    <div id="search1">
        <button type="button" class="close">×</button>
        <form>
            <input type="search" value="" placeholder="Nhập từ khóa..." />
            <button type="submit" class="btn btn-primary">Tìm</button>
        </form>
    </div>

    <!-- login registration modal -->
    <div class="modal fade log-reg" id="exampleModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <div class="post-tabs">
                        <ul class="nav nav-tabs nav-pills nav-fill" id="postsTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button aria-controls="login" aria-selected="false" class="nav-link active"
                                    data-bs-target="#login" data-bs-toggle="tab" id="login-tab" role="tab"
                                    type="button">Login</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button aria-controls="register" aria-selected="true" class="nav-link"
                                    data-bs-target="#register" data-bs-toggle="tab" id="register-tab" role="tab"
                                    type="button">Register</button>
                            </li>
                        </ul>
                        <div class="tab-content blog-full" id="postsTabContent">
                            <div aria-labelledby="login-tab" class="tab-pane fade active show" id="login" role="tabpanel">
                                <div class="row">
                                    <div class="col-lg-6">
                                       <div class="blog-image rounded">
                                            <a href="#" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/trending/trending5.jpg);"></a>
                                        </div> 
                                    </div>
                                    <div class="col-lg-6">
                                        <h4 class="text-center border-b pb-2">Login</h4>
                                        <form method="post" action="#" name="contactform" id="contactform">
                                            <div class="form-group mb-2">
                                                <input type="text" name="user_name" class="form-control" id="fname" placeholder="User Name">
                                            </div>
                                            <div class="form-group mb-2">
                                                <input type="password" name="password_name" class="form-control" id="lpass" placeholder="Password">
                                            </div>
                                            <div class="comment-btn mb-2 pb-2 text-center border-b">
                                                <input type="submit" class="nir-btn w-100" id="submit" value="Login">
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div aria-labelledby="register-tab" class="tab-pane fade" id="register" role="tabpanel">
                                 <!-- Register Form -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

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