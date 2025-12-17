<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script>
    // Immediate Theme Check to prevent FOUC (Flash of Unstyled Content)
    (function() {
        // Check localStorage or System preference
        const savedTheme = localStorage.getItem('color-theme');
        const systemDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
        
        // If saved is dark, OR no save but system is dark -> Add dark class
        if (savedTheme === 'dark' || (!savedTheme && systemDark)) {
            document.documentElement.classList.add('dark');
            document.documentElement.setAttribute('data-theme', 'dark');
        } else {
            // Otherwise remove it
            document.documentElement.classList.remove('dark');
            document.documentElement.setAttribute('data-theme', 'light');
        }
    })();
</script>