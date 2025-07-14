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

            // Lấy tham số ngày từ request
            String dateParam = request.getParameter("date");
            java.math.BigDecimal revenueBySelectedDate = null;
            java.time.LocalDate selectedDate = null;
            if (dateParam != null && !dateParam.isEmpty()) {
                selectedDate = java.time.LocalDate.parse(dateParam);
                revenueBySelectedDate = bookingDAO.getRevenueByDate(selectedDate);
                request.setAttribute("selectedDate", selectedDate);
                request.setAttribute("revenueBySelectedDate", revenueBySelectedDate);
            }

            // Lấy tham số tháng từ request
            String monthParam = request.getParameter("month");
            java.math.BigDecimal revenueBySelectedMonth = null;
            if (monthParam != null && !monthParam.isEmpty()) {
                // monthParam dạng yyyy-MM
                String[] parts = monthParam.split("-");
                int year = Integer.parseInt(parts[0]);
                int month = Integer.parseInt(parts[1]);
                revenueBySelectedMonth = bookingDAO.getRevenueByMonth(year, month);
                request.setAttribute("selectedMonth", monthParam);
                request.setAttribute("revenueBySelectedMonth", revenueBySelectedMonth);
            }

            // Doanh thu từng ngày trong 30 ngày gần nhất
            java.util.List<java.util.Map<String, Object>> revenueByDay = bookingDAO.getRevenueByDay(30);
            request.setAttribute("revenueByDay", revenueByDay);

            // Doanh thu từng tháng trong 12 tháng gần nhất
            java.util.List<java.util.Map<String, Object>> revenueByMonth = bookingDAO.getRevenueByMonth(12);
            request.setAttribute("revenueByMonth", revenueByMonth);

            // Top 5 ngày doanh thu cao nhất
            java.util.List<java.util.Map<String, Object>> topRevenueDays = bookingDAO.getTopRevenueDays(5);
            request.setAttribute("topRevenueDays", topRevenueDays);

            // Top 5 tháng doanh thu cao nhất
            java.util.List<java.util.Map<String, Object>> topRevenueMonths = bookingDAO.getTopRevenueMonths(5);
            request.setAttribute("topRevenueMonths", topRevenueMonths);

            // 10 booking gần nhất
            java.util.List<java.util.Map<String, Object>> recentBookings = bookingDAO.getRecentBookings(10);
            request.setAttribute("recentBookings", recentBookings);

            // Lấy số booking theo từng sân
            java.util.List<java.util.Map<String, Object>> bookingCountByField = bookingDAO.getBookingCountByField();
            request.setAttribute("bookingCountByField", bookingCountByField);

            // Lấy danh sách sân cho dropdown lọc
            java.util.List<java.util.Map<String, Object>> fields = bookingDAO.getAllFields();
            request.setAttribute("fields", fields);

            // Lấy 10 user mới đăng ký gần đây
            dao.AccountDAO accountDAO = new dao.AccountDAO();
            java.util.List<model.Account> recentUsers = accountDAO.getRecentRegisteredUsers(10);
            request.setAttribute("recentUsers", recentUsers);

            // Lọc doanh thu theo khoảng ngày, sân, trạng thái
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            String fieldIdStr = request.getParameter("fieldId");
            String payStatus = request.getParameter("payStatus");
            Integer fieldId = (fieldIdStr != null && !fieldIdStr.isEmpty()) ? Integer.parseInt(fieldIdStr) : null;
            java.math.BigDecimal filteredRevenue = bookingDAO.getRevenueFiltered(fromDate, toDate, fieldId, payStatus);
            request.setAttribute("filteredRevenue", filteredRevenue);

            // Lọc doanh thu theo tháng riêng biệt
            String monthFilter = request.getParameter("monthFilter");
            java.math.BigDecimal revenueByMonthFilter = null;
            if (monthFilter != null && !monthFilter.isEmpty()) {
                String[] parts = monthFilter.split("-");
                int year = Integer.parseInt(parts[0]);
                int month = Integer.parseInt(parts[1]);
                revenueByMonthFilter = bookingDAO.getRevenueByMonth(year, month);
                request.setAttribute("revenueByMonthFilter", revenueByMonthFilter);
                request.setAttribute("selectedMonthFilter", monthFilter);
            }

            // Thống kê doanh thu theo từng sân
            java.util.List<java.util.Map<String, Object>> revenueByField = bookingDAO.getRevenueByField();
            request.setAttribute("revenueByField", revenueByField);

            // Sau khi lấy dữ liệu, setAttribute cho request
            // request.setAttribute("tenDuLieu", duLieu);

            request.getRequestDispatcher("/admin/BaoCaoChiTiet.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server: " + e.getMessage());
        }
    }
} 