package controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BookingDetails;
import service.BookingService;

import java.io.BufferedReader;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.List;
import java.util.stream.Collectors;
import model.Account;

@WebServlet(name = "DatSan", urlPatterns = {"/dat-san"})
public class DatSan extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("accountId") == null) {
            response.sendRedirect("login"); 
            return;
        }

        // Forward tới trang đặt sân
        request.getRequestDispatcher("/UI/calendar.jsp").forward(request, response);
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

        if (account == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\": false, \"message\": \"Chưa đăng nhập.\"}");
            return;
        }
        BookingService bookingService = new BookingService();
        boolean success = bookingService.createBooking(account, detailsList);

        if (success) {
            response.getWriter().write("{\"success\": true}");
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Không thể đặt sân.\"}");
        }
    }
}
