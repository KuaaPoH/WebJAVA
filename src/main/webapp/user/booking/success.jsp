<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt Tour Thành Công - Travelin</title>
    <!-- Include CSS giống home.jsp -->
    <link href="${pageContext.request.contextPath}/assets/travelin/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/assets/travelin/css/style.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .success-box {
            text-align: center;
            padding: 50px;
            background: #f8f9fa;
            border-radius: 10px;
            margin: 50px auto;
            max-width: 600px;
        }
        .success-icon {
            color: #28a745;
            font-size: 80px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    
    <div class="container">
        <div class="success-box">
            <i class="fa fa-check-circle success-icon"></i>
            <h2 class="text-success">Thành Công!</h2>
            <p class="lead">${message}</p>
            <p>Chúng tôi sẽ liên hệ lại với bạn sớm nhất để xác nhận.</p>
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Về Trang Chủ</a>
                <a href="${pageContext.request.contextPath}/tours" class="btn btn-outline-primary ml-2">Xem Thêm Tour Khác</a>
            </div>
        </div>
    </div>

</body>
</html>