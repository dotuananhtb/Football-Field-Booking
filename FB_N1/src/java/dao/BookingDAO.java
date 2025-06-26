package dao;

import model.Booking;
import model.BookingDetails;
import util.DBContext;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO extends DBContext {
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
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setBookingCode(rs.getString("booking_code"));
                booking.setTotalAmount(rs.getBigDecimal("total_amount"));
                booking.setStatusPay(rs.getBoolean("status_pay"));
                return booking;
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
            ps.setBoolean(7, booking.isStatusPay());
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
                        rs.getBoolean("status_pay")
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
                        rs.getBoolean("status_pay")
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
                        rs.getBoolean("status_pay")
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
                        rs.getBoolean("status_pay")
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
}
