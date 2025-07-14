package controller;

import com.google.gson.Gson;
import dao.BookingDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/booking")
public class AdminBookingListServlet extends HttpServlet {
    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json;charset=UTF-8");
        List<Map<String, Object>> bookings = bookingDAO.getAllBookingsForAdmin();
        resp.getWriter().print(new Gson().toJson(bookings));
    }
}
