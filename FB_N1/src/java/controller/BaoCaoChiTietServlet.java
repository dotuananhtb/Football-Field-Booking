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
import java.util.List;
import java.util.Map;

@WebServlet(name = "BaoCaoChiTietServlet", urlPatterns = {"/admin/bao-cao-chi-tiet"})
public class BaoCaoChiTietServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            BookingDAO bookingDAO = new BookingDAO();
            AccountDAO accountDAO = new AccountDAO();

            // =============================
            // 1. Báo cáo chi tiết đơn đặt sân
            // Lấy các tham số filter từ request (ngày, sân, trạng thái, người đặt)
            // Dùng để hiển thị bảng chi tiết đơn đặt sân và phân trang ở JSP
            // =============================
            String detailFromDate = request.getParameter("detailFromDate");
            String detailToDate = request.getParameter("detailToDate");
            String detailFieldIdStr = request.getParameter("detailFieldId");
            String detailStatus = request.getParameter("detailStatus");
            String detailUser = request.getParameter("detailUser");
            Integer detailFieldId = (detailFieldIdStr != null && !detailFieldIdStr.isEmpty()) ? Integer.parseInt(detailFieldIdStr) : null;
            int page = 1;
            int pageSize = 10;
            try { page = Integer.parseInt(request.getParameter("page")); } catch (Exception ignored) {}
            try { pageSize = Integer.parseInt(request.getParameter("pageSize")); } catch (Exception ignored) {}
            // Đếm tổng số đơn đặt sân theo filter
            int totalBookingDetails = bookingDAO.countBookingDetailsWithFilters(
                detailFromDate, detailToDate, detailFieldId, detailStatus, detailUser
            );
            int totalPages = (int) Math.ceil((double) totalBookingDetails / pageSize);
            // Lấy danh sách đơn đặt sân theo filter và phân trang
            List<Map<String, Object>> bookingDetails = bookingDAO.getBookingDetailsWithFilters(
                detailFromDate, detailToDate, detailFieldId, detailStatus, detailUser, page, pageSize
            );
            // Đẩy sang JSP để hiển thị bảng chi tiết đơn đặt sân và phân trang
            request.setAttribute("bookingDetails", bookingDetails);
            request.setAttribute("page", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalBookingDetails", totalBookingDetails);

            // =============================
            // 2. Báo cáo người dùng
            // Lấy danh sách người dùng và phân trang, hiển thị bảng người dùng ở JSP
            // =============================
            int userPage = 1;
            int userPageSize = 10;
            try { userPage = Integer.parseInt(request.getParameter("userPage")); } catch (Exception ignored) {}
            try { userPageSize = Integer.parseInt(request.getParameter("userPageSize")); } catch (Exception ignored) {}
            int totalUserReport = accountDAO.countUserReportList();
            int totalUserPages = (int) Math.ceil((double) totalUserReport / userPageSize);
            List<Map<String, Object>> userReportListPaging = accountDAO.getUserReportListPaging(userPage, userPageSize);
            // Đẩy sang JSP để hiển thị bảng người dùng và phân trang
            request.setAttribute("userReportList", userReportListPaging);
            request.setAttribute("userPage", userPage);
            request.setAttribute("userPageSize", userPageSize);
            request.setAttribute("totalUserPages", totalUserPages);
            request.setAttribute("totalUserReport", totalUserReport);

            // =============================
            // 3. Báo cáo tình trạng sử dụng từng sân
            // Lấy danh sách số lần sử dụng từng sân và phân trang, hiển thị bảng ở JSP
            // =============================
            FieldDAO fieldDAO = new FieldDAO();
            int fieldPage = 1;
            int fieldPageSize = 10;
            try { fieldPage = Integer.parseInt(request.getParameter("fieldPage")); } catch (Exception ignored) {}
            try { fieldPageSize = Integer.parseInt(request.getParameter("fieldPageSize")); } catch (Exception ignored) {}
            int totalFieldReport = fieldDAO.countFieldUsageReport();
            int totalFieldPages = (int) Math.ceil((double) totalFieldReport / fieldPageSize);
            List<Map<String, Object>> fieldUsageReportList = fieldDAO.getFieldUsageReportPaging(fieldPage, fieldPageSize);
            // Đẩy sang JSP để hiển thị bảng sử dụng sân và phân trang
            request.setAttribute("fieldUsageReportList", fieldUsageReportList);
            request.setAttribute("fieldPage", fieldPage);
            request.setAttribute("fieldPageSize", fieldPageSize);
            request.setAttribute("totalFieldPages", totalFieldPages);
            request.setAttribute("totalFieldReport", totalFieldReport);

            // =============================
            //  4. Báo cáo doanh thu chi tiết (giao dịch)
            // Lấy danh sách giao dịch thanh toán chi tiết và phân trang, hiển thị bảng ở JSP
            // =============================
            PaymentDAO paymentDAO = new PaymentDAO();
            int detailedPaymentsPage = 1;
            int detailedPaymentsPageSize = 10;
            try { detailedPaymentsPage = Integer.parseInt(request.getParameter("detailedPaymentsPage")); } catch (Exception ignored) {}
            try { detailedPaymentsPageSize = Integer.parseInt(request.getParameter("detailedPaymentsPageSize")); } catch (Exception ignored) {}
            int detailedPaymentsTotal = paymentDAO.countDetailedPayments();
            int detailedPaymentsTotalPages = (int) Math.ceil((double) detailedPaymentsTotal / detailedPaymentsPageSize);
            List<Map<String, Object>> detailedPayments = paymentDAO.getDetailedPaymentsPaging(detailedPaymentsPage, detailedPaymentsPageSize);
            // Đẩy sang JSP để hiển thị bảng giao dịch chi tiết và phân trang
            request.setAttribute("detailedPayments", detailedPayments);
            request.setAttribute("detailedPaymentsPage", detailedPaymentsPage);
            request.setAttribute("detailedPaymentsPageSize", detailedPaymentsPageSize);
            request.setAttribute("detailedPaymentsTotalPages", detailedPaymentsTotalPages);
            request.setAttribute("detailedPaymentsTotal", detailedPaymentsTotal);

            // =============================
            //  5. Báo cáo đặt sân theo thời gian (7 ngày gần nhất, giờ cao điểm)
            // Lấy số lượng đơn đặt sân và doanh thu từng ngày trong 7 ngày gần nhất để vẽ biểu đồ ở JSP
            // =============================
            List<Map<String, Object>> bookingCountByDay7 = bookingDAO.getBookingCountByDayInLast7Days();
            List<Map<String, Object>> revenueByDay7 = bookingDAO.getRevenueByDayInLast7Days();
            request.setAttribute("bookingCountByDay7", bookingCountByDay7);
            request.setAttribute("revenueByDay7", revenueByDay7);

            // =============================
            // Sau khi lấy dữ liệu, forward sang trang JSP để hiển thị tất cả các báo cáo trên
            // =============================
            request.getRequestDispatcher("/admin/BaoCaoChiTiet.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server: " + e.getMessage());
        }
    }
}
