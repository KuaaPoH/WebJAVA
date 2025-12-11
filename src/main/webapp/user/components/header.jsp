<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                                <li><a href="${pageContext.request.contextPath}/tours">Tours</a></li>
                                <li><a href="${pageContext.request.contextPath}/blogs">Tin Tức</a></li>
                                <li><a href="${pageContext.request.contextPath}/contact">Liên Hệ</a></li>
                            </ul>
                        </div><!-- /.navbar-collapse -->  
                        
                        <div class="register-login d-flex align-items-center">
                            <c:if test="${sessionScope.user == null}">
                                <a href="${pageContext.request.contextPath}/login" class="me-3">
                                    <i class="icon-user"></i> Đăng Nhập
                                </a>
                                <a href="${pageContext.request.contextPath}/register" class="me-3">
                                    <i class="icon-user"></i> Đăng Ký
                                </a>
                            </c:if>
                            <c:if test="${sessionScope.user != null}">
                                <a href="${pageContext.request.contextPath}/profile" class="me-3 d-flex align-items-center text-decoration-none text-dark">
                                    <img src="${pageContext.request.contextPath}/assets/images/users/${sessionScope.user.avatar}" 
                                         alt="avatar" 
                                         class="rounded-circle me-2" 
                                         style="width: 30px; height: 30px; object-fit: cover;"
                                         onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/reviewer/1.jpg'">
                                    <span class="fw-bold">Xin chào, ${sessionScope.user.username}</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/logout?role=user" class="me-3 text-danger">
                                    <i class="icon-logout"></i>
                                </a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/tours" class="nir-btn white">Đặt Ngay</a>
                        </div>

                        <div id="slicknav-mobile"></div>
                    </div>
                </div><!-- /.container-fluid -->
            </nav>
        </div>
        <!-- Navigation Bar Ends -->
    </header>
    <!-- header ends -->
