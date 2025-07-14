package controller;

import com.google.gson.Gson;
import dao.BookingDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/booking/details")
public class AdminBookingDetailsServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String bookingCode = req.getParameter("bookingCode");
        resp.setContentType("application/json;charset=UTF-8");

        if (bookingCode == null || bookingCode.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().print("{\"error\":\"Thiếu bookingCode\"}");
            return;
        }

        List<Map<String, Object>> details = bookingDAO.getBookingSlots(bookingCode);
        resp.getWriter().print(new Gson().toJson(details));
    }
}
