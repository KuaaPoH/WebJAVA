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

    <jsp:include page="/user/components/header.jsp" />

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

                            <!-- MAP -->
                            <div id="single-map" class="single-map mb-4">
                                <h4>Bản Đồ</h4>
                                <div class="map rounded overflow-hidden">
                                    <div style="width: 100%">
                                        <iframe class="rounded overflow-hidden" height="400" src="https://maps.google.com/maps?width=100%25&amp;height=600&amp;hl=en&amp;q=+(Hanoi)&amp;t=&amp;z=14&amp;ie=UTF8&amp;iwloc=B&amp;output=embed"></iframe>
                                    </div>
                                </div>
                            </div>

                            <!-- REVIEWS SUMMARY -->
                            <div id="single-review" class="single-review mb-4">
                                <h4>Đánh Giá Trung Bình</h4>
                                <div class="row d-flex align-items-center">
                                    <div class="col-lg-4 col-md-4">
                                        <div class="review-box bg-title text-center py-4 p-2 rounded">
                                            <h2 class="mb-1 white"><span>${avgStar}</span>/5</h2>
                                            <h4 class="white mb-1">"Tuyệt vời"</h4>
                                            <p class="mb-0 white font-italic">Dựa trên ${reviewCount} đánh giá</p>
                                        </div>
                                    </div>
                                    <div class="col-lg-8 col-md-8">
                                        <div class="review-progress">
                                            <!-- Progress bars static for now -->
                                            <div class="progress-item mb-1">
                                                <p class="mb-0">Sạch sẽ</p>
                                                <div class="progress rounded">
                                                    <div class="progress-bar bg-theme" role="progressbar" style="width:90%"></div>
                                                </div>
                                            </div>
                                            <div class="progress-item mb-1">
                                                <p class="mb-0">Tiện nghi</p>
                                                <div class="progress rounded">
                                                    <div class="progress-bar bg-theme" role="progressbar" style="width:80%"></div>
                                                </div>
                                            </div>
                                            <div class="progress-item mb-1">
                                                <p class="mb-0">Giá cả</p>
                                                <div class="progress rounded">
                                                    <div class="progress-bar bg-theme" role="progressbar" style="width:85%"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- COMMENT LIST -->
                            <div id="single-comments" class="single-comments single-box mb-4">
                                <h5 class="border-b pb-2 mb-2">Bình Luận (${reviewCount})</h5>
                                
                                <c:if test="${empty reviews}">
                                    <p>Chưa có bình luận nào. Hãy là người đầu tiên đánh giá tour này!</p>
                                </c:if>

                                <c:forEach var="r" items="${reviews}">
                                    <div class="comment-box">
                                        <div class="comment-image">
                                            <c:choose>
                                                <c:when test="${r.image != null && r.image.startsWith('http')}">
                                                    <img src="${r.image}" alt="avatar" style="width: 90px; height: 100px; object-fit: cover;" onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/reviewer/avatar-1.jpg'">
                                                </c:when>
                                                <c:when test="${r.image != null && not empty r.image}">
                                                     <img src="${pageContext.request.contextPath}/assets/travelin/images/${r.image}" alt="avatar" style="width: 90px; height: 100px; object-fit: cover;" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/travelin/images/reviewer/avatar-1.jpg';">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/assets/travelin/images/reviewer/avatar-1.jpg" alt="avatar" style="width: 90px; height: 100px; object-fit: cover;">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="comment-content rounded">
                                            <h5 class="mb-1">${r.name != null ? r.name : 'Ẩn Danh'}</h5>
                                            <p class="comment-date mb-2 text-muted" style="position: static; float: none; display: block;"><fmt:formatDate value="${r.createdDate}" pattern="dd/MM/yyyy HH:mm"/></p>
                                            
                                            <div class="comment-rate">
                                                <div class="rating mar-right-15">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <span class="fa fa-star ${i <= r.star ? 'checked' : ''}"></span>
                                                    </c:forEach>
                                                </div>
                                            </div>    
                                            <p class="comment">${r.detail}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- ADD REVIEW FORM -->
                            <div id="single-add-review" class="single-add-review">
                                <h4>Viết Đánh Giá</h4>
                                <form action="tour-detail" method="post">
                                    <input type="hidden" name="tourId" value="${tour.tourId}">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group mb-2">
                                                <input type="text" name="name" placeholder="Tên của bạn (Để trống nếu muốn ẩn danh)">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mb-2">
                                                <input type="email" name="email" placeholder="Email (Không bắt buộc)">
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group mb-2">
                                                <label class="mb-1">Đánh giá của bạn:</label>
                                                <div class="star-rating-select">
                                                    <i class="fa fa-star" data-rating="1"></i>
                                                    <i class="fa fa-star" data-rating="2"></i>
                                                    <i class="fa fa-star" data-rating="3"></i>
                                                    <i class="fa fa-star" data-rating="4"></i>
                                                    <i class="fa fa-star" data-rating="5"></i>
                                                    <input type="hidden" name="star" id="rating-value" value="5">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group mb-2">
                                                <textarea name="detail" placeholder="Nội dung đánh giá" required></textarea>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-btn">
                                                <button type="submit" class="nir-btn">Gửi Đánh Giá</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

    <!-- Script xử lý Star Rating -->
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const stars = document.querySelectorAll('.star-rating-select .fa');
            const ratingInput = document.getElementById('rating-value');
            
            // Set default (5 star)
            stars.forEach(s => s.classList.add('checked'));

            stars.forEach(star => {
                star.style.cursor = 'pointer';
                star.style.fontSize = '20px';
                star.style.marginRight = '5px';
                
                star.addEventListener('click', function() {
                    const rating = this.getAttribute('data-rating');
                    ratingInput.value = rating;
                    
                    stars.forEach(s => {
                        if (s.getAttribute('data-rating') <= rating) {
                            s.classList.add('checked');
                            s.style.color = 'orange'; // Fallback color
                        } else {
                            s.classList.remove('checked');
                            s.style.color = '#ccc';
                        }
                    });
                });
                
                // Hover effect (Optional)
                star.addEventListener('mouseover', function() {
                    const rating = this.getAttribute('data-rating');
                    stars.forEach(s => {
                        if (s.getAttribute('data-rating') <= rating) {
                            s.style.color = 'orange';
                        } else {
                            s.style.color = '#ccc';
                        }
                    });
                });

                star.addEventListener('mouseout', function() {
                    // Reset to selected value
                    const currentRating = ratingInput.value;
                    stars.forEach(s => {
                        if (s.getAttribute('data-rating') <= currentRating) {
                            s.style.color = 'orange'; // Hoặc dùng class .checked của template
                            s.classList.add('checked');
                        } else {
                            s.style.color = '#ccc';
                            s.classList.remove('checked');
                        }
                    });
                });
            });
        });
    </script>

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
                        
                        <!-- BOOKING LINK -->
                        <div class="desc-box bg-grey p-4 rounded mb-4 text-center">
                            <h4 class="mb-2">Đặt Tour Ngay</h4>
                            <p class="mb-4">Đặt tour ngay hôm nay để giữ chỗ và nhận ưu đãi!</p>
                            <a href="${pageContext.request.contextPath}/booking-page?id=${tour.tourId}" class="nir-btn w-100">Tiến Hành Đặt Tour</a>
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