/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.BookingDetails;
import util.DBContext;
import model.Booking;
import model.BookingDetails;
import util.DBContext;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.BookingDetailsDTO;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class BookingDetailsDAO extends DBContext {

    public boolean insertBookingDetail(BookingDetails detail) {
        String sql = "INSERT INTO BookingDetails (booking_id, slot_field_id, slot_field_price, extra_minutes, extra_fee, slot_date, note, status_checking_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, detail.getBookingId());
            ps.setInt(2, detail.getSlotFieldId());
            ps.setBigDecimal(3, detail.getSlotFieldPrice());
            ps.setInt(4, detail.getExtraMinutes());
            ps.setBigDecimal(5, detail.getExtraFee());
            ps.setString(6, detail.getSlotDate());
            ps.setString(7, detail.getNote());
            ps.setInt(8, detail.getStatusCheckingId());

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
                        rs.getInt("slot_field_id"),
                        rs.getBigDecimal("slot_field_price"),
                        rs.getInt("extra_minutes"),
                        rs.getBigDecimal("extra_fee"),
                        rs.getString("slot_date"),
                        rs.getString("note"),
                        rs.getInt("status_checking_id")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy chi tiết đặt sân theo booking
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
                        rs.getInt("slot_field_id"),
                        rs.getBigDecimal("slot_field_price"),
                        rs.getInt("extra_minutes"),
                        rs.getBigDecimal("extra_fee"),
                        rs.getString("slot_date"),
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

        String sql = "SELECT bd.booking_details_id, f.field_name, f.image, sd.start_time, sd.end_time, "
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

}
