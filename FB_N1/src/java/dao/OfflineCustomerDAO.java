package dao;

import model.OfflineUser;
import model.OfflineCustomer;
import util.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author Đỗ Tuấn Anh
 */
public class OfflineCustomerDAO extends DBContext {

    public void setConnection(Connection conn) {
        this.connection = conn;
    }

    // Thêm khách offline vào bảng liên kết booking
    public boolean insertOfflineCustomer(OfflineCustomer customer) {
        String sql = "INSERT INTO OfflineCustomer (booking_id, offline_user_id) VALUES (?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customer.getBookingId());
            ps.setInt(2, customer.getOfflineUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Lấy đối tượng OfflineCustomer từ booking_id
    public OfflineCustomer getOfflineCustomerByBookingId(int bookingId) {
        String sql = "SELECT * FROM OfflineCustomer WHERE booking_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                OfflineCustomer c = new OfflineCustomer();
                c.setBookingId(rs.getInt("booking_id"));
                c.setOfflineUserId(rs.getInt("offline_user_id"));
                return c;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Lấy OfflineUser từ booking_detail_id
    public OfflineUser getOfflineUserByBookingDetailId(int bookingDetailId) {
        String sql = """
            SELECT ou.offline_user_id, ou.full_name, ou.phone, ou.email, ou.created_date, ou.created_by
            FROM OfflineCustomer oc
            JOIN BookingDetails bd ON oc.booking_id = bd.booking_id
            JOIN OfflineUser ou ON oc.offline_user_id = ou.offline_user_id
            WHERE bd.booking_details_id = ?
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingDetailId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                OfflineUser ou = new OfflineUser();
                ou.setOfflineUserId(rs.getInt("offline_user_id"));
                ou.setFullName(rs.getString("full_name"));
                ou.setPhone(rs.getString("phone"));
                ou.setEmail(rs.getString("email"));
                ou.setCreatedDate(rs.getString("created_date"));
                ou.setCreatedBy(rs.getInt("created_by"));
                return ou;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
