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

    public void setConnection(Connection conn) {
        this.connection = conn;
    }

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

    public String getFieldIdBySlotFieldId(int slotFieldId) {
        String sql = "SELECT field_id FROM SlotsOfField WHERE slot_field_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, slotFieldId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("field_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public SlotsOfField getSlotOfFieldById(int slotFieldId) {
        String sql = """
        SELECT 
            sf.slot_field_id, 
            sf.slot_field_price,
            sf.field_id,
            f.field_name,
            sd.slot_id, 
            sd.start_time, 
            sd.end_time, 
            sd.field_type_id
        FROM SlotsOfField sf
        JOIN SlotsOfDay sd ON sf.slot_id = sd.slot_id
        JOIN Field f ON sf.field_id = f.field_id
        WHERE sf.slot_field_id = ?
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, slotFieldId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Gán thông tin SlotsOfDay
                    SlotsOfDay slot = new SlotsOfDay();
                    slot.setSlotId(rs.getInt("slot_id"));
                    slot.setStartTime(rs.getString("start_time"));
                    slot.setEndTime(rs.getString("end_time"));
                    slot.setFieldTypeId(rs.getInt("field_type_id"));

                    // Gán thông tin Field
                    Field field = new Field();
                    field.setFieldId(rs.getInt("field_id"));
                    field.setFieldName(rs.getString("field_name"));

                    // Gán vào SlotsOfField
                    SlotsOfField sof = new SlotsOfField();
                    sof.setSlotFieldId(rs.getInt("slot_field_id"));
                    sof.setSlotFieldPrice(rs.getBigDecimal("slot_field_price"));
                    sof.setSlotInfo(slot);
                    sof.setField(field);

                    return sof;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public static void main(String[] args) {
        // Tạo DAO, giả sử constructor DAO có tự set connection
        SlotsOfFieldDAO slotsOfFieldDAO= new SlotsOfFieldDAO();

        // ID ca sân muốn test, ví dụ: 1
        int testSlotFieldId = 1;

        SlotsOfField sof = slotsOfFieldDAO.getSlotOfFieldById(testSlotFieldId);

        if (sof != null) {
            System.out.println("Thông tin ca sân:");
            System.out.println("🆔 ID: " + sof.getSlotFieldId());
            System.out.println("💵 Giá: " + sof.getSlotFieldPrice());
            System.out.println("📍 Sân: " + sof.getField().getFieldName());
            System.out.println("🕒 Thời gian: " + sof.getSlotInfo().getStartTime()
                    + " - " + sof.getSlotInfo().getEndTime());
            System.out.println("⚽ Loại sân (ID): " + sof.getSlotInfo().getFieldTypeId());
        } else {
            System.out.println("Không tìm thấy ca sân với ID: " + testSlotFieldId);
        }
    }
}
