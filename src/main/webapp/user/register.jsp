<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng Ký Tài Khoản - Travelin</title>
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

    <!-- header starts -->
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
        <!-- Navigation Bar -->
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
                                <li><a href="${pageContext.request.contextPath}/tours">Tours</a></li>
                                <li><a href="${pageContext.request.contextPath}/about.html">Giới Thiệu</a></li>
                                <li><a href="${pageContext.request.contextPath}/contact">Liên Hệ</a></li>
                            </ul>
                        </div>
                        <div id="slicknav-mobile"></div>
                    </div>
                </div>
            </nav>
        </div>
    </header>

    <!-- BreadCrumb Starts -->  
    <section class="breadcrumb-main pb-20 pt-14" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/bg/bg1.jpg);">
        <div class="section-shape section-shape1 top-inherit bottom-0" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/shape8.png);"></div>
        <div class="breadcrumb-outer">
            <div class="container">
                <div class="breadcrumb-content text-center">
                    <h1 class="mb-3">Đăng Ký Tài Khoản</h1>
                    <nav aria-label="breadcrumb" class="d-block">
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Đăng Ký</li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <div class="dot-overlay"></div>
    </section>

    <!-- register section starts -->
    <section class="login-register pt-6 pb-6">
        <div class="container">
            <div class="log-main blog-full log-reg w-75 mx-auto">
                
                <!-- Alert Message -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger text-center" role="alert">
                        ${error}
                    </div>
                </c:if>
                <c:if test="${not empty message}">
                    <div class="alert alert-success text-center" role="alert">
                        ${message}
                    </div>
                </c:if>

                <div class="row justify-content-center">
                    <!-- REGISTER FORM -->
                    <div class="col-lg-6">
                        <h3 class="text-center border-b pb-2">Đăng Ký</h3>
                        <form method="post" action="${pageContext.request.contextPath}/register">
                            <div class="form-group mb-2">
                                <input type="text" name="username" class="form-control" placeholder="Tên đăng nhập" required>
                            </div>
                            <div class="form-group mb-2">
                                <input type="email" name="email" class="form-control" placeholder="Địa chỉ Email" required>
                            </div>
                            <div class="form-group mb-2">
                                <input type="password" name="password" class="form-control" placeholder="Mật khẩu" required>
                            </div>
                            <div class="form-group mb-2">
                                <input type="password" name="re_password" class="form-control" placeholder="Nhập lại mật khẩu" required>
                            </div>
                            <div class="comment-btn mb-2 pb-2 text-center border-b">
                                <input type="submit" class="nir-btn" value="Đăng Ký">
                            </div>
                            <p class="text-center">Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="theme">Đăng nhập</a></p>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- footer starts -->
    <footer class="pt-20 pb-4" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/background_pattern.png);">
        <div class="section-shape top-0" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/shape8.png);"></div>
        <div class="footer-upper pb-4">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 col-md-6 col-sm-12 mb-4 pe-4">
                        <div class="footer-about">
                            <img src="${pageContext.request.contextPath}/assets/travelin/images/logo-white.png" alt="">
                            <p class="mt-3 mb-3 white">Travelin - Đồng hành cùng bạn trên mọi nẻo đường.</p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                        <div class="footer-links">
                            <h3 class="white">Liên Kết Nhanh</h3>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                                <li><a href="${pageContext.request.contextPath}/tours">Tours</a></li>
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
    <script src="${pageContext.request.contextPath}/assets/travelin/js/custom-nav.js"></script>
</body>
</html>