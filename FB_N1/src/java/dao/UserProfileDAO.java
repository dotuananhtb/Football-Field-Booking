/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.util.Vector;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
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
        String sql = "SELECT * FROM UserProfile";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                UserProfile up = new UserProfile(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9)
                );
                list.add(up);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public boolean changeRole(String accountId, String role) {
        String sql = "UPDATE [dbo].[UserProfile]\n"
                + "   SET \n"
                + "      [role_id] = ?\n"
                + "\n"
                + " WHERE account_id = ?";
        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, role);
            ps.setString(2, accountId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public UserProfile getProfileByAccountId(int accountId) {
        String sql = "SELECT * FROM UserProfile WHERE account_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, accountId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return new UserProfile(
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
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public UserProfile getProfileByAccountIdString(String accountId) {
        String sql = "SELECT * FROM UserProfile WHERE account_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, accountId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return new UserProfile(
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
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public Vector<UserProfile> getProfileByRoleId(int roleId) {
        String sql = "SELECT * FROM UserProfile WHERE role_id = ?";
        Vector<UserProfile> list = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, roleId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                UserProfile u = new UserProfile(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getString(9)
                );
                list.add(u);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
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
        String sql = "UPDATE [dbo].[UserProfile]\n"
                + "   SET \n"
                + "      [first_name] = ?\n"
                + "      ,[last_name] = ?\n"
                + "      ,[address] = ?\n"
                + "      ,[gender] = ?\n"
                + "      ,[dob] = ?\n"
                + "      ,[phone] = ?\n"
                + "      ,[avatar] = ?\n"
                + " WHERE account_id =?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, up.getFirstName());
            ptm.setString(2, up.getLastName());
            ptm.setString(3, up.getAddress());
            ptm.setString(4, up.getGender());
            ptm.setString(5, up.getDob());
            ptm.setString(6, up.getPhone());
            ptm.setString(7, up.getAvatar());
            ptm.setInt(8, up.getAccountId());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

    }

    public void updateProfile1(UserProfile up, String id) {
        String sql = "UPDATE UserProfile SET  first_name=?, last_name=?, address=?,  phone=? ,dob = ?,gender=? WHERE account_id=?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);

            ptm.setString(1, up.getFirstName());
            ptm.setString(2, up.getLastName());
            ptm.setString(3, up.getAddress());
            ptm.setString(4, up.getPhone());
            ptm.setString(5, up.getDob());
            ptm.setString(6, up.getGender());
            ptm.setString(7, id);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

    }

    public boolean updateAvatar(String avatarPath, int accountId) {
        String sql = "UPDATE UserProfile SET avatar = ? WHERE account_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, avatarPath);  // đường dẫn ảnh avatar (VD: "assets/img/avatars/tenfile.jpg")
            ptm.setInt(2, accountId);

            int rowsAffected = ptm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
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

    public Account login(String acc) {
        String sql = "SELECT * FROM Account WHERE username = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, acc);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return new Account(rs.getInt("account_id"),
                        rs.getInt("status_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        null, null);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

//public Contact getContact() {
//        String sql = "SELECT * FROM contact_info WHERE id = 1";
//        try {
//            PreparedStatement ptm = connection.prepareStatement(sql);
//            
//            ResultSet rs = ptm.executeQuery();
//            if (rs.next()) {
//                return new Contact(
//                        
//                        rs.getString(2),
//                        rs.getString(3),
//                        rs.getString(4),
//                        rs.getString(5)
//                        
//                );
//            }
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
//        return null;
//    }
    public Contact getContact() {
        String sql = "SELECT * FROM contact_info WHERE id = 1";
        try (PreparedStatement pts = connection.prepareStatement(sql)) {
            ResultSet rs = pts.executeQuery();
            if (rs.next()) {
                Contact contact = new Contact();
                contact.setDescription(rs.getString(5)); // Sửa tên cột đúng với database
                contact.setEmail(rs.getString(2));
                contact.setPhone(rs.getString(3));
                contact.setAddress(rs.getString(4));
                return contact; // Trả về đối tượng Contact
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // In lỗi nếu có
        }
        return null; // Trả về null nếu không có dữ liệu
    }

    public static void main(String[] args) {
        UserProfileDAO dao = new UserProfileDAO();
        Vector<UserProfile> list = dao.getProfileByRoleId(3);
        for (UserProfile u : list) {
            System.out.println(u);
        }
    }

}
