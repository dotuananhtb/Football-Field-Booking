/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingDetailsDAO;
import dao.SlotsOfFieldDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.Set;
import model.Account;
import model.BookingDetails;
import service.BookingService;
import util.ToastUtil;
import websocket.AppWebSocket;

/**
 *
 * @author Đỗ Tuấn Anh
 */
@WebServlet(name = "CancelBookingServlet", urlPatterns = {"/huy-dat-san"})
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Account account = (session != null) ? (Account) session.getAttribute("account") : null;
        BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();
        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        int bookingDetailsId = Integer.parseInt(request.getParameter("bookingDetailsId"));
        String bookingId = request.getParameter("bookingId");
        String page = request.getParameter("page");
        BookingDetails bookingDetails = bookingDetailsDAO.getBookingDetailsById(bookingDetailsId);
        BookingService bookingService = new BookingService();

        // Kiểm tra có được phép hủy không
        if (!bookingService.isCancelable(bookingDetailsId)) {
            ToastUtil.setErrorToast(request, "Ca này không thể hủy vì sắp diễn ra hoặc đã qua.");
            response.sendRedirect("chi-tiet-dat-san?bookingId=" + bookingId + "&page=" + page);
            return;
        }

        boolean success = bookingService.updateStatus(bookingDetailsId, 2);

        if (success) {
            AppWebSocket.broadcastToRole("1", "cancelRequest", "Khách hàng " + account.getUsername() + " yêu cầu huỷ ca #" + bookingDetailsId);
            Set<String> affectedFieldIds = new HashSet<>();
            SlotsOfFieldDAO slotsOfFieldDAO = new SlotsOfFieldDAO();

            String fieldId = slotsOfFieldDAO.getFieldIdBySlotFieldId(bookingDetails.getSlotFieldId());
            if (fieldId != null) {
                affectedFieldIds.add(fieldId);

            }
            AppWebSocket.broadcastCalendarUpdates(affectedFieldIds); // Gửi socket cập nhật lịch cho tất cả các sân bị ảnh hưởng
            ToastUtil.setSuccessToast(request, "Yêu cầu huỷ thành công, vui lòng đợi Nhân viên xử lí!");
        } else {
            ToastUtil.setErrorToast(request, "Hủy ca thất bại! Vui lòng thử lại sau.");
        }

        response.sendRedirect("chi-tiet-dat-san?bookingId=" + bookingId + "&page=" + page);
    }

}
