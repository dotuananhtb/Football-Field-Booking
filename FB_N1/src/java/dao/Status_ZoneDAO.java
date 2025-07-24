/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.StatusZone;
import model.Status_Blog;
import util.DBContext;

/**
 *
 * @author VAN NGUYEN
 */
public class Status_ZoneDAO extends DBContext {

    public List<StatusZone> getAllStatus() {
        List<StatusZone> list = new ArrayList<>();
        String sql = "SELECT  [status_id]\n"
                + "      ,[status_name]\n"
                + "  FROM [FootballFieldBooking].[dbo].[Status_Zone]";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                StatusZone s = new StatusZone();
                s.setStatus_id(rs.getInt(1));
                s.setStatus_des(rs.getString(2));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static void main(String[] args) {
         Status_ZoneDAO s = new Status_ZoneDAO();
        List<StatusZone> list = s.getAllStatus();
        for (StatusZone status_Blog : list) {
            System.out.println(status_Blog);
        }
    }

}
