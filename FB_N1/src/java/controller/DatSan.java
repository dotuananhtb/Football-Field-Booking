/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
/**
 *
 * @author Đỗ Tuấn Anh
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import dao.BookingDAO;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.BookingDetails;
import service.BookingService;

@WebServlet("/dat-san")
public class DatSan extends HttpServlet {

    private final Gson gson = new Gson();
    private final BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("UI/calendar.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            StringBuilder jsonBuffer = new StringBuilder();
            String line;
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }

            String jsonData = jsonBuffer.toString();
            System.out.println("📥 JSON nhận được từ client:");
            System.out.println(jsonData);

            // Parse JSON thành list
            Type listType = new TypeToken<List<BookingDetails>>() {
            }.getType();
            List<BookingDetails> detailsList = gson.fromJson(jsonData, listType);

            HttpSession session = request.getSession(false);
            Account acc = (Account) session.getAttribute("account");

            boolean success = bookingService.createBooking(acc, detailsList);

            if (success) {
                response.getWriter().write("{\"success\": true, \"message\": \"Đặt sân thành công.\"}");
            } else {
                // gửi thêm log cho client để xem debug
                response.getWriter().write("{\"success\": false, \"message\": \"Đặt sân thất bại. Kiểm tra chi tiết trong server log hoặc dữ liệu đầu vào.\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            String errorJson = String.format("{\"success\": false, \"message\": \"Lỗi server: %s\"}", e.getMessage());
            response.getWriter().write(errorJson);
        }
    }
}
