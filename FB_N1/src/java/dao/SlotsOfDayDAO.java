/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Đỗ Tuấn Anh
 */
import java.sql.*;
import java.util.*;
import model.*;
import util.DBContext;

public class SlotsOfDayDAO extends DBContext {

    public List<SlotsOfDay> getAllSlots() {
        List<SlotsOfDay> list = new ArrayList<>();
        String sql = "SELECT * FROM SlotsOfDay";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SlotsOfDay slot = new SlotsOfDay(
                        rs.getInt("slot_id"),
                        rs.getString("start_time"),
                        rs.getString("end_time"),
                        rs.getInt("field_type_id")
                );
                list.add(slot);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    

    

}
