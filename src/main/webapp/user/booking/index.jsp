<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đặt Tour - Travelin</title>
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

    <!-- BreadCrumb Starts -->  
    <section class="breadcrumb-main pb-20 pt-14" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/bg/bg1.jpg);">
        <div class="section-shape section-shape1 top-inherit bottom-0" style="background-image: url(${pageContext.request.contextPath}/assets/travelin/images/shape8.png);"></div>
        <div class="breadcrumb-outer">
            <div class="container">
                <div class="breadcrumb-content text-center">
                    <h1 class="mb-3">Đặt Tour</h1>
                    <nav aria-label="breadcrumb" class="d-block">
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Đặt Tour</li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <div class="dot-overlay"></div>
    </section>
    <!-- BreadCrumb Ends --> 

    <!-- top Destination starts -->
    <section class="trending pt-6 pb-0 bg-lgrey">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mb-4">
                    <div class="payment-book">
                        <div class="booking-box">
                            <div class="customer-information mb-4">
                                <h3 class="border-b pb-2 mb-2">Thông Tin Khách Hàng</h3>
                                <form action="${pageContext.request.contextPath}/booking" method="post" class="mb-2">
                                    <input type="hidden" name="tourId" value="${tour.tourId}">
                                    <h5>Hãy cho chúng tôi biết bạn là ai</h5>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group mb-2">
                                                <label>Họ và Tên</label>
                                                <input type="text" name="fullname" placeholder="Nhập họ tên đầy đủ" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mb-2">
                                                <label>Email</label>
                                                <input type="email" name="email" placeholder="Địa chỉ Email" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mb-2">
                                                <label>Số Điện Thoại</label>
                                                <input type="text" name="phone" placeholder="Số điện thoại liên hệ" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mb-2">
                                                <label>Số Lượng Khách</label>
                                                <input type="number" id="guestInput" name="guests" min="1" value="1" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mb-2">
                                                <label>Loại Phòng</label>
                                                <select class="niceSelect" name="roomType" id="roomSelect">
                                                    <option value="Standard" data-surcharge="0">Phòng Tiêu Chuẩn (Standard)</option>
                                                    <option value="Deluxe" data-surcharge="500000">Phòng Cao Cấp (Deluxe) [+500.000₫]</option>
                                                    <option value="Suite" data-surcharge="1000000">Phòng Thượng Hạng (Suite) [+1.000.000₫]</option>
                                                    <option value="Single" data-surcharge="200000">Phòng Đơn (Single) [+200.000₫]</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mb-2">
                                                <label>Ngày Khởi Hành</label>
                                                <input type="date" name="date" required>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-group mb-2">
                                                <label>Địa Chỉ</label>
                                                <input type="text" name="address" placeholder="Địa chỉ liên hệ">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="customer-information card-information mt-4">
                                        <h3 class="border-b pb-2 mb-2">Bạn muốn thanh toán như thế nào?</h3>
                                        
                                        <!-- Hidden input to store selected payment method -->
                                        <input type="hidden" name="paymentMethod" id="paymentMethodInput" value="CreditCard">

                                        <div class="trending-topic-main">
                                            <!-- tab navs -->
                                            <ul class="nav nav-tabs nav-pills nav-fill w-50" id="postsTab1" role="tablist">
                                                <li class="nav-item me-2 ms-0" role="presentation">
                                                    <button aria-controls="card" aria-selected="true" class="nav-link active" data-bs-target="#card" data-bs-toggle="tab" id="card-tab" role="tab" type="button" onclick="setPaymentMethod('CreditCard')">Thẻ Tín Dụng / Ghi Nợ</button>
                                                </li>
                                                <li class="nav-item m-0" role="presentation">
                                                    <button aria-controls="paypal" aria-selected="false" class="nav-link" data-bs-target="#paypal" data-bs-toggle="tab" id="paypal-tab" role="tab" type="button" onclick="setPaymentMethod('Paypal')">Thanh Toán Điện Tử</button>
                                                </li>
                                            </ul>
                                            <!-- tab contents -->
                                            <div class="tab-content" id="postsTabContent1">
                                                <!-- card posts -->
                                                <div aria-labelledby="card-tab" class="tab-pane fade active show" id="card" role="tabpanel">
                                                    <div class="card-detail">
                                                        <h5 class="mb-2 border-b pb-2"><i class="fa fa-credit-card"></i> Thông Tin Thẻ</h5>
                                                        <div class="row align-items-center">
                                                            <div class="col-md-8">
                                                                <div class="row">
                                                                    <div class="col-md-6">
                                                                        <div class="form-group mb-2">
                                                                            <label>Số Thẻ (Card Number)</label>
                                                                            <input type="text" placeholder="**** **** **** ****">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="form-group mb-2">
                                                                            <label>Tên Chủ Thẻ (Card Holder)</label>
                                                                            <input type="text" placeholder="Tên in trên thẻ">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="form-group mb-2">
                                                                            <label>Ngày Hết Hạn (Expiry Date)</label>
                                                                            <input type="text" id="expiryDate" placeholder="MM/YY" maxlength="5">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <div class="form-group">
                                                                            <label>Mã Bảo Mật (CVC/CVV)</label>
                                                                            <input type="text" placeholder="CVC" maxlength="3" oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 3)">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <img src="${pageContext.request.contextPath}/assets/travelin/images/cc.png" alt="" class="rounded">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- paypal posts -->
                                                <div aria-labelledby="paypal-tab" class="tab-pane fade" id="paypal" role="tabpanel">
                                                    <div class="paypal-card">
                                                        <h5 class="mb-2 border-b pb-2"><i class="fab fa-paypal"></i> Paypal / Ví Điện Tử</h5>
                                                        <ul class="">
                                                            <li class="d-block">Để hoàn tất thanh toán an toàn, bạn sẽ được chuyển hướng đến cổng thanh toán.</li>
                                                            <li class="d-block">
                                                                <a href="#" class="theme">Thanh toán ngay <i class="fa fa-long-arrow-alt-right"></i></a>
                                                            </li>
                                                            <li class="d-block">Tổng số tiền thanh toán: <span class="fw-bold theme" id="paypalTotalDisplay">0₫</span></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="booking-terms border-t pt-3 mt-3">
                                        <div class="d-lg-flex align-items-center">
                                            <div class="form-group mb-2 w-75">
                                                <input type="checkbox" required> Bằng cách tiếp tục, bạn đồng ý với <a href="#">Điều khoản và Điều kiện.</a>
                                            </div>
                                            <button type="submit" class="nir-btn float-lg-end w-25">XÁC NHẬN ĐẶT</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4 mb-4 ps-ld-4">
                    <div class="sidebar-sticky">
                        <div class="sidebar-item bg-white rounded box-shadow overflow-hidden p-3 mb-4">
                            <h4>Chi Tiết Đặt Tour</h4>
                            <div class="trend-full border-b pb-2 mb-2">
                                <div class="row">
                                    <div class="col-lg-4 col-md-4">
                                       <div class="trend-item2 rounded">
                                            <a href="#">
                                                <img src="${pageContext.request.contextPath}/assets/images/products/${tour.image != null ? tour.image : 'no-image.png'}" alt="${tour.title}" class="img-fluid rounded" onerror="this.src='${pageContext.request.contextPath}/assets/travelin/images/trending/trending-large.jpg'">
                                            </a>
                                             <!-- <div class="color-overlay"></div> -->
                                        </div> 
                                    </div>
                                    <div class="col-lg-8 col-md-8 ps-0">
                                        <div class="trend-content position-relative">
                                            <div class="rating mb-1">
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                                <span class="fa fa-star checked"></span>
                                            </div>
                                            <h5 class="mb-1"><a href="#">${tour.title}</a></h5>
                                            <h6 class="theme mb-0"><i class="icon-location-pin"></i> ${tour.location}</h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="trend-check border-b pb-2 mb-2">
                                <p class="mb-0">Thời gian:</p>
                                <h6 class="mb-0">${tour.timeTravel} Ngày</h6>
                            </div>
                        </div>  
                        <div class="sidebar-item bg-white rounded box-shadow overflow-hidden p-3 mb-4">
                            <h4>Tóm Tắt Giá</h4>
                            <table>
                                <tbody>
                                    <tr>
                                        <td>Giá Tour (1 người)</td>
                                        <td class="theme2">
                                            <span id="basePriceDisplay"><fmt:formatNumber value="${tour.priceSale > 0 ? tour.priceSale : tour.price}" pattern="#,###"/></span>₫
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Phụ phí phòng (1 người)</td>
                                        <td class="theme2"><span id="roomSurchargeDisplay">0</span>₫</td>
                                    </tr>
                                    <tr>
                                        <td>Số lượng khách</td>
                                        <td class="theme2"><span id="guestDisplay">1</span></td>
                                    </tr>
                                </tbody>
                                <tfoot class="bg-title">
                                    <tr>
                                        <th class="font-weight-bold white">Tổng Cộng</th>
                                        <th class="font-weight-bold white">
                                            <span id="totalPriceDisplay"><fmt:formatNumber value="${tour.priceSale > 0 ? tour.priceSale : tour.price}" pattern="#,###"/></span>₫
                                        </th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- top Destination ends -->

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

    <!-- Calculation Script -->
    <script>
        function setPaymentMethod(method) {
            document.getElementById("paymentMethodInput").value = method;
        }

        $(document).ready(function() {
            // Giá gốc từ server (JSP render ra số, ví dụ 500000)
            const basePrice = ${tour.priceSale > 0 ? tour.priceSale : tour.price};
            
            function updatePrice() {
                // Lấy số lượng khách
                let guests = parseInt($("#guestInput").val());
                if (guests < 1 || isNaN(guests)) guests = 1;
                
                // Lấy phụ phí phòng
                let surcharge = 0;
                let selectedOption = $("#roomSelect option:selected");
                surcharge = parseInt(selectedOption.attr('data-surcharge')) || 0;
                
                // Tính toán
                let totalPrice = (basePrice + surcharge) * guests;
                
                // Format số tiền (thêm dấu phẩy)
                let formatter = new Intl.NumberFormat('vi-VN');
                let formattedPrice = formatter.format(totalPrice);
                
                // Cập nhật giao diện
                $("#guestDisplay").text(guests);
                $("#roomSurchargeDisplay").text(formatter.format(surcharge));
                $("#totalPriceDisplay").text(formattedPrice);
                
                // Cập nhật giá bên tab Paypal
                $("#paypalTotalDisplay").text(formattedPrice + "₫");
            }

            // Lắng nghe sự kiện thay đổi
            $("#guestInput").on('input change', updatePrice);
            $("#roomSelect").on('change', updatePrice);
            
            // Khởi chạy lần đầu
            updatePrice();

            // Auto-format Expiry Date
            const expiryInput = document.getElementById('expiryDate');
            if (expiryInput) {
                expiryInput.addEventListener('input', function(e) {
                    let input = this.value;
                    if (/\D\/$/.test(input)) input = input.substr(0, input.length - 3);
                    let values = input.split('/').map(function(v) {
                        return v.replace(/\D/g, '')
                    });
                    if (values[0]) values[0] = checkValue(values[0], 12);
                    // if (values[1]) values[1] = checkValue(values[1], 31); // Năm không cần check max
                    let output = values.map(function(v, i) {
                        return v.length == 2 && i < 1 ? v + '/' : v;
                    });
                    this.value = output.join('').substr(0, 5);
                });

                function checkValue(str, max) {
                    if (str.charAt(0) !== '0' || str == '00') {
                        var num = parseInt(str);
                        if (isNaN(num) || num <= 0 || num > max) num = str; // Logic đơn giản: nhập sai thì giữ nguyên hoặc xử lý chặt hơn tùy ý
                        // str = num > parseInt(max.toString().charAt(0)) && num.toString().length == 1 ? '0' + num : num.toString();
                    };
                    return str;
                };
            }
        });
    </script>
</body>
</html>