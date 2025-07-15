/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Zone;
import util.DBContext;

/**
 *
 * @author VAN NGUYEN
 */
public class Zone_DAO extends DBContext {

    public List<Zone> getAllZone() {
        List<Zone> listZ = new ArrayList<>();
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Zone]";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Zone zone = new Zone(rs.getInt(1), rs.getString(2), rs.getString(3));
                listZ.add(zone);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listZ;
    }

    public boolean InsertZone(Zone zone) {
        String sql = "INSERT INTO [dbo].[Zone]\n"
                + "           ([zone_name]\n"
                + "           ,[Address])\n"
                + "     VALUES\n"
                + "           (?,?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql);) {
            ptm.setString(1, zone.getZone_name());
            ptm.setString(2, zone.getAddress());
            int rowInserted = ptm.executeUpdate();
            return rowInserted > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Zone_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public int countZone() {
        String sql = "SELECT count(*)\n"
                + "  FROM [FootballFieldBooking].[dbo].[Zone]";
        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery();) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;

    }

    public boolean UpdateZone(Zone zone) {
        String sql = "UPDATE [dbo].[Zone]\n"
                + "   SET [zone_name] = ?\n"
                + "      ,[Address] = ?\n"
                + " WHERE zone_id = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql);) {
            ptm.setString(1, zone.getZone_name());
            ptm.setString(2, zone.getAddress());
            ptm.setInt(3, zone.getZoneId());
            int rowUpdated = ptm.executeUpdate();
            return rowUpdated > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Zone_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Zone getZonebyZoneId(String zone_id) {
        String sql = "SELECT *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Zone]\n"
                + "  where zone_id = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql);) {
            ptm.setString(1, zone_id);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                return new Zone(rs.getInt(1), rs.getString(2), rs.getString(3));
            }

        } catch (SQLException ex) {
            Logger.getLogger(Zone_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void main(String[] args) {

        Zone_DAO zD = new Zone_DAO();
        List<Zone> list = zD.getAllZone();
        for (Zone zone : list) {
            System.out.println(zone);
        }
        Zone zone1 = zD.getZonebyZoneId("1");
        System.out.println(zone1);
    }

}
