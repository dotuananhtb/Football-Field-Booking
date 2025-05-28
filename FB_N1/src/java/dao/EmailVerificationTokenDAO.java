/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Đỗ Tuấn Anh
 */
import java.sql.*;
import model.EmailVerificationToken;
import util.DBContext;

public class EmailVerificationTokenDAO {

    // Lấy token từ DB
    public EmailVerificationToken getTokenByValue(String tokenValue) {
        String sql = "SELECT * FROM EmailVerification WHERE token = ?";
        try (Connection conn = new DBContext().connection; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, tokenValue);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                EmailVerificationToken token = new EmailVerificationToken();
                token.setId(rs.getInt("id"));
                token.setAccountId(rs.getInt("account_id"));
                token.setToken(rs.getString("token"));
                token.setCreatedAt(rs.getString("created_at"));
                token.setExpiresAt(rs.getString("expires_at"));
                token.setUsed(rs.getBoolean("is_used"));
                return token;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Đánh dấu token đã sử dụng
    public boolean markTokenAsUsed(String token) {
        String sql = "UPDATE EmailVerification SET is_used = 1 WHERE token = ?";
        try (Connection conn = new DBContext().connection; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, token);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật statusId của tài khoản thành 1 (đã xác minh)
    public boolean activateAccount(int accountId) {
        String sql = "UPDATE Account SET status_id = 1 WHERE account_id = ?";
        try (Connection conn = new DBContext().connection; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, accountId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm thử DAO
    public static void main(String[] args) {
        EmailVerificationTokenDAO dao = new EmailVerificationTokenDAO();

        // ✅ Sử dụng token thực tế trong DB
        String tokenValue = "b0f96141-13e8-48a4-bfa4-6e9824c91be5";

        EmailVerificationToken token = dao.getTokenByValue(tokenValue);
        if (token != null) {
            System.out.println("✔ Token tìm thấy:");
            System.out.println("Token: " + token.getToken());
            System.out.println("isUsed: " + token.isUsed());
            System.out.println("accountId: " + token.getAccountId());

            boolean usedUpdated = dao.markTokenAsUsed(token.getToken());
            System.out.println("→ markTokenAsUsed: " + (usedUpdated ? "THÀNH CÔNG" : "THẤT BẠI"));

            boolean accountUpdated = dao.activateAccount(token.getAccountId());
            System.out.println("→ activateAccount: " + (accountUpdated ? "THÀNH CÔNG" : "THẤT BẠI"));
        } else {
            System.out.println("❌ Token không tồn tại trong DB.");
        }
    }
}
