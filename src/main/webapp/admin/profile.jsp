<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <%@include file="/admin/components/theme_loader.jsp" %>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ Sơ Cá Nhân - Admin</title>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/images/favicon.png" sizes="16x16">
    <!-- google fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- remix icon font css  -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/remixicon.css">
    <!-- main css -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <!-- Iconify Font js -->
    <script src="${pageContext.request.contextPath}/assets/js/lib/iconify-icon.min.js"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* Scoped CSS from Template-1 to avoid conflicts */
        .profile-wrapper {
            /* Default Light Mode Variables */
            --bg-card: #ffffff;
            --bg-input: #f3f4f6;
            --text-main: #1f2937;
            --text-secondary: #6b7280;
            --accent-blue: #3b82f6;
            --accent-green: #10b981;
            --border-radius: 12px;
            font-family: 'Inter', sans-serif;
            color: var(--text-main);
        }

        /* Dark Mode Overrides */
        :is(.dark .profile-wrapper) {
            --bg-card: #1a1f33;
            --bg-input: #232840;
            --text-main: #ffffff;
            --text-secondary: #a0aec0;
        }

        /* Smooth Transition for Profile Components */
        .profile-wrapper * {
            transition: background-color 0.3s ease, color 0.3s ease, border-color 0.3s ease, box-shadow 0.3s ease;
        }

        /* --- ANIMATIONS --- */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes pulseBorder {
            0% { box-shadow: 0 0 0 0 rgba(59, 130, 246, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(59, 130, 246, 0); }
            100% { box-shadow: 0 0 0 0 rgba(59, 130, 246, 0); }
        }

        .profile-wrapper .profile-card-item {
            background-color: var(--bg-card); 
            border-radius: var(--border-radius); 
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
            margin-bottom: 25px;
            transition: transform 0.3s, box-shadow 0.3s;
            /* Entrance Animation */
            animation: fadeInUp 0.6s cubic-bezier(0.2, 0.8, 0.2, 1) backwards;
        }

        /* Stagger Animation delays */
        .left-col .profile-card-item:nth-child(1) { animation-delay: 0.1s; }
        .left-col .profile-card-item:nth-child(2) { animation-delay: 0.2s; }
        .right-col .profile-card-item:nth-child(1) { animation-delay: 0.3s; }
        .right-col .profile-card-item:nth-child(2) { animation-delay: 0.4s; }

        .profile-wrapper .profile-card-item:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0, 0, 0, 0.4); }

        .profile-wrapper .banner-bg {
            background: linear-gradient(135deg, #3b82f6, #8b5cf6);
            height: 100px; margin: -20px -20px 50px -20px;
            border-radius: 12px 12px 0 0;
        }

        .profile-wrapper .avatar-container {
            width: 120px; height: 120px; border-radius: 50%;
            background-color: #333; margin: -80px auto 15px auto;
            border: 5px solid var(--bg-card); position: relative;
            display: flex; align-items: center; justify-content: center;
            overflow: hidden;
            /* Avatar Pulse Animation */
            animation: pulseBorder 2s infinite;
        }
        
        .profile-wrapper .avatar-container img {
            width: 100%; height: 100%; object-fit: cover;
        }

        .profile-wrapper .student-name { font-size: 18px; font-weight: 700; margin-bottom: 5px; text-transform: uppercase; letter-spacing: 0.5px; text-align: center; }
        .profile-wrapper .student-id { color: var(--accent-blue); font-weight: 600; margin-bottom: 20px; text-align: center; display: block; }

        .profile-wrapper .section-title { font-size: 16px; font-weight: 600; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .profile-wrapper .section-title i { color: var(--accent-blue); }

        .profile-wrapper .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .profile-wrapper .form-group { margin-bottom: 15px; }
        .profile-wrapper .form-group label { display: block; color: var(--text-secondary); margin-bottom: 8px; font-size: 13px; }

        .profile-wrapper .input-wrapper {
            position: relative; background-color: var(--bg-input); border-radius: 8px;
            display: flex; align-items: center; padding: 0 15px;
            border: 1px solid transparent; transition: 0.3s;
        }
        .profile-wrapper .input-wrapper:hover { border-color: #4a5568; }
        
        /* Input Glow Effect - Only for input-wrapper */
        .profile-wrapper .input-wrapper:focus-within { 
            border-color: var(--accent-blue); 
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.3); /* Blue glow ring */
        }

        .profile-wrapper .input-wrapper i.icon-left { color: #64748b; margin-right: 10px; }
        .profile-wrapper .input-wrapper input, .profile-wrapper .input-wrapper textarea { 
            background: transparent; border: none; color: var(--text-main); 
            padding: 12px 0; width: 100%; outline: none; 
        }
        
        /* FIX: Remove inner default browser/bootstrap focus border */
        .profile-wrapper .input-wrapper input:focus, 
        .profile-wrapper .input-wrapper textarea:focus {
            outline: none !important;
            box-shadow: none !important;
            border: none !important;
        }
        
        .profile-wrapper .btn-save {
            background: var(--accent-blue); color: white; border: none;
            padding: 12px 24px; border-radius: 8px; font-weight: 600; cursor: pointer;
            transition: 0.3s; width: 100%; margin-top: 10px;
        }
        .profile-wrapper .btn-save:hover { background: #2563eb; }
        
        /* Custom File Upload */
        input[type="file"] { display: none; }
        .custom-file-upload {
            border: 1px dashed var(--text-secondary);
            display: inline-block;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 8px;
            background: var(--bg-input);
            color: var(--text-secondary);
            width: 100%;
            text-align: center;
            transition: 0.3s;
        }
        .custom-file-upload:hover {
            border-color: var(--accent-blue);
            color: var(--accent-blue);
            background: rgba(59, 130, 246, 0.1);
        }
        .file-name {
            margin-top: 5px;
            font-size: 12px;
            color: var(--accent-green);
            display: block;
            text-align: center;
            min-height: 18px;
        }

        /* Layout Grid for Profile Page */
        .profile-layout {
            display: grid; grid-template-columns: 350px 1fr; gap: 25px;
        }
        @media (max-width: 992px) {
            .profile-layout { grid-template-columns: 1fr; }
            .profile-wrapper .form-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>

<body class="dark:bg-neutral-800 bg-neutral-100 dark:text-white">

    <%@include file="/admin/components/sidebar.jsp" %>

    <main class="dashboard-main">

        <%@include file="/admin/components/header.jsp" %>

        <div class="dashboard-main-body profile-wrapper">
            
            <div class="flex flex-wrap items-center justify-between gap-2 mb-6">
                <h6 class="text-xl font-semibold mb-0 dark:text-white">Hồ Sơ Cá Nhân</h6>
                <c:if test="${not empty message}">
                    <div class="p-3 bg-green-100 text-green-700 rounded border border-green-300">
                        <i class="fas fa-check-circle"></i> ${message}
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="p-3 bg-red-100 text-red-700 rounded border border-red-300">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                    </div>
                </c:if>
            </div>

            <div class="profile-layout">
                <!-- Left Column -->
                <aside class="left-col">
                    <div class="profile-card-item">
                        <div class="banner-bg"></div>
                        <div class="avatar-container">
                            <img src="${pageContext.request.contextPath}/assets/images/users/${sessionScope.admin.image != null ? sessionScope.admin.image : 'default-admin.png'}" alt="Avatar" id="avatarPreview" onerror="this.src='${pageContext.request.contextPath}/assets/images/user.png'">
                        </div>
                        
                        <h2 class="student-name">${sessionScope.admin.fullName}</h2>
                        <span class="student-id">@${sessionScope.admin.username}</span>

                        <div style="text-align: center; margin-top: 15px;">
                            <span class="px-3 py-1 rounded-full text-xs font-medium bg-green-100 text-green-600">
                                <i class="fas fa-shield-alt"></i> Quản Trị Viên
                            </span>
                        </div>
                    </div>

                    <div class="profile-card-item">
                        <div class="section-title">Trạng thái bảo mật</div>
                        <div style="display: flex; justify-content: space-between; margin-top: 10px; color: #a0aec0; font-size: 13px;">
                            <span>Đăng nhập cuối</span>
                            <span>${sessionScope.admin.lastLogin != null ? sessionScope.admin.lastLogin : 'Vừa xong'}</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; margin-top: 10px; color: #a0aec0; font-size: 13px;">
                            <span>Role ID</span>
                            <span style="color: var(--accent-blue);">${sessionScope.admin.roleId}</span>
                        </div>
                    </div>
                </aside>

                <!-- Right Column -->
                <main class="right-col">
                    <!-- Form Update Info -->
                    <form action="profile" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="updateInfo">
                        <div class="profile-card-item">
                            <div class="section-title">
                                <span><i class="fas fa-user-edit"></i> Cập nhật thông tin</span>
                            </div>

                            <div class="form-grid">
                                <div class="form-group">
                                    <label>Tên đăng nhập (Read-only)</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-fingerprint icon-left"></i>
                                        <input type="text" value="${sessionScope.admin.username}" readonly style="cursor: not-allowed; opacity: 0.7;">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Họ và tên</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-user icon-left"></i>
                                        <input type="text" name="fullName" value="${sessionScope.admin.fullName}" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-envelope icon-left"></i>
                                        <input type="email" name="email" value="${sessionScope.admin.email}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Số điện thoại</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-phone icon-left"></i>
                                        <input type="text" name="phone" value="${sessionScope.admin.phone}">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label>Giới thiệu / Mô tả</label>
                                <div class="input-wrapper">
                                    <i class="fas fa-info-circle icon-left"></i>
                                    <textarea name="description" rows="3" style="resize: none;">${sessionScope.admin.description}</textarea>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Ảnh đại diện mới</label>
                                <label for="file-upload" class="custom-file-upload">
                                    <i class="fas fa-cloud-upload-alt"></i> Chọn ảnh từ máy tính
                                </label>
                                <input id="file-upload" type="file" name="avatarFile" accept="image/*" onchange="previewImage(this)">
                                <span id="file-name" class="file-name"></span>
                            </div>

                            <button type="submit" class="btn-save">
                                <i class="fas fa-save"></i> Lưu Thay Đổi
                            </button>
                        </div>
                    </form>
                    
                    <!-- Form Change Password -->
                    <form action="profile" method="post">
                        <input type="hidden" name="action" value="changePass">
                        <div class="profile-card-item">
                            <div class="section-title">
                                <span><i class="fas fa-key"></i> Đổi mật khẩu</span>
                            </div>
                            <div class="form-grid">
                                <div class="form-group">
                                    <label>Mật khẩu hiện tại</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-lock icon-left"></i>
                                        <input type="password" name="currentPass" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Mật khẩu mới</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-lock icon-left"></i>
                                        <input type="password" name="newPass" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Nhập lại mật khẩu mới</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-lock icon-left"></i>
                                        <input type="password" name="confirmPass" required>
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn-save" style="background: #ef4444;">
                                <i class="fas fa-shield-alt"></i> Cập Nhật Mật Khẩu
                            </button>
                        </div>
                    </form>

                </main>
            </div>
        </div>
        
        <footer class="d-footer">
            <div class="flex items-center justify-between gap-3">
                <p class="mb-0">© 2025. All Rights Reserved.</p>
            </div>
        </footer>

    </main>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/lib/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/lib/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/flowbite.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
    
    <script>
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    $('#avatarPreview').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
                
                // Hien thi ten file
                document.getElementById('file-name').innerText = "Đã chọn: " + input.files[0].name;
            }
        }



    </script>
</body>
</html>