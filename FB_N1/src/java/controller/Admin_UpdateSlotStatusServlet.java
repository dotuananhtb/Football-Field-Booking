/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import dao.BookingDetailsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.HashMap;
import java.util.Map;
import model.BookingDetails;
import service.BookingService;

/**
 *
 * @author Đỗ Tuấn Anh
 */
@WebServlet("/admin/update-slot-status")
public class Admin_UpdateSlotStatusServlet extends HttpServlet {

    private final Gson gson = new Gson();

    static class SlotStatusRequest {

        int slotFieldId;
        String slotDate;
        int status;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Đọc và parse JSON request
            SlotStatusRequest data = gson.fromJson(request.getReader(), SlotStatusRequest.class);

            int slotFieldId = data.slotFieldId;
            String slotDate = data.slotDate;
            int new_statusId = data.status;
            BookingService bookingService = new BookingService();
            BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();
            BookingDetails bd = bookingDetailsDAO.getBySlotFieldAndDate(slotFieldId, slotDate);
            // TODO: Gọi DAO để cập nhật
            boolean updated = bookingService.updateStatus(bd.getBookingDetailsId(), new_statusId);

            // Phản hồi JSON
            Map<String, Object> result = new HashMap<>();
            result.put("success", updated);
            result.put("message", updated ? "Cập nhật thành công!" : "Không thể cập nhật ca.");
            String jsonResponse = gson.toJson(result);
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            Map<String, Object> error = new HashMap<>();
            error.put("success", false);
            error.put("message", "Lỗi xử lý dữ liệu JSON.");
            response.getWriter().write(gson.toJson(error));
        }
    }
}
