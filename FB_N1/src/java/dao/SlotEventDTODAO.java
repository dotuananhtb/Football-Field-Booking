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
import model.Account;
import model.Booking;
import model.BookingDetails;
import model.Field;
import model.OfflineCustomer;
import model.OfflineUser;
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
        String fieldName = fieldDAO.getFieldByFieldID(fieldId).getFieldName();

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
                } else if (detail.getStatusCheckingId() == 4) {
                    status = "Wait";
                    color = "#9900FF";
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

    public List<Map<String, Object>> getAllBookedOrPendingSlots() {
        List<Map<String, Object>> list = new ArrayList<>();
        SlotsOfFieldDAO slotsOfFieldDAO = new SlotsOfFieldDAO();
        BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();
        BookingDAO bookingDAO = new BookingDAO();
        FieldDAO fieldDAO = new FieldDAO();
        AccountDAO accountDAO = new AccountDAO();
        OfflineCustomerDAO offlineDAO = new OfflineCustomerDAO();

        List<BookingDetails> allDetails = bookingDetailsDAO.getAllBookingDetail();

        for (BookingDetails detail : allDetails) {
            int slotFieldId = detail.getSlotFieldId();
            String slotDate = detail.getSlotDate();

            SlotsOfField slot = slotsOfFieldDAO.getSlotOfFieldById(slotFieldId);
            if (slot == null) {
                continue;
            }

            Field field = slot.getField();
            if (field == null) {
                continue;
            }

            String fieldName = field.getFieldName();
            String fieldTypeName = field.getTypeOfField().getFieldTypeName();
            String startTime = detail.getStartTime();
            String endTime = detail.getEndTime();
            BigDecimal price = slot.getSlotFieldPrice();

            int status = detail.getStatusCheckingId();
            String className = (status == 1) ? "bg-danger" : "bg-warning";

            // Lấy thông tin người đặt
            Map<String, Object> userInfo = null;
            Booking booking = bookingDAO.getBookingByBookingDetailId(detail.getBookingDetailsId());

            if (booking != null) {
                userInfo = new HashMap<>();
                Integer accountId = booking.getAccountId();
                OfflineCustomer offline = offlineDAO.getOfflineCustomerByBookingId(booking.getBookingId());

                if (offline != null) {
                    OfflineUser offlineUser = offlineDAO.getOfflineUserByBookingDetailId(detail.getBookingDetailsId());
                    if (offlineUser != null) {
                        userInfo.put("name", offlineUser.getFullName());
                        userInfo.put("phone", offlineUser.getPhone());
                        userInfo.put("email", offlineUser.getEmail());
                        userInfo.put("isOffline", true);
                    }
                } else {
                    Account acc = accountDAO.getAccountById(accountId);
                    if (acc != null) {
                        userInfo.put("name", acc.getUserProfile().getFullName());
                        userInfo.put("email", acc.getEmail());
                        userInfo.put("phone", acc.getUserProfile().getPhone());
                        userInfo.put("isOffline", false);
                    }
                }
            }

            Map<String, Object> extendedProps = new HashMap<>();
            extendedProps.put("slot_field_id", slotFieldId);
            extendedProps.put("slot_date", slotDate);
            extendedProps.put("start_time", startTime);
            extendedProps.put("end_time", endTime);
            extendedProps.put("field_name", fieldName);
            extendedProps.put("price", price);
            extendedProps.put("extra_minutes", detail.getExtraMinutes());
            extendedProps.put("extra_fee", detail.getExtraFee());
            extendedProps.put("note", detail.getNote());
            extendedProps.put("status", status);
            extendedProps.put("userInfo", userInfo);
            extendedProps.put("booking_id", detail.getBookingId());
            extendedProps.put("booking_details_id", detail.getBookingDetailsId());
            extendedProps.put("booking_date", booking != null ? booking.getBookingDate() : null);
            extendedProps.put("booking_code", booking != null ? booking.getBookingCode() : null);
            extendedProps.put("booking_details_code", detail.getBookingDetailsCode());
            extendedProps.put("field_type_name", fieldTypeName);

            Map<String, Object> event = new HashMap<>();
            event.put("title", fieldName + " ca " + startTime + " - " + endTime);
            event.put("start", slotDate + "T" + startTime);
            event.put("end", slotDate + "T" + endTime);
            event.put("className", className);
            event.put("extendedProps", extendedProps);

            list.add(event);
        }

        return list;
    }

    public List<Map<String, Object>> getAllSlotsForRange2(int fieldId, String startDate, String endDate) {
        List<Map<String, Object>> list = new ArrayList<>();
        FieldDAO fieldDAO = new FieldDAO();
        SlotsOfFieldDAO slotsOfFieldDAO = new SlotsOfFieldDAO();
        BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();
        BookingDAO bookingDAO = new BookingDAO();
        AccountDAO accountDAO = new AccountDAO();
        OfflineCustomerDAO offlineDAO = new OfflineCustomerDAO();

        List<SlotsOfField> slots = slotsOfFieldDAO.getSlotsByField(fieldId);
        String fieldName = fieldDAO.getFieldByFieldID(fieldId).getFieldName();
        String fieldTypeName = fieldDAO.getFieldByFieldID(fieldId).getTypeOfField().getFieldTypeName();

        LocalDate start = LocalDate.parse(startDate);
        LocalDate end = LocalDate.parse(endDate);
        DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime now = LocalDateTime.now();

        for (LocalDate date = start; !date.isAfter(end); date = date.plusDays(1)) {
            String slotDate = date.format(dateFormat);
            for (SlotsOfField slot : slots) {
                int slotFieldId = slot.getSlotFieldId();
                BigDecimal price = slot.getSlotFieldPrice();

                BookingDetails detail = bookingDetailsDAO.getBySlotFieldAndDate(slotFieldId, slotDate);

                // ✅ Ưu tiên thời gian từ BookingDetails nếu đã được đặt
                String startTime, endTime;
                if (detail != null && detail.getStartTime() != null && detail.getEndTime() != null) {
                    startTime = detail.getStartTime();
                    endTime = detail.getEndTime();
                } else {
                    startTime = slot.getSlotInfo().getStartTime();
                    endTime = slot.getSlotInfo().getEndTime();
                }

                LocalTime slotStartTime = LocalTime.parse(startTime);
                LocalDateTime slotStartDateTime = LocalDateTime.of(date, slotStartTime);

                int status;
                String className;
                Map<String, Object> userInfo = null;

                if (slotStartDateTime.isBefore(now)) {
                    if (detail != null) {
                        switch (detail.getStatusCheckingId()) {

                            case 1 -> {
                                status = 1;
                                className = "bg-danger bg-opacity-25 text-dark";
                            }
                            case 2 -> {
                                status = 2;
                                className = "bg-warning bg-opacity-25 text-dark";
                            }
                            default -> {
                                status = 3;
                                className = "bg-light text-dark";
                            }
                            case 4 -> {
                                status = 4;
                                className = "bg-primary bg-opacity-25 text-dark";
                            }
                        }
                    } else {
                        status = -1;
                        className = "bg-light text-dark";
                    }
                } else {
                    if (detail == null || detail.getStatusCheckingId() == 3) {
                        status = 0;
                        className = "bg-success";
                    } else if (detail.getStatusCheckingId() == 2) {
                        status = 2;
                        className = "bg-warning";

                    } else if (detail.getStatusCheckingId() == 4) {
                        status = 4;
                        className = "bg-primary bg-opacity-25 text-dark";//cho thanh toan

                    } else {
                        status = 1;
                        className = "bg-danger";
                    }
                }

                // Lấy thông tin người đặt (nếu có)
                if (detail != null) {
                    userInfo = new HashMap<>();
                    Booking booking = bookingDAO.getBookingByBookingDetailId(detail.getBookingDetailsId());

                    if (booking != null) {
                        Integer accountId = booking.getAccountId();

                        // Kiểm tra offline
                        OfflineCustomer offlineCustomer = offlineDAO.getOfflineCustomerByBookingId(booking.getBookingId());

                        if (offlineCustomer != null) {
                            OfflineUser offlineUser = offlineDAO.getOfflineUserByBookingDetailId(detail.getBookingDetailsId());
                            if (offlineUser != null) {
                                userInfo.put("name", offlineUser.getFullName());
                                userInfo.put("phone", offlineUser.getPhone());
                                userInfo.put("email", offlineUser.getEmail());
                                userInfo.put("isOffline", true);
                                userInfo.put("createdBy", offlineUser.getCreatedBy());
                            }
                        } else {
                            Account acc = accountDAO.getAccountById(accountId);
                            if (acc != null) {
                                userInfo.put("name", acc.getUserProfile().getFullName());
                                userInfo.put("email", acc.getEmail());
                                userInfo.put("phone", acc.getUserProfile().getPhone());
                                userInfo.put("isOffline", false);
                            }
                        }
                    }
                }

                // extendedProps
                Map<String, Object> extendedProps = new HashMap<>();
                extendedProps.put("slot_field_id", slotFieldId);
                extendedProps.put("slot_date", slotDate);
                extendedProps.put("start_time", startTime);
                extendedProps.put("end_time", endTime);
                extendedProps.put("field_name", fieldName);
                extendedProps.put("price", price);
                extendedProps.put("extra_minutes", detail != null ? detail.getExtraMinutes() : 0);
                extendedProps.put("extra_fee", detail != null ? detail.getExtraFee() : BigDecimal.ZERO);
                extendedProps.put("note", detail != null ? detail.getNote() : null);
                extendedProps.put("status", status);
                extendedProps.put("userInfo", userInfo);
                extendedProps.put("booking_id", detail != null ? detail.getBookingId() : null);
                extendedProps.put("booking_details_id", detail != null ? detail.getBookingDetailsId() : null);
                extendedProps.put("booking_date", detail != null ? bookingDAO.getBookingByBookingDetailId(detail.getBookingDetailsId()).getBookingDate() : null);
                extendedProps.put("booking_code", detail != null ? bookingDAO.getBookingByBookingDetailId(detail.getBookingDetailsId()).getBookingCode() : null);
                extendedProps.put("booking_details_code", detail != null ? detail.getBookingDetailsCode() : null);

                extendedProps.put("field_type_name", fieldTypeName);

                // Event
                Map<String, Object> event = new HashMap<>();
                event.put("title", fieldName + " ca " + startTime + " - " + endTime);
                event.put("start", slotDate + "T" + startTime);
                event.put("end", slotDate + "T" + endTime);
                event.put("className", className);
                event.put("extendedProps", extendedProps);

                list.add(event);
            }
        }

        return list;
    }

    public static void main(String[] args) {
//        // Khởi tạo DAO
//        SlotEventDTODAO dao = new SlotEventDTODAO();
//
//        // Gọi hàm chính để lấy danh sách slot
//        List<Map<String, Object>> result = dao.getAllSlotsForRange(
//                9, // fieldId: sân số 2
//                "2025-06-13", // startDate
//                "2025-06-22" // endDate
//        );
//
//        // In ra dưới dạng JSON
//        Gson gson = new Gson();
//        String jsonOutput = gson.toJson(result);
//        System.out.println(jsonOutput);

        SlotEventDTODAO dao = new SlotEventDTODAO();
        List<Map<String, Object>> events = dao.getAllBookedOrPendingSlots();

        System.out.println("Tổng số slot đã đặt hoặc chờ xử lý: " + events.size());

        for (Map<String, Object> event : events) {
            System.out.println("-----");
            System.out.println("Tiêu đề: " + event.get("title"));
            System.out.println("Thời gian bắt đầu: " + event.get("start"));
            System.out.println("Thời gian kết thúc: " + event.get("end"));

            Map<String, Object> extended = (Map<String, Object>) event.get("extendedProps");
            System.out.println("Sân: " + extended.get("field_name"));
            System.out.println("Giá: " + extended.get("price"));
            System.out.println("Trạng thái: " + extended.get("status"));

            Map<String, Object> userInfo = (Map<String, Object>) extended.get("userInfo");
            if (userInfo != null) {
                System.out.println("Khách: " + userInfo.get("name") + " | " + userInfo.get("phone"));
            } else {
                System.out.println("Khách: (Không có)");
            }
        }
    }
}
