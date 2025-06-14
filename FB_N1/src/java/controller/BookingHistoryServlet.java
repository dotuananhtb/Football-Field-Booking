package controller;

import com.google.gson.Gson;
import dao.BookingDAO;
import dao.SaleDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Account;
import model.Booking;

import java.io.IOException;
import java.util.*;

@WebServlet(name = "BookingHistoryServlet", urlPatterns = {"/lich-su-dat-san"})
public class BookingHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Account account = (session != null) ? (Account) session.getAttribute("account") : null;

        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        int accountId = account.getAccountId();
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && pageParam.matches("\\d+")) {
            page = Integer.parseInt(pageParam);
        }

        BookingDAO bookingDAO = new BookingDAO();
        SaleDAO saleDAO = new SaleDAO();

        List<Booking> bookings = bookingDAO.getBookingsByAccountIdPaging(accountId, page);
        int totalBookings = bookingDAO.countBookingsByAccountId(accountId);
        int totalPages = (int) Math.ceil((double) totalBookings / 3);

        // Tạo map để ánh xạ bookingId → salePercent
        Map<Integer, Integer> saleMap = new HashMap<>();
        for (Booking booking : bookings) {
            int salePercent = saleDAO.getSalePercentById(booking.getSaleId());
            saleMap.put(booking.getBookingId(), salePercent);
        }

        request.setAttribute("bookingList", bookings);
        request.setAttribute("saleMap", saleMap);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("UI/lichsuDatSan.jsp").forward(request, response);
    }

}
