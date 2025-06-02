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
        String sql = "UPDATE Account SET status_id = ? WHERE account_id = ?";
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

    // check mật khẩu
    public boolean isSamePassword(int accountId, String newPassword) {
        Account acc = getAccountById(accountId);
        if (acc == null) {
            return false;
        }
        return acc.getPassword().equals(newPassword);
    }

    public boolean isStrongPassword(String password) {
        // Regex: ít nhất 8 ký tự, 1 chữ hoa, 1 chữ thường, 1 số, 1 ký tự đặc biệt
        String check = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@#$%^&+=!()_\\-{}\\[\\]:;\"'<>,.?/~`|\\\\]).{8,}$";
        return password != null && password.matches(check);
    }

    public Account getAccountById(int accountId) {
        String sql = "SELECT * FROM [FootballFieldBooking].[dbo].[Account] WHERE account_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePassword(String email, String password) {
        String sql = "UPDATE [dbo].[Account] SET [password] = ? WHERE [email] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, password);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean resetPass(String email) {
        String insertTokenSQL = "INSERT INTO EmailVerification (account_id, token, created_at, expires_at, is_used) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement psToken = null;
        try {
            String token = java.util.UUID.randomUUID().toString();
            String createdAt = java.time.LocalDateTime.now().toString();
            String expiresAt = java.time.LocalDateTime.now().plusHours(24).toString();

            psToken = connection.prepareStatement(insertTokenSQL);
            psToken.setInt(1, getAcountIdByEmail(email));
            psToken.setString(2, token);
            psToken.setString(3, createdAt);
            psToken.setString(4, expiresAt);
            psToken.setBoolean(5, false);
            psToken.executeUpdate();
            connection.commit();

            String verifyLink = "http://localhost:9999/FB_N1/resetPassword?token=" + token;
            SendMail sender = new SendMail();
            sender.guiResetPasswordMail(email, verifyLink, getLastNameByEmail(email));
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public String getLastNameByEmail(String email) {
        String sql = "SELECT up.last_name FROM Account a JOIN UserProfile up ON a.account_id = up.account_id WHERE a.email = ?";
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
        return null;
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
        return null;
    }

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
                if (generatedKeys != null)
                    generatedKeys.close();
                if (psAccount != null)
                    psAccount.close();
                if (psProfile != null)
                    psProfile.close();
                if (psToken != null)
                    psToken.close();
                connection.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public boolean update_Password(String username, String newPassword) {
        String sql = "UPDATE [Account] SET password = ? WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, username);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkPassword(String username, String password) {
        String sql = "SELECT password FROM [Account] WHERE username = ? AND password = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getAccountIDbyUsername(String username) {
        String sql = "SELECT account_id FROM [FootballFieldBooking].[dbo].[Account] WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public boolean checkLogin(String userName, String passWord) {
        String sql = "SELECT * FROM [FootballFieldBooking].[dbo].[Account] WHERE username = ? AND password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, userName);
            st.setString(2, passWord);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // New methods for Google Sign-In
    public boolean checkGoogleIdExists(String googleId) {
        String sql = "SELECT 1 FROM GoogleAuth WHERE google_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, googleId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addGoogleAccount(String googleId, String email, String name, String accessToken, String refreshToken,
            long expiresIn) {
        String insertAccountSQL = "INSERT INTO Account (status_id, username, password, email, created_at) VALUES (?, ?, ?, ?, ?)";
        String insertProfileSQL = "INSERT INTO UserProfile (account_id, role_id, first_name, last_name) VALUES (?, ?, ?, ?)";
        String insertGoogleAuthSQL = "INSERT INTO GoogleAuth (account_id, google_id, access_token, refresh_token, expires_at, created_at) VALUES (?, ?, ?, ?, ?, ?)";

        PreparedStatement psAccount = null;
        PreparedStatement psProfile = null;
        PreparedStatement psGoogleAuth = null;
        ResultSet generatedKeys = null;

        try {
            connection.setAutoCommit(false);

            // Generate a unique username based on email
            String username = email.split("@")[0] + "_" + System.currentTimeMillis();
            String createdAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            String expiresAt = LocalDateTime.now().plusSeconds(expiresIn)
                    .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

            // Insert into Account
            psAccount = connection.prepareStatement(insertAccountSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            psAccount.setInt(1, 1); // status_id = 1 (Hoạt động)
            psAccount.setString(2, username);
            psAccount.setString(3, ""); // No password for Google accounts
            psAccount.setString(4, email);
            psAccount.setString(5, createdAt);
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

            // Insert into UserProfile
            psProfile = connection.prepareStatement(insertProfileSQL);
            psProfile.setInt(1, accountId);
            psProfile.setInt(2, 3); // role_id = 3 (USER)
            psProfile.setString(3, name);
            psProfile.setString(4, "");
            psProfile.executeUpdate();

            // Insert into GoogleAuth
            psGoogleAuth = connection.prepareStatement(insertGoogleAuthSQL);
            psGoogleAuth.setInt(1, accountId);
            psGoogleAuth.setString(2, googleId);
            psGoogleAuth.setString(3, accessToken);
            psGoogleAuth.setString(4, refreshToken != null ? refreshToken : "");
            psGoogleAuth.setString(5, expiresAt);
            psGoogleAuth.setString(6, createdAt);
            psGoogleAuth.executeUpdate();

            connection.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                if (generatedKeys != null)
                    generatedKeys.close();
                if (psAccount != null)
                    psAccount.close();
                if (psProfile != null)
                    psProfile.close();
                if (psGoogleAuth != null)
                    psGoogleAuth.close();
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public Integer getAccountIdByGoogleId(String googleId) {
        String sql = "SELECT account_id FROM GoogleAuth WHERE google_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, googleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("account_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getRoleIDbyAccount(String username, String password) {
        int roleID = 0;
        String sql = "SELECT u.role_id\n"
                + "  FROM [FootballFieldBooking].[dbo].[Account] a join [dbo].[UserProfile] u on a.account_id = u.account_id\n"
                + "  where a.username = ? and a.password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                roleID = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return roleID;
    }

    public int getStatusIDbyAccount(String username, String password) {
        int statusID = 0;
        String sql = "SELECT a.status_id\n"
                + "  FROM [FootballFieldBooking].[dbo].[Account]  a\n"
                + "  where a.username = ? and a.password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                statusID = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return statusID;
    }

    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();
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
        account.setUsername("binhcute5a");
        account.setPassword("123456");
        account.setEmail("pitiy69288@pricegh.com");
        account.setCreatedAt(createdAt);
        account.setUserProfile(profile);

        boolean result = dao.addAccountAndSendVerificationEmail(account);
    }
}