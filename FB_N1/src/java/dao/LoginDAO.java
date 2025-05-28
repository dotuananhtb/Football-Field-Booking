/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBContext;

/**
 *
 * @author VAN NGUYEN
 */
public class LoginDAO extends DBContext {

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

    public int getStatusID(String userName, String passWord) {
        String sql = "SELECT status_id\n"
                + "  FROM [FootballFieldBooking].[dbo].[Account]\n"
                + "  where username = ? and password = ?";
        int statusID = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, userName);
            st.setString(2, passWord);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                statusID = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return statusID;
    }
//    public boolean checkLoginWithStatusID(String userName, String passWord){
//        
//    }

    public int getRoleID(String userName, String passWord) {
        String sql = "SELECT r.role_id\n"
                + "  FROM [FootballFieldBooking].[dbo].Account a join UserProfile u on u.account_id = a.account_id join \n"
                + "  Role r on u.role_id = r.role_id";
        int roleID = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, userName);
            st.setString(2, passWord);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                roleID = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return roleID;  
    }

    public static void main(String[] args) {
        LoginDAO lD = new LoginDAO();
        boolean check = lD.checkLogin("nguyen", "123");
        System.out.println(check);

        int statusID = lD.getStatusID("nguyen", "123");
        System.out.println(statusID);

    }
}
