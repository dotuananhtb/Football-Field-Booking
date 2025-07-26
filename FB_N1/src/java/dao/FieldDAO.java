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
import dao.SlotsOfFieldDAO;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.HashMap;
import java.sql.Connection;

/**
 *
 * @author Binh
 */
public class FieldDAO extends DBContext {

    public List<Field> getAllFields() {
        List<Field> list = new ArrayList<>();
        String sql = "SELECT f.*,z.zone_name, z.Address, z.status_id, t.field_type_name FROM Field f "
                + "JOIN Zone z ON f.zone_id = z.zone_id "
                + "JOIN TypeOfField t ON f.field_type_id = t.field_type_id where z.status_id = 1";

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
                z.setZone_name(rs.getString("zone_name"));
                z.setAddress(rs.getString("Address"));
                z.setStatus(rs.getInt("status_id"));
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
    public List<Field> getAllFields2() {
        List<Field> list = new ArrayList<>();
        String sql = "SELECT f.*,z.zone_name, z.Address, z.status_id, t.field_type_name FROM Field f "
                + "JOIN Zone z ON f.zone_id = z.zone_id "
                + "JOIN TypeOfField t ON f.field_type_id = t.field_type_id ";

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
                z.setZone_name(rs.getString("zone_name"));
                z.setAddress(rs.getString("Address"));
                z.setStatus(rs.getInt("status_id"));
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
                + "WHERE f.status = N'hoạt động' and z.status_id = 1  "
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
                + "WHERE f.status = N'hoạt động' AND z.zone_id = ?  "
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
        String sql = "SELECT f.*, z.zone_id,z.status_id, z.zone_name,z.Address, t.field_type_id, t.field_type_name "
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
                zone.setZone_name(rs.getString("zone_name"));
                zone.setAddress(rs.getString("Address"));
                zone.setStatus(rs.getInt("status_id"));
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

    // binh
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

    // phân trang sân và sắp xếp
    // by Binh
    public List<Field> pagingField(String zoneId, String typeId, String timeRange,
            BigDecimal minPrice, BigDecimal maxPrice,
            int pageIndex, int pageSize,
            String sortBy,
            String keyword) {

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
                .append("z.zone_id, z.zone_name, z.Address, ")
                .append("t.field_type_id, t.field_type_name, ")
                .append("MIN(sof.slot_field_price) as min_price, ")
                .append("MAX(sof.slot_field_price) as max_price ")
                .append("FROM Field f ")
                .append("INNER JOIN Zone z ON f.zone_id = z.zone_id ")
                .append("INNER JOIN TypeOfField t ON f.field_type_id = t.field_type_id ")
                .append("INNER JOIN SlotsOfField sof ON f.field_id = sof.field_id ")
                .append("INNER JOIN SlotsOfDay sd ON sof.slot_id = sd.slot_id ")
                .append("WHERE f.status = N'Hoạt động' and  z.status_id = 1");

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
        if (keyword != null && !keyword.isEmpty()) {
            sql.append("AND f.field_name LIKE ? ");
        }

        sql.append("GROUP BY f.field_id, f.field_name, f.image, f.status, f.description, ")
                .append("f.created_at, f.updated_at, z.zone_id, z.zone_name, z.Address, t.field_type_id, t.field_type_name ")
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
            if (keyword != null && !keyword.isEmpty()) {
                ps.setString(i++, "%" + keyword + "%");
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
                z.setZone_name(rs.getString("zone_name"));
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
                .append("WHERE f.status = N'Hoạt động' and  z.status_id = 1 ");

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

    // lấy danh sách cùng với giá min-max và số lượng slot
    public List<Field> getAllFieldsWithPriceRange() {
        SlotsOfFieldDAO dao = new SlotsOfFieldDAO();
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

                f.setSlots(dao.getFieldSlotsWithDetails(f.getFieldId()));
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

    // quản lý sân
    public void updateField(Field field) {
        String sql = "UPDATE Field SET zone_id = ?, field_type_id = ?, field_name = ?, image = ?, status = ?, description = ? WHERE field_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, field.getZone().getZoneId());
            ps.setInt(2, field.getTypeOfField().getFieldTypeId());
            ps.setString(3, field.getFieldName());
            ps.setString(4, field.getImage());
            ps.setString(5, field.getStatus());
            ps.setString(6, field.getDescription());
            ps.setInt(7, field.getFieldId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void syncSlotsAfterTypeUpdate(int fieldId, int newFieldTypeId) {
        try {
            // 1. Xóa slot cũ
            String deleteSql = "DELETE FROM SlotsOfField WHERE field_id = ?";
            try (PreparedStatement ps = connection.prepareStatement(deleteSql)) {
                ps.setInt(1, fieldId);
                ps.executeUpdate();
            }

            // 2. Lấy danh sách slot mới theo loại sân mới
            String selectSlotsSql = "SELECT slot_id FROM SlotsOfDay WHERE field_type_id = ?";
            List<Integer> newSlotIds = new ArrayList<>();
            try (PreparedStatement ps = connection.prepareStatement(selectSlotsSql)) {
                ps.setInt(1, newFieldTypeId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        newSlotIds.add(rs.getInt("slot_id"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertField(Field field) {
        String sql = "INSERT INTO Field (zone_id, field_type_id, field_name, image, status, description) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, field.getZone().getZoneId());
            ps.setInt(2, field.getTypeOfField().getFieldTypeId());
            ps.setString(3, field.getFieldName());
            ps.setString(4, field.getImage());
            ps.setString(5, field.getStatus());
            ps.setString(6, field.getDescription());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isFieldNameExistInZone(String fieldName, int zoneId, Integer excludeFieldId) {
        String sql = "SELECT COUNT(*) FROM Field WHERE field_name = ? AND zone_id = ?";
        if (excludeFieldId != null) {
            sql += " AND field_id != ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, fieldName);
            ps.setInt(2, zoneId);
            if (excludeFieldId != null) {
                ps.setInt(3, excludeFieldId);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Báo cáo tình trạng sử dụng từng sân (có phân trang)
    public List<Map<String, Object>> getFieldUsageReport() {
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            String sql
                    = "SELECT f.field_id, f.field_name, tof.field_type_name, f.status, "
                    + "COUNT(bd.booking_details_id) AS booking_count, ISNULL(SUM(bd.slot_field_price + ISNULL(bd.extra_fee,0)), 0) AS total_revenue "
                    + "FROM Field f "
                    + "LEFT JOIN TypeOfField tof ON f.field_type_id = tof.field_type_id "
                    + "LEFT JOIN SlotsOfField sf ON f.field_id = sf.field_id "
                    + "LEFT JOIN BookingDetails bd ON sf.slot_field_id = bd.slot_field_id "
                    + "GROUP BY f.field_id, f.field_name, tof.field_type_name, f.status "
                    + "ORDER BY f.field_id DESC";
            try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("field_id", rs.getInt("field_id"));
                    map.put("field_name", rs.getString("field_name"));
                    map.put("field_type_name", rs.getString("field_type_name"));
                    map.put("status", rs.getString("status"));
                    map.put("booking_count", rs.getInt("booking_count"));
                    map.put("total_revenue", rs.getBigDecimal("total_revenue"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm tổng số sân cho báo cáo tình trạng sử dụng (phục vụ phân trang)
    public int countFieldUsageReport() throws SQLException {
        String sql = "SELECT COUNT(*) as total FROM Field";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        }
        return 0;
    }

    // Báo cáo tình trạng sử dụng từng sân có filter (bỏ số lượt đặt)
    public List<Map<String, Object>> getFieldUsageReportWithFilters(String fieldKeyword, String fieldType, String fieldStatus, String revenueFrom, String revenueTo) {
        List<Map<String, Object>> list = new ArrayList<>();
        try {
            StringBuilder sql = new StringBuilder();
            sql.append("SELECT f.field_id, f.field_name, tof.field_type_name, f.status, ");
            sql.append("COUNT(bd.booking_details_id) AS booking_count, ISNULL(SUM(bd.slot_field_price + ISNULL(bd.extra_fee,0)), 0) AS total_revenue ");
            sql.append("FROM Field f ");
            sql.append("INNER JOIN TypeOfField tof ON f.field_type_id = tof.field_type_id ");
            sql.append("LEFT JOIN SlotsOfField sf ON f.field_id = sf.field_id ");
            sql.append("LEFT JOIN BookingDetails bd ON sf.slot_field_id = bd.slot_field_id ");
            sql.append("WHERE 1=1 ");
            if (fieldKeyword != null && !fieldKeyword.isEmpty()) {
                sql.append(" AND LOWER(f.field_name) LIKE ? ");
            }
            if (fieldType != null && !fieldType.isEmpty()) {
                sql.append(" AND f.field_type_id = ? ");
            }
            if (fieldStatus != null && !fieldStatus.isEmpty()) {
                sql.append(" AND f.status = ? ");
            }
            sql.append("GROUP BY f.field_id, f.field_name, tof.field_type_name, f.status ");
            sql.append("HAVING 1=1 ");
            if (revenueFrom != null && !revenueFrom.isEmpty()) {
                sql.append(" AND ISNULL(SUM(bd.slot_field_price + ISNULL(bd.extra_fee,0)),0) >= ? ");
            }
            if (revenueTo != null && !revenueTo.isEmpty()) {
                sql.append(" AND ISNULL(SUM(bd.slot_field_price + ISNULL(bd.extra_fee,0)),0) <= ? ");
            }
            sql.append("ORDER BY f.field_id DESC");
            try (Connection conn = util.DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
                int idx = 1;
                if (fieldKeyword != null && !fieldKeyword.isEmpty()) {
                    ps.setString(idx++, "%" + fieldKeyword.trim().toLowerCase() + "%");
                }
                if (fieldType != null && !fieldType.isEmpty()) {
                    ps.setString(idx++, fieldType);
                }
                if (fieldStatus != null && !fieldStatus.isEmpty()) {
                    ps.setString(idx++, fieldStatus);
                }
                if (revenueFrom != null && !revenueFrom.isEmpty()) {
                    ps.setBigDecimal(idx++, new java.math.BigDecimal(revenueFrom));
                }
                if (revenueTo != null && !revenueTo.isEmpty()) {
                    ps.setBigDecimal(idx++, new java.math.BigDecimal(revenueTo));
                }
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("field_id", rs.getInt("field_id"));
                    map.put("field_name", rs.getString("field_name"));
                    map.put("field_type_name", rs.getString("field_type_name"));
                    map.put("status", rs.getString("status"));
                    map.put("booking_count", rs.getInt("booking_count"));
                    map.put("total_revenue", rs.getBigDecimal("total_revenue"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
