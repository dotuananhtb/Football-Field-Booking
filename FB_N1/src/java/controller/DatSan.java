package controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import dao.FieldDAO;
import dao.SlotsOfFieldDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BookingDetails;
import service.BookingService;

import java.io.BufferedReader;
import java.io.IOException;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;
import model.Account;
import model.Field;
import model.SlotsOfField;

@WebServlet(name = "DatSan", urlPatterns = {"/dat-san"})
public class DatSan extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fieldIdRaw = request.getParameter("field_id");
        FieldDAO fieldDAO = new FieldDAO();
        SlotsOfFieldDAO sofDAO = new SlotsOfFieldDAO();

        if (fieldIdRaw != null) {
            try {
                int fieldId = Integer.parseInt(fieldIdRaw);
                Field field = fieldDAO.getFieldByFieldID(fieldId); // đổi tên biến cho đúng

                if (field == null) {
                    response.sendRedirect("danh-sach-san");
                    return;
                }
                // Lấy danh sách slot của sân (có thể lấy tất cả slot hoặc theo ca/time nếu cần)
                List<SlotsOfField> slots = sofDAO.getSlotsByField(fieldId); // giả sử hàm này lấy toàn bộ slot sân

                // Tính min giá, max giá, tổng số slot
                BigDecimal minPrice = null, maxPrice = null;
                for (SlotsOfField slot : slots) {
                    BigDecimal price = slot.getSlotFieldPrice();
                    if (minPrice == null || price.compareTo(minPrice) < 0) {
                        minPrice = price;
                    }
                    if (maxPrice == null || price.compareTo(maxPrice) > 0) {
                        maxPrice = price;
                    }
                }
                if (minPrice == null) {
                    minPrice = BigDecimal.ZERO;
                }
                if (maxPrice == null) {
                    maxPrice = BigDecimal.ZERO;
                }
                int totalSlots = slots.size();

                // Gán vào request để truyền xuống JSP
                request.setAttribute("minPrice", minPrice);
                request.setAttribute("maxPrice", maxPrice);
                request.setAttribute("totalSlots", totalSlots);
                request.setAttribute("field", field); // ✔ đúng
                request.setAttribute("field_id", fieldId);

                request.getRequestDispatcher("/UI/chitietsan.jsp").forward(request, response);
                return;
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("danh-sach-san");
                return;
            }
        }
        // Forward tới trang đặt sân
        request.getRequestDispatcher("/UI/chitietsan.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Đọc JSON từ request body
        BufferedReader reader = request.getReader();
        String json = reader.lines().collect(Collectors.joining());

        Gson gson = new Gson();
        Type listType = new TypeToken<List<BookingDetails>>() {
        }.getType();
        List<BookingDetails> detailsList = gson.fromJson(json, listType);

        HttpSession session = request.getSession(false);
        Account account = (session != null && session.getAttribute("account") != null)
                ? (Account) session.getAttribute("account")
                : null;

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        if (account == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\": false, \"message\": \"Chưa đăng nhập.\"}");
            return;
        }
        BookingService bookingService = new BookingService();
        model.Booking booking = bookingService.createBooking2(account, detailsList);

        if (booking != null) {
            String bookingCode = booking.getBookingCode();
            response.getWriter().write(
                    String.format("{\"success\": true, \"bookingCode\": \"%s\"}", bookingCode)
            );
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Không thể đặt sân.\"}");
        }
    }
}
