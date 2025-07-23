package dao;

import model.BookingDetails;
import util.DBContext;
import model.BookingDetailsDTO;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class BookingDetailsDAO extends DBContext {
// Update ca về trạng thái huỷ (3)

    public boolean updateSlotsStatusByBooking(int bookingId, int statusCheckingId) throws SQLException {
        String sql = "UPDATE BookingDetails SET status_checking_id = ? WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, statusCheckingId);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        }
    }

    public int countFutureSlotsByBooking(int bookingId) throws SQLException {
        String sql = """
        SELECT COUNT(*)
        FROM BookingDetails
        WHERE booking_id = ?
          AND TRY_CAST(slot_date + ' ' + start_time AS DATETIME) > GETDATE()
          AND status_checking_id != 3
    """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

// Lấy field_id của các ca trong booking
    public Set<String> getFieldIdsByBooking(int bookingId) throws SQLException {
        Set<String> fieldIds = new HashSet<>();
        String sql = """
        SELECT DISTINCT f.field_id
        FROM BookingDetails bd
        JOIN SlotsOfField sf ON bd.slot_field_id = sf.slot_field_id
        JOIN Field f ON sf.field_id = f.field_id
        WHERE bd.booking_id = ?
    """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    fieldIds.add(String.valueOf(rs.getInt("field_id")));
                }
            }
        }
        return fieldIds;
    }

    public boolean insertBookingDetail(BookingDetails detail) {
        String sql = "INSERT INTO BookingDetails "
                + "(booking_id, slot_field_id, slot_field_price, extra_minutes, extra_fee, slot_date, start_time, end_time, note, status_checking_id, booking_details_code) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, detail.getBookingId());
            ps.setInt(2, detail.getSlotFieldId());
            ps.setBigDecimal(3, detail.getSlotFieldPrice());
            ps.setInt(4, detail.getExtraMinutes());
            ps.setBigDecimal(5, detail.getExtraFee());
            ps.setString(6, detail.getSlotDate());
            ps.setString(7, detail.getStartTime());
            ps.setString(8, detail.getEndTime());
            ps.setString(9, detail.getNote());
            ps.setInt(10, detail.getStatusCheckingId());
            ps.setString(11, detail.getBookingDetailsCode());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void setConnection(Connection conn) {
        this.connection = conn;
    }

    public Integer getAccountIdByBookingDetailId(int bookingDetailsId) {
        String sql = "SELECT b.account_id "
                + "FROM BookingDetails bd "
                + "JOIN Booking b ON bd.booking_id = b.booking_id "
                + "WHERE bd.booking_details_id = ?";

        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingDetailsId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("account_id");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Không tìm thấy
    }

    public boolean updateStatus(int bookingDetailsId, int newStatus) {
        String updateSlotSql = "UPDATE BookingDetails SET status_checking_id = ? WHERE booking_details_id = ?";
        String getBookingIdSql = "SELECT booking_id FROM BookingDetails WHERE booking_details_id = ?";
        String checkAllCancelledSql = "SELECT COUNT(*) AS total, SUM(CASE WHEN status_checking_id = 3 THEN 1 ELSE 0 END) AS cancelled "
                + "FROM BookingDetails WHERE booking_id = ?";
        String updateBookingSql = "UPDATE Booking SET status_pay = -2 WHERE booking_id = ?";

        try (PreparedStatement updatePs = connection.prepareStatement(updateSlotSql); PreparedStatement getBookingIdPs = connection.prepareStatement(getBookingIdSql)) {

            // Cập nhật trạng thái của 1 bookingDetails
            updatePs.setInt(1, newStatus);
            updatePs.setInt(2, bookingDetailsId);
            int updated = updatePs.executeUpdate();

            if (updated == 0) {
                return false;
            }

            // Lấy booking_id từ bookingDetailsId
            getBookingIdPs.setInt(1, bookingDetailsId);
            ResultSet rs = getBookingIdPs.executeQuery();
            if (!rs.next()) {
                return true;
            }

            int bookingId = rs.getInt("booking_id");

            // Kiểm tra xem tất cả các ca của booking này có bị huỷ hết không
            try (PreparedStatement checkAllPs = connection.prepareStatement(checkAllCancelledSql)) {
                checkAllPs.setInt(1, bookingId);
                ResultSet checkRs = checkAllPs.executeQuery();
                if (checkRs.next()) {
                    int total = checkRs.getInt("total");
                    int cancelled = checkRs.getInt("cancelled");
                    if (total > 0 && total == cancelled) {
                        // Tất cả ca đã huỷ → cập nhật status_pay = -2
                        try (PreparedStatement updateBookingPs = connection.prepareStatement(updateBookingSql)) {
                            updateBookingPs.setInt(1, bookingId);
                            updateBookingPs.executeUpdate();
                        }
                    }
                }
            }

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStatusByBookingId(int bookingId, int newStatusId) {
        String sql = "UPDATE BookingDetails SET status_checking_id = ? WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newStatusId);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public BookingDetails getBySlotFieldAndDate(int slotFieldId, String slotDate) {
        String sql = "SELECT * FROM BookingDetails WHERE slot_field_id = ? AND slot_date = ? AND status_checking_id != 3"; // tránh lấy bản ghi đã hủy
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, slotFieldId);
            ps.setString(2, slotDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new BookingDetails(
                        rs.getInt("booking_details_id"),
                        rs.getInt("booking_id"),
                        rs.getString("booking_details_code"),
                        rs.getInt("slot_field_id"),
                        rs.getBigDecimal("slot_field_price"),
                        rs.getInt("extra_minutes"),
                        rs.getBigDecimal("extra_fee"),
                        rs.getString("slot_date"),
                        rs.getString("start_time"), // thêm start_time
                        rs.getString("end_time"), // thêm end_time
                        rs.getString("note"),
                        rs.getInt("status_checking_id")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<BookingDetails> getDetailsByBookingId(int bookingId) {
        List<BookingDetails> list = new ArrayList<>();

        String sql = "SELECT * FROM BookingDetails WHERE booking_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BookingDetails detail = new BookingDetails(
                        rs.getInt("booking_details_id"),
                        rs.getInt("booking_id"),
                        rs.getString("booking_details_code"),
                        rs.getInt("slot_field_id"),
                        rs.getBigDecimal("slot_field_price"),
                        rs.getInt("extra_minutes"),
                        rs.getBigDecimal("extra_fee"),
                        rs.getString("slot_date"),
                        rs.getString("start_time"), // thêm start_time
                        rs.getString("end_time"), // thêm end_time
                        rs.getString("note"),
                        rs.getInt("status_checking_id")
                );

                list.add(detail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public BookingDetails getByCode(String bookingDetailsCode) {
        String sql = "SELECT * FROM BookingDetails WHERE booking_details_code = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, bookingDetailsCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new BookingDetails(
                            rs.getInt("booking_details_id"),
                            rs.getInt("booking_id"),
                            rs.getString("booking_details_code"),
                            rs.getInt("slot_field_id"),
                            rs.getBigDecimal("slot_field_price"),
                            rs.getInt("extra_minutes"),
                            rs.getBigDecimal("extra_fee"),
                            rs.getString("slot_date"),
                            rs.getString("start_time"),
                            rs.getString("end_time"),
                            rs.getString("note"),
                            rs.getInt("status_checking_id")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Hoặc log.warn nếu bạn muốn hạn chế in stacktrace
        }
        return null; // Không tìm thấy
    }

    public boolean isSlotAlreadyBooked(int slotFieldId, String slotDate) throws SQLException {
        String sql = "SELECT COUNT(*) FROM BookingDetails "
                + "WHERE slot_field_id = ? AND slot_date = ? AND status_checking_id = 1";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, slotFieldId);
            ps.setString(2, slotDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    public BigDecimal totalBookingDetails(int bookingDetailsId) {
        String sql = "SELECT slot_field_price, extra_fee FROM BookingDetails WHERE booking_details_id = ?";
        BigDecimal total = BigDecimal.ZERO;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingDetailsId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                BigDecimal slotPrice = rs.getBigDecimal("slot_field_price");
                BigDecimal extraFee = rs.getBigDecimal("extra_fee");

                if (slotPrice != null) {
                    total = total.add(slotPrice);
                }
                if (extraFee != null) {
                    total = total.add(extraFee);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

    public List<BookingDetailsDTO> getBookingDetailsByBookingIdPaging(int bookingId, int accountId, int pageIndex, int pageSize) {
        List<BookingDetailsDTO> list = new ArrayList<>();

        String sql = "SELECT bd.booking_details_id,bd.booking_details_code, f.field_name, f.image, sd.start_time, sd.end_time, "
                + "bd.slot_date, bd.slot_field_price, bd.extra_fee, bd.extra_minutes, "
                + "scs.status_name, scs.status_checking_id, bd.note "
                + "FROM BookingDetails bd "
                + "JOIN Booking b ON bd.booking_id = b.booking_id "
                + "JOIN SlotsOfField sof ON bd.slot_field_id = sof.slot_field_id "
                + "JOIN Field f ON sof.field_id = f.field_id "
                + "JOIN SlotsOfDay sd ON sof.slot_id = sd.slot_id "
                + "JOIN StatusCheckingSlot scs ON bd.status_checking_id = scs.status_checking_id "
                + "WHERE b.booking_id = ? AND b.account_id = ? "
                + "ORDER BY bd.booking_details_id "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, accountId);
            ps.setInt(3, (pageIndex - 1) * pageSize);
            ps.setInt(4, pageSize);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookingDetailsDTO dto = new BookingDetailsDTO(
                            rs.getInt("booking_details_id"),
                            rs.getString("booking_details_code"),
                            rs.getString("field_name"),
                            rs.getString("image"),
                            rs.getString("start_time"),
                            rs.getString("end_time"),
                            rs.getString("slot_date"),
                            rs.getBigDecimal("slot_field_price"),
                            rs.getBigDecimal("extra_fee"),
                            rs.getString("status_name"),
                            rs.getInt("status_checking_id"),
                            rs.getString("note"),
                            rs.getInt("extra_minutes")
                    );
                    list.add(dto);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countBookingDetails(int bookingId, int accountId) {
        String sql = "SELECT COUNT(*) FROM BookingDetails bd "
                + "JOIN Booking b ON bd.booking_id = b.booking_id "
                + "WHERE b.booking_id = ? AND b.account_id = ?";

        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, accountId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public BookingDetails getBookingDetailsById(int bookingDetailsId) {
        String sql = """
        SELECT booking_details_id, booking_id,booking_details_code, slot_field_id,
               slot_field_price, extra_minutes, extra_fee,
               slot_date, start_time, end_time, note, status_checking_id
        FROM BookingDetails
        WHERE booking_details_id = ?
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingDetailsId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new BookingDetails(
                            rs.getInt("booking_details_id"),
                            rs.getInt("booking_id"),
                            rs.getString("booking_details_code"),
                            rs.getInt("slot_field_id"),
                            rs.getBigDecimal("slot_field_price"),
                            rs.getInt("extra_minutes"),
                            rs.getBigDecimal("extra_fee"),
                            rs.getString("slot_date"),
                            rs.getString("start_time"),
                            rs.getString("end_time"),
                            rs.getString("note"),
                            rs.getInt("status_checking_id")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<BookingDetails> getAllBookingDetail() {
        List<BookingDetails> list = new ArrayList<>();

        String sql = "SELECT * FROM BookingDetails\n"
                + "ORDER BY booking_details_id DESC;";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingDetails bd = new BookingDetails();
                bd.setBookingDetailsId(rs.getInt("booking_details_id"));
                bd.setBookingId(rs.getInt("booking_id"));
                bd.setSlotFieldId(rs.getInt("slot_field_id"));
                bd.setSlotDate(rs.getString("slot_date"));
                bd.setStartTime(rs.getString("start_time"));
                bd.setEndTime(rs.getString("end_time"));
                bd.setStatusCheckingId(rs.getInt("status_checking_id"));
                bd.setNote(rs.getString("note"));
                bd.setExtraMinutes(rs.getInt("extra_minutes"));
                bd.setExtraFee(rs.getBigDecimal("extra_fee"));
                bd.setBookingDetailsCode(rs.getString("booking_details_code"));

                list.add(bd);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<BookingDetails> getAllBookingDetailsWithStatus() {
        List<BookingDetails> list = new ArrayList<>();

        String sql = "SELECT * FROM BookingDetails WHERE status_checking_id IN (1, 2,3)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingDetails bd = new BookingDetails();
                bd.setBookingDetailsId(rs.getInt("booking_details_id"));
                bd.setBookingId(rs.getInt("booking_id"));
                bd.setSlotFieldId(rs.getInt("slot_field_id"));
                bd.setSlotDate(rs.getString("slot_date"));
                bd.setStartTime(rs.getString("start_time"));
                bd.setEndTime(rs.getString("end_time"));
                bd.setStatusCheckingId(rs.getInt("status_checking_id"));
                bd.setNote(rs.getString("note"));
                bd.setExtraMinutes(rs.getInt("extra_minutes"));
                bd.setExtraFee(rs.getBigDecimal("extra_fee"));
                bd.setBookingDetailsCode(rs.getString("booking_details_code"));

                list.add(bd);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Lấy danh sách giao dịch chi tiết từ bảng BookingDetails (thay cho Payments)
    public List<java.util.Map<String, Object>> getDetailedBookingDetails() {
        List<java.util.Map<String, Object>> list = new java.util.ArrayList<>();
        String sql = """
            SELECT bd.booking_details_code, 
                   ISNULL(up.first_name, '') + ' ' + ISNULL(up.last_name, '') AS payer_name,
                   bd.slot_date, bd.start_time, bd.end_time, bd.slot_field_price, bd.extra_fee, bd.note
            FROM BookingDetails bd
            LEFT JOIN Booking b ON bd.booking_id = b.booking_id
            LEFT JOIN Account a ON b.account_id = a.account_id
            LEFT JOIN UserProfile up ON a.account_id = up.account_id
            ORDER BY bd.slot_date DESC, bd.start_time DESC
        """;
        try (java.sql.Connection conn = util.DBContext.getConnection();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            java.sql.ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                java.util.Map<String, Object> map = new java.util.HashMap<>();
                map.put("transaction_code", rs.getString("booking_details_code"));
                map.put("payer_name", rs.getString("payer_name"));
                map.put("pay_time", rs.getString("slot_date") + " " + rs.getString("start_time") + " - " + rs.getString("end_time"));
                java.math.BigDecimal slotPrice = rs.getBigDecimal("slot_field_price");
                java.math.BigDecimal extraFee = rs.getBigDecimal("extra_fee");
                if (slotPrice == null) slotPrice = java.math.BigDecimal.ZERO;
                if (extraFee == null) extraFee = java.math.BigDecimal.ZERO;
                map.put("transfer_amount", slotPrice.add(extraFee));
                map.put("gateway", "-"); // Không có cổng thanh toán
                map.put("description", rs.getString("note"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy danh sách giao dịch chi tiết từ BookingDetails có filter (bỏ noteKeyword)
    public List<java.util.Map<String, Object>> getDetailedBookingDetailsWithFilters(String payerKeyword, String paymentFromDate, String paymentToDate, String amountFrom, String amountTo) {
        List<java.util.Map<String, Object>> list = new java.util.ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT bd.booking_details_code, ");
        sql.append("ISNULL(up.first_name, '') + ' ' + ISNULL(up.last_name, '') AS payer_name, ");
        sql.append("bd.slot_date, bd.start_time, bd.end_time, bd.slot_field_price, bd.extra_fee, bd.note ");
        sql.append("FROM BookingDetails bd ");
        sql.append("LEFT JOIN Booking b ON bd.booking_id = b.booking_id ");
        sql.append("LEFT JOIN Account a ON b.account_id = a.account_id ");
        sql.append("LEFT JOIN UserProfile up ON a.account_id = up.account_id ");
        sql.append("WHERE 1=1 ");
        if (payerKeyword != null && !payerKeyword.isEmpty()) {
            sql.append(" AND (LOWER(ISNULL(up.first_name, '') + ' ' + ISNULL(up.last_name, '')) LIKE ? OR bd.booking_details_code LIKE ?) ");
        }
        if (paymentFromDate != null && !paymentFromDate.isEmpty()) {
            sql.append(" AND bd.slot_date >= ? ");
        }
        if (paymentToDate != null && !paymentToDate.isEmpty()) {
            sql.append(" AND bd.slot_date <= ? ");
        }
        if (amountFrom != null && !amountFrom.isEmpty()) {
            sql.append(" AND (bd.slot_field_price + ISNULL(bd.extra_fee,0)) >= ? ");
        }
        if (amountTo != null && !amountTo.isEmpty()) {
            sql.append(" AND (bd.slot_field_price + ISNULL(bd.extra_fee,0)) <= ? ");
        }
        sql.append("ORDER BY bd.slot_date DESC, bd.start_time DESC");
        try (java.sql.Connection conn = util.DBContext.getConnection();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int idx = 1;
            if (payerKeyword != null && !payerKeyword.isEmpty()) {
                String kw = "%" + payerKeyword.trim().toLowerCase() + "%";
                ps.setString(idx++, kw);
                ps.setString(idx++, payerKeyword.trim());
            }
            if (paymentFromDate != null && !paymentFromDate.isEmpty()) {
                ps.setString(idx++, paymentFromDate);
            }
            if (paymentToDate != null && !paymentToDate.isEmpty()) {
                ps.setString(idx++, paymentToDate);
            }
            if (amountFrom != null && !amountFrom.isEmpty()) {
                ps.setBigDecimal(idx++, new java.math.BigDecimal(amountFrom));
            }
            if (amountTo != null && !amountTo.isEmpty()) {
                ps.setBigDecimal(idx++, new java.math.BigDecimal(amountTo));
            }
            java.sql.ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                java.util.Map<String, Object> map = new java.util.HashMap<>();
                map.put("transaction_code", rs.getString("booking_details_code"));
                map.put("payer_name", rs.getString("payer_name"));
                map.put("pay_time", rs.getString("slot_date") + " " + rs.getString("start_time") + " - " + rs.getString("end_time"));
                java.math.BigDecimal slotPrice = rs.getBigDecimal("slot_field_price");
                java.math.BigDecimal extraFee = rs.getBigDecimal("extra_fee");
                if (slotPrice == null) slotPrice = java.math.BigDecimal.ZERO;
                if (extraFee == null) extraFee = java.math.BigDecimal.ZERO;
                map.put("transfer_amount", slotPrice.add(extraFee));
                map.put("gateway", "-");
                map.put("description", rs.getString("note"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy doanh thu từng tháng từ bookingdetails cho các booking đã hoàn thành
    public List<Double> getRevenueByMonthFromBookingDetails(int year) throws SQLException {
        List<Double> revenues = new ArrayList<>();
        String sql = "SELECT MONTH(bd.slot_date) AS month, SUM(bd.slot_field_price + ISNULL(bd.extra_fee, 0)) AS revenue " +
                     "FROM BookingDetails bd " +
                     "JOIN Booking b ON bd.booking_id = b.booking_id " +
                     "WHERE b.status_pay = 1 AND YEAR(bd.slot_date) = ? " +
                     "GROUP BY MONTH(bd.slot_date) ORDER BY MONTH(bd.slot_date)";
        try (Connection conn = util.DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            java.util.Map<Integer, Double> monthRevenue = new java.util.HashMap<>();
            while (rs.next()) {
                monthRevenue.put(rs.getInt("month"), rs.getDouble("revenue"));
            }
            for (int i = 1; i <= 12; i++) {
                revenues.add(monthRevenue.getOrDefault(i, 0.0));
            }
        }
        return revenues;
    }

    // Lấy doanh thu từng ngày trong 7 ngày gần nhất từ bookingdetails cho các booking đã hoàn thành
    public java.util.Map<String, Double> getRevenueByDayInLastWeekFromBookingDetails() throws SQLException {
        java.util.Map<String, Double> revenueByDay = new java.util.LinkedHashMap<>();
        String sql = "SELECT CONVERT(date, bd.slot_date) as day, SUM(bd.slot_field_price + ISNULL(bd.extra_fee, 0)) as revenue " +
                     "FROM BookingDetails bd " +
                     "JOIN Booking b ON bd.booking_id = b.booking_id " +
                     "WHERE b.status_pay = 1 AND bd.slot_date >= DATEADD(DAY, -6, CAST(GETDATE() AS date)) " +
                     "GROUP BY CONVERT(date, bd.slot_date) ORDER BY day";
        try (Connection conn = util.DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
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

    // Lấy doanh thu từng sân từ bookingdetails cho các booking đã hoàn thành
    public java.util.Map<String, Double> getRevenueByFieldFromBookingDetails() throws SQLException {
        java.util.Map<String, Double> revenueByField = new java.util.LinkedHashMap<>();
        String sql = "SELECT f.field_name, SUM(bd.slot_field_price + ISNULL(bd.extra_fee, 0)) as revenue " +
                     "FROM BookingDetails bd " +
                     "JOIN Booking b ON bd.booking_id = b.booking_id " +
                     "JOIN SlotsOfField sf ON bd.slot_field_id = sf.slot_field_id " +
                     "JOIN Field f ON sf.field_id = f.field_id " +
                     "WHERE b.status_pay = 1 " +
                     "GROUP BY f.field_name ORDER BY revenue DESC";
        try (Connection conn = util.DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String fieldName = rs.getString("field_name");
                double revenue = rs.getDouble("revenue");
                revenueByField.put(fieldName, revenue);
            }
        }
        return revenueByField;
    }

    // Thống kê số lượt booking theo loại sân (chỉ tính booking đã hoàn thành)
    public java.util.Map<String, Integer> getBookingTypeOfFieldRatioFromBookingDetails() throws SQLException {
        java.util.Map<String, Integer> typeRatio = new java.util.LinkedHashMap<>();
        String sql = "SELECT tof.field_type_name, COUNT(*) as count " +
                     "FROM BookingDetails bd " +
                     "JOIN Booking b ON bd.booking_id = b.booking_id " +
                     "JOIN SlotsOfField sf ON bd.slot_field_id = sf.slot_field_id " +
                     "JOIN Field f ON sf.field_id = f.field_id " +
                     "JOIN TypeOfField tof ON f.field_type_id = tof.field_type_id " +
                     "WHERE b.status_pay = 1 " +
                     "GROUP BY tof.field_type_name ORDER BY count DESC";
        try (Connection conn = util.DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String typeName = rs.getString("field_type_name");
                int count = rs.getInt("count");
                typeRatio.put(typeName, count);
            }
        }
        return typeRatio;
    }

    // Thống kê số lượt đặt theo khung giờ (giờ bắt đầu), chỉ tính booking đã hoàn thành
    public java.util.Map<String, Integer> getPopularBookingHoursFromBookingDetails() throws SQLException {
        java.util.Map<String, Integer> hourMap = new java.util.LinkedHashMap<>();
        String sql = "SELECT sod.start_time, COUNT(*) as count " +
                     "FROM BookingDetails bd " +
                     "JOIN Booking b ON bd.booking_id = b.booking_id " +
                     "JOIN SlotsOfField sf ON bd.slot_field_id = sf.slot_field_id " +
                     "JOIN SlotsOfDay sod ON sf.slot_id = sod.slot_id " +
                     "WHERE b.status_pay = 1 " +
                     "GROUP BY sod.start_time ORDER BY sod.start_time";
        try (Connection conn = util.DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String startTime = rs.getString("start_time");
                int count = rs.getInt("count");
                hourMap.put(startTime, count);
            }
        }
        return hourMap;
    }

    // Lấy tổng doanh thu trong khoảng ngày (chỉ booking đã hoàn thành)
    public java.math.BigDecimal getRevenueInDateRange(String fromDate, String toDate) throws SQLException {
        String sql = "SELECT SUM(bd.slot_field_price + ISNULL(bd.extra_fee, 0)) as revenue " +
                     "FROM BookingDetails bd " +
                     "JOIN Booking b ON bd.booking_id = b.booking_id " +
                     "WHERE b.status_pay = 1 AND bd.slot_date >= ? AND bd.slot_date <= ?";
        try (Connection conn = util.DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fromDate);
            ps.setString(2, toDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getBigDecimal("revenue") != null) {
                return rs.getBigDecimal("revenue");
            }
        }
        return java.math.BigDecimal.ZERO;
    }

    // Lấy tổng doanh thu theo tháng/năm (chỉ booking đã hoàn thành)
    public java.math.BigDecimal getRevenueByMonthYear(int month, int year) throws SQLException {
        String sql = "SELECT SUM(bd.slot_field_price + ISNULL(bd.extra_fee, 0)) as revenue " +
                     "FROM BookingDetails bd " +
                     "JOIN Booking b ON bd.booking_id = b.booking_id " +
                     "WHERE b.status_pay = 1 AND MONTH(bd.slot_date) = ? AND YEAR(bd.slot_date) = ?";
        try (Connection conn = util.DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getBigDecimal("revenue") != null) {
                return rs.getBigDecimal("revenue");
            }
        }
        return java.math.BigDecimal.ZERO;
    }

    // Lấy tổng doanh thu toàn hệ thống (chỉ booking đã hoàn thành)
    public java.math.BigDecimal getTotalRevenueFromBookingDetails() throws SQLException {
        String sql = "SELECT SUM(bd.slot_field_price + ISNULL(bd.extra_fee, 0)) as revenue " +
                     "FROM BookingDetails bd " +
                     "JOIN Booking b ON bd.booking_id = b.booking_id " +
                     "WHERE b.status_pay = 1";
        try (Connection conn = util.DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getBigDecimal("revenue") != null) {
                return rs.getBigDecimal("revenue");
            }
        }
        return java.math.BigDecimal.ZERO;
    }

    // Lấy tổng doanh thu từ một thời điểm (chỉ booking đã hoàn thành)
    public java.math.BigDecimal getRevenueSinceFromBookingDetails(java.time.LocalDateTime from) throws SQLException {
        String sql = "SELECT SUM(bd.slot_field_price + ISNULL(bd.extra_fee, 0)) as revenue " +
                     "FROM BookingDetails bd " +
                     "JOIN Booking b ON bd.booking_id = b.booking_id " +
                     "WHERE b.status_pay = 1 AND CONVERT(datetime, bd.slot_date, 120) >= ?";
        java.time.format.DateTimeFormatter dtf = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        try (Connection conn = util.DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, from.format(dtf));
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getBigDecimal("revenue") != null) {
                return rs.getBigDecimal("revenue");
            }
        }
        return java.math.BigDecimal.ZERO;
    }

    // Lấy tổng doanh thu theo năm (chỉ booking đã hoàn thành)
    public java.math.BigDecimal getRevenueByYearFromBookingDetails(int year) throws SQLException {
        String sql = "SELECT SUM(bd.slot_field_price + ISNULL(bd.extra_fee, 0)) as revenue " +
                     "FROM BookingDetails bd " +
                     "JOIN Booking b ON bd.booking_id = b.booking_id " +
                     "WHERE b.status_pay = 1 AND YEAR(bd.slot_date) = ?";
        try (Connection conn = util.DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getBigDecimal("revenue") != null) {
                return rs.getBigDecimal("revenue");
            }
        }
        return java.math.BigDecimal.ZERO;
    }

    // Lấy tổng doanh thu theo khoảng tháng trong 1 năm (chỉ booking đã hoàn thành)
    public java.math.BigDecimal getRevenueByMonthRange(int fromMonth, int toMonth, int year) throws SQLException {
        String sql = "SELECT SUM(bd.slot_field_price + ISNULL(bd.extra_fee, 0)) as revenue " +
                     "FROM BookingDetails bd " +
                     "JOIN Booking b ON bd.booking_id = b.booking_id " +
                     "WHERE b.status_pay = 1 AND YEAR(bd.slot_date) = ? AND MONTH(bd.slot_date) BETWEEN ? AND ?";
        try (Connection conn = util.DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, fromMonth);
            ps.setInt(3, toMonth);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getBigDecimal("revenue") != null) {
                return rs.getBigDecimal("revenue");
            }
        }
        return java.math.BigDecimal.ZERO;
    }

    public static void main(String[] args) {
        try (Connection conn = DBContext.getConnection()) {
            BookingDetailsDAO dao = new BookingDetailsDAO();
            dao.setConnection(conn);

            // Ví dụ bookingId để test
            int bookingId = 1;  // Bạn thay bằng bookingId thực tế cần kiểm tra

            int futureSlotCount = dao.countFutureSlotsByBooking(bookingId);
            System.out.println("Số ca chưa đá của booking " + bookingId + ": " + futureSlotCount);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
