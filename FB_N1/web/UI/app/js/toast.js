const notyf = new Notyf({
    duration: 4000,
    dismissible: true,
    position: { x: 'right', y: 'top' }
});

function showToast(type, message) {
    if (!type || !message) return;

    switch (type) {
        case 'success':
            notyf.success(message);
            break;
        case 'error':
            notyf.error(message);
            break;
        case 'warning':
            notyf.open({ type: 'warning', message });
            break;
        case 'info':
            notyf.open({ type: 'info', message });
            break;
        default:
            notyf.open({ type: type, message });
            break;
    }
}

