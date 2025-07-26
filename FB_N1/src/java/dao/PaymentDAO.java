package dao;

import model.Payment;
import util.DBContext;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.LinkedHashMap;

public class PaymentDAO extends DBContext {

    public void insert(Payment p) throws SQLException {
        String sql = "INSERT INTO Payments (booking_id, transaction_code, transfer_amount, pay_time, confirmed_time, pay_status, gateway, content, description, raw_data) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setObject(1, p.getBookingId()); // Nullable
            ps.setString(2, p.getTransactionCode());
            ps.setDouble(3, p.getTransferAmount());
            ps.setString(4, p.getPayTime());
            ps.setString(5, p.getConfirmedTime());
            ps.setString(6, p.getPayStatus());
            ps.setString(7, p.getGateway());
            ps.setString(8, p.getContent());
            ps.setString(9, p.getDescription());
            ps.setString(10, p.getRawData());
            ps.executeUpdate();
        }
    }

    public List<Map<String, Object>> getPendingPaymentsWithoutBooking() throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT transaction_code, transfer_amount, pay_time, content, gateway, pay_status, description "
                + "FROM Payments WHERE booking_id IS NULL";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("transaction_code", rs.getString("transaction_code"));
                map.put("transfer_amount", rs.getBigDecimal("transfer_amount"));
                map.put("pay_time", rs.getString("pay_time"));
                map.put("content", rs.getString("content"));
                map.put("gateway", rs.getString("gateway"));
                map.put("pay_status", rs.getString("pay_status"));
                map.put("description", rs.getString("description"));
                list.add(map);

            }
        }
        return list;
    }


    public boolean matchPaymentToBooking(String transactionCode, String bookingCode, String confirmedBy, String description) throws SQLException {
        String sqlGetBookingId = "SELECT booking_id FROM Booking WHERE booking_code = ?";
        String sqlUpdatePayment = "UPDATE Payments SET pay_status = 'success', confirmed_time = ?, description = ?, booking_id = ? WHERE transaction_code = ?";
        String sqlUpdateSlotStatus = "UPDATE BookingDetails SET status_checking_id = 1 WHERE booking_id = ?";
        String sqlUpdateBookingPayStatus = "UPDATE Booking SET status_pay = 1 WHERE booking_code = ?";

        String confirmedTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        try (Connection conn = DBContext.getConnection()) {
            conn.setAutoCommit(false);

            try (
                    PreparedStatement psGetBookingId = conn.prepareStatement(sqlGetBookingId); PreparedStatement psUpdatePayment = conn.prepareStatement(sqlUpdatePayment); PreparedStatement psUpdateSlotStatus = conn.prepareStatement(sqlUpdateSlotStatus); PreparedStatement psUpdateBookingPayStatus = conn.prepareStatement(sqlUpdateBookingPayStatus)) {
                // Lấy booking_id
                psGetBookingId.setString(1, bookingCode);
                ResultSet rs = psGetBookingId.executeQuery();

                int bookingId = -1;
                if (rs.next()) {
                    bookingId = rs.getInt("booking_id");
                } else {
                    conn.rollback();
                    return false;
                }

                // Cập nhật Payment
                psUpdatePayment.setString(1, confirmedTime);
                psUpdatePayment.setString(2, description + " (Xác nhận bởi: " + confirmedBy + ")");
                psUpdatePayment.setInt(3, bookingId);
                psUpdatePayment.setString(4, transactionCode);
                int updated = psUpdatePayment.executeUpdate();

                if (updated == 0) {
                    conn.rollback();
                    return false;
                }

                // Cập nhật trạng thái các slot
                psUpdateSlotStatus.setInt(1, bookingId);
                psUpdateSlotStatus.executeUpdate();

                // ✅ Cập nhật trạng thái thanh toán trong bảng Booking
                psUpdateBookingPayStatus.setString(1, bookingCode);
                psUpdateBookingPayStatus.executeUpdate();

                conn.commit();
                return true;

            } catch (SQLException e) {
                conn.rollback();
                throw e;
            }
        }
    }

    // Lấy doanh thu từng tháng trong năm (chỉ tính payment thành công)
    public List<Double> getRevenueByMonth(int year) throws SQLException {
        List<Double> revenues = new ArrayList<>();
        String sql = "SELECT MONTH(pay_time) AS month, SUM(transfer_amount) AS revenue "
                + "FROM Payments WHERE pay_status = 'success' AND YEAR(pay_time) = ? "
                + "GROUP BY MONTH(pay_time) ORDER BY MONTH(pay_time)";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            Map<Integer, Double> monthRevenue = new HashMap<>();
            while (rs.next()) {
                monthRevenue.put(rs.getInt("month"), rs.getDouble("revenue"));
            }
            // Đảm bảo đủ 12 tháng, tháng không có doanh thu thì là 0
            for (int i = 1; i <= 12; i++) {
                revenues.add(monthRevenue.getOrDefault(i, 0.0));
            }
        }
        return revenues;
    }

    // Lấy doanh thu từng ngày trong 7 ngày gần nhất (SQL Server)
    public Map<String, Double> getRevenueByDayInLastWeek() throws SQLException {
        Map<String, Double> revenueByDay = new LinkedHashMap<>();
        String sql = "SELECT CONVERT(date, pay_time) as day, SUM(transfer_amount) as revenue "
                + "FROM Payments WHERE pay_status = 'success' AND pay_time >= DATEADD(DAY, -6, CAST(GETDATE() AS date)) "
                + "GROUP BY CONVERT(date, pay_time) ORDER BY day";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            // Chuẩn bị đủ 7 ngày gần nhất
            java.time.LocalDate today = java.time.LocalDate.now();
            for (int i = 6; i >= 0; i--) {
                java.time.LocalDate d = today.minusDays(i);
                revenueByDay.put(d.toString(), 0.0);
            }
            while (rs.next()) {
                String day = rs.getString("day");
                double revenue = rs.getDouble("revenue");
                if (revenueByDay.containsKey(day)) {
                    revenueByDay.put(day, revenue);
                }
            }
        }
        return revenueByDay;
    }

    // Lấy doanh thu từng sân (field) - luôn hiển thị tất cả sân, kể cả doanh thu = 0
    public Map<String, Double> getRevenueByField() throws SQLException {
        Map<String, Double> revenueByField = new LinkedHashMap<>();
        String sql
                = "SELECT f.field_name, ISNULL(SUM(p.transfer_amount), 0) as revenue "
                + "FROM Field f "
                + "LEFT JOIN SlotsOfField sf ON f.field_id = sf.field_id "
                + "LEFT JOIN BookingDetails bd ON sf.slot_field_id = bd.slot_field_id "
                + "LEFT JOIN Booking b ON bd.booking_id = b.booking_id "
                + "LEFT JOIN Payments p ON b.booking_id = p.booking_id AND p.pay_status = 'success' "
                + "GROUP BY f.field_name ORDER BY revenue DESC";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String fieldName = rs.getString("field_name");
                double revenue = rs.getDouble("revenue");
                revenueByField.put(fieldName, revenue);
            }
        }
        return revenueByField;
    }

    // Thống kê số lượt booking theo loại sân (5 người, 7 người, 11 người) chỉ tính booking có thanh toán thành công
    public Map<String, Integer> getBookingTypeOfFieldRatio() throws SQLException {
        Map<String, Integer> typeRatio = new LinkedHashMap<>();
        String sql
                = "SELECT tof.field_type_name, COUNT(*) as count "
                + "FROM Payments p "
                + "JOIN Booking b ON p.booking_id = b.booking_id "
                + "JOIN BookingDetails bd ON b.booking_id = bd.booking_id "
                + "JOIN SlotsOfField sf ON bd.slot_field_id = sf.slot_field_id "
                + "JOIN Field f ON sf.field_id = f.field_id "
                + "JOIN TypeOfField tof ON f.field_type_id = tof.field_type_id "
                + "WHERE p.pay_status = 'success' "
                + "GROUP BY tof.field_type_name ORDER BY count DESC";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String typeName = rs.getString("field_type_name");
                int count = rs.getInt("count");
                typeRatio.put(typeName, count);
            }
        }
        return typeRatio;
    }

    // Thống kê số lượt đặt theo khung giờ (giờ bắt đầu), chỉ tính booking có thanh toán thành công
    public Map<String, Integer> getPopularBookingHours() throws SQLException {
        Map<String, Integer> hourMap = new LinkedHashMap<>();
        String sql
                = "SELECT sod.start_time, COUNT(*) as count "
                + "FROM Payments p "
                + "JOIN Booking b ON p.booking_id = b.booking_id "
                + "JOIN BookingDetails bd ON b.booking_id = bd.booking_id "
                + "JOIN SlotsOfField sof ON bd.slot_field_id = sof.slot_field_id "
                + "JOIN SlotsOfDay sod ON sof.slot_id = sod.slot_id "
                + "WHERE p.pay_status = 'success' "
                + "GROUP BY sod.start_time ORDER BY sod.start_time";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String startTime = rs.getString("start_time");
                int count = rs.getInt("count");
                hourMap.put(startTime, count);
            }
        }
        return hourMap;
    }

    // Lấy danh sách giao dịch chi tiết có phân trang
    public List<Map<String, Object>> getDetailedPayments() {
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            String sql = """
                SELECT p.transaction_code, 
                       ISNULL(up.first_name, '') + ' ' + ISNULL(up.last_name, '') AS payer_name,
                       p.pay_time, p.transfer_amount, p.gateway, p.description
                FROM Payments p
                LEFT JOIN Booking b ON p.booking_id = b.booking_id
                LEFT JOIN Account a ON b.account_id = a.account_id
                LEFT JOIN UserProfile up ON a.account_id = up.account_id
                ORDER BY p.pay_time DESC
            """;
            try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("transaction_code", rs.getString("transaction_code"));
                    map.put("payer_name", rs.getString("payer_name"));
                    map.put("pay_time", rs.getString("pay_time"));
                    map.put("transfer_amount", rs.getBigDecimal("transfer_amount"));
                    map.put("gateway", rs.getString("gateway"));
                    map.put("description", rs.getString("description"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm tổng số giao dịch chi tiết
    public int countDetailedPayments() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Payments";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
