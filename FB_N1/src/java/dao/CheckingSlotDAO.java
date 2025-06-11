/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Đỗ Tuấn Anh
 */
import java.util.ArrayList;
import java.util.List;
import model.TypeOfField;
import java.sql.*;
import model.CheckingSlot;
import model.SlotEventDTO;
import util.DBContext;

public class CheckingSlotDAO extends DBContext {

    public List<CheckingSlot> getCheckingSlotsByFieldId(int fieldId) {
        List<CheckingSlot> list = new ArrayList<>();
        String sql = """
        SELECT cs.checking_slot_id, cs.slot_field_id, cs.slot_date, cs.status
        FROM CheckingSlot cs
        JOIN SlotsOfField sof ON cs.slot_field_id = sof.slot_field_id
        WHERE sof.field_id = ?
    """;
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, fieldId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CheckingSlot cs = new CheckingSlot();
                cs.setCheckingSlotId(rs.getInt("checking_slot_id"));
                cs.setSlotFieldId(rs.getInt("slot_field_id"));
                cs.setSlotDate(rs.getString("slot_date"));
                cs.setStatus(rs.getString("status"));
                list.add(cs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;

    }

    public String getSlotStatus(int slotFieldId, String date) {
        String sql = "SELECT status FROM CheckingSlot WHERE slot_field_id = ? AND CONVERT(DATE, slot_date) = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, slotFieldId);
            ps.setString(2, date);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("status");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "available";
    }

    public static void main(String[] args) {
        CheckingSlotDAO dao = new CheckingSlotDAO();

        // Thử với field_id = 1 (Tuan Anh thay số ID thực tế trong DB)
        int testFieldId = 2;
        List<CheckingSlot> slots = dao.getCheckingSlotsByFieldId(testFieldId);

        // In ra danh sách các CheckingSlot
        for (CheckingSlot slot : slots) {
            System.out.println(slot.toString());
        }
    }

}
