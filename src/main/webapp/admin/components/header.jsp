<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    /* --- Scoped Styles for Header Component --- */
    .admin-header {
        background-color: #273142; /* Changed to requested color */
        color: #ffffff;
        padding: 10px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #2d3748;
        position: sticky;
        top: 0;
        z-index: 50;
        min-height: 70px; /* Ensure enough height */
        font-family: 'Inter', sans-serif;
    }

    /* Left Side */
    .header-left {
        display: flex;
        align-items: center;
        gap: 16px;
        z-index: 20; /* Above center widget */
    }

    .sidebar-toggle-btn {
        background: transparent;
        border: none;
        color: #a0aec0;
        cursor: pointer;
        font-size: 24px;
        transition: 0.3s;
        display: flex;
        align-items: center;
    }
    .sidebar-toggle-btn:hover { color: #ffffff; }

    /* Center Widget - Absolute Center */
    .header-center {
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        z-index: 10; /* Below interactive elements if needed, but text needs to be visible */
        text-align: center;
        pointer-events: none; /* Let clicks pass through if overlapping empty space */
        width: auto;
        white-space: nowrap;
    }

    /* Clock & Weather Styles from Template */
    .time-wrapper {
        display: flex;
        flex-direction: column;
        align-items: center; /* Center align for the absolute widget */
        pointer-events: auto;
    }

    .clock-text {
        font-family: monospace;
        font-size: 18px;
        font-weight: 700;
        letter-spacing: 1px;
        color: #ffffff;
        line-height: 1.2;
    }

    .extra-info-text {
        font-size: 13px;
        color: #a0aec0;
        margin-top: 2px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        height: 20px;
        opacity: 0;
        transition: opacity 0.5s ease-in-out;
    }
    .extra-info-text.show { opacity: 1; }

    /* Right Side */
    .header-right {
        display: flex;
        align-items: center;
        gap: 20px;
        z-index: 20;
    }

    .user-greeting {
        color: #a0aec0;
        font-size: 14px;
        font-weight: 500;
        display: none; /* Hidden on mobile by default */
    }
    @media (min-width: 640px) {
        .user-greeting { display: block; }
    }

    .user-highlight {
        color: #ffffff;
        font-weight: 700;
    }

    .theme-toggle-btn, .user-avatar-btn {
        background: #2d3748;
        border: none;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: 0.3s;
        color: #a0aec0;
    }
    .theme-toggle-btn:hover, .user-avatar-btn:hover {
        background: #3b82f6;
        color: #ffffff;
    }
    
    .user-avatar-img {
        width: 100%;
        height: 100%;
        border-radius: 50%;
        object-fit: cover;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .admin-header { padding: 10px 15px; }
        .clock-text { font-size: 16px; }
        .extra-info-text { font-size: 12px; }
    }
</style>

<div class="admin-header">
    <!-- Left: Sidebar Toggle -->
    <div class="header-left">
        <button type="button" class="sidebar-toggle sidebar-toggle-btn">
            <iconify-icon icon="heroicons:bars-3-solid" class="icon non-active"></iconify-icon>
            <iconify-icon icon="iconoir:arrow-right" class="icon active"></iconify-icon>
        </button>
    </div>

    <!-- Center: Clock & Weather Widget -->
    <div class="header-center">
        <div class="time-wrapper">
            <div id="clock" class="clock-text">00:00:00</div>
            <div id="extra-info" class="extra-info-text">Loading...</div>
        </div>
    </div>

    <!-- Right: User Actions -->
    <div class="header-right">
        <c:if test="${not empty sessionScope.admin}">
            <span class="user-greeting">
                Xin chào, <span class="user-highlight">${sessionScope.admin.username}</span>!
            </span>
        </c:if>
        
        <!-- Theme Toggle -->
        <button type="button" id="theme-toggle" class="theme-toggle-btn">
            <span id="theme-toggle-dark-icon" class="hidden"><i class="ri-sun-line"></i></span>
            <span id="theme-toggle-light-icon" class="hidden"><i class="ri-moon-line"></i></span>
        </button>
        
        <!-- Profile Dropdown -->
        <div class="relative">
            <button data-dropdown-toggle="dropdownProfile" data-dropdown-placement="bottom-end" class="user-avatar-btn p-0" type="button">
                 <img src="${pageContext.request.contextPath}/assets/images/users/${sessionScope.admin.image != null ? sessionScope.admin.image : 'default-admin.png'}" 
                      alt="avatar" class="user-avatar-img"
                      onerror="this.src='${pageContext.request.contextPath}/assets/images/user.png'">
            </button>
            <!-- Dropdown Content -->
            <%@include file="/admin/components/profile_dropdown.jsp" %>
        </div>
    </div>
</div>

<script>
    // --- CLOCK & WEATHER WIDGET SCRIPT ---
    // Ensure script only runs once
    if (!window.hasInitializedClock) {
        window.hasInitializedClock = true;

        function updateClock() {
            const now = new Date();
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');
            const clockEl = document.getElementById('clock');
            if(clockEl) clockEl.innerText = `${hours}:${minutes}:${seconds}`;
        }

        let isShowingWeather = false; // Bắt đầu bằng false để lần đầu tiên hiện ngày tháng

        function toggleInfo() {
            const extraInfo = document.getElementById('extra-info');
            if(!extraInfo) return;
            
            // Fade out
            extraInfo.classList.remove('show');

            setTimeout(() => {
                if (!isShowingWeather) { // Nếu đang không hiển thị thời tiết (tức là lần này sẽ hiển thị ngày tháng)
                    const now = new Date();
                    const options = { weekday: 'long', day: 'numeric', month: 'numeric' }; // Format: Thứ Hai, 16/12
                    try {
                        const dateStr = now.toLocaleDateString('vi-VN', options); 
                        extraInfo.innerHTML = `${dateStr} <i class="far fa-calendar-check" style="margin-left: 5px;"></i>`;
                    } catch (e) {
                         extraInfo.innerHTML = now.toDateString();
                    }
                } else { // Lần này sẽ hiển thị thời tiết
                    extraInfo.innerHTML = `Trời quang <i class="fas fa-robot" style="color: #fff; margin-left: 5px;"></i>`;
                }
                
                isShowingWeather = !isShowingWeather; // Đảo ngược trạng thái
                
                // Fade in
                extraInfo.classList.add('show');
            }, 500); 
        }

        // Initialize when DOM is ready
        function startWidgets() {
            setInterval(updateClock, 1000);
            updateClock(); // Initial call
            
            toggleInfo(); // Initial call to show date first
            setInterval(toggleInfo, 4000); // Subsequent toggles
        }

        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', startWidgets);
        } else {
            startWidgets();
        }
    }
</script>