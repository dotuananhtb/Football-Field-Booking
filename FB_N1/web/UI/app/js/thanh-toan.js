console.log("✅ thanh-toan.js loaded");

(function () {
    const body = document.body;
    const accountId = body.getAttribute("data-account-id");
    const roleId = body.getAttribute("data-role-id");
    const fieldId = 0;

    if (!accountId || !roleId || parseInt(accountId) <= 0 || parseInt(roleId) <= 0) {
        console.warn("⚠️ Thiếu accountId hoặc roleId. Không mở WebSocket thanh toán.");
        return;
    }

    const wsUrl = `ws://${location.host}/FB_N1/ws/app?accountId=${accountId}&roleId=${roleId}&fieldId=${fieldId}`;
    const socket = new WebSocket(wsUrl);

    socket.onopen = () => {
        console.log("✅ WebSocket đã kết nối.");
    };

    socket.onmessage = function (event) {
        try {
            const data = JSON.parse(event.data);

            if (data.type === "pay_success") {
                showSuccessRedirectDialog({
                    title: "🎉 Thanh toán thành công!",
                    message: data.message || "Cảm ơn bạn đã sử dụng dịch vụ.",
                    redirectUrl: "/FB_N1/home",
                    confirmText: "🏠 Về trang chủ"
                });

            }

            if (data.type === "refreshCalendar") {
//                showToast_sweetalert("🗓️ Lịch sân đã được cập nhật!", "info");
            }

        } catch (e) {
            console.error("❌ Lỗi phân tích WebSocket:", e);
        }
    };

    socket.onerror = function (error) {
        console.error("❌ WebSocket lỗi:", error);
    };

    socket.onclose = function () {
        console.warn("🔌 WebSocket đã đóng.");
    };
})();
