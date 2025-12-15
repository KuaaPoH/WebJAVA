<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<aside class="sidebar">
    <button type="button" class="sidebar-close-btn !mt-4">
        <iconify-icon icon="radix-icons:cross-2"></iconify-icon>
    </button>
    <div>
        <a href="${pageContext.request.contextPath}/admin/quanlytour" class="sidebar-logo">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="site logo" class="light-logo">
            <img src="${pageContext.request.contextPath}/assets/images/logo-light.png" alt="site logo" class="dark-logo">
            <img src="${pageContext.request.contextPath}/assets/images/logo-icon.png" alt="site logo" class="logo-icon">
        </a>
    </div>
    <div class="sidebar-menu-area">
        <ul class="sidebar-menu" id="sidebar-menu">
            <li class="${request.getRequestURI().endsWith("/admin") ? "active" : ""}">
                <a href="${pageContext.request.contextPath}/admin">
                    <iconify-icon icon="solar:home-smile-angle-outline" class="menu-icon"></iconify-icon>
                    <span>Trang Chủ</span>
                </a>
            </li>
            
            <li class="sidebar-menu-group-title">Quản Lý</li>
            
            <li class="${request.getRequestURI().contains("/admin/quanlytour") ? "active" : ""}">
                <a href="${pageContext.request.contextPath}/admin/quanlytour">
                    <iconify-icon icon="mingcute:storage-line" class="menu-icon"></iconify-icon>
                    <span>Quản Lý Tour</span>
                </a>
            </li>
            <li class="${request.getRequestURI().contains("/admin/quanlyblog") ? "active" : ""}">
                <a href="${pageContext.request.contextPath}/admin/quanlyblog">
                    <iconify-icon icon="icon-park-outline:writing-fluently" class="menu-icon"></iconify-icon>
                    <span>Quản Lý Blog</span>
                </a>
            </li>
            <li class="${request.getRequestURI().contains("/admin/quanlyslide") ? "active" : ""}">
                <a href="${pageContext.request.contextPath}/admin/quanlyslide">
                    <iconify-icon icon="solar:gallery-wide-bold" class="menu-icon"></iconify-icon>
                    <span>Quản Lý Banner</span>
                </a>
            </li>
            <li class="${request.getRequestURI().contains("/admin/orders") ? "active" : ""}">
                <a href="${pageContext.request.contextPath}/admin/orders">
                    <iconify-icon icon="solar:bag-bold" class="menu-icon"></iconify-icon>
                    <span>Quản Lý Đơn Hàng</span>
                </a>
            </li>
            <li class="${request.getRequestURI().contains("/admin/reviews") ? "active" : ""}">
                <a href="${pageContext.request.contextPath}/admin/reviews">
                    <iconify-icon icon="solar:star-bold" class="menu-icon"></iconify-icon>
                    <span>Đánh Giá Tour</span>
                </a>
            </li>
            <li class="${request.getRequestURI().contains("/admin/blog-reviews") ? "active" : ""}">
                <a href="${pageContext.request.contextPath}/admin/blog-reviews">
                    <iconify-icon icon="solar:chat-round-dots-bold" class="menu-icon"></iconify-icon>
                    <span>Bình Luận Blog</span>
                </a>
            </li>
            <li class="${request.getRequestURI().contains("/admin/customers") ? "active" : ""}">
                <a href="${pageContext.request.contextPath}/admin/customers">
                    <iconify-icon icon="solar:user-bold" class="menu-icon"></iconify-icon>
                    <span>Quản Lý Khách Hàng</span>
                </a>
            </li>
            <li class="${request.getRequestURI().contains("/admin/quanlylienhe") ? "active" : ""}">
                <a href="${pageContext.request.contextPath}/admin/quanlylienhe">
                    <iconify-icon icon="fluent:contact-card-20-regular" class="menu-icon"></iconify-icon>
                    <span>Quản Lý Liên Hệ</span>
                </a>
            </li>
            <li class="${request.getRequestURI().contains("/admin/quanlymenu") ? "active" : ""}">
                <a href="${pageContext.request.contextPath}/admin/quanlymenu">
                    <iconify-icon icon="mingcute:menu-line" class="menu-icon"></iconify-icon>
                    <span>Quản Lý Menu</span>
                </a>
            </li>
        </ul>
    </div>
</aside>