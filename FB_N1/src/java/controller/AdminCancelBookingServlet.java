package controller;

import com.google.gson.JsonObject;
import dao.BookingDAO;
import dao.BookingDetailsDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Set;
import util.DBContext;
import websocket.AppWebSocket;

@WebServlet("/admin/cancel-booking")
public class AdminCancelBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        String bookingCode = req.getParameter("bookingCode");

        if (bookingCode == null || bookingCode.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"success\":false,\"message\":\"Thiếu bookingCode\"}");
            return;
        }

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);

            BookingDAO bookingDAO = new BookingDAO();
            BookingDetailsDAO detailsDAO = new BookingDetailsDAO();
            bookingDAO.setConnection(conn);
            detailsDAO.setConnection(conn);

            var booking = bookingDAO.getBookingByCode(bookingCode);
            if (booking == null) {
                conn.rollback();
                resp.getWriter().write("{\"success\":false,\"message\":\"Booking không tồn tại\"}");
                return;
            }

            if (booking.getStatusPay() == 1) {
                conn.rollback();
                resp.getWriter().write("{\"success\":false,\"message\":\"Booking đã thanh toán, không thể huỷ\"}");
                return;
            }

            boolean bookingUpdated = bookingDAO.updateBookingStatusPay(booking.getBookingId(), -2);
            boolean slotsUpdated = detailsDAO.updateSlotsStatusByBooking(booking.getBookingId(), 3);

            if (!bookingUpdated || !slotsUpdated) {
                conn.rollback();
                resp.getWriter().write("{\"success\":false,\"message\":\"Huỷ booking thất bại\"}");
                return;
            }

            conn.commit();

            // Gửi socket cập nhật lịch
            Set<String> fieldIds = detailsDAO.getFieldIdsByBooking(booking.getBookingId());
            AppWebSocket.broadcastCalendarUpdates(fieldIds);

            // Gửi socket thông báo rõ cho người dùng
            JsonObject msg = new JsonObject();
            msg.addProperty("type", "booking_cancelled");
            msg.addProperty("bookingCode", booking.getBookingCode());
            msg.addProperty("message", "Booking mã [" + booking.getBookingCode() + "] đã bị huỷ bởi admin.");
            AppWebSocket.sendToAccount(String.valueOf(booking.getAccountId()), "userMessage", msg.toString());

            resp.getWriter().write("{\"success\":true,\"message\":\"Huỷ booking thành công\"}");

        } catch (SQLException e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"success\":false,\"message\":\"Lỗi server: " + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }
}
