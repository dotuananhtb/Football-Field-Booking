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
import model.Account;
import model.Event;
import model.Post;

@WebServlet(name = "BaoCaoChiTietServlet", urlPatterns = {"/admin/bao-cao-chi-tiet"})
public class BaoCaoChiTietServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            BookingDAO bookingDAO = new BookingDAO();
            AccountDAO accountDAO = new AccountDAO();
            // Lấy bộ lọc chi tiết đơn đặt sân
            String detailFromDate = request.getParameter("detailFromDate");
            String detailToDate = request.getParameter("detailToDate");
            String detailFieldIdStr = request.getParameter("detailFieldId");
            String detailStatus = request.getParameter("detailStatus");
            String detailUser = request.getParameter("detailUser");
            Integer detailFieldId = (detailFieldIdStr != null && !detailFieldIdStr.isEmpty()) ? Integer.parseInt(detailFieldIdStr) : null;
            // Phân trang cho báo cáo chi tiết đơn đặt sân
            int page = 1;
            int pageSize = 10;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (Exception ignored) {
            }
            try {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            } catch (Exception ignored) {
            }
            int totalBookingDetails = bookingDAO.countBookingDetailsWithFilters(
                    detailFromDate, detailToDate, detailFieldId, detailStatus, detailUser
            );
            int totalPages = (int) Math.ceil((double) totalBookingDetails / pageSize);
            java.util.List<java.util.Map<String, Object>> bookingDetails = bookingDAO.getBookingDetailsWithFilters(
                    detailFromDate, detailToDate, detailFieldId, detailStatus, detailUser, page, pageSize
            );
            request.setAttribute("bookingDetails", bookingDetails);
            request.setAttribute("page", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalBookingDetails", totalBookingDetails);

            // Phân trang cho báo cáo người dùng
            int userPage = 1;
            int userPageSize = 10;
            try {
                userPage = Integer.parseInt(request.getParameter("userPage"));
            } catch (Exception ignored) {
            }
            try {
                userPageSize = Integer.parseInt(request.getParameter("userPageSize"));
            } catch (Exception ignored) {
            }
            int totalUserReport = accountDAO.countUserReportList();
            int totalUserPages = (int) Math.ceil((double) totalUserReport / userPageSize);
            java.util.List<java.util.Map<String, Object>> userReportListPaging = accountDAO.getUserReportListPaging(userPage, userPageSize);
            request.setAttribute("userReportList", userReportListPaging);
            request.setAttribute("userPage", userPage);
            request.setAttribute("userPageSize", userPageSize);
            request.setAttribute("totalUserPages", totalUserPages);
            request.setAttribute("totalUserReport", totalUserReport);

            // Phân trang cho báo cáo tình trạng sử dụng từng sân
            FieldDAO fieldDAO = new FieldDAO();
            int fieldPage = 1;
            int fieldPageSize = 10;
            try {
                fieldPage = Integer.parseInt(request.getParameter("fieldPage"));
            } catch (Exception ignored) {
            }
            try {
                fieldPageSize = Integer.parseInt(request.getParameter("fieldPageSize"));
            } catch (Exception ignored) {
            }
            int totalFieldReport = fieldDAO.countFieldUsageReport();
            int totalFieldPages = (int) Math.ceil((double) totalFieldReport / fieldPageSize);
            java.util.List<java.util.Map<String, Object>> fieldUsageReportList = fieldDAO.getFieldUsageReportPaging(fieldPage, fieldPageSize);
            request.setAttribute("fieldUsageReportList", fieldUsageReportList);
            request.setAttribute("fieldPage", fieldPage);
            request.setAttribute("fieldPageSize", fieldPageSize);
            request.setAttribute("totalFieldPages", totalFieldPages);
            request.setAttribute("totalFieldReport", totalFieldReport);

            // --- Báo cáo doanh thu chi tiết (giao dịch) ---
            dao.PaymentDAO paymentDAO = new dao.PaymentDAO();
            int detailedPaymentsPage = 1;
            int detailedPaymentsPageSize = 10;
            try {
                detailedPaymentsPage = Integer.parseInt(request.getParameter("detailedPaymentsPage"));
            } catch (Exception ignored) {
            }
            try {
                detailedPaymentsPageSize = Integer.parseInt(request.getParameter("detailedPaymentsPageSize"));
            } catch (Exception ignored) {
            }
            int detailedPaymentsTotal = paymentDAO.countDetailedPayments();
            int detailedPaymentsTotalPages = (int) Math.ceil((double) detailedPaymentsTotal / detailedPaymentsPageSize);
            java.util.List<java.util.Map<String, Object>> detailedPayments = paymentDAO.getDetailedPaymentsPaging(detailedPaymentsPage, detailedPaymentsPageSize);
            request.setAttribute("detailedPayments", detailedPayments);
            request.setAttribute("detailedPaymentsPage", detailedPaymentsPage);
            request.setAttribute("detailedPaymentsPageSize", detailedPaymentsPageSize);
            request.setAttribute("detailedPaymentsTotalPages", detailedPaymentsTotalPages);
            request.setAttribute("detailedPaymentsTotal", detailedPaymentsTotal);

            // --- Báo cáo đặt sân theo thời gian (7 ngày gần nhất, giờ cao điểm) ---
            java.util.List<java.util.Map<String, Object>> bookingCountByDay7 = bookingDAO.getBookingCountByDayInLast7Days();
            java.util.List<java.util.Map<String, Object>> revenueByDay7 = bookingDAO.getRevenueByDayInLast7Days();
            request.setAttribute("bookingCountByDay7", bookingCountByDay7);
            request.setAttribute("revenueByDay7", revenueByDay7);

            // Sau khi lấy dữ liệu, setAttribute cho request
            // request.setAttribute("tenDuLieu", duLieu);
            request.getRequestDispatcher("/admin/BaoCaoChiTiet.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server: " + e.getMessage());
        }
    }
}
