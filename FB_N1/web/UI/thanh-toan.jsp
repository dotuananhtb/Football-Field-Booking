<%@page import="model.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String qrUrl = (String) request.getAttribute("qrUrl");
    String bookingCode = (String) request.getAttribute("bookingCode");
    String amount = (String) request.getAttribute("amount");
    String accountNumber = (String) request.getAttribute("accountNumber");
    String accountName = (String) request.getAttribute("accountName");

    if (qrUrl == null || qrUrl.trim().isEmpty()) {
%>
<div class="alert alert-danger text-center my-5">❌ Không tìm thấy mã QR thanh toán!</div>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thanh toán đơn hàng</title>
        <link href="/FB_N1/UI/app/css/app.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <style>
            body {
                background: #f8f9fa;
                font-family: 'Segoe UI', sans-serif;
            }

            .container-box {
                max-width: 960px;
                margin: 60px auto;
            }

            .qr-img {
                max-width: 100%;
                border: 1px dashed #ccc;
                border-radius: 12px;
                padding: 10px;
                background: #fff;
            }

            .info-box code {
                background: #f1f1f1;
                padding: 4px 8px;
                border-radius: 4px;
            }

            .copy-btn {
                margin-left: 8px;
            }

            @media (max-width: 768px) {
                .row.flex-lg-row {
                    flex-direction: column !important;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="sweetalert-include.jsp" />
        <div class="container container-box">
            <div class="card shadow p-4">
                <h3 class="text-center text-primary mb-4">🔐 Vui lòng quét mã QR để thanh toán</h3>

                <div class="row flex-lg-row">
                    <div class="col-lg-6 d-flex justify-content-center align-items-center mb-4 mb-lg-0">
                        <img src="<%= qrUrl%>" alt="QR Thanh toán" class="qr-img" style="max-width: 320px;">
                    </div>

                    <div class="col-lg-6 info-box">
                        <p><strong>Số tài khoản:</strong>
                            <code id="copyStk"><%= accountNumber%></code>
                            <button class="btn btn-outline-primary btn-sm copy-btn" onclick="copyToClipboard('copyStk')">📋 Copy</button>
                        </p>
                        <p><strong>Tên tài khoản:</strong> <span class="text-dark"><%= accountName%></span></p>

                        <p><strong>Số tiền:</strong>
                            <code id="copyAmount"><%= amount%></code> VNĐ
                            <button class="btn btn-outline-success btn-sm copy-btn" onclick="copyToClipboard('copyAmount')">📋 Copy</button>
                        </p>

                        <p><strong>Nội dung chuyển khoản:</strong>
                            <code id="copyCode"><%= bookingCode%></code>
                            <button class="btn btn-outline-warning btn-sm copy-btn" onclick="copyToClipboard('copyCode')">📋 Copy</button>
                        </p>

                        <a href="/FB_N1/home" class="btn btn-outline-secondary mt-3">⬅️ Quay lại trang chủ</a>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // ✅ Hàm sao chép, luôn khả dụng
            function copyToClipboard(id) {
                const text = document.getElementById(id).textContent;
                navigator.clipboard.writeText(text).then(() => {
                    showToast_sweetalert("✅ Đã sao chép!", "success");
                }).catch(() => {
                    showToast_sweetalert("❌ Sao chép thất bại!", "error");
                });
            }
        </script>

        <%
            Account acc = (Account) session.getAttribute("account");
            int accountId = acc != null ? acc.getAccountId() : 0;
            int roleId = acc != null && acc.getUserProfile() != null ? acc.getUserProfile().getRoleId() : 0;
        %>
        <script>
            const accountId = <%= accountId%>;
            const roleId = <%= roleId%>;
            const fieldId = "*"; // Nếu trang cần cập nhật lịch sân cũng có thể đổi thành fieldId cụ thể

            if (accountId > 0 && roleId > 0) {
                const socket = new WebSocket(`ws://localhost:9999/FB_N1/ws/app?accountId=${accountId}&roleId=${roleId}&fieldId=${fieldId}`);

                socket.onopen = () => {
                    console.log("✅ WebSocket đã kết nối.");
                };

                socket.onmessage = function (event) {
                    try {
                        const data = JSON.parse(event.data);

                        // 💬 Nhận thông báo từ server



                        if (data.type === "notify") {
                            showToast_sweetalert(data.message || "🔔 Có thông báo mới", "success");
                            setTimeout(() => {
                                window.location.href = "/FB_N1/home";
                            }, 3000);
                        }

                        if (data.type === "refreshCalendar") {
                            showToast_sweetalert("🗓️ Lịch sân đã được cập nhật!", "info");
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
            } else {
                console.warn("⚠️ Không có accountId hoặc roleId, không mở WebSocket.");
            }
        </script>




    </body>
</html>
