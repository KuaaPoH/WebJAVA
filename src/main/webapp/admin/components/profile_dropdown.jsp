<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<div id="dropdownProfile" class="w-[280px] p-4 bg-white dark:bg-neutral-700 rounded-lg shadow-lg hidden">
    <div class="flex items-center gap-4 border-b border-neutral-200 dark:border-neutral-600 pb-3">
        <img src="${pageContext.request.contextPath}/assets/images/users/${sessionScope.admin.image != null ? sessionScope.admin.image : 'default-admin.png'}" alt="image" class="w-10 h-10 object-cover rounded-full" onerror="this.src='${pageContext.request.contextPath}/assets/images/user.png'">
        <div>
            <h6 class="text-neutral-700 dark:text-neutral-200 text-lg font-bold">${sessionScope.admin.username}</h6>
            <span class="text-neutral-500 dark:text-neutral-400 text-sm">Admin</span>
        </div>
    </div>
    <ul class="py-3 px-0 flex flex-col gap-2">
        <li>
            <a href="${pageContext.request.contextPath}/admin/profile" class="flex items-center gap-2 hover:bg-neutral-100 hover:text-primary-600 rounded-md p-2 text-neutral-600 dark:text-neutral-200 dark:hover:bg-neutral-800">
                <iconify-icon icon="solar:user-circle-linear" class="text-xl"></iconify-icon>
                Profile
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/logout?role=admin" class="flex items-center gap-2 hover:bg-red-100 hover:text-red-600 rounded-md p-2 text-red-500 dark:hover:bg-neutral-800">
                <iconify-icon icon="solar:logout-linear" class="text-xl"></iconify-icon>
                Đăng Xuất
            </a>
        </li>
    </ul>
</div>
