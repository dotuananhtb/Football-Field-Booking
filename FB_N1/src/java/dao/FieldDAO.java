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

    public Vector<Field> getAllField1() {
        Vector<Field> list = new Vector<>();
        String sql = "Select f.field_name,\n"
                + "                f.image,\n"
                + "                f.status,\n"
                + "                f.description,\n"
                + "                z.Address AS zone_address,\n"
                + "                sl.slot_field_price,\n"
                + "                ty.field_type_name,\n"
                + "                sld.start_time,\n"
                + "                sld.end_time from Field f join Zone z on f.zone_id = z.zone_id join SlotsOfField sl on f.field_id = sl.field_id join TypeOfField ty on ty.field_type_id = f.field_type_id join SlotsOfDay sld on sld.slot_id = sl.slot_id";
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

    public Vector<FieldDetails> getAllFieldDetails() {
        Vector<FieldDetails> list = new Vector<>();
        String sql = "SELECT f.field_id, f.field_name, z.Address, t.field_type_name, \n"
                + "               f.image, f.description, f.status,\n"
                + "               MIN(sf.slot_field_price) as min_price\n"
                + "        FROM Field f\n"
                + "        INNER JOIN Zone z ON f.zone_id = z.zone_id\n"
                + "        INNER JOIN TypeOfField t ON f.field_type_id = t.field_type_id\n"
                + "        LEFT JOIN SlotsOfField sf ON f.field_id = sf.field_id\n"
                + //"        WHERE f.status = N'Hoạt động'\n" +
                "        GROUP BY f.field_id, f.field_name, z.Address, t.field_type_name, \n"
                + "                 f.image, f.description, f.status\n"
                + "        ORDER BY f.field_id";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                FieldDetails up = new FieldDetails(
                        rs.getInt("field_id"),
                        rs.getString("field_name"),
                        rs.getString("Address"),
                        rs.getString("field_type_name"),
                        rs.getString("image"),
                        rs.getString("description"),
                        rs.getString("status"),
                        rs.getDouble("min_price")
                );
                list.add(up);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public int getTotalField() {

        String sql = "Select count(*) from Field";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }
//    public Vector<Field>pagingField(int index){
//        Vector<Field> list = new Vector<>();
//        String sql = "Select count(*) from Field";
//        return list;
//    }

    public static void main(String[] args) {
        Vector<FieldDetails> listFields;
        FieldDAO dao = new FieldDAO();
        listFields = dao.getAllFieldDetails();
        for (FieldDetails listField : listFields) {
            System.out.println(listField);
        }

    }
}
