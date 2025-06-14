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
        boolean success = bookingService.cancelBooking(bookingDetailsId);

        // Set thông báo tùy vào kết quả
        if (success) {
            ToastUtil.setSuccessToast(request, "Hủy ca thành công!");
        } else {
            ToastUtil.setErrorToast(request, "Hủy ca thất bại! Vui lòng thử lại sau.");
        }

        // Redirect lại đúng trang chi tiết với tham số bookingId và page
        response.sendRedirect("chi-tiet-dat-san?bookingId=" + bookingId + "&page=" + page);
    }
}
