package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dao.PaymentDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/ho-tro-thanh-toan")
public class Admin_HoTroThanhToan extends HttpServlet {
    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String requestedWith = req.getHeader("X-Requested-With");

        try {
            List<Map<String, Object>> payments = paymentDAO.getPendingPaymentsWithoutBooking();

            if ("XMLHttpRequest".equalsIgnoreCase(requestedWith)) {
                // Gọi từ JS/AJAX => trả JSON
                resp.setContentType("application/json;charset=UTF-8");
                String json = new Gson().toJson(payments);
                resp.getWriter().write(json);
            } else {
                // Truy cập trình duyệt => chuyển trang
                req.setAttribute("payments", payments);
                try {
                    req.getRequestDispatcher("/admin/hotrothanhtoan.jsp").forward(req, resp);
                } catch (Exception e) {
                    resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi forward: " + e.getMessage());
                }
            }
        } catch (SQLException e) {
            if ("XMLHttpRequest".equalsIgnoreCase(requestedWith)) {
                writeJson(resp, false, "Lỗi server: " + escapeJson(e.getMessage()), HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            } else {
                resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server: " + e.getMessage());
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");
        StringBuilder sb = new StringBuilder();

        try (BufferedReader reader = req.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        if (sb.length() == 0) {
            writeJson(resp, false, "Không có dữ liệu gửi lên", HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            JsonObject json = JsonParser.parseString(sb.toString()).getAsJsonObject();
            String transactionCode = getJsonString(json, "transactionCode");
            String bookingCode = getJsonString(json, "bookingCode");
            String confirmedBy = getJsonString(json, "confirmedBy");
            String description = getJsonString(json, "description", "");

            if (transactionCode == null || bookingCode == null || confirmedBy == null) {
                writeJson(resp, false, "Thiếu dữ liệu bắt buộc (transactionCode, bookingCode, confirmedBy)", HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            boolean success = paymentDAO.matchPaymentToBooking(transactionCode, bookingCode, confirmedBy, description);
            if (success) {
                writeJson(resp, true, "Đối soát thành công", HttpServletResponse.SC_OK);
            } else {
                writeJson(resp, false, "Đối soát thất bại. Vui lòng kiểm tra trạng thái booking hoặc payment.", HttpServletResponse.SC_BAD_REQUEST);
            }

        } catch (Exception e) {
            writeJson(resp, false, "Lỗi xử lý: " + escapeJson(e.getMessage()), HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private String getJsonString(JsonObject json, String key) {
        return json.has(key) && !json.get(key).isJsonNull() ? json.get(key).getAsString().trim() : null;
    }

    private String getJsonString(JsonObject json, String key, String defaultValue) {
        return json.has(key) && !json.get(key).isJsonNull() ? json.get(key).getAsString().trim() : defaultValue;
    }

    private void writeJson(HttpServletResponse resp, boolean success, String message, int status) throws IOException {
        resp.setStatus(status);
        JsonObject res = new JsonObject();
        res.addProperty("success", success);
        res.addProperty("message", message);
        resp.getWriter().write(new Gson().toJson(res));
    }

    private String escapeJson(String text) {
        return text == null ? "" : text.replace("\"", "\\\"");
    }
}
