/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import dao.BookingSlotInfoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.BookingSlotInfo;

/**
 *
 * @author Đỗ Tuấn Anh
 */
@WebServlet("/check-slot-info")
public class CheckSlotInfoServlet extends HttpServlet {

    private BookingSlotInfoDAO dao;

    @Override
    public void init() {
        dao = new BookingSlotInfoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String slotDate = request.getParameter("slotDate");
        String slotFieldIdStr = request.getParameter("slotFieldId");

        Gson gson = new Gson();
        PrintWriter out = response.getWriter();

        try {
            if (slotDate != null && slotFieldIdStr != null) {
                int slotFieldId = Integer.parseInt(slotFieldIdStr);
                BookingSlotInfo info = dao.getBySlotDateAndSlotFieldId(slotDate, slotFieldId);
                if (info != null) {
                    out.print(gson.toJson(info));
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.print("{\"message\":\"Không tìm thấy dữ liệu\"}");
                }
            } else {
                List<BookingSlotInfo> list = dao.getAllBookingSlots();
                out.print(gson.toJson(list));
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
}
