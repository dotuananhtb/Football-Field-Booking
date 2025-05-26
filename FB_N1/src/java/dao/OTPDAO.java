package dao;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.OTP;
import util.DBContext;

public class OTPDAO {

    private Connection connection;

    public OTPDAO() {
        try {
            connection = new DBContext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // CREATE
    public boolean insertOTP(OTP otp) {
        String sql = "INSERT INTO OTP (account_id, otp, otp_date) VALUES (?, ?, ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, otp.getAccountId());
            stm.setString(2, otp.getOtp());
            stm.setTimestamp(3, (Timestamp) otp.getOtpDate());
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(OTPDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // READ
    public OTP getOtpByAccountId(int accountId) {
        String sql = "SELECT * FROM OTP WHERE account_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, accountId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                OTP otpObj = new OTP();
                otpObj.setOtpId(rs.getInt("otp_id"));
                otpObj.setAccountId(rs.getInt("account_id"));
                otpObj.setOtp(rs.getString("otp"));
                otpObj.setOtpDate(rs.getTimestamp("otp_date"));
                return otpObj;
            }
        } catch (SQLException ex) {
            Logger.getLogger(OTPDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // UPDATE
    public boolean updateOtp(OTP otp) {
        String sql = "UPDATE OTP SET otp = ?, otp_date = ? WHERE account_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, otp.getOtp());
            stm.setTimestamp(2, (Timestamp) otp.getOtpDate());
            stm.setInt(3, otp.getAccountId());
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(OTPDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // DELETE
    public boolean deleteOtpByAccountId(int accountId) {
        String sql = "DELETE FROM OTP WHERE account_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, accountId);
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(OTPDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
