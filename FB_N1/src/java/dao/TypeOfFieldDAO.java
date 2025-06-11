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
    public List<TypeOfField> getAllTypes() {
        List<TypeOfField> list = new ArrayList<>();
        String sql = "SELECT * FROM TypeOfField";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new TypeOfField(rs.getInt(1), rs.getString(2)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}