package controller;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@WebServlet(name = "ThongKeServlet", urlPatterns = {"/admin/thong-ke"})
public class ThongKeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Số lượng tài khoản user
            AccountDAO accountDAO = new AccountDAO();
            int totalUsers = accountDAO.getAccountByRoleId(3).size(); // 3: user
            int totalStaff = accountDAO.getAccountByRoleId(2).size(); // 2: staff
            int totalAdmin = accountDAO.getAccountByRoleId(1).size(); // 1: admin

            // Số lượng tài khoản bị khóa (status_id != 1)
            int lockedAccounts = 0;
            for (int roleId = 1; roleId <= 3; roleId++) {
                lockedAccounts += (int) accountDAO.getAccountByRoleId(roleId).stream().filter(a -> a.getStatusId() != 1).count();
            }

            // Tổng số booking
            BookingDAO bookingDAO = new BookingDAO();
            int totalBookings = bookingDAO.getAllBookingsForAdmin().size();

            // Tổng số sự kiện
            EventDAO eventDAO = new EventDAO();
            int totalEvents = eventDAO.getAllEvent().size();

            // Tổng số bài viết/blog
            PostDAO postDAO = new PostDAO();
            int totalPosts = postDAO.countAllPosts();

            // Tổng số slider/banner
            SliderDAO sliderDAO = new SliderDAO();
            int totalSliders = sliderDAO.countSliders();

            // Tổng doanh thu (booking đã thanh toán)
            BigDecimal totalRevenue = BigDecimal.ZERO;
            for (Map<String, Object> booking : bookingDAO.getAllBookingsForAdmin()) {
                Integer statusPay = (Integer) booking.get("status_pay");
                if (statusPay != null && statusPay == 1) { // 1: đã thanh toán
                    BigDecimal amount = (BigDecimal) booking.get("total_amount");
                    if (amount != null) totalRevenue = totalRevenue.add(amount);
                }
            }

            // Doanh thu theo 1, 3, 6 tháng
            LocalDate now = LocalDate.now();
            BigDecimal revenue1Month = BigDecimal.ZERO;
            BigDecimal revenue3Month = BigDecimal.ZERO;
            BigDecimal revenue6Month = BigDecimal.ZERO;
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            for (Map<String, Object> booking : bookingDAO.getAllBookingsForAdmin()) {
                Integer statusPay = (Integer) booking.get("status_pay");
                if (statusPay != null && statusPay == 1) {
                    String dateStr = (String) booking.get("booking_date");
                    LocalDate bookingDate = LocalDateTime.parse(dateStr, formatter).toLocalDate();
                    BigDecimal amount = (BigDecimal) booking.get("total_amount");
                    if (amount == null) continue;
                    if (!bookingDate.isBefore(now.minusMonths(1))) revenue1Month = revenue1Month.add(amount);
                    if (!bookingDate.isBefore(now.minusMonths(3))) revenue3Month = revenue3Month.add(amount);
                    if (!bookingDate.isBefore(now.minusMonths(6))) revenue6Month = revenue6Month.add(amount);
                }
            }

            // Số booking mới trong ngày/tuần/tháng
            int newBookingToday = 0, newBookingWeek = 0, newBookingMonth = 0, cancelledBookings = 0;
            LocalDate startOfWeek = now.minusDays(now.getDayOfWeek().getValue() - 1);
            for (Map<String, Object> booking : bookingDAO.getAllBookingsForAdmin()) {
                String dateStr = (String) booking.get("booking_date");
                LocalDate bookingDate = LocalDateTime.parse(dateStr, formatter).toLocalDate();
                if (bookingDate.isEqual(now)) newBookingToday++;
                if (!bookingDate.isBefore(startOfWeek)) newBookingWeek++;
                if (!bookingDate.isBefore(now.withDayOfMonth(1))) newBookingMonth++;
                Integer statusPay = (Integer) booking.get("status_pay");
                if (statusPay != null && statusPay == -1) cancelledBookings++;
            }

            // Thống kê booking theo trạng thái
            int totalPendingBookings = 0;
            int totalCompletedBookings = 0;
            int totalCancelledBookings = 0;
            for (Map<String, Object> booking : bookingDAO.getAllBookingsForAdmin()) {
                Integer statusPay = (Integer) booking.get("status_pay");
                if (statusPay != null) {
                    if (statusPay == 0) totalPendingBookings++;
                    else if (statusPay == 1) totalCompletedBookings++;
                    else if (statusPay == -1) totalCancelledBookings++;
                }
            }
            double bookingSuccessRate = 0, bookingCancelRate = 0;
            int totalCount = totalCompletedBookings + totalCancelledBookings;
            if (totalCount > 0) {
                bookingSuccessRate = (double) totalCompletedBookings * 100 / totalCount;
                bookingCancelRate = (double) totalCancelledBookings * 100 / totalCount;
            }

            

            // Tổng số sản phẩm
            dao.ProductDAO productDAO = new dao.ProductDAO();
            int totalProducts = productDAO.getTotalProduct();
            request.setAttribute("totalProducts", totalProducts);

            // Tổng số sân bóng
            FieldDAO fieldDAO = new FieldDAO();
            int totalFields = fieldDAO.getAllFields().size();
            request.setAttribute("totalFields", totalFields);

            // Tổng số khu vực
            dao.Zone_DAO zoneDAO = new dao.Zone_DAO();
            int totalZones = zoneDAO.getAllZone().size();
            request.setAttribute("totalZones", totalZones);
            // Tổng số loại sân
            dao.TypeOfFieldDAO typeOfFieldDAO = new dao.TypeOfFieldDAO();
            int totalFieldTypes = typeOfFieldDAO.getAllFieldTypes().size();
            request.setAttribute("totalFieldTypes", totalFieldTypes);
            // Tổng số loại sản phẩm
            dao.CateProduct_DAO cateProductDAO = new dao.CateProduct_DAO();
            int totalProductCategories = cateProductDAO.getAllCategory().size();
            request.setAttribute("totalProductCategories", totalProductCategories);

            // Set attribute cho JSP
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalStaff", totalStaff);
            request.setAttribute("totalAdmin", totalAdmin);
            request.setAttribute("lockedAccounts", lockedAccounts);
            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("totalEvents", totalEvents);
            request.setAttribute("totalPosts", totalPosts);
            request.setAttribute("totalSliders", totalSliders);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("revenue1Month", revenue1Month);
            request.setAttribute("revenue3Month", revenue3Month);
            request.setAttribute("revenue6Month", revenue6Month);
            request.setAttribute("newBookingToday", newBookingToday);
            request.setAttribute("newBookingWeek", newBookingWeek);
            request.setAttribute("newBookingMonth", newBookingMonth);
            request.setAttribute("cancelledBookings", cancelledBookings);
            request.setAttribute("totalPendingBookings", totalPendingBookings);
            request.setAttribute("totalCompletedBookings", totalCompletedBookings);
            request.setAttribute("bookingSuccessRate", bookingSuccessRate);
            request.setAttribute("bookingCancelRate", bookingCancelRate);
            

            request.getRequestDispatcher("/admin/ThongKe.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server: " + e.getMessage());
        }
    }
} 