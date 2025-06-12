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
import model.BookingDetails;
import model.SlotEventDTO;
import model.SlotsOfField;
import util.DBContext;

public class SlotEventDTODAO extends DBContext {

    public List<Map<String, Object>> getAllSlotsForRange(int fieldId, String startDate, String endDate) {
        List<Map<String, Object>> list = new ArrayList<>();

        // DAO để truy xuất dữ liệu
        SlotsOfFieldDAO slotsOfFieldDAO = new SlotsOfFieldDAO();
        BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();

        // Lấy danh sách slot theo sân
        List<SlotsOfField> slots = slotsOfFieldDAO.getSlotsByField(fieldId);

        // Xử lý khoảng ngày
        LocalDate start = LocalDate.parse(startDate);
        LocalDate end = LocalDate.parse(endDate);
        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        for (LocalDate date = start; !date.isAfter(end); date = date.plusDays(1)) {
            String slotDate = date.format(dateFormat);

            for (SlotsOfField slot : slots) {
                int slotFieldId = slot.getSlotFieldId();

                // Kiểm tra xem slot này trong ngày đó đã được đặt hay chưa
                BookingDetails detail = bookingDetailsDAO.getBySlotFieldAndDate(slotFieldId, slotDate);

                String status;
                String color;
                if (detail == null || detail.getStatusCheckingId() == 3) {
                    status = "Available";
                    color = "#28a745"; // xanh
                } else if (detail.getStatusCheckingId() == 2) {
                    status = "Pending";
                    color = "#ffc107"; // vàng
                } else {
                    status = "Booked";
                    color = "#dc3545"; // đỏ
                }

                // Tạo object event để hiển thị
                Map<String, Object> event = new HashMap<>();
                event.put("title", status);
                event.put("start", slotDate + "T" + slot.getSlotInfo().getStartTime());
                event.put("end", slotDate + "T" + slot.getSlotInfo().getEndTime());
                event.put("color", color);

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
