/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.BookingDAO;
import dao.BookingDetailsDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.BookingDetailsDTO;

/**
 *
 * @author Đỗ Tuấn Anh
 */
@WebServlet(name = "BookingDetailsServlet", urlPatterns = {"/chi-tiet-dat-san"})
public class BookingDetailsServlet extends HttpServlet {

    private static final int PAGE_SIZE = 4; // số dòng mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Account account = (session != null) ? (Account) session.getAttribute("account") : null;

        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        String bookingIdParam = request.getParameter("bookingId");
        String pageParam = request.getParameter("page");

        int bookingId;
        int page = 1;

        try {
            bookingId = Integer.parseInt(bookingIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("lich-su-dat-san");
            return;
        }

        if (pageParam != null && pageParam.matches("\\d+")) {
            page = Integer.parseInt(pageParam);
        }

        int accountId = account.getAccountId();

        BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();

        // Danh sách chi tiết có phân trang
        List<BookingDetailsDTO> details = bookingDetailsDAO.getBookingDetailsByBookingIdPaging(bookingId, accountId, page, PAGE_SIZE);
        int totalDetails = bookingDetailsDAO.countBookingDetails(bookingId, accountId);
        int totalPages = (int) Math.ceil((double) totalDetails / PAGE_SIZE);

        // Đẩy dữ liệu sang JSP
        request.setAttribute("bookingId", bookingId);
        request.setAttribute("details", details);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("UI/lichsuChiTiet.jsp").forward(request, response);
    }
}
