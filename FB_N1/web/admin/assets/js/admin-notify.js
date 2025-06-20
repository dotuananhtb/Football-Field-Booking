let notiAdmin_socket = null;

function connectAdminSocket(accountId, roleId) {
    if (notiAdmin_socket && notiAdmin_socket.readyState === WebSocket.OPEN) {
        notiAdmin_socket.close(); // Đóng nếu đang tồn tại
    }

    notiAdmin_socket = new WebSocket(`ws://${location.host}/FB_N1/ws/app?accountId=${accountId}&roleId=${roleId}&fieldId=0`);

    notiAdmin_socket.onopen = () => {
        console.log("✅ WebSocket admin đã kết nối");
    };

    notiAdmin_socket.onclose = () => {
        console.warn("⚠️ WebSocket admin đã đóng");
    };

    notiAdmin_socket.onerror = (e) => {
        console.error("❌ WebSocket lỗi:", e);
    };

    notiAdmin_socket.onmessage = (event) => {
        const data = JSON.parse(event.data);
        console.log("📥 WebSocket nhận:", data);

        if (data.type === 'newBooking') {
            showToast("info", `🟢 ${data.message}`);
        }

        if (data.type === 'cancelRequest') {
            showToast("warning", `🔴 ${data.message}`);
        }

        // Có thể xử lý thêm các loại khác nếu cần
    };
}
