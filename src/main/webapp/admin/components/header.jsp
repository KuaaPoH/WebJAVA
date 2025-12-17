<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!-- Font Awesome for Weather Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    /* --- Scoped Styles for Header Component --- */
    .admin-header {
        background-color: #ffffff; /* Light Mode BG */
        color: #1f2937; /* Light Mode Text (Gray-800) */
        padding: 0 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #e5e7eb; /* Light Mode Border (Gray-200) */
        position: sticky;
        top: 0;
        z-index: 50;
        height: 72px;
        box-sizing: border-box;
        font-family: 'Inter', sans-serif;
    }
    
    /* Dark Mode Override */
    :is(.dark .admin-header) {
        background-color: #273142;
        color: #ffffff;
        border-bottom: 1px solid #374151;
    }

    /* Left Side */
    .header-left {
        display: flex;
        align-items: center;
        gap: 16px;
        z-index: 20;
    }

    .sidebar-toggle-btn {
        background: transparent;
        border: none;
        color: #6b7280; /* Light Mode Icon (Gray-500) */
        cursor: pointer;
        font-size: 24px;
        transition: 0.3s;
        display: flex;
        align-items: center;
    }
    .sidebar-toggle-btn:hover { color: #111827; } /* Gray-900 */
    
    :is(.dark .sidebar-toggle-btn) { color: #a0aec0; }
    :is(.dark .sidebar-toggle-btn:hover) { color: #ffffff; }

    /* Center Widget - Absolute Center */
    .header-center {
        position: absolute;
        left: 50%;
        top: 50%;
        transform: translate(-50%, -50%);
        z-index: 10;
        text-align: center;
        width: auto;
        white-space: nowrap;
    }

    /* Clock & Weather Styles */
    .time-wrapper {
        display: flex;
        flex-direction: column;
        align-items: center;
        pointer-events: auto;
    }

    .clock-text {
        font-family: monospace;
        font-size: 18px;
        font-weight: 700;
        letter-spacing: 1px;
        color: #111827; /* Light Mode Text */
        line-height: 1.2;
    }
    :is(.dark .clock-text) { color: #ffffff; }

    .extra-info-text {
        font-size: 13px;
        color: #6b7280; /* Light Mode Text */
        margin-top: 2px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        height: 20px;
        opacity: 0;
        transition: opacity 0.5s ease-in-out;
    }
    :is(.dark .extra-info-text) { color: #a0aec0; }
    .extra-info-text.show { opacity: 1; }
    
    .weather-icon {
        color: #f59e0b; /* Sun Color (Amber-500) for Light Mode */
        font-size: 14px;
    }
    :is(.dark .weather-icon) { color: #ffffff; } /* White in Dark Mode */

    /* Right Side */
    .header-right {
        display: flex;
        align-items: center;
        gap: 20px;
        z-index: 20;
    }

    .user-greeting {
        color: #6b7280;
        font-size: 14px;
        font-weight: 500;
        display: none; 
    }
    :is(.dark .user-greeting) { color: #a0aec0; }
    
    @media (min-width: 640px) {
        .user-greeting { display: block; }
    }

    .user-highlight {
        color: #111827;
        font-weight: 700;
    }
    :is(.dark .user-highlight) { color: #ffffff; }

    .theme-toggle-btn, .user-avatar-btn {
        background: #f3f4f6; /* Light Mode BG (Gray-100) */
        border: none;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: 0.3s;
        color: #6b7280;
    }
    :is(.dark .theme-toggle-btn), :is(.dark .user-avatar-btn) {
        background: #2d3748;
        color: #a0aec0;
    }

    .theme-toggle-btn:hover, .user-avatar-btn:hover {
        background: #3b82f6;
        color: #ffffff;
    }
    :is(.dark .theme-toggle-btn:hover), :is(.dark .user-avatar-btn:hover) {
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
        .admin-header { padding: 0 15px; }
        .clock-text { font-size: 16px; }
        .extra-info-text { font-size: 12px; }
        .header-center { position: relative; left: auto; top: auto; transform: none; margin: 0 10px; }
        .user-greeting { display: none; }
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

    <!-- Center: Clock & Weather Widget (Moved back to center) -->
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
    // --- CLOCK & REAL WEATHER WIDGET SCRIPT ---
    if (!window.hasInitializedClock) {
        window.hasInitializedClock = true;
        
        // Store weather data
        window.currentWeather = {
            temp: '--',
            text: 'Đang tải...',
            icon: 'fas fa-spinner fa-spin'
        };

        function updateClock() {
            const now = new Date();
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            const seconds = String(now.getSeconds()).padStart(2, '0');
            const clockEl = document.getElementById('clock');
            if(clockEl) clockEl.innerText = hours + ':' + minutes + ':' + seconds;
        }

        // Mapping WMO Weather Code to Vietnamese & Icons
        function getWeatherDetails(code) {
            // Codes from Open-Meteo
            if (code === 0) return { text: 'Trời quang', icon: 'fas fa-sun' };
            if (code >= 1 && code <= 3) return { text: 'Có mây', icon: 'fas fa-cloud-sun' };
            if (code === 45 || code === 48) return { text: 'Sương mù', icon: 'fas fa-smog' };
            if (code >= 51 && code <= 55) return { text: 'Mưa phùn', icon: 'fas fa-cloud-rain' };
            if (code >= 61 && code <= 65) return { text: 'Mưa', icon: 'fas fa-cloud-showers-heavy' };
            if (code >= 71 && code <= 77) return { text: 'Tuyết', icon: 'fas fa-snowflake' };
            if (code >= 80 && code <= 82) return { text: 'Mưa rào', icon: 'fas fa-cloud-showers-heavy' };
            if (code >= 95 && code <= 99) return { text: 'Dông', icon: 'fas fa-bolt' };
            return { text: 'Trời quang', icon: 'fas fa-sun' }; // Default
        }

        async function fetchRealWeather() {
            // Default: Vinh, Nghe An Coordinates
            const lat = 18.6733;
            const lon = 105.6924;
            const url = 'https://api.open-meteo.com/v1/forecast?latitude=' + lat + '&longitude=' + lon + '&current_weather=true';

            try {
                const response = await fetch(url);
                const data = await response.json();
                
                if (data.current_weather) {
                    const details = getWeatherDetails(data.current_weather.weathercode);
                    window.currentWeather = {
                        temp: Math.round(data.current_weather.temperature),
                        text: details.text,
                        icon: details.icon
                    };
                }
            } catch (error) {
                console.error('Weather fetch error:', error);
                // Fallback on error
                window.currentWeather = { temp: 25, text: 'Trời đẹp', icon: 'fas fa-sun' };
            }
        }

        let isShowingWeather = false;

        function toggleInfo() {
            const extraInfo = document.getElementById('extra-info');
            if(!extraInfo) return;
            
            // Fade out
            extraInfo.classList.remove('show');

            setTimeout(() => {
                if (!isShowingWeather) { 
                    // Show Date
                    const now = new Date();
                    const options = { weekday: 'long', day: 'numeric', month: 'numeric' }; 
                    try {
                        const dateStr = now.toLocaleDateString('vi-VN', options); 
                        extraInfo.innerHTML = dateStr + ' <i class="far fa-calendar-check" style="margin-left: 5px;"></i>';
                    } catch (e) {
                         extraInfo.innerHTML = now.toDateString();
                    }
                } else { 
                    // Show Real Weather
                    const w = window.currentWeather;
                    extraInfo.innerHTML = w.text + ' ' + w.temp + '&deg;C <i class="' + w.icon + ' weather-icon" style="margin-left: 5px;"></i>';
                }
                
                isShowingWeather = !isShowingWeather;
                extraInfo.classList.add('show');
            }, 500); 
        }

        function startWidgets() {
            setInterval(updateClock, 1000);
            updateClock();
            
            // Fetch weather immediately
            fetchRealWeather();
            // Refresh weather every 15 minutes
            setInterval(fetchRealWeather, 15 * 60 * 1000);

            toggleInfo();
            setInterval(toggleInfo, 4000);
        }

        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', startWidgets);
        } else {
            startWidgets();
        }
    }
</script>