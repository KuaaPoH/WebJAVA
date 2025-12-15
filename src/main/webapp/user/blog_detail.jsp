<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${blog.title} - Travelin</title>
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
            <div id="blogDetailBannerCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach items="${slides}" var="s" varStatus="status">
                        <div class="carousel-item ${status.first ? 'active' : ''}">
                            <section class="breadcrumb-main pb-20 pt-14" style="background-image:url(${pageContext.request.contextPath}/assets/images/${s.image}); background-size: cover; background-position: center;">
                                <div class="section-shape section-shape1 top-inherit bottom-0" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/shape8.png);"></div>
                                <div class="breadcrumb-outer">
                                    <div class="container">
                                        <div class="breadcrumb-content text-center">
                                            <h1 class="mb-1 white" style="text-shadow: 2px 2px 4px rgba(0,0,0,0.5);">Chi Tiết Bài Viết</h1>
                                            <h3 class="white theme mb-3" style="text-shadow: 1px 1px 2px rgba(0,0,0,0.5);">${s.title}</h3>
                                            <nav aria-label="breadcrumb" class="d-block">
                                                <ul class="breadcrumb">
                                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/blogs">Blog</a></li>
                                                    <li class="breadcrumb-item active" aria-current="page">Chi Tiết</li>
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
                            <h1 class="mb-3 white">Chi Tiết Bài Viết</h1>
                            <nav aria-label="breadcrumb" class="d-block">
                                <ul class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/blogs">Blog</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Chi Tiết</li>
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

    <!-- blog detail starts -->
    <section class="blog blog-left pt-10 pb-10">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-md-12 col-sm-12">
                    <div class="blog-single">
                        <div class="blog-image mb-4">
                             <img src="${pageContext.request.contextPath}/assets/images/blogs/${blog.image}" 
                                  alt="${blog.title}" 
                                  style="width: 100%; object-fit: cover;"
                                  onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/blog/blog1.jpg'">
                        </div>
                        <div class="blog-content">
                            <div class="blog-date mb-2">
                                <span class="me-3"><i class="fa fa-calendar-alt"></i> <fmt:formatDate value="${blog.createdDate}" pattern="dd/MM/yyyy"/></span>
                                <span class="me-3"><i class="fa fa-user"></i> Admin</span>
                                <span><i class="fa fa-eye"></i> ${blog.countView} lượt xem</span>
                            </div>
                            <h3 class="title mb-3">${blog.title}</h3>
                            <div class="description mb-4 fst-italic fw-bold text-muted">
                                ${blog.description}
                            </div>
                            <div class="detail-content mb-4">
                                <c:out value="${blog.detail}" escapeXml="false" />
                            </div>
                            
                            <!-- Share Buttons (Static) -->
                            <div class="blog-share d-flex justify-content-between align-items-center mb-4 border-t border-b pt-3 pb-3">
                                <div class="tags">
                                    <strong>Tags: </strong>
                                    <span>Travel, Tours, Asia</span>
                                </div>
                                <div class="header-social">
                                    <ul>
                                        <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
                                        <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                                        <li><a href="#"><i class="fab fa-instagram"></i></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <!-- Comments Section -->
                        <div class="blog-comment mb-4">
                            <h4 class="mb-2">Bình Luận (${comments.size()})</h4>
                            <div id="comments">
                                <c:forEach items="${comments}" var="c">
                                    <div class="comment-item border-b pb-3 mb-3 d-flex">
                                        <div class="comment-image me-3">
                                            <img src="${pageContext.request.contextPath}/assets/images/users/${c.image}" 
                                                 alt="avatar" 
                                                 class="rounded-circle"
                                                 style="width: 50px; height: 50px; object-fit: cover;"
                                                 onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/reviewer/1.jpg'">
                                        </div>
                                        <div class="comment-content flex-grow-1">
                                            <h5 class="mb-0">${c.name}</h5>
                                            <span class="text-muted small"><fmt:formatDate value="${c.createdDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                                            <p class="mt-1 mb-0">${c.detail}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:if test="${empty comments}">
                                    <p class="text-muted">Chưa có bình luận nào. Hãy là người đầu tiên bình luận!</p>
                                </c:if>
                            </div>
                        </div>

                        <!-- Comment Form -->
                        <div class="blog-form">
                            <h4 class="mb-3">Để lại bình luận</h4>
                            <form action="blog-detail" method="post">
                                <input type="hidden" name="blogId" value="${blog.blogId}">
                                <div class="row">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user}">
                                            <div class="col-12 mb-3">
                                                <p>Bình luận với tên: <strong>${sessionScope.user.username}</strong></p>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="col-lg-6 mb-3">
                                                <input type="text" name="name" class="form-control" placeholder="Họ tên *" required>
                                            </div>
                                            <div class="col-lg-6 mb-3">
                                                <input type="email" name="email" class="form-control" placeholder="Email *" required>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="col-lg-12 mb-3">
                                        <textarea name="detail" rows="5" class="form-control" placeholder="Nội dung bình luận *" required></textarea>
                                    </div>
                                    <div class="col-lg-12">
                                        <button type="submit" class="nir-btn">Gửi Bình Luận</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-lg-4 col-md-12 col-sm-12">
                    <div class="sidebar-sticky">
                        <div class="list-sidebar">
                            <div class="sidebar-item mb-4">
                                <h4 class="">Bài Viết Mới Nhất</h4>
                                <ul class="sidebar-category">
                                    <c:forEach items="${recentBlogs}" var="r">
                                        <li>
                                            <div class="d-flex align-items-center mb-3">
                                                <img src="${pageContext.request.contextPath}/assets/images/blogs/${r.image}" 
                                                     alt="${r.title}" 
                                                     class="rounded me-3"
                                                     style="width: 70px; height: 70px; object-fit: cover;"
                                                     onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/blog/blog1.jpg'">
                                                <div>
                                                    <h6 class="mb-1"><a href="${pageContext.request.contextPath}/blog-detail?id=${r.blogId}">${r.title}</a></h6>
                                                    <small class="text-muted"><fmt:formatDate value="${r.createdDate}" pattern="dd/MM/yyyy"/></small>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            
                            <div class="sidebar-item mb-4">
                                <h4 class="">Tags</h4>
                                <ul class="sidebar-tags">
                                    <li><a href="#">Tour</a></li>
                                    <li><a href="#">Rental</a></li>
                                    <li><a href="#">City</a></li>
                                    <li><a href="#">Yacht</a></li>
                                    <li><a href="#">Activity</a></li>
                                    <li><a href="#">Museum</a></li>
                                    <li><a href="#">Beauty</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- blog detail ends -->

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