
package dao;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import util.DBContext;

public class AccountDAO {

    private Connection connection;

    public AccountDAO() {
        try {
            connection = new DBContext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // CREATE
    public boolean insertAccount(Account acc) {
        String sql = "INSERT INTO Account (status_id, username, password, email, created_at) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, acc.getStatusId());
            stm.setString(2, acc.getUsername());
            stm.setString(3, acc.getPassword());
            stm.setString(4, acc.getEmail());
            stm.setDate(5, (Date) acc.getCreatedAt());
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
                acc.setCreatedAt(rs.getDate("created_at"));
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
            stm.setDate(5, (Date) acc.getCreatedAt());
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

