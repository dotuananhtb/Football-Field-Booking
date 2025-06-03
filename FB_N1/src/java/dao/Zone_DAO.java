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
import model.Zone;
import util.DBContext;

/**
 *
 * @author VAN NGUYEN
 */
public class Zone_DAO extends DBContext {
    public List<Zone> getAllZone(){
        List<Zone> listZ = new ArrayList<>();
        String sql = "SELECT *\n" +
"  FROM [FootballFieldBooking].[dbo].[Zone]";
         try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Zone zone = new Zone(rs.getInt(1), rs.getString(2));
                listZ.add(zone);
            }
         } catch (SQLException ex) {
            ex.printStackTrace();
        }
         return listZ;
    }
    public static void main(String[] args) {
        
        Zone_DAO zD = new Zone_DAO();
        List<Zone> list = zD.getAllZone();
        for( Zone zone : list){
            System.out.println(zone);
        }
    }
    
    
}
