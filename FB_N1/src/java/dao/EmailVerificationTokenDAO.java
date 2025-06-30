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
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.UUID;
import mailverify.SendMail;
import model.EmailVerificationToken;
import util.DBContext;

public class EmailVerificationTokenDAO extends DBContext {

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

    public Integer getAccountIdByToken(String token) {
        String sql = "SELECT account_id FROM EmailVerification WHERE token = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("account_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /////======================================================================
    public boolean isTokenExistsInDB(String token) {
        String sql = "SELECT 1 FROM EmailVerification WHERE token = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private EmailVerificationToken getLatestTokenByAccountId(int accountId) throws SQLException {
        String sql = "SELECT TOP 1 token, expires_at, is_used FROM EmailVerification "
                + "WHERE account_id = ? ORDER BY created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    EmailVerificationToken token = new EmailVerificationToken();
                    token.setToken(rs.getString("token"));
                    token.setExpiresAt(rs.getString("expires_at"));
                    token.setUsed(rs.getBoolean("is_used"));
                    return token;
                }
            }
        }
        return null;
    }

    private void markAllTokensUsed(int accountId) throws SQLException {
        String sql = "UPDATE EmailVerification SET is_used = 1 WHERE account_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ps.executeUpdate();
        }
    }

    private String generateUniqueToken() throws SQLException {
        String token;
        do {
            token = UUID.randomUUID().toString();
        } while (isTokenExistsInDB(token));
        return token;
    }

    private void insertNewToken(int accountId, String token, String createdAt, String expiresAt) throws SQLException {
        String sql = "INSERT INTO EmailVerification (account_id, token, created_at, expires_at, is_used) "
                + "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ps.setString(2, token);
            ps.setString(3, createdAt);
            ps.setString(4, expiresAt);
            ps.setBoolean(5, false);
            ps.executeUpdate();
        }
    }

    private void sendVerificationMail(String email, String lastName, String token) {
        String verifyLink = "http://localhost:9999/FB_N1/verify?token=" + token;
        SendMail sender = new SendMail();
        new Thread(() -> {
            try {
                sender.guiMailFULLHD(email, verifyLink, lastName);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }).start();
    }

    public boolean createOrResendVerificationToken(int accountId, String email, String lastName) {
        try {
            connection.setAutoCommit(false);

            EmailVerificationToken token = getLatestTokenByAccountId(accountId);

            if (token != null) {
                boolean isExpired = System.currentTimeMillis()
                        > LocalDateTime.parse(token.getExpiresAt()).toInstant(ZoneOffset.UTC).toEpochMilli();
                if (!token.isUsed() && !isExpired) {
                    sendVerificationMail(email, lastName, token.getToken());
                    connection.commit();
                    return true;
                }
                markAllTokensUsed(accountId);
            }

            String newToken = generateUniqueToken();
            String createdAt = LocalDateTime.now().toString();
            String expiresAt = LocalDateTime.now().plusMinutes(30).toString();

            insertNewToken(accountId, newToken, createdAt, expiresAt);
            sendVerificationMail(email, lastName, newToken);

            connection.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
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
