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

    public Map<String, String> getStartEndTimeBySlotFieldId(int slotFieldId) {
        String sql = "SELECT sd.start_time, sd.end_time "
                + "FROM SlotsOfField sf "
                + "JOIN SlotsOfDay sd ON sf.slot_id = sd.slot_id "
                + "WHERE sf.slot_field_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, slotFieldId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Map<String, String> result = new HashMap<>();
                    result.put("start_time", rs.getString("start_time"));
                    result.put("end_time", rs.getString("end_time"));
                    return result;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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

    public List<SlotsOfField> getSlotsByField2(int fieldId) {
        List<SlotsOfField> list = new ArrayList<>();
        String sql = "SELECT sf.slot_field_id, sf.slot_field_price, "
                + "sd.slot_id, sd.start_time, sd.end_time, sd.field_type_id, "
                + "f.field_id, f.field_name, f.image "
                + "FROM SlotsOfField sf "
                + "JOIN SlotsOfDay sd ON sf.slot_id = sd.slot_id "
                + "JOIN Field f ON sf.field_id = f.field_id "
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

                    // Tạo đối tượng Field
                    Field field = new Field();
                    field.setFieldId(rs.getInt("field_id"));
                    field.setFieldName(rs.getString("field_name"));
                    field.setImage(rs.getString("image"));

                    // Tạo đối tượng SlotsOfField
                    SlotsOfField slotField = new SlotsOfField();
                    slotField.setSlotFieldId(rs.getInt("slot_field_id"));
                    slotField.setSlotFieldPrice(rs.getBigDecimal("slot_field_price"));
                    slotField.setSlotInfo(slotOfDay);
                    slotField.setField(field); 

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
            
            -- Field
            f.field_id,
            f.field_name,
            f.field_type_id,
            f.zone_id,
            
            -- TypeOfField
            tf.field_type_name,
            
            -- Zone
            z.zone_name,
            z.address,

            -- Slot Info
            sd.slot_id, 
            sd.start_time, 
            sd.end_time, 
            sd.field_type_id AS slot_field_type_id
        FROM SlotsOfField sf
        JOIN SlotsOfDay sd ON sf.slot_id = sd.slot_id
        JOIN Field f ON sf.field_id = f.field_id
        JOIN TypeOfField tf ON f.field_type_id = tf.field_type_id
        JOIN Zone z ON f.zone_id = z.zone_id
        WHERE sf.slot_field_id = ?
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, slotFieldId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // ✅ Gán thông tin SlotsOfDay
                    SlotsOfDay slot = new SlotsOfDay();
                    slot.setSlotId(rs.getInt("slot_id"));
                    slot.setStartTime(rs.getString("start_time"));
                    slot.setEndTime(rs.getString("end_time"));
                    slot.setFieldTypeId(rs.getInt("slot_field_type_id"));

                    // ✅ Gán thông tin TypeOfField
                    TypeOfField tf = new TypeOfField();
                    tf.setFieldTypeId(rs.getInt("field_type_id"));
                    tf.setFieldTypeName(rs.getString("field_type_name"));

                    // ✅ Gán thông tin Zone
                    Zone zone = new Zone();
                    zone.setZoneId(rs.getInt("zone_id"));
                    zone.setZone_name(rs.getString("zone_name"));
                    zone.setAddress(rs.getString("address"));

                    // ✅ Gán thông tin Field
                    Field field = new Field();
                    field.setFieldId(rs.getInt("field_id"));
                    field.setFieldName(rs.getString("field_name"));
                    field.setTypeOfField(tf); // Liên kết TypeOfField
                    field.setZone(zone);      // Liên kết Zone

                    // ✅ Gán vào SlotsOfField
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

    // lọc slot( bình)
    public List<SlotsOfField> getFieldSlotsBySession(int fieldId, String session) {
        List<SlotsOfField> allSlots = getFieldSlotsWithDetails(fieldId);
        List<SlotsOfField> filteredSlots = new ArrayList<>();

        for (SlotsOfField slot : allSlots) {
            String startTime = slot.getSlotInfo().getStartTime(); // VD: "06:00"

            if (session == null || session.isEmpty()) {
                filteredSlots.add(slot); // không lọc
            } else if (session.equalsIgnoreCase("morning")
                    && startTime.compareTo("06:00") >= 0 && startTime.compareTo("11:59") <= 0) {
                filteredSlots.add(slot);
            } else if (session.equalsIgnoreCase("afternoon")
                    && startTime.compareTo("12:00") >= 0 && startTime.compareTo("17:59") <= 0) {
                filteredSlots.add(slot);
            } else if (session.equalsIgnoreCase("evening")
                    && startTime.compareTo("18:00") >= 0 && startTime.compareTo("23:59") <= 0) {
                filteredSlots.add(slot);
            }
        }
        return filteredSlots;
    }

    //chi tiết khung giờ và giá
    public List<SlotsOfField> getFieldSlotsWithDetails(int fieldId) {
        List<SlotsOfField> slots = new ArrayList<>();
        String sql = "SELECT sof.slot_field_id, sof.slot_field_price, "
                + "sod.slot_id, sod.start_time, sod.end_time, "
                + "f.field_id, f.field_name "
                + "FROM SlotsOfField sof "
                + "INNER JOIN SlotsOfDay sod ON sof.slot_id = sod.slot_id "
                + "INNER JOIN Field f ON sof.field_id = f.field_id "
                + "WHERE f.field_id = ? "
                + "ORDER BY sod.start_time";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, fieldId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                SlotsOfField slot = new SlotsOfField();
                slot.setSlotFieldId(rs.getInt("slot_field_id"));
                slot.setSlotFieldPrice(rs.getBigDecimal("slot_field_price"));

//                 Bạn có thể set thêm thông tin slot time vào đây
                SlotsOfDay sod = new SlotsOfDay();
                sod.setStartTime(rs.getString("start_time"));
                sod.setEndTime(rs.getString("end_time"));
                slot.setSlotInfo(sod);

                slots.add(slot);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return slots;
    }
    // quản lý giá theo slot theo sân

    public List<SlotsOfField> getAllSlotPricesWithDetails() {
        List<SlotsOfField> list = new ArrayList<>();
        String sql = "SELECT sof.slot_field_id, sof.slot_field_price, "
                + "sod.slot_id, sod.start_time, sod.end_time, "
                + "f.field_id, f.field_name, f.image "
                + "FROM SlotsOfField sof "
                + "JOIN SlotsOfDay sod ON sof.slot_id = sod.slot_id "
                + "JOIN Field f ON sof.field_id = f.field_id "
                + "ORDER BY f.field_id, sod.start_time";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SlotsOfField sof = new SlotsOfField();
                sof.setSlotFieldId(rs.getInt("slot_field_id"));
                sof.setSlotFieldPrice(rs.getBigDecimal("slot_field_price"));

                SlotsOfDay sod = new SlotsOfDay();
                sod.setSlotId(rs.getInt("slot_id"));
                sod.setStartTime(rs.getString("start_time"));
                sod.setEndTime(rs.getString("end_time"));
                sof.setSlotInfo(sod);

                Field f = new Field();
                f.setFieldId(rs.getInt("field_id"));
                f.setFieldName(rs.getString("field_name"));
                f.setImage(rs.getString("image"));
                sof.setField(f);

                list.add(sof);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 1. Trả về Map<slot_id, price> cho sân
    public Map<Integer, BigDecimal> getPricesByField(int fieldId) {
        Map<Integer, BigDecimal> map = new HashMap<>();
        String sql = "SELECT slot_id, slot_field_price FROM SlotsOfField WHERE field_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, fieldId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getInt("slot_id"), rs.getBigDecimal("slot_field_price"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }

    // 2. Kiểm tra đã có giá cho (field, slot) chưa
    public boolean existsSlotPrice(int fieldId, int slotId) {
        String sql = "SELECT 1 FROM SlotsOfField WHERE field_id = ? AND slot_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, fieldId);
            ps.setInt(2, slotId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3. Thêm mới giá cho ca của sân
    public void insertSlotPrice(int fieldId, int slotId, BigDecimal price) {
        String sql = "INSERT INTO SlotsOfField (slot_id, field_id, slot_field_price) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, slotId);
            ps.setInt(2, fieldId);
            ps.setBigDecimal(3, price);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 4. Cập nhật giá nếu đã tồn tại
    public void updateSlotPrice(int fieldId, int slotId, BigDecimal price) {
        String sql = "UPDATE SlotsOfField SET slot_field_price = ? WHERE field_id = ? AND slot_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBigDecimal(1, price);
            ps.setInt(2, fieldId);
            ps.setInt(3, slotId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //check đã có giao dịch chưa
    public boolean isSlotPriceUsedInBooking(int slotFieldId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM BookingDetails WHERE slot_field_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, slotFieldId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }
    // xóa

    public boolean deleteSlotPriceById(int slotFieldId) {
        String sql = "DELETE FROM SlotsOfField WHERE slot_field_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, slotFieldId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

///
    public static void main(String[] args) {
        // Tạo DAO, giả sử constructor DAO có tự set connection
        SlotsOfFieldDAO slotsOfFieldDAO = new SlotsOfFieldDAO();

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
