package controller;

import dao.*;
import dao.Zone_DAO;
import dao.TypeOfFieldDAO;
import dao.CateProduct_DAO;
import dao.ProductDAO;
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
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import util.DBContext;

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



            // Tổng số sản phẩm
            ProductDAO productDAO = new ProductDAO();
            int totalProducts = productDAO.getTotalProduct();
            request.setAttribute("totalProducts", totalProducts);

            // Tổng số sân bóng
            FieldDAO fieldDAO = new FieldDAO();
            int totalFields = fieldDAO.getAllFields().size();
            request.setAttribute("totalFields", totalFields);

            // Tổng số khu vực
            Zone_DAO zoneDAO = new Zone_DAO();
            int totalZones = zoneDAO.getAllZone().size();
            request.setAttribute("totalZones", totalZones);
            // Tổng số loại sân
            TypeOfFieldDAO typeOfFieldDAO = new TypeOfFieldDAO();
            int totalFieldTypes = typeOfFieldDAO.getAllFieldTypes().size();
            request.setAttribute("totalFieldTypes", totalFieldTypes);
            // Tổng số loại sản phẩm
            CateProduct_DAO cateProductDAO = new CateProduct_DAO();
            int totalProductCategories = cateProductDAO.getAllCategory().size();
            request.setAttribute("totalProductCategories", totalProductCategories);

            // --- Thêm: Lấy doanh thu từng tháng ---
            int year = java.time.LocalDate.now().getYear();
            // Sử dụng BookingDetailsDAO để lấy doanh thu từ bookingdetails
            BookingDetailsDAO bookingDetailsDAO = new dao.BookingDetailsDAO();
            List<Double> revenueByMonth = bookingDetailsDAO.getRevenueByMonthFromBookingDetails(year);
            List<String> monthLabels = new ArrayList<>();
            for (int i = 1; i <= 12; i++) monthLabels.add("Tháng " + i);
            double totalRevenueYear = 0;
            for (Double d : revenueByMonth) totalRevenueYear += d;
            request.setAttribute("revenueByMonth", revenueByMonth);
            request.setAttribute("monthLabels", monthLabels);
            request.setAttribute("totalRevenueYear", totalRevenueYear);

            // --- Thêm: Lấy doanh thu từng ngày trong 1 tuần gần nhất ---
            Map<String, Double> revenueByDayMap = bookingDetailsDAO.getRevenueByDayInLastWeekFromBookingDetails();
            List<String> weekDayLabels = new ArrayList<>(revenueByDayMap.keySet());
            List<Double> weekDayRevenue = new ArrayList<>(revenueByDayMap.values());
            request.setAttribute("weekDayLabels", weekDayLabels);
            request.setAttribute("weekDayRevenue", weekDayRevenue);

            // --- Thêm: Lấy doanh thu từng sân ---
            Map<String, Double> revenueByFieldMap = bookingDetailsDAO.getRevenueByFieldFromBookingDetails();
            List<String> fieldLabels = new ArrayList<>(revenueByFieldMap.keySet());
            List<Double> fieldRevenue = new ArrayList<>(revenueByFieldMap.values());
            request.setAttribute("fieldLabels", fieldLabels);
            request.setAttribute("fieldRevenue", fieldRevenue);

            // --- Thêm: Thống kê tỷ lệ loại sân được đặt ---
            Map<String, Integer> typeOfFieldRatioMap = bookingDetailsDAO.getBookingTypeOfFieldRatioFromBookingDetails();
            List<String> typeOfFieldLabels = new ArrayList<>(typeOfFieldRatioMap.keySet());
            List<Integer> typeOfFieldCounts = new ArrayList<>(typeOfFieldRatioMap.values());
            request.setAttribute("typeOfFieldLabels", typeOfFieldLabels);
            request.setAttribute("typeOfFieldCounts", typeOfFieldCounts);

            // --- Thêm: Thống kê khung giờ đặt sân phổ biến ---
            Map<String, Integer> popularBookingHoursMap = bookingDetailsDAO.getPopularBookingHoursFromBookingDetails();
            List<String> bookingHourLabels = new ArrayList<>(popularBookingHoursMap.keySet());
            List<Integer> bookingHourCounts = new ArrayList<>(popularBookingHoursMap.values());
            request.setAttribute("bookingHourLabels", bookingHourLabels);
            request.setAttribute("bookingHourCounts", bookingHourCounts);

            // Doanh thu tổng quát nhất từ bookingdetails
            request.setAttribute("totalRevenue", bookingDetailsDAO.getTotalRevenueFromBookingDetails());
            request.setAttribute("revenue1Month", bookingDetailsDAO.getRevenueSinceFromBookingDetails(LocalDateTime.now().minusMonths(1)));
            request.setAttribute("revenue3Month", bookingDetailsDAO.getRevenueSinceFromBookingDetails(LocalDateTime.now().minusMonths(3)));
            request.setAttribute("revenue6Month", bookingDetailsDAO.getRevenueSinceFromBookingDetails(LocalDateTime.now().minusMonths(6)));
            request.setAttribute("totalRevenueYear", bookingDetailsDAO.getRevenueByYearFromBookingDetails(LocalDate.now().getYear()));

            // Xử lý doanh thu custom theo khoảng thời gian hoặc tháng/năm 
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");
            String monthStr = request.getParameter("month");
            String yearStr = request.getParameter("year");
            BigDecimal revenueCustom = null;
            String fromMonthStr = request.getParameter("fromMonth");
            String toMonthStr = request.getParameter("toMonth");
            String yearRangeStr = request.getParameter("yearRange");
            if (fromMonthStr != null && !fromMonthStr.isEmpty() && toMonthStr != null && !toMonthStr.isEmpty() && yearRangeStr != null && !yearRangeStr.isEmpty()) {
                int fromMonth = Integer.parseInt(fromMonthStr);
                int toMonth = Integer.parseInt(toMonthStr);
                int yearRange = Integer.parseInt(yearRangeStr);
                revenueCustom = bookingDetailsDAO.getRevenueByMonthRange(fromMonth, toMonth, yearRange);
            } else if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
                revenueCustom = bookingDetailsDAO.getRevenueInDateRange(fromDate, toDate);
            }
            if (revenueCustom != null) {
                request.setAttribute("revenueCustom", revenueCustom);
            }

            // Set attribute cho JSP 
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalStaff", totalStaff);
            request.setAttribute("totalAdmin", totalAdmin);
            request.setAttribute("lockedAccounts", lockedAccounts);
            
            request.setAttribute("totalEvents", new EventDAO().getAllEvent().size()); 
            request.setAttribute("totalPosts", new PostDAO().countAllPostsOfUserRole3()); 
            request.setAttribute("totalSliders", new SliderDAO().countSliders()); 
            request.setAttribute("totalBlogs", new dao.blogDAO().countAllBlogs());

            request.getRequestDispatcher("/admin/ThongKe.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi server: " + e.getMessage());
        }
    }
} 