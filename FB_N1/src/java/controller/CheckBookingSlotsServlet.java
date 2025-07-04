package controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import dao.BookingDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/check-booking-slots")
public class CheckBookingSlotsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String bookingCode = req.getParameter("bookingCode");
        resp.setContentType("application/json;charset=UTF-8");

        if (bookingCode == null || bookingCode.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"message\":\"Thiếu bookingCode\"}");
            return;
        }

        try {
            BookingDAO dao = new BookingDAO();
            List<Map<String, Object>> slots = dao.getBookingSlotStatus(bookingCode);

            if (slots.isEmpty()) {
                resp.getWriter().write("{\"canMatch\":false, \"message\":\"Không tìm thấy booking hoặc không có ca nào.\"}");
                return;
            }

            boolean canMatch = true;
            Integer statusPay = null;
            JsonArray invalidSlots = new JsonArray();

            for (Map<String, Object> s : slots) {
                if (statusPay == null && s.containsKey("status_pay")) {
                    statusPay = (Integer) s.get("status_pay");
                }

                int slotStatus = (int) s.get("status_checking_id");
                String statusName = (String) s.get("status_name");

                if (statusPay != null && statusPay == 1) {
                    canMatch = false;
                    // Không cần kiểm slot nữa, booking đã thanh toán
                }

                if (slotStatus == 1) { // Có ca đã đặt
                    canMatch = false;
                    invalidSlots.add(makeSlotInfo(s, "Ca đã được người khác đặt"));
                }
            }

            // Xử lý theo trạng thái thanh toán
            String payStatusDesc;
            if (statusPay == null) {
                canMatch = false;
                payStatusDesc = "Không xác định trạng thái thanh toán";
            } else if (statusPay == 1) {
                payStatusDesc = "Booking đã thanh toán trước đó";
            } else if (statusPay == 0) {
                payStatusDesc = "Chờ thanh toán tự động";
            } else if (statusPay == 2) {
                payStatusDesc = "Đặt offline chưa thanh toán";
            } else if (statusPay == -1) {
                payStatusDesc = "Booking đã huỷ do quá hạn thanh toán";
            } else {
                payStatusDesc = "Trạng thái thanh toán không xác định";
            }

            // Quy tắc nghiệp vụ: chỉ cho đối soát khi
            // - status_pay 0 hoặc 2 + slot all 4
            // - status_pay -1 + slot all 3 + chưa có slot nào bị đặt lại
            if (statusPay != null) {
                if (statusPay == 0 || statusPay == 2) {
                    for (Map<String, Object> s : slots) {
                        int slotStatus = (int) s.get("status_checking_id");
                        if (slotStatus != 4) {
                            canMatch = false;
                            invalidSlots.add(makeSlotInfo(s, "Ca không ở trạng thái chờ thanh toán"));
                        }
                    }
                } else if (statusPay == -1) {
                    for (Map<String, Object> s : slots) {
                        int slotStatus = (int) s.get("status_checking_id");
                        if (slotStatus != 3) {
                            canMatch = false;
                            invalidSlots.add(makeSlotInfo(s, "Ca không ở trạng thái đã huỷ"));
                        }
                    }
                } else {
                    // Đã thanh toán hoặc trạng thái không hợp lệ
                    canMatch = false;
                }
            }

            JsonObject result = new JsonObject();
            result.addProperty("canMatch", canMatch);
            result.addProperty("payStatus", payStatusDesc);
            if (!canMatch) {
                result.addProperty("message", "Không thể đối soát do các lý do sau.");
                result.add("invalidSlots", invalidSlots);
            } else {
                result.addProperty("message", "Tất cả điều kiện hợp lệ. Có thể đối soát.");
            }

            result.add("slots", new Gson().toJsonTree(slots));
            resp.getWriter().write(result.toString());

        } catch (SQLException e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"message\":\"Lỗi server: " + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }

    private JsonObject makeSlotInfo(Map<String, Object> s, String reason) {
        JsonObject obj = new JsonObject();
        obj.addProperty("slot_date", (String) s.get("slot_date"));
        obj.addProperty("start_time", (String) s.get("start_time"));
        obj.addProperty("end_time", (String) s.get("end_time"));
        obj.addProperty("field_name", (String) s.get("field_name"));
        obj.addProperty("current_status", (String) s.get("status_name"));
        obj.addProperty("reason", reason);
        return obj;
    }
}
