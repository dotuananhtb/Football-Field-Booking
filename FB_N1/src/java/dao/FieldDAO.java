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
        String sql = "Sselect * from Field";
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
}
