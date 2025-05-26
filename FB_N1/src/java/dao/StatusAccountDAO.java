/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.StatusAccount;
import util.DBContext;

/**
 *
 * @author Admin
 */
public class StatusAccountDAO extends DBContext{

    public Vector<StatusAccount> getStatusAccount(String sql) {
        Vector<StatusAccount> listStatusAccount = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                StatusAccount st = new StatusAccount(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3));
                listStatusAccount.add(st);
            }
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return listStatusAccount;
    }

    public StatusAccount searchStatusAccount(int statusId) {
        String sql = "SELECT *\n"
                + "  FROM [StatusAccount]\n"
                + "  where status_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, statusId);
            ResultSet rs = ptm.executeQuery();
            if (rs.next()) {
                StatusAccount st = new StatusAccount(statusId, rs.getInt(2),
                        rs.getString(3));
                return st;
            }
        } catch (Exception ex) {
            ex.getStackTrace();
        }
        return null;
    }
    public int insertStatusAccount(StatusAccount st) {
        String sql = "INSERT INTO [dbo].[StatusAccount]\n"
                + "           ([description])\n"
                + "     VALUES\n"
                + "           (?)";
        int n = 0;
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, st.getDescription());
            n = ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.getStackTrace();
        }
        return n;
    }
        public void updateStatusAccount(StatusAccount st) {
        String sql = "UPDATE [dbo].[StatusAccount]\n"
                + "   SET [description] = ?"
                + " WHERE status_id = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setString(1, st.getDescription());
            ptm.setInt(2, st.getStatusAccount());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

    }
    public int deleteStatusAccount(int statusId) {
        int n = 0;
        String checkSql = "SELECT COUNT(*) FROM [dbo].[Account] WHERE status_id = ?";
        String deleteSql = "DELETE FROM [dbo].[StatusAccount] WHERE status_id = ?";

        try {
            PreparedStatement checkPtm = connection.prepareStatement(checkSql);
            checkPtm.setInt(1, statusId);
            ResultSet rs = checkPtm.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                
                return 0;
            }


            PreparedStatement deletePtm = connection.prepareStatement(deleteSql);
            deletePtm.setInt(1, statusId);
            n = deletePtm.executeUpdate();

        } catch (SQLException ex) {
            ex.printStackTrace(); 
        }
        return n;
    }

}
