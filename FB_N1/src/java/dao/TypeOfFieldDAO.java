/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import java.util.List;
import model.TypeOfField;
import java.sql.*;
import util.DBContext;

/**
 *
 * @author Đỗ Tuấn Anh
 */
public class TypeOfFieldDAO extends DBContext {

    public List<TypeOfField> getAllFieldTypes() {
        List<TypeOfField> list = new ArrayList<>();
        String sql = "SELECT * FROM TypeOfField";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                TypeOfField type = new TypeOfField();
                type.setFieldTypeId(rs.getInt("field_type_id"));
                type.setFieldTypeName(rs.getString("field_type_name"));
                list.add(type);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getFieldTypeNameById(int id) {
        String sql = "SELECT field_type_name FROM TypeOfField WHERE field_type_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getString("field_type_name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "";
    }

//CRUD loại sân
    public TypeOfField getFieldTypeById(int id) {
        String sql = "SELECT * FROM TypeOfField WHERE field_type_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new TypeOfField(
                        rs.getInt("field_type_id"),
                        rs.getString("field_type_name")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertFieldType(String name) {
        String sql = "INSERT INTO TypeOfField(field_type_name) VALUES (?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateFieldType(int id, String name) {
        String sql = "UPDATE TypeOfField SET field_type_name = ? WHERE field_type_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, name);
            st.setInt(2, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isTypeInUse(int typeId) {
        String sqlField = "SELECT COUNT(*) FROM Field WHERE field_type_id = ?";
        String sqlSlot = "SELECT COUNT(*) FROM SlotsOfDay WHERE field_type_id = ?";
        try {
            PreparedStatement ps1 = connection.prepareStatement(sqlField);
            ps1.setInt(1, typeId);
            ResultSet rs1 = ps1.executeQuery();

            PreparedStatement ps2 = connection.prepareStatement(sqlSlot);
            ps2.setInt(1, typeId);
            ResultSet rs2 = ps2.executeQuery();

            int countField = 0, countSlot = 0;
            if (rs1.next()) {
                countField = rs1.getInt(1);
            }
            if (rs2.next()) {
                countSlot = rs2.getInt(1);
            }

            return (countField > 0 || countSlot > 0); // đang được sử dụng
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true; 
    }

    public void deleteFieldType(int id) {
        String sql = "DELETE FROM TypeOfField WHERE field_type_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
