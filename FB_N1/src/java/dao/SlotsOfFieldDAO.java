/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Đỗ Tuấn Anh
 */
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;
import model.*;
import util.DBContext;

public class SlotsOfFieldDAO extends DBContext {

    public List<SlotEventDTO> getAllSlotsOfField(int fieldId) {
        List<SlotEventDTO> list = new ArrayList<>();
        String sql = """
        SELECT 
            sof.slot_field_id AS id,
            sd.start_time,
            sd.end_time
        FROM SlotsOfField sof
        JOIN SlotsOfDay sd ON sof.slot_id = sd.slot_id
        WHERE sof.field_id = ?
        ORDER BY sd.start_time
    """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, fieldId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SlotEventDTO slot = new SlotEventDTO();
                    slot.setId(rs.getInt("id"));
                    slot.setTitle("Ca " + rs.getString("start_time") + " - " + rs.getString("end_time"));
                    slot.setStart(rs.getString("start_time"));
                    slot.setEnd(rs.getString("end_time"));
                    slot.setColor("#28a745"); // mặc định available
                    slot.setStatus("available");
                    slot.setDescription("Chưa có ghi chú");
                    list.add(slot);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<SlotsOfField> getSlotsByField(int fieldId) {
        List<SlotsOfField> list = new ArrayList<>();
        String sql = "SELECT sf.slot_field_id, sf.slot_field_price, "
                + "sd.slot_id, sd.start_time, sd.end_time, sd.field_type_id "
                + "FROM SlotsOfField sf "
                + "JOIN SlotsOfDay sd ON sf.slot_id = sd.slot_id "
                + "WHERE sf.field_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, fieldId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Tạo đối tượng SlotsOfDay
                    SlotsOfDay slotOfDay = new SlotsOfDay();
                    slotOfDay.setSlotId(rs.getInt("slot_id"));
                    slotOfDay.setStartTime(rs.getString("start_time"));
                    slotOfDay.setEndTime(rs.getString("end_time"));
                    slotOfDay.setFieldTypeId(rs.getInt("field_type_id"));

                    // Tạo đối tượng SlotsOfField
                    SlotsOfField slotField = new SlotsOfField();
                    slotField.setSlotFieldId(rs.getInt("slot_field_id"));
                    slotField.setSlotFieldPrice(rs.getBigDecimal("slot_field_price"));
                    slotField.setSlotInfo(slotOfDay);  // Gán thông tin slot

                    list.add(slotField);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public BigDecimal getPriceBySlotFieldId(int slotFieldId) {
        String sql = "SELECT slot_field_price FROM SlotsOfField WHERE slot_field_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, slotFieldId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal("slot_field_price");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // hoặc BigDecimal.ZERO nếu bạn muốn tránh null
    }

}
