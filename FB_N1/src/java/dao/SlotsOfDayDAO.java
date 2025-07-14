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

// CRUD slot of fieldtype 
        public List<SlotsOfDay> getAllSlots2() {
        List<SlotsOfDay> list = new ArrayList<>();
        String sql = "SELECT * FROM SlotsOfDay ORDER BY CAST(start_time AS TIME)";
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
        
    public List<SlotsOfDay> getSlotsByFieldType(int fieldTypeId) {
    List<SlotsOfDay> list = new ArrayList<>();
    String sql = "SELECT * FROM SlotsOfDay WHERE field_type_id = ? ORDER BY CAST(start_time AS TIME)";
    
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, fieldTypeId);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                SlotsOfDay slot = new SlotsOfDay(
                    rs.getInt("slot_id"),
                    rs.getString("start_time"),
                    rs.getString("end_time"),
                    rs.getInt("field_type_id")
                );
                list.add(slot);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return list;
}

        
public SlotsOfDay getSlotById(int id) {
    String sql = "SELECT * FROM SlotsOfDay WHERE slot_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return new SlotsOfDay(
                rs.getInt("slot_id"),
                rs.getString("start_time"),
                rs.getString("end_time"),
                rs.getInt("field_type_id")
            );
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return null;
}

    
public void addSlot(SlotsOfDay slot) {
    String sql = "INSERT INTO SlotsOfDay (start_time, end_time, field_type_id) VALUES (?, ?, ?)";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, slot.getStartTime());
        ps.setString(2, slot.getEndTime());
        ps.setInt(3, slot.getFieldTypeId());
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
public void updateSlot(SlotsOfDay slot) {
    String sql = "UPDATE SlotsOfDay SET start_time = ?, end_time = ?, field_type_id = ? WHERE slot_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, slot.getStartTime());
        ps.setString(2, slot.getEndTime());
        ps.setInt(3, slot.getFieldTypeId());
        ps.setInt(4, slot.getSlotId());
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
public void deleteSlot(int slotId) {
    String sql = "DELETE FROM SlotsOfDay WHERE slot_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, slotId);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
// check slot tồn tại
public boolean isTimeSlotOverlap(String newStart, String newEnd, int fieldTypeId) {
    String sql = "SELECT * FROM SlotsOfDay WHERE field_type_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, fieldTypeId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String start = rs.getString("start_time");
            String end = rs.getString("end_time");

            // Nếu giao nhau thì trả về true
            if (newStart.compareTo(end) < 0 && start.compareTo(newEnd) < 0) {
                return true;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
// check slot tồn tại khi cập nhật
public boolean isTimeSlotOverlapExceptId(String newStart, String newEnd, int fieldTypeId, int excludeId) {
    String sql = "SELECT * FROM SlotsOfDay WHERE field_type_id = ? AND slot_id <> ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, fieldTypeId);
        ps.setInt(2, excludeId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String start = rs.getString("start_time");
            String end = rs.getString("end_time");

            if (newStart.compareTo(end) < 0 && start.compareTo(newEnd) < 0) {
                return true;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}




}
