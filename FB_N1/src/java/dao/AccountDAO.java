package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import mailverify.SendMail;
import model.Account;
import model.UserProfile;
import util.DBContext;

public class AccountDAO extends DBContext {

    public boolean updateStatus(int accountId, int newStatusId) {
        String sql = "UPDATE Account SET status_id = 1 WHERE account_id = ?";
        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, newStatusId);
            ps.setInt(2, accountId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //lấy email
    public Account getAccountById(int accountId) {
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Account]\n"
                + "  where account_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

//    rs.getInt(1),
//                        rs.getInt(2),
//                        rs.getString(3),
//                        rs.getString(4), rs.getString(5),
//                        rs.getString(6), 
//                        u);
    //cập nhật mật khẩu
    public void updatePassword(String email, String password) {
        String sql = "UPDATE [dbo].[Account]\n"
                + "SET [password] = ?\n"
                + "WHERE [email] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, password);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
//gửi link xác nhận tài khoản đến mail

    public boolean resetPass(String email) {
        String insertTokenSQL = "INSERT INTO EmailVerification (account_id, token, created_at, expires_at, is_used) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement psToken = null;
        ResultSet generatedKeys = null;
        AccountDAO dao = new AccountDAO();
        try {
            // 3. Tạo token xác minh

            String token = java.util.UUID.randomUUID().toString();
            String createdAt = java.time.LocalDateTime.now().toString();
            String expiresAt = java.time.LocalDateTime.now().plusHours(24).toString();

            psToken = connection.prepareStatement(insertTokenSQL);
            psToken.setInt(1, dao.getAcountIdByEmail(email));
            psToken.setString(2, token);
            psToken.setString(3, createdAt);
            psToken.setString(4, expiresAt);
            psToken.setBoolean(5, false);
            psToken.executeUpdate();
            connection.commit();

            // 4. Gửi email xác minh
            String verifyLink = "http://localhost:9999/FB_N1/resetPassword?token=" + token;

            SendMail sender = new SendMail();
            sender.guiResetPasswordMail(email, verifyLink, dao.getLastNameByEmail(email));

            return true;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public String getLastNameByEmail(String email) {
        String sql = """
        SELECT up.last_name 
        FROM Account a 
        JOIN UserProfile up ON a.account_id = up.account_id 
        WHERE a.email = ?
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("last_name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public Integer getAcountIdByEmail(String email) {
        String sql = "SELECT account_id FROM Account WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("account_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy hoặc lỗi
    }

    public Integer getStatusIdByEmail(String email) {
        String sql = "SELECT status_id FROM Account WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("status_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy hoặc lỗi
    }
    //// Ham de xu li dang ki _ Tuan Anh
    // 1. Kiểm tra tồn tại username

    public boolean checkTonTaiUsername(String username) {
        String sql = "SELECT 1 FROM Account WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 2. Kiểm tra tồn tại email
    public boolean checkTonTaiEmail(String email) {
        String sql = "SELECT 1 FROM Account WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3. Thêm tài khoản và hồ sơ người dùng
    public boolean addAccountAndSendVerificationEmail(Account account) {
        String insertAccountSQL = "INSERT INTO Account (status_id, username, password, email, created_at) VALUES (?, ?, ?, ?, ?)";
        String insertProfileSQL = "INSERT INTO UserProfile (account_id, role_id, first_name, last_name, address, gender, dob, phone, avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String insertTokenSQL = "INSERT INTO EmailVerification (account_id, token, created_at, expires_at, is_used) VALUES (?, ?, ?, ?, ?)";

        PreparedStatement psAccount = null;
        PreparedStatement psProfile = null;
        PreparedStatement psToken = null;
        ResultSet generatedKeys = null;

        try {
            connection.setAutoCommit(false);

            // 1. Thêm tài khoản
            psAccount = connection.prepareStatement(insertAccountSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            psAccount.setInt(1, 2); // statusId = 2 (chưa xác minh)
            psAccount.setString(2, account.getUsername());
            psAccount.setString(3, account.getPassword());
            psAccount.setString(4, account.getEmail());
            psAccount.setString(5, account.getCreatedAt());
            int affectedRows = psAccount.executeUpdate();

            if (affectedRows == 0) {
                connection.rollback();
                return false;
            }

            generatedKeys = psAccount.getGeneratedKeys();
            int accountId = -1;
            if (generatedKeys.next()) {
                accountId = generatedKeys.getInt(1);
            } else {
                connection.rollback();
                return false;
            }

            // 2. Thêm hồ sơ người dùng
            UserProfile p = account.getUserProfile();
            psProfile = connection.prepareStatement(insertProfileSQL);
            psProfile.setInt(1, accountId);
            psProfile.setInt(2, p.getRoleId());
            psProfile.setString(3, p.getFirstName());
            psProfile.setString(4, p.getLastName());
            psProfile.setString(5, p.getAddress());
            psProfile.setString(6, p.getGender());
            psProfile.setString(7, p.getDob());
            psProfile.setString(8, p.getPhone());
            psProfile.setString(9, p.getAvatar());
            psProfile.executeUpdate();

            // 3. Tạo token xác minh
            String token = java.util.UUID.randomUUID().toString();
            String createdAt = java.time.LocalDateTime.now().toString();
            String expiresAt = java.time.LocalDateTime.now().plusHours(24).toString();

            psToken = connection.prepareStatement(insertTokenSQL);
            psToken.setInt(1, accountId);
            psToken.setString(2, token);
            psToken.setString(3, createdAt);
            psToken.setString(4, expiresAt);
            psToken.setBoolean(5, false);
            psToken.executeUpdate();

            connection.commit();

            // 4. Gửi email xác minh
            String verifyLink = "http://localhost:9999/FB_N1/verify?token=" + token;

            SendMail sender = new SendMail();
            Thread thread = new Thread(() -> {
                try {
                    sender.guiMailFULLHD(account.getEmail(), verifyLink, p.getLastName());
                } catch (Exception e) {
                    e.printStackTrace();
                }
            });
            thread.start();
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
                if (generatedKeys != null) {
                    generatedKeys.close();
                }
                if (psAccount != null) {
                    psAccount.close();
                }
                if (psProfile != null) {
                    psProfile.close();
                }
                if (psToken != null) {
                    psToken.close();
                }
                connection.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    //5. Thay đổi mật khẩu
    public boolean update_Password(String username, String newPassword) {
        String sql = "UPDATE [Account] SET password=? WHERE username=?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, newPassword);
            ps.setString(2, username);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //6. Check mật khẩu
    public boolean checkPassword(String username, String password) {
        String sql = "SELECT password FROM [Account] WHERE username=? AND password=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Returns true if password matches
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // TEST MAIN
    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();

        // Dữ liệu mẫu để test
        String createdAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        UserProfile profile = new UserProfile();
        profile.setRoleId(3);
        profile.setFirstName("Tuan");
        profile.setLastName("Anh");
        profile.setAddress("Ha Noi");
        profile.setGender("Nam");
        profile.setDob("2000-01-01");
        profile.setPhone("0123456789");
        profile.setAvatar("assets/img/avatars/avatar_goc.jpg");

        Account account = new Account();

        account.setStatusId(3);
        account.setUsername("binhcute5a"); // Đổi mỗi lần test để tránh trùng
        account.setPassword("123456");
        account.setEmail("pitiy69288@pricegh.com"); // Đổi mỗi lần test
        account.setCreatedAt(createdAt);
        account.setUserProfile(profile);

        // Thực thi và in kết quả
        boolean result = dao.addAccountAndSendVerificationEmail(account);
//        if (result) {
//            System.out.println("Thêm tài khoản và gửi email xác minh thành công!");
//        } else {
//            System.out.println("Thêm tài khoản thất bại hoặc lỗi gửi email.");
//        }
//        System.out.println(dao.getStatusIdByEmail("pitiy69288@pricegh.com"));
//        dao.resetPass("dognoperke@gufum.com");
//            int testId=1;
//           Account acc = dao.getAccountById(testId);
//
//            if (acc != null) {
//                System.out.println("Thông tin tài khoản:");
//                System.out.println("ID: " + acc.getAccountId());
//                System.out.println("Username: " + acc.getUsername());
//                System.out.println("Email: " + acc.getEmail());
//                System.out.println("Password: " + acc.getPassword());
//                System.out.println("Created At: " + acc.getCreatedAt());
//                System.out.println("Status ID: " + acc.getStatusId());
//            } else {
//                System.out.println("Không tìm thấy tài khoản có ID = " + testId);
//            }
    }

}
