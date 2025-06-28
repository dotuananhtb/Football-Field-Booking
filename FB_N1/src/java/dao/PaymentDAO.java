package dao;

import model.Payment;
import util.DBContext;

import java.sql.*;

public class PaymentDAO extends DBContext {
    public void insert(Payment p) throws SQLException {
        String sql = "INSERT INTO Payments (booking_id, transaction_code, transfer_amount, pay_time, confirmed_time, pay_status, gateway, content, description, raw_data) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
}
