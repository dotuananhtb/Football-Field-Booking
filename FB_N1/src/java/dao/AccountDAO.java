package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import mailverify.SendMail;
import model.Account;
import model.Role;
import model.UserProfile;
import util.DBContext;

public class AccountDAO extends DBContext {

    public List<Account> getAccountByRoleId(int roleId) {

        List<Account> list = new ArrayList<>();
        String sql = "SELECT a.account_id, a.username, a.status_id, a.password, a.email, a.created_at, u.address, u.avatar, u.dob, u.first_name,\n"
                + "u.gender,u.last_name,u.phone,u.role_id\n"
                + "  FROM [FootballFieldBooking].[dbo].[Account] a join UserProfile u on a.account_id = u.account_id\n"
                + "  where u.role_id = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql);) {
            ptm.setInt(1, roleId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {

                UserProfile u = new UserProfile(
                        rs.getInt("account_id"),
                        rs.getInt("role_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("address"),
                        rs.getString("gender"),
                        rs.getString("dob"),
                        rs.getString("phone"),
                        rs.getString("avatar")
                );

                Account a = new Account(rs.getInt("account_id"), rs.getInt("status_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getString("created_at"),
                        u);
                list.add(a);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EventDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }

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

    public boolean changeStatus(String accountId, String newStatusId) {
        String sql = "UPDATE Account SET status_id = ? WHERE account_id = ?";
        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatusId);
            ps.setString(2, accountId);
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

    //
    public Account getAccountById(int accountId) {
        UserProfileDAO userProfileDAO = new UserProfileDAO();
        String sql = "SELECT * FROM [FootballFieldBooking].[dbo].[Account] WHERE account_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), userProfileDAO.getProfileByAccountId(accountId));

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public Account getAccountByIdString(String accountId) {
        UserProfileDAO userProfileDAO = new UserProfileDAO();
        String sql = "SELECT * FROM [FootballFieldBooking].[dbo].[Account] WHERE account_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), userProfileDAO.getProfileByAccountIdString(accountId));

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

   public boolean insertAccountWithProfile(Account account) {
    String insertAccountSQL = "INSERT INTO Account (status_id, username, password, email, created_at) VALUES (?, ?, ?, ?, ?)";
    String insertProfileSQL = "INSERT INTO UserProfile (account_id, role_id, avatar) VALUES (?, ?, ?)";

    try {
        connection.setAutoCommit(false); // Bắt đầu transaction

        // Insert vào bảng Account
        PreparedStatement psAccount = connection.prepareStatement(insertAccountSQL, PreparedStatement.RETURN_GENERATED_KEYS);
        psAccount.setInt(1, account.getStatusId());
        psAccount.setString(2, account.getUsername());
        psAccount.setString(3, account.getPassword());
        psAccount.setString(4, account.getEmail());
        psAccount.setString(5, account.getCreatedAt());

        int affectedRows = psAccount.executeUpdate();
        if (affectedRows == 0) {
            connection.rollback();
            return false;
        }

        // Lấy account_id vừa tạo
        ResultSet rs = psAccount.getGeneratedKeys();
        int accountId;
        if (rs.next()) {
            accountId = rs.getInt(1);
            account.setAccountId(accountId);
        } else {
            connection.rollback();
            return false;
        }

        // Insert vào bảng UserProfile
        UserProfile profile = account.getUserProfile();
        if (profile == null) {
            connection.rollback();
            return false; // hoặc bạn có thể tạo UserProfile mặc định
        }

        PreparedStatement psProfile = connection.prepareStatement(insertProfileSQL);
        psProfile.setInt(1, accountId);
        psProfile.setInt(2, profile.getRoleId());
        psProfile.setString(3, profile.getAvatar());

        int profileRows = psProfile.executeUpdate();
        if (profileRows == 0) {
            connection.rollback();
            return false;
        }

        connection.commit(); // Nếu mọi thứ thành công
        return true;

    } catch (SQLException e) {
        try {
            connection.rollback();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        e.printStackTrace();
        return false;
    } finally {
        try {
            connection.setAutoCommit(true);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
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
    
    public boolean updateAccount(Account account) {
    String updateAccountSQL = "UPDATE Account SET status_id = ?, username = ?, password = ?, email = ?, created_at = ? WHERE account_id = ?";
    String updateProfileSQL = "UPDATE UserProfile SET role_id = ?, first_name = ?, last_name = ?, address = ?, gender = ?, dob = ?, phone = ? WHERE account_id = ?";
    
    try (Connection conn = connection;
         PreparedStatement psAccount = conn.prepareStatement(updateAccountSQL);
         PreparedStatement psProfile = conn.prepareStatement(updateProfileSQL)) {

        // Cập nhật bảng Account
        psAccount.setInt(1, account.getStatusId());
        psAccount.setString(2, account.getUsername());
        psAccount.setString(3, account.getPassword());
        psAccount.setString(4, account.getEmail());
        psAccount.setString(5, account.getCreatedAt());
        psAccount.setInt(6, account.getAccountId());
        int accountUpdated = psAccount.executeUpdate();

        // Cập nhật bảng UserProfile (bỏ avatar)
        UserProfile profile = account.getUserProfile();
        psProfile.setInt(1, profile.getRoleId());
        psProfile.setString(2, profile.getFirstName());
        psProfile.setString(3, profile.getLastName());
        psProfile.setString(4, profile.getAddress());
        psProfile.setString(5, profile.getGender());
        psProfile.setString(6, profile.getDob());
        psProfile.setString(7, profile.getPhone());
        psProfile.setInt(8, account.getAccountId());
        int profileUpdated = psProfile.executeUpdate();

        return accountUpdated > 0 && profileUpdated > 0;
    } catch (Exception e) {
        e.printStackTrace();
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

    public boolean checkLogin(String userName, String passWord) {
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Account]\n"
                + "  where username =? and password =?";
        boolean check = false;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, userName);
            st.setString(2, passWord);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return check;

    }

    public void updateUsername(String username, String accountId) {
        String sql = "UPDATE Account SET username=? WHERE account_id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, username);
            ptm.setString(2, accountId);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
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

    // New methods for Google Sign-In
    public int getStatusByEmail(String email) throws SQLException {
        String sql = "SELECT status_id FROM Account WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("status_id");
            }
        }
        return -1; // Trả về -1 nếu email không tồn tại
    }

    public Account getAccountByEmail(String email) throws SQLException {
        UserProfileDAO userProfileDAO = new UserProfileDAO();
        AccountDAO accountDAO = new AccountDAO();
        String sql = "SELECT account_id, status_id, username, password, email, created_at FROM Account WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Account account = new Account();
                account.setAccountId(rs.getInt("account_id"));
                account.setStatusId(rs.getInt("status_id"));
                account.setUsername(rs.getString("username"));
                account.setPassword(rs.getString("password"));
                account.setEmail(rs.getString("email"));
                account.setCreatedAt(rs.getTimestamp("created_at").toString());
                account.setUserProfile(userProfileDAO.getProfileByAccountId(accountDAO.getAcountIdByEmail(email)));
                return account;
            }
        }
        return null; // Trả về null nếu không tìm thấy
    }

    public boolean addGoogleAccount(String googleId, String email, String firstName, String lastName, String avatar,
            String accessToken) {
        String insertAccountSQL = "INSERT INTO Account (status_id, username, password, email, created_at) VALUES (?, ?, ?, ?, ?)";
        String insertProfileSQL = "INSERT INTO UserProfile (account_id, role_id, first_name, last_name, address, gender, dob, phone, avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String insertGoogleAuthSQL = "INSERT INTO GoogleAuth (account_id, google_id, access_token, refresh_token, expires_at, created_at) VALUES (?, ?, ?, ?, ?, ?)";

        PreparedStatement psAccount = null;
        PreparedStatement psProfile = null;
        PreparedStatement psGoogleAuth = null;
        ResultSet generatedKeys = null;

        try {
            connection.setAutoCommit(false);

            // Thêm vào bảng Account
            psAccount = connection.prepareStatement(insertAccountSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            psAccount.setInt(1, 1); // status_id = 1
            psAccount.setString(2, googleId + "_gg"); // username = googleId + "gg"
            psAccount.setString(3, googleId + "_pw"); // password = googleId + "pw"
            psAccount.setString(4, email);
            String createdAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
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

            // Thêm vào bảng UserProfile
            psProfile = connection.prepareStatement(insertProfileSQL);
            psProfile.setInt(1, accountId);
            psProfile.setInt(2, 3); // role_id mặc định là 3
            psProfile.setString(3, firstName);
            psProfile.setString(4, lastName);
            psProfile.setString(5, null); // address (còn trống)
            psProfile.setString(6, null); // gender (còn trống)
            psProfile.setString(7, null); // dob (còn trống)
            psProfile.setString(8, null); // phone (còn trống)
            psProfile.setString(9, avatar);
            psProfile.executeUpdate();

            // Thêm vào bảng GoogleAuth
            psGoogleAuth = connection.prepareStatement(insertGoogleAuthSQL);
            psGoogleAuth.setInt(1, accountId);
            psGoogleAuth.setString(2, googleId);
            psGoogleAuth.setString(3, accessToken);
            psGoogleAuth.setString(4, null); // refresh_token (còn trống, cần lấy từ token response)
            psGoogleAuth.setString(5, null); // expires_at (còn trống, cần lấy từ token response)
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
                if (psGoogleAuth != null) {
                    psGoogleAuth.close();
                }
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
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

    public Role getRoleByAccountId(int accountId) {
        String sql = "SELECT  r.role_id\n"
                + "      ,[role_name]\n"
                + "      ,[description]\n"
                + "  FROM [FootballFieldBooking].[dbo].[Role] r join UserProfile u on r.role_id = u.role_id join Account a on u.account_id = a.account_id\n"
                + "  where a.account_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Role(rs.getInt(1), rs.getString(2), rs.getString(3));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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

    public Account getAccountByUsername(String username) {
        UserProfileDAO userProfileDAO = new UserProfileDAO();
        AccountDAO accountDAO = new AccountDAO();
        String sql = "SELECT * FROM [FootballFieldBooking].[dbo].[Account] WHERE username = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getString(6), userProfileDAO.getProfileByAccountId(accountDAO.getAccountIDbyUsername(username)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();
            
         UserProfile profile = new UserProfile();
            profile.setRoleId(2); // ví dụ: 2 = khách hàng
            profile.setAvatar("default-avatar.png");

            // Tạo đối tượng Account
            Account account = new Account();
            account.setStatusId(1); // ví dụ: 1 = active
            account.setUsername("testuser");
            account.setPassword("123456");
            account.setEmail("test@example.com");
            account.setCreatedAt("2025-06-19"); // hoặc LocalDate.now().toString()
            account.setUserProfile(profile);

            // Thử insert
            boolean success = dao.insertAccountWithProfile(account);

            if (success) {
                System.out.println("✅ Insert thành công! Account ID: " + account.getAccountId());
            } else {
                System.out.println("❌ Insert thất bại.");
            }

    }
}
