package dao;

import model.Booking;
import model.BookingDetails;
import util.DBContext;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import websocket.AppWebSocket;

public class BookingDAO extends DBContext {

    public void autoCancelExpiredBookings() throws SQLException {
        String selectExpiredBookingIdsSQL = """
            SELECT booking_id FROM Booking
            WHERE status_pay = 0
              AND DATEDIFF(MINUTE, booking_date, GETDATE()) >= 1
        """;
        String cancelBookingSQL = """
            UPDATE Booking
            SET status_pay = -1
            WHERE booking_id = ?
        """;
        String cancelBookingDetailsSQL = """
            UPDATE BookingDetails
            SET status_checking_id = 3,
                note = CONCAT(
                    ISNULL(note, ''), 
                    N' [Tự động huỷ lúc ', 
                    CONVERT(NVARCHAR(50), GETDATE(), 120), 
                    ']'
                )
            WHERE booking_id = ?
        """;

        Connection conn = null;
        try {
            conn = this.connection;
            conn.setAutoCommit(false);

            List<Integer> expiredBookingIds = new ArrayList<>();
            try (PreparedStatement selectStmt = conn.prepareStatement(selectExpiredBookingIdsSQL); ResultSet rs = selectStmt.executeQuery()) {
                while (rs.next()) {
                    expiredBookingIds.add(rs.getInt("booking_id"));
                }
            }

            System.out.println("📋 Số booking quá hạn cần huỷ: " + expiredBookingIds.size());

            int countDetails = 0;
            try (PreparedStatement cancelBookingStmt = conn.prepareStatement(cancelBookingSQL); PreparedStatement cancelDetailsStmt = conn.prepareStatement(cancelBookingDetailsSQL)) {
                for (int bookingId : expiredBookingIds) {
                    cancelBookingStmt.setInt(1, bookingId);
                    cancelBookingStmt.executeUpdate();
                    cancelDetailsStmt.setInt(1, bookingId);
                    countDetails += cancelDetailsStmt.executeUpdate();
                }
            }

            conn.commit();
            System.out.println("✅ Đã huỷ " + expiredBookingIds.size() + " booking và " + countDetails + " bookingDetail");

            if (countDetails > 0) {
                AppWebSocket.broadcastCalendarUpdate("*");
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi huỷ booking tự động: " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback();
                    System.err.println("🔁 Đã rollback transaction.");
                } catch (SQLException ex) {
                    System.err.println("❌ Rollback thất bại: " + ex.getMessage());
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // ✅ Bây giờ conn vẫn còn sống
                } catch (SQLException e) {
                    System.err.println("❌ Không thể reset AutoCommit: " + e.getMessage());
                }
            }
        }
    }

    public List<Map<String, Object>> getAllBookingsForAdmin() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = """
            SELECT b.booking_code, b.booking_date, b.total_amount, b.status_pay,
                   ISNULL(ou.full_name, CONCAT(up.first_name, ' ', up.last_name)) AS customer_name,
                   ISNULL(ou.phone, up.phone) AS customer_phone,
                   CASE WHEN ou.offline_user_id IS NOT NULL THEN 'offline' ELSE 'online' END AS customer_type,
                   (SELECT COUNT(*) FROM BookingDetails bd WHERE bd.booking_id = b.booking_id) AS slot_count,
                   (SELECT STRING_AGG(scs.status_name, '; ')
                       FROM BookingDetails bd
                       JOIN StatusCheckingSlot scs ON bd.status_checking_id = scs.status_checking_id
                       WHERE bd.booking_id = b.booking_id) AS slot_status_summary
            FROM Booking b
            LEFT JOIN OfflineCustomer oc ON b.booking_id = oc.booking_id
            LEFT JOIN OfflineUser ou ON oc.offline_user_id = ou.offline_user_id
            LEFT JOIN UserProfile up ON b.account_id = up.account_id
            ORDER BY b.booking_date DESC
        """;

        try ( PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("booking_code", rs.getString("booking_code"));
                map.put("booking_date", rs.getString("booking_date"));
                map.put("total_amount", rs.getBigDecimal("total_amount"));
                map.put("status_pay", rs.getInt("status_pay"));
                map.put("customer_name", rs.getString("customer_name"));
                map.put("customer_phone", rs.getString("customer_phone"));
                map.put("customer_type", rs.getString("customer_type"));
                map.put("slot_count", rs.getInt("slot_count"));
                map.put("slot_status_summary", rs.getString("slot_status_summary"));
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Map<String, Object>> getBookingSlots(String bookingCode) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = """
            SELECT bd.slot_date, bd.start_time, bd.end_time, 
                   bd.slot_field_price, bd.extra_minutes, bd.extra_fee,
                   scs.status_name, bd.note,
                   f.field_name, tf.field_type_name
            FROM BookingDetails bd
            JOIN Booking b ON bd.booking_id = b.booking_id
            JOIN SlotsOfField sf ON bd.slot_field_id = sf.slot_field_id
            JOIN Field f ON sf.field_id = f.field_id
            JOIN TypeOfField tf ON f.field_type_id = tf.field_type_id
            JOIN StatusCheckingSlot scs ON bd.status_checking_id = scs.status_checking_id
            WHERE b.booking_code = ?
            ORDER BY bd.slot_date, bd.start_time
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bookingCode);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("slot_date", rs.getString("slot_date"));
                map.put("start_time", rs.getString("start_time"));
                map.put("end_time", rs.getString("end_time"));
                map.put("price", rs.getBigDecimal("slot_field_price"));
                map.put("extra_minutes", rs.getInt("extra_minutes"));
                map.put("extra_fee", rs.getBigDecimal("extra_fee"));
                map.put("status_name", rs.getString("status_name"));
                map.put("note", rs.getString("note"));
                map.put("field_name", rs.getString("field_name"));
                map.put("field_type_name", rs.getString("field_type_name"));
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean bookingExists(String bookingCode) throws SQLException {
        String sql = "SELECT 1 FROM Booking WHERE booking_code = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bookingCode);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public List<Map<String, Object>> getBookingSlotStatus(String bookingCode) throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT bd.booking_details_id, bd.slot_date, bd.start_time, bd.end_time, "
                + "bd.status_checking_id, s.status_name, bd.slot_field_id, f.field_name, b.status_pay "
                + "FROM BookingDetails bd "
                + "JOIN Booking b ON bd.booking_id = b.booking_id "
                + "JOIN StatusCheckingSlot s ON bd.status_checking_id = s.status_checking_id "
                + "JOIN SlotsOfField sf ON bd.slot_field_id = sf.slot_field_id "
                + "JOIN Field f ON sf.field_id = f.field_id "
                + "WHERE b.booking_code = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bookingCode);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("booking_details_id", rs.getInt("booking_details_id"));
                    row.put("slot_date", rs.getString("slot_date"));
                    row.put("start_time", rs.getString("start_time"));
                    row.put("end_time", rs.getString("end_time"));
                    row.put("status_checking_id", rs.getInt("status_checking_id"));
                    row.put("status_name", rs.getString("status_name"));
                    row.put("slot_field_id", rs.getInt("slot_field_id"));
                    row.put("field_name", rs.getString("field_name"));
                    row.put("status_pay", rs.getInt("status_pay"));
                    list.add(row);
                }
            }
        }
        return list;
    }

    public boolean checkSlotConflictWithOtherBooking(int slotFieldId, String slotDate, String startTime, String endTime, String currentBookingCode) throws SQLException {
        String sql = "SELECT 1 FROM BookingDetails bd "
                + "JOIN Booking b ON bd.booking_id = b.booking_id "
                + "WHERE bd.slot_field_id = ? AND bd.slot_date = ? AND bd.start_time = ? AND bd.end_time = ? "
                + "AND bd.status_checking_id = 1 AND b.booking_code <> ?";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, slotFieldId);
            ps.setString(2, slotDate);
            ps.setString(3, startTime);
            ps.setString(4, endTime);
            ps.setString(5, currentBookingCode);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public Integer getBookingIdByCode(String bookingCode) {
        String sql = "SELECT booking_id FROM Booking WHERE booking_code = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bookingCode);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("booking_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateStatusPaySuccessByCode(String bookingCode) {
        String sql = "UPDATE Booking SET status_pay = 1 WHERE booking_code = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bookingCode);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ✅ Tìm booking theo nội dung có mã booking
    public Booking findByCodeInContent(String content) throws SQLException {
        String sql = "SELECT * FROM Booking WHERE booking_code IS NOT NULL AND ? LIKE '%' + booking_code + '%'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, content);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Booking(
                        rs.getInt("booking_id"),
                        rs.getString("booking_code"),
                        rs.getInt("account_id"),
                        rs.getObject("sale_id") != null ? rs.getInt("sale_id") : null,
                        rs.getString("booking_date"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("email"),
                        rs.getInt("status_pay")
                );
            }
        }
        return null;
    }

    // ✅ Thêm đơn đặt sân
    public int insertBooking(Booking booking) {
        String sql = "INSERT INTO Booking (account_id, sale_id, booking_date, total_amount, email, booking_code, status_pay) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            String now = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
            ps.setInt(1, booking.getAccountId());
            if (booking.getSaleId() != null) {
                ps.setInt(2, booking.getSaleId());
            } else {
                ps.setNull(2, Types.INTEGER);
            }
            ps.setString(3, now);
            ps.setBigDecimal(4, booking.getTotalAmount());
            ps.setString(5, booking.getEmail());
            ps.setString(6, booking.getBookingCode());
            ps.setInt(7, booking.getStatusPay());
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // ✅ Cập nhật trạng thái thanh toán
    public boolean updateBookingStatusPaySuccess(int bookingId) {
        String sql = "UPDATE Booking SET status_pay = 1 WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Booking getBookingByID(int bookingID) {
        String sql = "SELECT * FROM Booking WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Booking(
                        rs.getInt("booking_id"),
                        rs.getString("booking_code"),
                        rs.getInt("account_id"),
                        rs.getObject("sale_id") != null ? rs.getInt("sale_id") : null,
                        rs.getString("booking_date"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("email"),
                        rs.getInt("status_pay")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Booking getBookingByCode(String bookingCode) {
        String sql = "SELECT * FROM Booking WHERE booking_code = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bookingCode);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Booking(
                        rs.getInt("booking_id"),
                        rs.getString("booking_code"),
                        rs.getInt("account_id"),
                        rs.getObject("sale_id") != null ? rs.getInt("sale_id") : null,
                        rs.getString("booking_date"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("email"),
                        rs.getInt("status_pay")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean isBookingCodeExists(String bookingCode) {
        String sql = "SELECT COUNT(*) FROM Booking WHERE booking_code = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bookingCode);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void setConnection(Connection conn) {
        this.connection = conn;
    }

    public List<Booking> getBookingsByAccountId(int accountId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE account_id = ? ORDER BY booking_date DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("booking_id"),
                        rs.getString("booking_code"),
                        rs.getInt("account_id"),
                        rs.getObject("sale_id") != null ? rs.getInt("sale_id") : null,
                        rs.getString("booking_date"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("email"),
                        rs.getInt("status_pay")
                );
                list.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Booking getBookingByBookingDetailId(int bookingDetailsId) {
        String sql = """
            SELECT b.*
            FROM Booking b
            JOIN BookingDetails bd ON b.booking_id = bd.booking_id
            WHERE bd.booking_details_id = ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingDetailsId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Booking(
                        rs.getInt("booking_id"),
                        rs.getString("booking_code"),
                        rs.getInt("account_id"),
                        rs.getObject("sale_id") != null ? rs.getInt("sale_id") : null,
                        rs.getString("booking_date"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("email"),
                        rs.getInt("status_pay")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Booking> getBookingsByAccountIdPaging(int accountId, int pageIndex, int pageSize) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE account_id = ? "
                + "ORDER BY booking_date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int offset = (pageIndex - 1) * pageSize;
            ps.setInt(1, accountId);
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("booking_id"),
                        rs.getString("booking_code"),
                        rs.getInt("account_id"),
                        rs.getObject("sale_id") != null ? rs.getInt("sale_id") : null,
                        rs.getString("booking_date"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("email"),
                        rs.getInt("status_pay")
                );
                list.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countBookingsByAccountId(int accountId) {
        String sql = "SELECT COUNT(*) FROM Booking WHERE account_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public BigDecimal calculateTotalBooking(List<BookingDetails> detailsList) {
        BigDecimal total = BigDecimal.ZERO;
        for (BookingDetails detail : detailsList) {
            BigDecimal slotPrice = detail.getSlotFieldPrice() != null ? detail.getSlotFieldPrice() : BigDecimal.ZERO;
            BigDecimal extraFee = detail.getExtraFee() != null ? detail.getExtraFee() : BigDecimal.ZERO;
            total = total.add(slotPrice).add(extraFee);
        }
        int slotCount = detailsList.size();
        SaleDAO saleDAO = new SaleDAO();
        int discountPercent = saleDAO.getDiscountPercent(slotCount);
        if (discountPercent > 0) {
            BigDecimal discount = total.multiply(BigDecimal.valueOf(discountPercent)).divide(BigDecimal.valueOf(100));
            total = total.subtract(discount);
        }
        return total;
    }

    public Booking findByBookingCode(String bookingCode) {
        String sql = "SELECT * FROM Booking WHERE booking_code = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bookingCode);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("booking_id"),
                        rs.getString("booking_code"),
                        rs.getInt("account_id"),
                        rs.getObject("sale_id") != null ? rs.getInt("sale_id") : null,
                        rs.getString("booking_date"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("email"),
                        rs.getInt("status_pay")
                );
                return booking;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
