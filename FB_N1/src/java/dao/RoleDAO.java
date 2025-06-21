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
public class RoleDAO extends DBContext {

    public List<Role> getAllRoles() {
        List<Role> roles = new ArrayList<>();
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Role]";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Role r = new Role(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)
                );
                roles.add(r);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return roles;
    }

    public Role getRoleById(int roleId) {
        String sql = "SELECT * FROM tblRole WHERE roleId = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, roleId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                return new Role(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3)
                );
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public void insertRole(Role role) {
        String sql = "INSERT INTO tblRole (roleName, description) VALUES (?, ?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, role.getRoleName());
            ptm.setString(2, role.getDescription());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

    }

    public int updateRole(Role role) {
        String sql = "UPDATE tblRole SET roleName = ?, description = ? WHERE roleId = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, role.getRoleName());
            ptm.setString(2, role.getDescription());
            ptm.setInt(3, role.getRoleId());
            return ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public void deleteRole(int roleId) {
        String sql = "DELETE FROM tblRole WHERE roleId = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, roleId);
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

    }
    public static void main(String[] args) {
        RoleDAO rDao = new RoleDAO();
        List<Role> r = rDao.getAllRoles();
        for(Role rs : r){
            System.out.println(rs);
        }
    }
}
