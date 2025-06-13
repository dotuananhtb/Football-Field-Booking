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
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.BookingDetails;
import model.SlotEventDTO;
import model.SlotsOfField;
import util.DBContext;

public class SlotEventDTODAO extends DBContext {

    public List<Map<String, Object>> getAllSlotsForRange(int fieldId, String startDate, String endDate) {
        List<Map<String, Object>> list = new ArrayList<>();
        FieldDAO fieldDAO = new FieldDAO();
        SlotsOfFieldDAO slotsOfFieldDAO = new SlotsOfFieldDAO();
        BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();

        List<SlotsOfField> slots = slotsOfFieldDAO.getSlotsByField(fieldId);
        String fieldName = fieldDAO.getFieldByFieldID(fieldId).getFieldName(); // chỉ gọi 1 lần

        LocalDate start = LocalDate.parse(startDate);
        LocalDate end = LocalDate.parse(endDate);
        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime now = LocalDateTime.now();

        for (LocalDate date = start; !date.isAfter(end); date = date.plusDays(1)) {
            String slotDate = date.format(dateFormat);

            for (SlotsOfField slot : slots) {
                int slotFieldId = slot.getSlotFieldId();
                String startTime = slot.getSlotInfo().getStartTime();
                String endTime = slot.getSlotInfo().getEndTime();
                BigDecimal price = slot.getSlotFieldPrice();
                LocalTime slotStartTime = LocalTime.parse(startTime);
                LocalDateTime slotStartDateTime = LocalDateTime.of(date, slotStartTime);

                BookingDetails detail = bookingDetailsDAO.getBySlotFieldAndDate(slotFieldId, slotDate);

                String status;
                String color;

                if (slotStartDateTime.isBefore(now)) {
                    status = "Đã qua";
                    color = "#6c757d";
                } else if (detail == null || detail.getStatusCheckingId() == 3) {
                    status = "Available";
                    color = "#28a745";
                } else if (detail.getStatusCheckingId() == 2) {
                    status = "Pending";
                    color = "#ffc107";
                } else {
                    status = "Booked";
                    color = "#dc3545";
                }

                String title = fieldName + " ca " + startTime + " - " + endTime;

                // Build extendedProps
                Map<String, Object> extendedProps = new HashMap<>();
                extendedProps.put("slot_field_id", slotFieldId);
                extendedProps.put("slot_date", slotDate);
                extendedProps.put("price", price);
                extendedProps.put("status", status);

                // Build event
                Map<String, Object> event = new HashMap<>();
                event.put("title", title);
                event.put("start", slotDate + "T" + startTime);
                event.put("end", slotDate + "T" + endTime);
                event.put("color", color);
                event.put("extendedProps", extendedProps);

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
                9, // fieldId: sân số 2
                "2025-06-13", // startDate
                "2025-06-22" // endDate
        );

        // In ra dưới dạng JSON
        Gson gson = new Gson();
        String jsonOutput = gson.toJson(result);
        System.out.println(jsonOutput);
    }
}
