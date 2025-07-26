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
import model.StatusZone;
import model.Zone;
import util.DBContext;

/**
 *
 * @author VAN NGUYEN
 */
public class Zone_DAO extends DBContext {

    public List<Zone> getAllZone() {
        List<Zone> listZ = new ArrayList<>();
        String sql = "SELECT z.*, s.status_name\n"
                + "  FROM [FootballFieldBooking].[dbo].[Zone] z join [dbo].[Status_Zone] s on z.status_id = s.status_id ";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {

                Zone zone = new Zone();
                zone.setZoneId(rs.getInt("zone_id"));
                zone.setZone_name(rs.getString("zone_name"));
                zone.setAddress(rs.getString("Address"));
                zone.setStatus(rs.getInt("status_id"));

                StatusZone sz = new StatusZone();
                sz.setStatus_id(rs.getInt("status_id"));
                sz.setStatus_des(rs.getString("status_name"));
                zone.setStatus_id(sz);
                listZ.add(zone);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listZ;
    }
    
  
    
    
    
    public List<Zone> getAllZoneWithStatus() {
        List<Zone> listZ = new ArrayList<>();
        String sql = "SELECT z.*, s.status_name\n"
                + "  FROM [FootballFieldBooking].[dbo].[Zone] z join [dbo].[Status_Zone] s on z.status_id = s.status_id where z.status_id = 1";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {

                Zone zone = new Zone();
                zone.setZoneId(rs.getInt("zone_id"));
                zone.setZone_name(rs.getString("zone_name"));
                zone.setAddress(rs.getString("Address"));
                zone.setStatus(rs.getInt("status_id"));

                StatusZone sz = new StatusZone();
                sz.setStatus_id(rs.getInt("status_id"));
                sz.setStatus_des(rs.getString("status_name"));
                zone.setStatus_id(sz);
                listZ.add(zone);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listZ;
    }

    public boolean changeStatus(int zoneId, int newStatusId) {
        String sql = "UPDATE [dbo].[Zone]\n"
                + "   SET \n"
                + "      [status_id] = ?\n"
                + " WHERE zone_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newStatusId);

            ps.setInt(2, zoneId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean InsertZone(Zone zone) {
        String sql = "INSERT INTO [dbo].[Zone]\n"
                + "           ([zone_name]\n"
                + "           ,[Address]\n"
                + "           ,[status_id])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?)";
        try (PreparedStatement ptm = connection.prepareStatement(sql);) {
            ptm.setString(1, zone.getZone_name());
            ptm.setString(2, zone.getAddress());
            ptm.setInt(3, zone.getStatus());
            int rowInserted = ptm.executeUpdate();
            return rowInserted > 0;
        } catch (SQLException ex) {
            Logger.getLogger(Zone_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public int countZone() {
        String sql = "SELECT count(*)\n"
                + "  FROM [FootballFieldBooking].[dbo].[Zone] where status_id = 1";
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
                + "      ,[status_id] = ?\n"
                + " WHERE zone_id = ?";
        try (PreparedStatement ptm = connection.prepareStatement(sql);) {
            ptm.setString(1, zone.getZone_name());
            ptm.setString(2, zone.getAddress());
            ptm.setInt(3, zone.getStatus());
            ptm.setInt(4, zone.getZoneId());
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
                return new Zone(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4));
            }

        } catch (SQLException ex) {
            Logger.getLogger(Zone_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void main(String[] args) {

        Zone_DAO zD = new Zone_DAO();
        List<Zone> list = zD.getAllZoneWithStatus();
        for (Zone zone : list) {
            System.out.println(zone);
        }
        boolean s = zD.changeStatus(1, 2);
        System.out.println(s);
        Zone zone1 = zD.getZonebyZoneId("1");
        System.out.println(zone1);
    }

}
