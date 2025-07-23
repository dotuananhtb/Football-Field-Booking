package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import dao.AccountDAO;
import dao.EventDAO;
import dao.PostDAO;
import dao.BookingDAO;
import dao.FieldDAO;
import dao.PaymentDAO;
import dao.BookingDetailsDAO;
import model.Account;
import model.Event;
import model.Post;
import java.util.List;
import java.util.Map;
import model.Field;

@WebServlet(name = "BaoCaoChiTietServlet", urlPatterns = {"/admin/bao-cao-chi-tiet"})
public class BaoCaoChiTietServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            BookingDAO bookingDAO = new BookingDAO();
            AccountDAO accountDAO = new AccountDAO();

            // =============================
            // 1. Báo cáo chi tiết đơn đặt sân (bỏ phân trang)
            // Lấy các tham số filter từ request (ngày, sân, trạng thái, người đặt)
            // Dùng để hiển thị bảng chi tiết đơn đặt sân và phân trang ở JSP
            // =============================
            String detailFromDate = request.getParameter("detailFromDate");
            String detailToDate = request.getParameter("detailToDate");
            String detailFieldIdStr = request.getParameter("detailFieldId");
            String detailStatus = request.getParameter("detailStatus");
            String detailUser = request.getParameter("detailUser");
            if (detailUser != null) detailUser = detailUser.trim().toLowerCase();
            Integer detailFieldId = (detailFieldIdStr != null && !detailFieldIdStr.isEmpty()) ? Integer.parseInt(detailFieldIdStr) : null;
            // 1. Báo cáo chi tiết đơn đặt sân (bỏ phân trang)
            List<Map<String, Object>> bookingDetails = bookingDAO.getBookingDetailsWithFilters(
                detailFromDate, detailToDate, detailFieldId, detailStatus, detailUser
            );
            request.setAttribute("bookingDetails", bookingDetails);

            // 2. Báo cáo người dùng (có filter)
            String userKeyword = request.getParameter("userKeyword");
            String userStatus = request.getParameter("userStatus");
            String userFromDate = request.getParameter("userFromDate");
            String userToDate = request.getParameter("userToDate");
            List<Map<String, Object>> userReportList = accountDAO.getUserReportListWithFilters(userKeyword, userStatus, userFromDate, userToDate);
            request.setAttribute("userReportList", userReportList);

            // 3. Báo cáo tình trạng sử dụng từng sân (không filter)
            FieldDAO fieldDAO = new FieldDAO();
            List<Map<String, Object>> fieldUsageReportList = fieldDAO.getFieldUsageReport();
            request.setAttribute("fieldUsageReportList", fieldUsageReportList);

            // 4. Báo cáo doanh thu chi tiết 
            String payerKeyword = request.getParameter("payerKeyword");
            String paymentFromDate = request.getParameter("paymentFromDate");
            String paymentToDate = request.getParameter("paymentToDate");
            String amountFrom = request.getParameter("amountFrom");
            String amountTo = request.getParameter("amountTo");
            BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();
            List<Map<String, Object>> detailedPayments = bookingDetailsDAO.getDetailedBookingDetailsWithFilters(payerKeyword, paymentFromDate, paymentToDate, amountFrom, amountTo);
            request.setAttribute("detailedPayments", detailedPayments);

            // =============================
            // Sau khi lấy dữ liệu, forward sang trang JSP để hiển thị tất cả các báo cáo trên
            // =============================
            List<Field> fields = fieldDAO.getAllFields();
            request.setAttribute("fields", fields);
            request.getRequestDispatcher("/admin/BaoCaoChiTiet.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server: " + e.getMessage());
        }
    }
}
