/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.Vector;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.DBContext;
import model.*;

/**
 *
 * @author Asus
 */
public class FieldDAO extends DBContext {

    public Vector<Field> getAllField() {
        Vector<Field> list = new Vector<>();
        String sql = "Select * from Field";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Field up = new Field(
                        rs.getInt("field_id"),
                        rs.getInt("zone_id"),
                        rs.getInt("field_type_id"),
                        rs.getString("field_name"),
                        rs.getString("image"),
                        rs.getString("status"),
                        rs.getString("description")
                );
                list.add(up);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    public Vector<Zone> getAllZone() {
        Vector<Zone> list = new Vector<>();
        String sql = "Select * from zone";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                Zone up = new Zone(
                        rs.getInt("zone_id"),
                        rs.getString("Address"));
                
                list.add(up);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    public Vector<TypeOfField> getAllTypeOfField() {
        Vector<TypeOfField> list = new Vector<>();
        String sql = "Select * from TypeOfField";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                TypeOfField up = new TypeOfField(
                        rs.getInt("field_type_id"),
                        rs.getString("field_type_name"));
                
                list.add(up);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    public Vector<SlotsOfField> getAllSlotsOfField() {
        Vector<SlotsOfField> list = new Vector<>();
        String sql = "Select * from SlotsOfField";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                SlotsOfField up = new SlotsOfField(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getDouble(4));
                        
                
                list.add(up);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }
    
    public static void main(String[] args) {
        Vector<SlotsOfField> listFields;
        FieldDAO dao = new FieldDAO();
        listFields = dao.getAllSlotsOfField();
        for (SlotsOfField listField : listFields) {
            System.out.println(listField);
        }
        
    }
}
