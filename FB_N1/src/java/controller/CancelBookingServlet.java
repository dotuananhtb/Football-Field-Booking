/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingDetailsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import service.BookingService;
import util.ToastUtil;

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

        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        int bookingDetailsId = Integer.parseInt(request.getParameter("bookingDetailsId"));
        String bookingId = request.getParameter("bookingId");
        String page = request.getParameter("page");

        BookingService bookingService = new BookingService();

        // Kiểm tra có được phép hủy không
        if (!bookingService.isCancelable(bookingDetailsId)) {
            ToastUtil.setErrorToast(request, "Ca này không thể hủy vì sắp diễn ra hoặc đã qua.");
            response.sendRedirect("chi-tiet-dat-san?bookingId=" + bookingId + "&page=" + page);
            return;
        }

        boolean success = bookingService.updateStatus(bookingDetailsId, 2);

        if (success) {
            ToastUtil.setSuccessToast(request, "Yêu cầu huỷ thành công, vui lòng đợi Nhân viên xử lí!");
        } else {
            ToastUtil.setErrorToast(request, "Hủy ca thất bại! Vui lòng thử lại sau.");
        }

        response.sendRedirect("chi-tiet-dat-san?bookingId=" + bookingId + "&page=" + page);
    }

}
