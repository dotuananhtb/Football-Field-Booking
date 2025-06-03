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
public class FieldDAO extends DBContext {

    public Vector<Field> getAllField() {
        Vector<Field> list = new Vector<>();
        String sql = "SELECT*\n"
                + "  FROM [FootballFieldBooking].[dbo].[Field]";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Field up = new Field(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7)
                );
                list.add(up);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Field getAllFieldByZoneID(int zone_id) {

        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Field]\n"
                + "  where zone_id =?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            ptm.setInt(1, zone_id);
            while (rs.next()) {
                return new Field(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7)
                );

            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;

    }

}
