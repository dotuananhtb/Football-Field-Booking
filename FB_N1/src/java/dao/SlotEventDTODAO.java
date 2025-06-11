/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author Đỗ Tuấn Anh
 */
import com.google.gson.Gson;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.SlotEventDTO;
import model.SlotsOfField;
import util.DBContext;

public class SlotEventDTODAO extends DBContext {

    public List<Map<String, Object>> getAllSlotsForRange(int fieldId, String startDate, String endDate) {
        List<Map<String, Object>> list = new ArrayList<>();

        // Bước 1: Lấy danh sách ca mặc định của sân
        SlotsOfFieldDAO slotsOfFieldDAO= new SlotsOfFieldDAO();
        List<SlotsOfField> slots = slotsOfFieldDAO.getSlotsByField(fieldId); // mỗi slot có: slotFieldId, startTime, endTime

        // Bước 2: Duyệt từng ngày trong khoảng
        LocalDate start = LocalDate.parse(startDate);
        LocalDate end = LocalDate.parse(endDate);
        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        for (LocalDate date = start; !date.isAfter(end); date = date.plusDays(1)) {
            String dateStr = date.format(dateFormat);

            for (SlotsOfField slot : slots) {
                int slotFieldId = slot.getSlotFieldId();

                // Bước 3: Check trong bảng CheckingSlot
                CheckingSlotDAO checkingSlotDAO = new CheckingSlotDAO();
                String status = checkingSlotDAO.getSlotStatus(slotFieldId, dateStr); // nếu không có bản ghi trả "available"

                // Bước 4: Tạo sự kiện cho FullCalendar
                Map<String, Object> event = new HashMap<>();
                event.put("title", status.equals("available") ? "Available" : "Booked");
                event.put("start", dateStr + "T" + slot.getSlotInfo().getStartTime()); // "2025-06-13T08:00:00"
                event.put("end", dateStr + "T" + slot.getSlotInfo().getEndTime());
                event.put("color", status.equals("available") ? "#28a745" : "#dc3545"); // xanh/đỏ
                list.add(event);
            }
        }

        return list;
    }
    
     public static void main(String[] args) {
        // Khởi tạo DAO
        SlotEventDTODAO dao = new SlotEventDTODAO();

        // Gọi hàm chính để lấy danh sách slot
        List<Map<String, Object>> result = dao.getAllSlotsForRange(
            9,                       // fieldId: sân số 2
            "2025-06-13",            // startDate
            "2025-06-22"             // endDate
        );

        // In ra dưới dạng JSON
        Gson gson = new Gson();
        String jsonOutput = gson.toJson(result);
        System.out.println(jsonOutput);
    }
}
