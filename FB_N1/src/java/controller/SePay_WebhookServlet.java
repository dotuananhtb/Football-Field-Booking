package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.BookingDAO;
import dao.PaymentDAO;
import model.Booking;
import model.Payment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.BufferedReader;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import service.BookingService;
import websocket.AppWebSocket;

@WebServlet("/sepay-webhook")
public class SePay_WebhookServlet extends HttpServlet {

    private static final String EXPECTED_API_KEY = "RT8HOQPGX5KFVEKBSEPA0B5TZWTGMIV4SIWKJQOJ2UYUCCMKGBLDJLZ9WURYNM3E";
    private final Gson gson = new Gson();
    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final BookingDAO bookingDAO = new BookingDAO();
    private final BookingService bookingService = new BookingService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xác thực API Key
//        String apiKeyHeader = request.getHeader("Authorization");
//        if (apiKeyHeader == null || !apiKeyHeader.equals(EXPECTED_API_KEY)) {
//            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
//            response.setContentType("application/json");
//            response.getWriter().write("{\"success\":false,\"message\":\"Unauthorized\"}");
//            return;
//        }

        StringBuilder jsonBuilder = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }
        }

        String rawJson = jsonBuilder.toString();
        try {
            JsonObject data = gson.fromJson(rawJson, JsonObject.class);

            String transactionDate = data.get("transactionDate").getAsString();
            String transferType = data.get("transferType").getAsString();
            double transferAmount = data.get("transferAmount").getAsDouble();
            String content = data.has("content") ? data.get("content").getAsString() : "";
            String referenceCode = data.has("referenceCode") ? data.get("referenceCode").getAsString() : "";
            String description = data.has("description") ? data.get("description").getAsString() : "";
            String gateway = data.has("gateway") ? data.get("gateway").getAsString() : "";

            Payment payment = new Payment();
            payment.setTransactionCode(referenceCode);
            payment.setTransferAmount(transferAmount);
            payment.setPayTime(transactionDate);
            payment.setPayStatus("pending");
            payment.setGateway(gateway);
            payment.setContent(content);
            payment.setDescription(description);
            payment.setRawData(rawJson);

            Booking matchedBooking = bookingDAO.findByCodeInContent(content);
            if (matchedBooking != null) {
                payment.setBookingId(matchedBooking.getBookingId());

                if (matchedBooking.getTotalAmount().compareTo(
                        java.math.BigDecimal.valueOf(transferAmount)) == 0) {
                    payment.setPayStatus("success");
                    payment.setConfirmedTime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

                    // ✅ Cập nhật trạng thái thanh toán thanh cong
                    bookingService.handlePaymentSuccess(content);

                    String accountId = String.valueOf(matchedBooking.getAccountId());
                    String message = "🎉 Thanh toán thành công cho mã đặt sân: " + matchedBooking.getBookingCode();

                    AppWebSocket.sendNotificationToAccount(accountId, message);

// Gửi socket cập nhật lịch đến các người đang xem sân đó
                    AppWebSocket.broadcastCalendarUpdate("*");
                }
            }

            paymentDAO.insert(payment);

            // Trả về đúng định dạng thành công
            response.setStatus(HttpServletResponse.SC_OK);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":true}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/plain");
        resp.getWriter().write("SePay Webhook OK");
    }
}
