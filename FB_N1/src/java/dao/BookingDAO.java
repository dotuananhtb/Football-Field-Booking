/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Đỗ Tuấn Anh
 */
import model.Booking;
import model.BookingDetails;
import util.DBContext;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO extends DBContext {

    // Thêm đơn đặt sân, trả về booking_id
    public int insertBooking(Booking booking) {
        String sql = "INSERT INTO Booking (account_id, sale_id, booking_date, total_amount, email) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Định dạng ngày hiện tại
            String now = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

            ps.setInt(1, booking.getAccountId());

            if (booking.getSaleId() != null) {
                ps.setInt(2, booking.getSaleId());
            } else {
                ps.setNull(2, Types.INTEGER);
            }

            ps.setString(3, now); // Ghi nhận thời gian hiện tại
            ps.setBigDecimal(4, booking.getTotalAmount());
            ps.setString(5, booking.getEmail());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Trả về booking_id vừa tạo
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    public void setConnection(Connection conn) {
        this.connection = conn;
    }

    // Lấy danh sách booking theo account
    public List<Booking> getBookingsByAccountId(int accountId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE account_id = ? ORDER BY booking_date DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("booking_id"),
                        rs.getInt("account_id"),
                        rs.getObject("sale_id") != null ? rs.getInt("sale_id") : null,
                        rs.getString("booking_date"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("email")
                );
                list.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Booking> getBookingsByAccountIdPaging(int accountId, int page) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE account_id = ? ORDER BY booking_date DESC OFFSET ? ROWS FETCH NEXT 3 ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int offset = (page - 1) * 3; // 3 dòng mỗi trang
            ps.setInt(1, accountId);
            ps.setInt(2, offset);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getInt("booking_id"),
                        rs.getInt("account_id"),
                        rs.getObject("sale_id") != null ? rs.getInt("sale_id") : null,
                        rs.getString("booking_date"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("email")
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

    // Tính tổng tiền của 1 booking
    public BigDecimal calculateTotalBooking(List<BookingDetails> detailsList) {
        BigDecimal total = BigDecimal.ZERO;

        for (BookingDetails detail : detailsList) {
            BigDecimal slotPrice = detail.getSlotFieldPrice() != null ? detail.getSlotFieldPrice() : BigDecimal.ZERO;
            BigDecimal extraFee = detail.getExtraFee() != null ? detail.getExtraFee() : BigDecimal.ZERO;
            total = total.add(slotPrice).add(extraFee);
        }

        int slotCount = detailsList.size(); // Số lượng ca đặt
        SaleDAO saleDAO = new SaleDAO();
        int discountPercent = saleDAO.getDiscountPercent(slotCount);

        if (discountPercent > 0) {
            BigDecimal discount = total.multiply(BigDecimal.valueOf(discountPercent)).divide(BigDecimal.valueOf(100));
            total = total.subtract(discount);
        }

        return total;
    }

}
