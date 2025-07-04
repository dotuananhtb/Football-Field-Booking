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
        String bookingDetailsCode;
        Integer slotFieldId;
        String slotDate;
        Integer status;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();
        try {
            SlotStatusRequest data = gson.fromJson(request.getReader(), SlotStatusRequest.class);

            if (data == null || data.status == null) {
                throw new IllegalArgumentException("Thiếu thông tin trạng thái.");
            }

            BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();
            BookingDetails bd = null;

            if (data.bookingDetailsCode != null && !data.bookingDetailsCode.trim().isEmpty()) {
                bd = bookingDetailsDAO.getByCode(data.bookingDetailsCode.trim());
            } else if (data.slotFieldId != null && data.slotDate != null && !data.slotDate.trim().isEmpty()) {
                bd = bookingDetailsDAO.getBySlotFieldAndDate(data.slotFieldId, data.slotDate.trim());
            }

            if (bd == null) {
                throw new IllegalArgumentException("Không tìm thấy ca đặt phù hợp.");
            }

            BookingService bookingService = new BookingService();
            boolean updated = bookingService.updateStatus(bd.getBookingDetailsId(), data.status);

            result.put("success", updated);
            result.put("message", updated ? "Cập nhật thành công!" : "Không thể cập nhật ca.");

            if (updated && bd.getBookingId() > 0) {
                sendSocketMessage(bd, data.status, bookingDetailsDAO);
            }

            response.getWriter().write(gson.toJson(result));

        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            result.put("success", false);
            result.put("message", e.getMessage());
            response.getWriter().write(gson.toJson(result));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            result.put("success", false);
            result.put("message", "Lỗi xử lý dữ liệu.");
            response.getWriter().write(gson.toJson(result));
        }
    }

    private void sendSocketMessage(BookingDetails bd, int newStatusId, BookingDetailsDAO bookingDetailsDAO) {
        try {
            int accid = bookingDetailsDAO.getAccountIdByBookingDetailId(bd.getBookingDetailsId());
            String accountId = String.valueOf(accid);

            SlotsOfFieldDAO slotDAO = new SlotsOfFieldDAO();
            SlotsOfField slot = slotDAO.getSlotOfFieldById(bd.getSlotFieldId());

            if (slot != null && slot.getSlotInfo() != null && slot.getField() != null) {
                String timeRange = slot.getSlotInfo().getStartTime() + " - " + slot.getSlotInfo().getEndTime();
                String fieldName = slot.getField().getFieldName();
                String dateStr = new SimpleDateFormat("dd/MM/yyyy")
                        .format(new SimpleDateFormat("yyyy-MM-dd").parse(bd.getSlotDate()));

                String msg = switch (newStatusId) {
                    case 1 -> "✅ Ca " + timeRange + " tại sân " + fieldName + " ngày " + dateStr + " của bạn đã được xác nhận.";
                    case 2 -> "⌛ Ca " + timeRange + " tại sân " + fieldName + " ngày " + dateStr + " của bạn đã chuyển về trạng thái chờ xử lý.";
                    case 3 -> "❌ Ca " + timeRange + " tại sân " + fieldName + " ngày " + dateStr + " của bạn đã bị huỷ bởi quản lý.";
                    default -> "⚠️ Ca " + timeRange + " tại sân " + fieldName + " ngày " + dateStr + " của bạn đã được cập nhật.";
                };

                AppWebSocket.sendToAccount(accountId, "userMessage", msg);
            }
        } catch (Exception e) {
            System.err.println("Lỗi khi gửi thông báo socket.");
        }
    }
}
