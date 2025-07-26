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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.BookingDetails;
import model.SlotsOfField;
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
            response.sendRedirect("dang-nhap");
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
// Lấy thông tin thời gian ca và sân
            SlotsOfFieldDAO slotsOfFieldDAO = new SlotsOfFieldDAO();
            String startTime = bookingDetails.getStartTime();
            String endTime = bookingDetails.getEndTime();
            String slotDate = null;
            try {
                slotDate = new SimpleDateFormat("dd/MM/yyyy")
                        .format(new SimpleDateFormat("yyyy-MM-dd").parse(bookingDetails.getSlotDate()));
            } catch (ParseException ex) {
                Logger.getLogger(CancelBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

// Lấy tên sân
            SlotsOfFieldDAO slotDAO = new SlotsOfFieldDAO();
            SlotsOfField slot = slotDAO.getSlotOfFieldById(bookingDetailsDAO.getBookingDetailsById(bookingDetailsId).getSlotFieldId());
            String fieldName = slot.getField().getFieldName();
// Gửi thông báo cụ thể
            String message = String.format("⚠️ Khách hàng %s yêu cầu huỷ ca %s - %s tại sân %s ngày %s.",
                    account.getUsername(),
                    startTime,
                    endTime,
                    fieldName,
                    slotDate
            );

            AppWebSocket.broadcastToRole("1", "cancelRequest", message);
            Set<String> affectedFieldIds = new HashSet<>();

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
