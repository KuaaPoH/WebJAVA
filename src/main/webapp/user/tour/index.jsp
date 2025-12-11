<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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

    <!-- Header -->
    <jsp:include page="/user/components/header.jsp" />
    <!-- Header Ends -->

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
                <!-- Sidebar -->
                <div class="col-lg-4">
                    <div class="sidebar-sticky">
                        <div class="list-sidebar">
                            <div class="author-news mb-4 box-shadow p-4 rounded">
                                <div class="author-news-content">
                                    <div class="author-thumb mb-1">
                                        <h4 class="mb-0 border-b pb-2">Tìm Kiếm & Lọc</h4>
                                    </div>
                                    <div class="author-content">
                                        <form action="tours" method="get">
                                            <!-- Keyword -->
                                            <div class="form-group mb-2">
                                                <label class="mb-1">Từ khóa</label>
                                                <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Nhập tên tour...">
                                            </div>

                                            <!-- Categories -->
                                            <h4 class="border-b pb-2 mb-2 mt-4">Danh Mục</h4>
                                            <div class="form-group mb-2">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="category" id="cat_all" value="" ${categoryId == null ? 'checked' : ''}>
                                                    <label class="form-check-label" for="cat_all">Tất cả</label>
                                                </div>
                                                <c:forEach items="${categories}" var="c">
                                                    <div class="form-check">
                                                        <input class="form-check-input" type="radio" name="category" id="cat_${c.categoryTourId}" value="${c.categoryTourId}" ${categoryId == c.categoryTourId ? 'checked' : ''}>
                                                        <label class="form-check-label" for="cat_${c.categoryTourId}">${c.title}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>

                                            <!-- Price Range -->
                                            <h4 class="border-b pb-2 mb-2 mt-4">Khoảng Giá</h4>
                                            <div class="form-group mb-2">
                                                <label class="mb-1">Giá thấp nhất</label>
                                                <input type="number" name="minPrice" value="${minPrice}" class="form-control mb-2" placeholder="0">
                                                
                                                <label class="mb-1">Giá cao nhất</label>
                                                <input type="number" name="maxPrice" value="${maxPrice}" class="form-control" placeholder="10,000,000">
                                            </div>

                                            <button type="submit" class="nir-btn w-100 mt-3">Áp Dụng Lọc</button>
                                            <a href="tours" class="btn btn-link w-100 mt-1 text-center">Xóa Lọc</a>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tour List -->
                <div class="col-lg-8">
                    <div class="row">
                        <c:if test="${empty listT}">
                            <div class="col-12 text-center">
                                <h3>Không tìm thấy tour nào phù hợp!</h3>
                                <p>Vui lòng thử lại với các tiêu chí tìm kiếm khác.</p>
                            </div>
                        </c:if>

                        <c:forEach items="${listT}" var="tour">
                            <div class="col-lg-6 col-md-6 mb-4">
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

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="col-lg-12">
                                <div class="pagination-main text-center">
                                    <ul class="pagination justify-content-center">
                                        <c:if test="${currentPage > 1}">
                                            <li><a href="tours?page=${currentPage - 1}&keyword=${keyword}&category=${categoryId}&minPrice=${minPrice}&maxPrice=${maxPrice}"><i class="fa fa-angle-left"></i></a></li>
                                        </c:if>
                                        
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="${currentPage == i ? 'active' : ''}">
                                                <a href="tours?page=${i}&keyword=${keyword}&category=${categoryId}&minPrice=${minPrice}&maxPrice=${maxPrice}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        
                                        <c:if test="${currentPage < totalPages}">
                                            <li><a href="tours?page=${currentPage + 1}&keyword=${keyword}&category=${categoryId}&minPrice=${minPrice}&maxPrice=${maxPrice}"><i class="fa fa-angle-right"></i></a></li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                        </c:if>
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