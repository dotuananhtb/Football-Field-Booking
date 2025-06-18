// toast.js

(function () {
    function initToast() {
        if (typeof Notyf === 'undefined') {
            console.error("❌ Notyf chưa được load!");
            return;
        }

        // Nếu showToast đã tồn tại thì không tạo lại
        if (typeof window.showToast === 'function') {
            console.warn("⚠️ showToast đã được khởi tạo trước đó. Bỏ qua.");
            return;
        }

        const notyf = new Notyf({
            duration: 4000,
            dismissible: true,
            position: {x: 'right', y: 'top'}
        });

        window.showToast = function (type, message) {
            if (!type || !message)
                return;

            switch (type) {
                case 'success':
                    notyf.success(message);
                    break;
                case 'error':
                    notyf.error(message);
                    break;
                case 'warning':
                    notyf.open({type: 'warning', message});
                    break;
                case 'info':
                    notyf.open({type: 'info', message});
                    break;
                default:
                    notyf.open({type, message});
            }
        };

        console.log("✅ showToast đã được khởi tạo");
    }

    // Đảm bảo Notyf được load xong trước khi khởi tạo
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initToast);
    } else {
        initToast();
    }
})();
