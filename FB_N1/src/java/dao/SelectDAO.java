/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author VAN NGUYEN
 */
public class SelectDAO extends DBContext {
    
    public void updateSelectedTheme(String eventId) {
    String sqlCheck = "SELECT COUNT(*) FROM SelectedTheme WHERE id = 1";
    String sqlInsert = "INSERT INTO SelectedTheme (id, event_id) VALUES (1, ?)";
    String sqlUpdate = "UPDATE SelectedTheme SET event_id = ? WHERE id = 1";

    try (PreparedStatement psCheck = connection.prepareStatement(sqlCheck);
         ResultSet rs = psCheck.executeQuery()) {
        if (rs.next() && rs.getInt(1) > 0) {
            try (PreparedStatement psUpdate = connection.prepareStatement(sqlUpdate)) {
                psUpdate.setString(1, eventId);
                psUpdate.executeUpdate();
            }
        } else {
            try (PreparedStatement psInsert = connection.prepareStatement(sqlInsert)) {
                psInsert.setString(1, eventId);
                psInsert.executeUpdate();
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}
   
    public String getSelectedThemeEventId() {
    String sql = "SELECT event_id FROM SelectedTheme WHERE id = 1";
    try (PreparedStatement ps = connection.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) {
            return rs.getString("event_id");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null; // fallback nếu chưa có gì → chọn mặc định
}
    public static void main(String[] args) {
        SelectDAO sDao = new SelectDAO();
        sDao.updateSelectedTheme("1");
               
    }

}
