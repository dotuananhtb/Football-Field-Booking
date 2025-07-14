/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.math.BigDecimal;
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
 * @author Binh
 */
public class FieldDAO extends DBContext {

    public List<Field> getAllFields() {
        List<Field> list = new ArrayList<>();
        String sql = "SELECT f.*,z.zone_name, z.Address, t.field_type_name FROM Field f "
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
                z.setZone_name("zone_name");
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

//    
    public List<Field> get6Field() {
        String sql = "SELECT TOP 6 "
                + "f.field_id, f.field_name, f.image, f.status, f.description, "
                + "z.zone_id, z.zone_name, z.Address, "
                + "t.field_type_id, t.field_type_name, "
                + "MIN(s.slot_field_price) AS min_price "
                + "FROM Field f "
                + "JOIN Zone z ON f.zone_id = z.zone_id "
                + "JOIN TypeOfField t ON t.field_type_id = f.field_type_id "
                + "JOIN SlotsOfField s ON f.field_id = s.field_id "
                + "WHERE f.status = N'hoạt động'"
                + "GROUP BY f.field_id, f.field_name, f.image, f.status, f.description, "
                + "z.zone_id, z.zone_name, z.Address, "
                + "t.field_type_id, t.field_type_name "
                + "ORDER BY f.field_id DESC";

        List<Field> list = new ArrayList<>();

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery();) {

            while (rs.next()) {
                Field f = new Field();
                f.setFieldId(rs.getInt("field_id"));
                f.setFieldName(rs.getString("field_name"));
                f.setImage(rs.getString("image"));
                f.setStatus(rs.getString("status"));
                f.setDescription(rs.getString("description"));
                f.setPrice(rs.getBigDecimal("min_price")); // <-- giá thấp nhất

                Zone z = new Zone();
                z.setZoneId(rs.getInt("zone_id"));
                z.setZone_name(rs.getString("zone_name"));
                z.setAddress(rs.getString("Address"));
                f.setZone(z);

                TypeOfField t = new TypeOfField();
                t.setFieldTypeId(rs.getInt("field_type_id"));
                t.setFieldTypeName(rs.getString("field_type_name"));
                f.setTypeOfField(t);

                list.add(f);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Field> get2Field() {
        String sql = "SELECT TOP 2 *\n"
                + "  FROM [FootballFieldBooking].[dbo].[Field]\n"
                + "  where status =N'hoạt động'\n"
                + "  order by field_id desc";
        List<Field> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery();) {
            while (rs.next()) {
                Field f = new Field();
                f.setFieldId(rs.getInt("field_id"));
                f.setFieldName(rs.getString("field_name"));
                f.setImage(rs.getString("image"));
                f.setStatus(rs.getString("status"));
                f.setDescription(rs.getString("description"));
                list.add(f);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Field> get6FieldByZoneId(String zoneId) {
        String sql = "SELECT TOP 6 "
                + "f.field_id, f.field_name, f.image, f.status, f.description, "
                + "z.zone_id, z.zone_name, z.Address, "
                + "t.field_type_id, t.field_type_name, "
                + "MIN(s.slot_field_price) AS min_price "
                + "FROM Field f "
                + "JOIN Zone z ON f.zone_id = z.zone_id "
                + "JOIN TypeOfField t ON t.field_type_id = f.field_type_id "
                + "JOIN SlotsOfField s ON f.field_id = s.field_id "
                + "WHERE f.status = N'hoạt động' AND z.zone_id = ? "
                + "GROUP BY f.field_id, f.field_name, f.image, f.status, f.description, "
                + "z.zone_id, z.zone_name, z.Address, "
                + "t.field_type_id, t.field_type_name "
                + "ORDER BY f.field_id DESC";
        List<Field> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql);) {
            ps.setString(1, zoneId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Field f = new Field();
                f.setFieldId(rs.getInt("field_id"));
                f.setFieldName(rs.getString("field_name"));
                f.setImage(rs.getString("image"));
                f.setStatus(rs.getString("status"));
                f.setDescription(rs.getString("description"));
                f.setPrice(rs.getBigDecimal("min_price")); // <-- giá thấp nhất

                Zone z = new Zone();
                z.setZoneId(rs.getInt("zone_id"));
                z.setZone_name("zone_name");
                z.setAddress(rs.getString("Address"));
                f.setZone(z);

                TypeOfField t = new TypeOfField();
                t.setFieldTypeId(rs.getInt("field_type_id"));
                t.setFieldTypeName(rs.getString("field_type_name"));
                f.setTypeOfField(t);

                list.add(f);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Field> getAllFieldsByZoneID(String zoneID) {
        List<Field> list = new ArrayList<>();
        String sql = "SELECT f.*,z.zone_name,z.Address, t.field_type_name\n"
                + "  FROM [FootballFieldBooking].[dbo].[Field] f join Zone z on f.zone_id = z.zone_id join TypeOfField t on t.field_type_id = f.field_type_id\n"
                + "  where z.zone_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql);) {
            ps.setString(1, zoneID);
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
                z.setZone_name(rs.getString("zone_name"));
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
        String sql = "SELECT f.*, z.zone_id, z.zone_name,z.Address, t.field_type_id, t.field_type_name "
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
                zone.setZone_name("zone_name");
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

        String sql = "SELECT f.*, z.zone_id,z.zone_name, z.Address, t.field_type_id, t.field_type_name "
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
                zone.setZone_name("zone_name");
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
    // by Binh
    public List<Field> pagingField(String zoneId, String typeId, String timeRange,
            BigDecimal minPrice, BigDecimal maxPrice,
            int pageIndex, int pageSize,
            String sortBy) {

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
        }

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT f.field_id, f.field_name, f.image, f.status, f.description, ")
                .append("z.zone_id,z.zone_name,z.Address, ")
                .append("t.field_type_id, t.field_type_name, ")
                .append("MIN(sof.slot_field_price) as min_price, ")
                .append("MAX(sof.slot_field_price) as max_price ")
                .append("FROM Field f ")
                .append("INNER JOIN Zone z ON f.zone_id = z.zone_id ")
                .append("INNER JOIN TypeOfField t ON f.field_type_id = t.field_type_id ")
                .append("INNER JOIN SlotsOfField sof ON f.field_id = sof.field_id ")
                .append("INNER JOIN SlotsOfDay sd ON sof.slot_id = sd.slot_id ")
                .append("WHERE f.status = N'Hoạt động' ");

        if (zoneId != null && !zoneId.isEmpty()) {
            sql.append("AND z.zone_id = ? ");
        }
        if (typeId != null && !typeId.isEmpty()) {
            sql.append("AND t.field_type_id = ? ");
        }
        if (minPrice != null) {
            sql.append("AND sof.slot_field_price >= ? ");
        }
        if (maxPrice != null) {
            sql.append("AND sof.slot_field_price <= ? ");
        }
        if (timeRange != null && !timeRange.isEmpty()) {
            sql.append("AND (")
                    .append("( ? = 'morning' AND TRY_CAST(sd.start_time AS TIME) < '12:00') OR ")
                    .append("( ? = 'afternoon' AND TRY_CAST(sd.start_time AS TIME) >= '12:00' AND TRY_CAST(sd.start_time AS TIME) < '18:00') OR ")
                    .append("( ? = 'evening' AND TRY_CAST(sd.start_time AS TIME) >= '18:00')")
                    .append(") ");
        }

        sql.append("GROUP BY f.field_id, f.field_name, f.image, f.status, f.description, ")
                .append("f.created_at, f.updated_at, z.zone_id,z.zone_name,z.Address, t.field_type_id, t.field_type_name ")
                .append("ORDER BY ").append(sortClause).append(" ")
                .append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int i = 1;

            if (zoneId != null && !zoneId.isEmpty()) {
                ps.setString(i++, zoneId);
            }
            if (typeId != null && !typeId.isEmpty()) {
                ps.setString(i++, typeId);
            }
            if (minPrice != null) {
                ps.setBigDecimal(i++, minPrice);
            }
            if (maxPrice != null) {
                ps.setBigDecimal(i++, maxPrice);
            }
            if (timeRange != null && !timeRange.isEmpty()) {
                ps.setString(i++, timeRange);
                ps.setString(i++, timeRange);
                ps.setString(i++, timeRange);
            }

            ps.setInt(i++, (pageIndex - 1) * pageSize);
            ps.setInt(i, pageSize);

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
                z.setZone_name("zone_name");
                z.setAddress(rs.getString("Address"));
                f.setZone(z);

                TypeOfField type = new TypeOfField();
                type.setFieldTypeId(rs.getInt("field_type_id"));
                type.setFieldTypeName(rs.getString("field_type_name"));
                f.setTypeOfField(type);

                list.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countFields(String zoneId, String typeId, String timeRange,
            BigDecimal minPrice, BigDecimal maxPrice) {

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(DISTINCT f.field_id) ")
                .append("FROM Field f ")
                .append("INNER JOIN Zone z ON f.zone_id = z.zone_id ")
                .append("INNER JOIN TypeOfField t ON f.field_type_id = t.field_type_id ")
                .append("INNER JOIN SlotsOfField sof ON f.field_id = sof.field_id ")
                .append("INNER JOIN SlotsOfDay sd ON sof.slot_id = sd.slot_id ")
                .append("WHERE f.status = N'Hoạt động' ");

        if (zoneId != null && !zoneId.isEmpty()) {
            sql.append("AND z.zone_id = ? ");
        }
        if (typeId != null && !typeId.isEmpty()) {
            sql.append("AND t.field_type_id = ? ");
        }
        if (minPrice != null) {
            sql.append("AND sof.slot_field_price >= ? ");
        }
        if (maxPrice != null) {
            sql.append("AND sof.slot_field_price <= ? ");
        }
        if (timeRange != null && !timeRange.isEmpty()) {
            sql.append("AND (")
                    .append("( ? = 'morning' AND TRY_CAST(sd.start_time AS TIME) < '12:00') OR ")
                    .append("( ? = 'afternoon' AND TRY_CAST(sd.start_time AS TIME) >= '12:00' AND TRY_CAST(sd.start_time AS TIME) < '18:00') OR ")
                    .append("( ? = 'evening' AND TRY_CAST(sd.start_time AS TIME) >= '18:00')")
                    .append(") ");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int i = 1;

            if (zoneId != null && !zoneId.isEmpty()) {
                ps.setString(i++, zoneId);
            }
            if (typeId != null && !typeId.isEmpty()) {
                ps.setString(i++, typeId);
            }
            if (minPrice != null) {
                ps.setBigDecimal(i++, minPrice);
            }
            if (maxPrice != null) {
                ps.setBigDecimal(i++, maxPrice);
            }
            if (timeRange != null && !timeRange.isEmpty()) {
                ps.setString(i++, timeRange);
                ps.setString(i++, timeRange);
                ps.setString(i++, timeRange);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

//lấy danh sách cùng với giá min-max và số lượng slot
    public List<Field> getAllFieldsWithPriceRange() {
        List<Field> list = new ArrayList<>();
        String sql = "SELECT f.field_id, f.field_name, f.image, f.status, f.description, "
                + "z.zone_id,z.zone_name,z.Address, "
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
                + "z.zone_id,z.zone_name,z.Address, t.field_type_id, t.field_type_name "
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
                z.setAddress(rs.getString("zone_name"));
                z.setAddress(rs.getString("address"));
                f.setZone(z);

                TypeOfField t = new TypeOfField();
                t.setFieldTypeId(rs.getInt("field_type_id"));
                t.setFieldTypeName(rs.getString("field_type_name"));
                f.setTypeOfField(t);

                f.setSlots(getFieldSlotsWithDetails(f.getFieldId()));

                list.add(f);

            }
        } catch (Exception e) {
        }
        return list;
    }

    public int countField() {
        String sql = "SELECT count(*)\n"
                + "  FROM [FootballFieldBooking].[dbo].[Field]";
        try (PreparedStatement ptm = connection.prepareStatement(sql); ResultSet rs = ptm.executeQuery();) {

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;

    }

    // lọc slot
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

    public static void main(String[] args) {
        FieldDAO fDao = new FieldDAO();
        List<Field> listF = fDao.get6FieldByZoneId("1");
        System.out.println(listF);
    }

}
