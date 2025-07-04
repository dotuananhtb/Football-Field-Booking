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
        String sql = "UPDATE BookingDetails SET status_checking_id = ? WHERE booking_details_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newStatus);
            ps.setInt(2, bookingDetailsId);

            return ps.executeUpdate() > 0;
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

}
