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

}
