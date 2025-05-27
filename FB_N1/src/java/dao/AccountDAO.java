package dao;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.UserProfile;
import util.DBContext;

public class AccountDAO {

    private Connection connection;

    

    // CREATE
    public boolean insertAccount(Account acc) {
        String sql = "INSERT INTO Account (status_id, username, password, email, created_at) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, acc.getStatusId());
            stm.setString(2, acc.getUsername());
            stm.setString(3, acc.getPassword());
            stm.setString(4, acc.getEmail());
            stm.setString(5, acc.getCreatedAt());
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

 

    // READ (by ID)
    public Account getAccountById(int accountId) {
        String sql = "SELECT * FROM Account WHERE account_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, accountId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Account acc = new Account();
                acc.setAccountId(rs.getInt("account_id"));
                acc.setStatusId(rs.getInt("status_id"));
                acc.setUsername(rs.getString("username"));
                acc.setPassword(rs.getString("password"));
                acc.setEmail(rs.getString("email"));
                acc.setCreatedAt(rs.getString("created_at"));
                return acc;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // UPDATE
    public boolean updateAccount(Account acc) {
        String sql = "UPDATE Account SET status_id = ?, username = ?, password = ?, email = ?, created_at = ? WHERE account_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, acc.getStatusId());
            stm.setString(2, acc.getUsername());
            stm.setString(3, acc.getPassword());
            stm.setString(4, acc.getEmail());
            stm.setString(5, acc.getCreatedAt());
            stm.setInt(6, acc.getAccountId());
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // DELETE
    public boolean deleteAccount(int accountId) {
        String sql = "DELETE FROM Account WHERE account_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, accountId);
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean addAccount(Account a) {
    String sqlInsertAccount = "INSERT INTO dbo.Account (status_id, username, password, email, created_at) VALUES (?, ?, ?, ?, ?)";
    String sqlGetAccountId = "SELECT account_id FROM dbo.Account WHERE username = ?";
    String sqlInsertUserProfile = "INSERT INTO dbo.UserProfile (account_id, role_id, first_name, last_name, address, gender, phone, avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    try {
        connection.setAutoCommit(false); // Bắt đầu transaction

        // 1. Thêm vào bảng Account
        PreparedStatement stAccount = connection.prepareStatement(sqlInsertAccount);
        stAccount.setInt(1, a.getStatusId()); // status_id mặc định, ví dụ 1: Active
        stAccount.setString(2, a.getUsername());
        stAccount.setString(3, a.getPassword());
        stAccount.setString(4, a.getEmail());
        stAccount.setString(5, a.getCreatedAt());
        int rowsAffected = stAccount.executeUpdate();
        if (rowsAffected == 0) {
            System.out.println("Không thể thêm tài khoản.");
            connection.rollback();
            return false;
        }

        // 2. Lấy account_id vừa thêm
        PreparedStatement stGetId = connection.prepareStatement(sqlGetAccountId);
        stGetId.setString(1, a.getUsername());
        ResultSet rs = stGetId.executeQuery();
        if (!rs.next()) {
            System.out.println("Không tìm thấy tài khoản vừa tạo.");
            connection.rollback();
            return false;
        }
        int accountId = rs.getInt("account_id");

        // 3. Thêm thông tin UserProfile
        UserProfile up = a.getUserProfile();
        PreparedStatement stProfile = connection.prepareStatement(sqlInsertUserProfile);
        stProfile.setInt(1, accountId);
        stProfile.setInt(2, up.getRoleId()); // role_id, ví dụ 3: USER
        stProfile.setString(3, up.getFirstName());
        stProfile.setString(4, up.getLastName());
        stProfile.setString(5, up.getAddress());
        stProfile.setString(6, up.getGender());
        stProfile.setString(7, up.getPhone());
        stProfile.setString(8, up.getAvatar());
        stProfile.executeUpdate();

        connection.commit(); // Commit tất cả nếu không lỗi
        return true;

    } catch (SQLException e) {
        e.printStackTrace();
        try {
            connection.rollback(); // rollback nếu lỗi
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    } finally {
        try {
            connection.setAutoCommit(true);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    return false;
}


     public boolean checkTonTaiUser(String username) {
        String sql = "SELECT COUNT(a.account_id)\n"
                + "	from dbo.Account a \n"
                + "	JOIN dbo.UserProfile p ON p.account_id = a.account_id\n"
                + "	WHERE a.username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int row = rs.getInt(1);
                if (row > 0) {
                    return true;
                }
            }

        } catch (Exception e) {
        }
        return false;

    }
}
