console.log("✅ userNoti-socket.js loaded");

let userNotiSocket;

function connectUserNotiSocket(accountId, roleId) {
    if (!accountId || !roleId) {
        console.warn("⚠️ Thiếu thông tin accountId hoặc roleId khi khởi tạo socket thông báo người dùng.");
        return;
    }

    const socketUrl = `ws://${location.host}/FB_N1/ws/app?accountId=${accountId}&roleId=${roleId}&fieldId=0`;
    console.log("🔗 WebSocket URL:", socketUrl);

    userNotiSocket = new WebSocket(socketUrl);

    userNotiSocket.onopen = () => {
        console.log("📢 User Notification Socket connected");
    };

    userNotiSocket.onmessage = (event) => {
        console.log("📨 Message from server:", event.data);
        try {
            const data = JSON.parse(event.data);
            if (data.type === "userMessage") {
                showUserNotification(data.message);
            }
        } catch (err) {
            console.error("❌ Lỗi khi xử lý message từ socket:", err);
        }
    };

    userNotiSocket.onclose = () => {
        console.warn("🔌 User Notification Socket disconnected");
    };

    userNotiSocket.onerror = (e) => {
        console.error("🔥 Socket error:", e);
    };
}

function showUserNotification(message) {
    showToast("info", message); // hoặc alert(message);
}
