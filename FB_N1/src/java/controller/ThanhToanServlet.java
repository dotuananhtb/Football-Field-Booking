package controller;

import dao.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Booking;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.DecimalFormat;

@WebServlet(name = "ThanhToanServlet", urlPatterns = {"/thanh-toan"})
public class ThanhToanServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookingCode = request.getParameter("code");
        if (bookingCode == null || bookingCode.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu mã booking.");
            return;
        }

        BookingDAO bookingDAO = new BookingDAO();
        Booking booking = bookingDAO.findByBookingCode(bookingCode);
        if (booking == null || booking.isStatusPay()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Đơn hàng này đã thanh toán hoặc không hợp lệ.");
            return;
        }
        

        // Xử lý dữ liệu QR ở đây
        BigDecimal amount = booking.getTotalAmount();
        String bankCode = "MB";
        String accountNumber = "8383626288888";
        String accountName = "DO TUAN ANH";
        String description = bookingCode;

        // Tạo link ảnh QR động
        String qrUrl = "https://img.vietqr.io/image/" + bankCode + "-" + accountNumber
                + "-print.png?amount=" + amount
                + "&addInfo=" + URLEncoder.encode(description, "UTF-8")
                + "&accountName=" + URLEncoder.encode(accountName, "UTF-8");

        DecimalFormat df = new DecimalFormat("#,###");
        String formattedAmount = df.format(booking.getTotalAmount());

        request.setAttribute("qrUrl", qrUrl);
        request.setAttribute("bookingCode", booking.getBookingCode());
        request.setAttribute("amount", formattedAmount);
        request.setAttribute("accountNumber", "8383626288888");
        request.setAttribute("accountName", "DO TUAN ANH");
        request.getRequestDispatcher("UI/thanh-toan.jsp").forward(request, response);
    }
}
