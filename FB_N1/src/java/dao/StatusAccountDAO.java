/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.List;
import model.StatusAccount;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author VAN NGUYEN
 */
public class StatusAccountDAO extends DBContext {

    public List<StatusAccount> getStatusAccount() {
        List<StatusAccount> list = new ArrayList<>();

        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[StatusAccount]";
        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery();) {
            while (rs.next()) {
                StatusAccount s = new StatusAccount(rs.getInt(1), rs.getString(2), rs.getString(3));
                list.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(StatusAccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public StatusAccount getStatusByStatusId(int statusId) {
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[StatusAccount]\n"
                + "  where status_id = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql); ) {
            ptm.setInt(1, statusId);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                return new StatusAccount(rs.getInt(1), rs.getString(2), rs.getString(3));
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(StatusAccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
