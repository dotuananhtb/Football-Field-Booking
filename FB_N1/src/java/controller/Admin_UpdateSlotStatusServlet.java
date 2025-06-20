package controller;

import com.google.gson.Gson;
import dao.BookingDAO;
import dao.BookingDetailsDAO;
import dao.SlotsOfFieldDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Booking;
import model.BookingDetails;
import service.BookingService;
import websocket.AppWebSocket;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import model.SlotsOfField;

@WebServlet("/admin/update-slot-status")
public class Admin_UpdateSlotStatusServlet extends HttpServlet {

    private final Gson gson = new Gson();

    static class SlotStatusRequest {

        int slotFieldId;
        String slotDate;
        int status;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // 1. Parse JSON từ request
            SlotStatusRequest data = gson.fromJson(request.getReader(), SlotStatusRequest.class);

            int slotFieldId = data.slotFieldId;
            String slotDate = data.slotDate;
            int newStatusId = data.status;

            // 2. Gọi Service để cập nhật
            BookingService bookingService = new BookingService();
            BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();
            BookingDetails bd = bookingDetailsDAO.getBySlotFieldAndDate(slotFieldId, slotDate);

            boolean updated = bookingService.updateStatus(bd.getBookingDetailsId(), newStatusId);

            // 3. Trả về phản hồi
            Map<String, Object> result = new HashMap<>();
            result.put("success", updated);
            result.put("message", updated ? "Cập nhật thành công!" : "Không thể cập nhật ca.");

            // 4. Gửi thông báo cho người dùng nếu cập nhật thành công
            if (updated && bd.getBookingId() > 0) {
                int accid = bookingDetailsDAO.getAccountIdByBookingDetailId(bd.getBookingDetailsId());
                String accountId = String.valueOf(accid);

                try {
                    System.out.println("→ Bắt đầu lấy thông tin ca sân với slotFieldId = " + bd.getSlotFieldId());

                    SlotsOfFieldDAO slotDAO = new SlotsOfFieldDAO();
                    SlotsOfField slot = slotDAO.getSlotOfFieldById(bd.getSlotFieldId());

                    if (slot == null) {
                        System.err.println("❌ Không tìm thấy slot với ID: " + bd.getSlotFieldId());
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        response.getWriter().write("{\"error\": \"Không tìm thấy thông tin ca sân.\"}");
                        return;
                    }

                    if (slot.getSlotInfo() == null) {
                        System.err.println("❌ SlotInfo null với slotFieldId = " + slot.getSlotFieldId());
                    }

                    if (slot.getField() == null) {
                        System.err.println("❌ Field null với slotFieldId = " + slot.getSlotFieldId());
                    }

                    String timeRange = slot.getSlotInfo().getStartTime() + " - " + slot.getSlotInfo().getEndTime();
                    String fieldName = slot.getField().getFieldName();
                    String dateStr = new SimpleDateFormat("dd/MM/yyyy")
                            .format(new SimpleDateFormat("yyyy-MM-dd").parse(bd.getSlotDate()));

                    System.out.println("✅ Thông tin đã lấy được:");
                    System.out.println("  - Ca: " + timeRange);
                    System.out.println("  - Sân: " + fieldName);
                    System.out.println("  - Ngày: " + dateStr);
                    System.out.println("  - Trạng thái mới: " + newStatusId);

                    String msg = switch (newStatusId) {
                        case 1 ->
                            "✅ Ca " + timeRange + " tại sân " + fieldName + " ngày " + dateStr + " của bạn đã được xác nhận.";
                        case 2 ->
                            "⌛ Ca " + timeRange + " tại sân " + fieldName + " ngày " + dateStr + " đã chuyển về trạng thái chờ xử lý.";
                        case 3 ->
                            "❌ Ca " + timeRange + " tại sân " + fieldName + " ngày " + dateStr + " đã bị huỷ bởi quản lý.";
                        default ->
                            "⚠️ Ca " + timeRange + " tại sân " + fieldName + " ngày " + dateStr + " đã được cập nhật.";
                    };

                    System.out.println("📢 Gửi socket đến accountId = " + accountId + " với message: " + msg);
                    AppWebSocket.sendToAccount(accountId, "userMessage", msg);

                } catch (Exception e) {
                    System.err.println("❌ Exception khi xử lý thông báo:");
                    e.printStackTrace();
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    response.getWriter().write("{\"error\": \"Lỗi server trong quá trình xử lý thông báo.\"}");
                }

            }

            response.getWriter().write(gson.toJson(result));

        } catch (Exception e) {
            e.printStackTrace(); // debug nếu cần
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "Lỗi xử lý dữ liệu JSON.");
            response.getWriter().write(gson.toJson(error));
        }
    }
}
