(function () {
    function initToast() {
        if (typeof Notyf === 'undefined') {
            console.error('❌ Notyf chưa được load!');
            return;
        }
        if (typeof window.showToast === 'function') {
            console.warn('⚠️ showToast đã được khởi tạo trước đó. Bỏ qua.');
            return;
        }

        const notyf = new Notyf({
            duration: 4000,
            dismissible: true,
            position: {x: 'right', y: 'top'},
            types: [
                {
                    type: 'warning',
                    background: '#ffa000', // màu cam cảnh báo
                    icon: {
                        className: 'material-icons',
                        tagName: 'i',
                        text: 'warning' // icon mặc định Notyf đề xuất
                    }
                },
                {
                    type: 'info',
                    background: '#2196f3', // xanh dương
                    icon: {
                        className: 'material-icons',
                        tagName: 'i',
                        text: 'info' // icon đề xuất cho "info"
                    }
                }
            ]
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
                case 'info':
                    notyf.open({type, message});
                    break;
                default:
                    console.warn(`❗ Unknown toast type: ${type}`);
                    notyf.open({type: 'info', message: `[${type}] ${message}`});
            }
        };

        console.log('✅ showToast đã được khởi tạo');
    }

    document.readyState === 'loading'
            ? document.addEventListener('DOMContentLoaded', initToast)
            : initToast();
})();
