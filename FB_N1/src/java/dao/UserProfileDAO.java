/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.Vector;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBContext;
import model.*;

/**
 *
 * @author Asus
 */
public class UserProfileDAO extends DBContext {

    public Vector<UserProfile> getAllProfiles() {
        Vector<UserProfile> list = new Vector<>();
        String sql = "SELECT * FROM tblUserProfile";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                UserProfile up = new UserProfile(
                        rs.getInt("accountId"),
                        rs.getInt("roleId"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("address"),
                        rs.getString("gender"),
                        rs.getString("phone"),
                        rs.getString("avatar")
                );
                list.add(up);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public UserProfile getProfileByAccountId(int accountId) {
        String sql = "SELECT * FROM tblUserProfile WHERE accountId = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, accountId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return new UserProfile(
                        rs.getInt("accountId"),
                        rs.getInt("roleId"),
                        rs.getString("firstName"),
                        rs.getString("lastName"),
                        rs.getString("address"),
                        rs.getString("gender"),
                        rs.getString("phone"),
                        rs.getString("avatar")
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public void insertProfile(UserProfile up) {
        String sql = "INSERT INTO tblUserProfile (accountId, roleId, firstName, lastName, address, gender, phone, avatar) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, up.getAccountId());
            ptm.setInt(2, up.getRoleId());
            ptm.setString(3, up.getFirstName());
            ptm.setString(4, up.getLastName());
            ptm.setString(5, up.getAddress());
            ptm.setString(6, up.getGender());
            ptm.setString(7, up.getPhone());
            ptm.setString(8, up.getAvatar());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

    }

    public void updateProfile(UserProfile up) {
        String sql = "UPDATE tblUserProfile SET roleId=?, firstName=?, lastName=?, address=?, gender=?, phone=?, avatar=? WHERE accountId=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, up.getRoleId());
            ptm.setString(2, up.getFirstName());
            ptm.setString(3, up.getLastName());
            ptm.setString(4, up.getAddress());
            ptm.setString(5, up.getGender());
            ptm.setString(6, up.getPhone());
            ptm.setString(7, up.getAvatar());
            ptm.setInt(8, up.getAccountId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

    }

    public void deleteProfile(int accountId) {
        String sql = "DELETE FROM tblUserProfile WHERE accountId = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, accountId);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

    }
}
