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
}