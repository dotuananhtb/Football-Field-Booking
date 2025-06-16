package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
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
import util.ToastUtil;

@WebServlet(name = "Admin_DatSan", urlPatterns = {"/admin/dat-san"})
public class Admin_DatSan extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Forward tới trang đặt sân
        request.getRequestDispatcher("/admin/quanlyDatSan.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

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

        JsonObject result = new JsonObject();

        if (account == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            result.addProperty("success", false);
            result.addProperty("type", "error");
            result.addProperty("message", "⚠️ Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.");
            response.getWriter().write(result.toString());
            return;
        }

        BookingService bookingService = new BookingService();
        boolean success = bookingService.createBooking(account, detailsList);

        if (success) {
            result.addProperty("success", true);
            result.addProperty("type", "success");
            result.addProperty("message", "✅ Đặt sân thành công!");
        } else {
            result.addProperty("success", false);
            result.addProperty("type", "error");
            result.addProperty("message", "❌ Không thể đặt sân. Vui lòng thử lại!");
        }

        response.getWriter().write(result.toString());
    }

}
