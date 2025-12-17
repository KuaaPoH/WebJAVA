<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tin Tức & Blog - Travelin</title>
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
            <div id="blogBannerCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach items="${slides}" var="s" varStatus="status">
                        <div class="carousel-item ${status.first ? 'active' : ''}">
                            <section class="breadcrumb-main pb-20 pt-14" style="background-image:url(${pageContext.request.contextPath}/assets/images/${s.image}); background-size: cover; background-position: center;">
                                <div class="section-shape section-shape1 top-inherit bottom-0" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/shape8.png);"></div>
                                <div class="breadcrumb-outer">
                                    <div class="container">
                                        <div class="breadcrumb-content text-center">
                                            <h1 class="mb-1 white" style="text-shadow: 2px 2px 4px rgba(0,0,0,0.5);">Tin Tức Du Lịch</h1>
                                            <h3 class="white theme mb-3" style="text-shadow: 1px 1px 2px rgba(0,0,0,0.5);">${s.title}</h3>
                                            <nav aria-label="breadcrumb" class="d-block">
                                                <ul class="breadcrumb">
                                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                                                    <li class="breadcrumb-item active" aria-current="page">Blog</li>
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
                            <h1 class="mb-3 white">Tin Tức Du Lịch</h1>
                            <nav aria-label="breadcrumb" class="d-block">
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Blog</li>
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

    <!-- blog list starts -->
    <section class="blog blog-left pt-10 pb-10">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-md-12 col-sm-12">
                    <div class="row">
                        <c:if test="${empty blogList}">
                            <div class="col-12">
                                <p>Chưa có bài viết nào.</p>
                            </div>
                        </c:if>
                        <c:forEach items="${blogList}" var="b">
                            <div class="col-lg-6 col-md-6 col-sm-12 mb-4">
                                <div class="blog-single-item">
                                    <div class="blog-image">
                                        <a href="${pageContext.request.contextPath}/blog-detail?id=${b.blogId}">
                                            <img src="${pageContext.request.contextPath}/assets/images/blogs/${b.image}" 
                                                 alt="${b.title}" 
                                                 style="width: 100%; height: 250px; object-fit: cover;"
                                                 onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/blog/blog1.jpg'">
                                        </a>
                                    </div>
                                    <div class="blog-content">
                                        <div class="blog-date">
                                            <span class="me-3"><i class="fa fa-calendar-alt"></i> <fmt:formatDate value="${b.createdDate}" pattern="dd/MM/yyyy"/></span>
                                            <span><i class="fa fa-eye"></i> ${b.countView}</span>
                                        </div>
                                        <h3 class="title"><a href="${pageContext.request.contextPath}/blog-detail?id=${b.blogId}">${b.title}</a></h3>
                                        <p class="mb-2" style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${b.description}</p>
                                        <a href="${pageContext.request.contextPath}/blog-detail?id=${b.blogId}" class="nir-btn-outline">Đọc Tiếp</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-lg-4 col-md-12 col-sm-12">
                    <div class="sidebar-sticky">
                        <div class="list-sidebar">
                            <div class="sidebar-item mb-4">
                                <h4 class="">Tìm Kiếm</h4>
                                <div class="newsletter-form rounded overflow-hidden position-relative">
                                    <form action="#" method="get">
                                        <input type="text" placeholder="Tìm kiếm tin tức...">
                                        <input type="submit" class="nir-btn mt-2 w-100" value="Tìm Kiếm">
                                    </form>
                                </div>
                            </div>
                            <div class="sidebar-item mb-4">
                                <h4 class="">Bài Viết Mới Nhất</h4>
                                <ul class="sidebar-category">
                                    <c:forEach items="${blogList}" var="recent" end="4">
                                        <li><a href="${pageContext.request.contextPath}/blog-detail?id=${recent.blogId}">${recent.title}</a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- blog list ends -->

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