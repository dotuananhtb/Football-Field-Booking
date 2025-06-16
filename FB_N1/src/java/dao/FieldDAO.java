/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import java.util.List;
import model.Field;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.SlotsOfDay;
import model.SlotsOfField;
import model.TypeOfField;
import model.Zone;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class FieldDAO extends DBContext {

    public List<Field> getAllFields() {
        List<Field> list = new ArrayList<>();
        String sql = "SELECT f.*, z.Address, t.field_type_name FROM Field f "
                + "JOIN Zone z ON f.zone_id = z.zone_id "
                + "JOIN TypeOfField t ON f.field_type_id = t.field_type_id";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Field f = new Field();
                f.setFieldId(rs.getInt("field_id"));
                f.setFieldName(rs.getString("field_name"));
                f.setImage(rs.getString("image"));
                f.setStatus(rs.getString("status"));
                f.setDescription(rs.getString("description"));

                Zone z = new Zone();
                z.setZoneId(rs.getInt("zone_id"));
                z.setAddress(rs.getString("Address"));
                f.setZone(z);

                TypeOfField t = new TypeOfField();
                t.setFieldTypeId(rs.getInt("field_type_id"));
                t.setFieldTypeName(rs.getString("field_type_name"));
                f.setTypeOfField(t);

                list.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Field getFieldByFieldID(int fieldId) {
        Field field = null;
        String sql = "SELECT f.*, z.zone_id, z.Address, t.field_type_id, t.field_type_name "
                + "FROM Field f "
                + "JOIN Zone z ON f.zone_id = z.zone_id "
                + "JOIN TypeOfField t ON f.field_type_id = t.field_type_id "
                + "WHERE f.field_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, fieldId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                field = new Field();
                field.setFieldId(rs.getInt("field_id"));
                field.setFieldName(rs.getString("field_name"));
                field.setImage(rs.getString("image"));
                field.setStatus(rs.getString("status"));
                field.setDescription(rs.getString("description"));

                // Gán Zone
                Zone zone = new Zone();
                zone.setZoneId(rs.getInt("zone_id"));
                zone.setAddress(rs.getString("Address"));
                field.setZone(zone);

                // Gán TypeOfField
                TypeOfField type = new TypeOfField();
                type.setFieldTypeId(rs.getInt("field_type_id"));
                type.setFieldTypeName(rs.getString("field_type_name"));
                field.setTypeOfField(type);

                // Lấy các slot tương ứng
                SlotsOfFieldDAO slotDAO = new SlotsOfFieldDAO();
                List<SlotsOfField> slots = slotDAO.getSlotsByField(fieldId);
                field.setSlots(slots);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return field;
    }

    public List<Field> getAllFields_2() {
        List<Field> list = new ArrayList<>();
        String sql = "SELECT * FROM Field";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Field f = new Field();
                f.setFieldId(rs.getInt("field_id"));
                f.setFieldName(rs.getString("field_name"));
                f.setImage(rs.getString("image"));
                f.setStatus(rs.getString("status"));
                f.setDescription(rs.getString("description"));
                list.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //binh
    public List<Field> getFieldsByZoneId(String zId) {
        List<Field> fields = new ArrayList<>();

        String sql = "SELECT f.*, z.zone_id, z.Address, t.field_type_id, t.field_type_name "
                + "FROM Field f "
                + "JOIN Zone z ON f.zone_id = z.zone_id "
                + "JOIN TypeOfField t ON f.field_type_id = t.field_type_id "
                + "WHERE f.zone_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, zId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Field field = new Field();
                field.setFieldId(rs.getInt("field_id"));
                field.setFieldName(rs.getString("field_name"));
                field.setImage(rs.getString("image"));
                field.setStatus(rs.getString("status"));
                field.setDescription(rs.getString("description"));

                // Gán Zone
                Zone zone = new Zone();
                zone.setZoneId(rs.getInt("zone_id"));
                zone.setAddress(rs.getString("Address"));
                field.setZone(zone);

                // Gán TypeOfField
                TypeOfField type = new TypeOfField();
                type.setFieldTypeId(rs.getInt("field_type_id"));
                type.setFieldTypeName(rs.getString("field_type_name"));
                field.setTypeOfField(type);

                // Lấy các slot tương ứng
                SlotsOfFieldDAO slotDAO = new SlotsOfFieldDAO();
                List<SlotsOfField> slots = slotDAO.getSlotsByField(field.getFieldId());
                field.setSlots(slots);

                fields.add(field);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return fields;
    }

    //phân trang sân và sắp xếp
    public int getTotalFiled() {
        String sql = "select  count(*) from Field";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                return rs.getInt(1);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public List<Field> pagingField(int index, String sortBy) {
        List<Field> list = new ArrayList<>();
        String sortClause = "f.field_id"; // mặc định

        
        switch (sortBy) {
            case "new":
                sortClause = "f.created_at DESC"; 
                break;
            case "recent":
                sortClause = "f.updated_at DESC"; 
                break;
            case "price_low":
                sortClause = "min_price ASC"; 
                break;
            case "price_high":
                sortClause = "min_price DESC"; 
                break;
            case "name":
                sortClause = "f.field_name ASC"; 
                break;
            default:
                sortClause = "f.field_id";
        }

        String sql = "SELECT f.field_id, f.field_name, f.image, f.status, f.description, "
                + "z.zone_id, z.Address, "
                + "t.field_type_id, t.field_type_name, "
                + "MIN(sof.slot_field_price) as min_price, "
                + "MAX(sof.slot_field_price) as max_price, "
                + "COUNT(sof.slot_field_id) as total_slots "
                + "FROM Field f "
                + "INNER JOIN Zone z ON f.zone_id = z.zone_id "
                + "INNER JOIN TypeOfField t ON f.field_type_id = t.field_type_id "
                + "INNER JOIN SlotsOfField sof ON f.field_id = sof.field_id "
                + "WHERE f.status = N'Hoạt động' "
                + "GROUP BY f.field_id, f.field_name, f.image, f.status, f.description,f.created_at,f.updated_at, "
                + "z.zone_id, z.Address, t.field_type_id, t.field_type_name "
                + "ORDER BY " + sortClause + " "
                + "OFFSET ? ROWS FETCH NEXT 6 ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, (index - 1) * 6);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Field f = new Field();
                f.setFieldId(rs.getInt("field_id"));
                f.setFieldName(rs.getString("field_name"));
                f.setImage(rs.getString("image"));
                f.setStatus(rs.getString("status"));
                f.setDescription(rs.getString("description"));

                Zone z = new Zone();
                z.setZoneId(rs.getInt("zone_id"));
                z.setAddress(rs.getString("Address"));
                f.setZone(z);

                TypeOfField type = new TypeOfField();
                type.setFieldTypeId(rs.getInt("field_type_id"));
                type.setFieldTypeName(rs.getString("field_type_name"));
                f.setTypeOfField(type);

                // Set price range
                f.setMinPrice(rs.getBigDecimal("min_price"));
                f.setMaxPrice(rs.getBigDecimal("max_price"));
                f.setTotalSlots(rs.getInt("total_slots"));

                list.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



//lấy danh sách cùng với giá min-max và số lượng slot
    public List<Field> getAllFieldsWithPriceRange() {
        List<Field> list = new ArrayList<>();
        String sql = "SELECT f.field_id, f.field_name, f.image, f.status, f.description, "
                + "z.zone_id, z.Address, "
                + "t.field_type_id, t.field_type_name, "
                + "MIN(sof.slot_field_price) as min_price, "
                + "MAX(sof.slot_field_price) as max_price, "
                + "COUNT(sof.slot_field_id) as total_slots "
                + "FROM Field f "
                + "INNER JOIN Zone z ON f.zone_id = z.zone_id "
                + "INNER JOIN TypeOfField t ON f.field_type_id = t.field_type_id "
                + "INNER JOIN SlotsOfField sof ON f.field_id = sof.field_id "
                + "WHERE f.status = N'Hoạt động' "
                + "GROUP BY f.field_id, f.field_name, f.image, f.status, f.description, "
                + "z.zone_id, z.Address, t.field_type_id, t.field_type_name "
                + "ORDER BY f.field_name";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Field f = new Field();
                f.setFieldId(rs.getInt("field_id"));
                f.setFieldName(rs.getString("field_name"));
                f.setImage(rs.getString("image"));
                f.setStatus(rs.getString("status"));
                f.setDescription(rs.getString("description"));
                
                Zone z = new Zone();
                z.setZoneId(rs.getInt("zone_id"));
                z.setAddress(rs.getString("address"));
                f.setZone(z);
                
                TypeOfField t = new TypeOfField();
                t.setFieldTypeId(rs.getInt("field_type_id"));
                t.setFieldTypeName(rs.getString("field_type_name"));
                f.setTypeOfField(t);
                
                f.setMinPrice(rs.getBigDecimal("min_price"));
                f.setMaxPrice(rs.getBigDecimal("max_price"));
                f.setTotalSlots(rs.getInt("total_slots"));
                f.setSlots(getFieldSlotsWithDetails(f.getFieldId()));

                list.add(f);
                
            }
        } catch (Exception e) {
        }
        return list;
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


    ///
    public static void main(String[] args) {
        FieldDAO dao = new FieldDAO();

        int pageIndex = 1;         // Trang muốn test
        String sortBy = "recent";     // Kiểu sắp xếp: "new", "recent", hoặc "" (mặc định)

        List<Field> list = dao.pagingField(pageIndex, sortBy);

        if (list.isEmpty()) {
            System.out.println("⚠️ Không lấy được sân nào từ database.");
        } else {
            System.out.println("✅ Số lượng sân lấy được: " + list.size());
            for (Field f : list) {
                System.out.println("Field ID: " + f.getFieldId()
                        + ", Name: " + f.getFieldName()
                        + ", Type: " + f.getTypeOfField().getFieldTypeName()
                        + ", Zone: " + f.getZone().getAddress());
            }
        }
    }

}
