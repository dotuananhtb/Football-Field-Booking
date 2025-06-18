package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.BookingSlotInfo;
import util.DBContext;

public class BookingSlotInfoDAO extends DBContext {

    public List<BookingSlotInfo> getAllBookingSlots() {
        List<BookingSlotInfo> list = new ArrayList<>();
        String sql = """
            SELECT bd.booking_details_id,
                   b.booking_id,
                   b.booking_date,
                   bd.slot_date,
                   s.start_time,
                   s.end_time,
                   f.field_name,
                   tf.field_type_name,
                   bd.slot_field_price,
                   scs.status_name AS slot_status,
                   up.first_name + ' ' + up.last_name AS customer_name,
                   up.phone,
                   a.email,
                   bd.note
            FROM BookingDetails bd
            JOIN Booking b ON bd.booking_id = b.booking_id
            JOIN SlotsOfField sof ON bd.slot_field_id = sof.slot_field_id
            JOIN SlotsOfDay s ON sof.slot_id = s.slot_id
            JOIN Field f ON sof.field_id = f.field_id
            JOIN TypeOfField tf ON f.field_type_id = tf.field_type_id
            JOIN StatusCheckingSlot scs ON bd.status_checking_id = scs.status_checking_id
            JOIN Account a ON b.account_id = a.account_id
            JOIN UserProfile up ON a.account_id = up.account_id
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                BookingSlotInfo info = extractFromResultSet(rs);
                list.add(info);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public BookingSlotInfo getBySlotDateAndSlotFieldId(String slotDate, int slotFieldId) {
        BookingSlotInfo info = null;
        String sql = """
            SELECT bd.booking_details_id,
                   b.booking_id,
                   b.booking_date,
                   bd.slot_date,
                   s.start_time,
                   s.end_time,
                   f.field_name,
                   tf.field_type_name,
                   bd.slot_field_price,
                   scs.status_name AS slot_status,
                   up.first_name + ' ' + up.last_name AS customer_name,
                   up.phone,
                   a.email,
                   bd.note
            FROM BookingDetails bd
            JOIN Booking b ON bd.booking_id = b.booking_id
            JOIN SlotsOfField sof ON bd.slot_field_id = sof.slot_field_id
            JOIN SlotsOfDay s ON sof.slot_id = s.slot_id
            JOIN Field f ON sof.field_id = f.field_id
            JOIN TypeOfField tf ON f.field_type_id = tf.field_type_id
            JOIN StatusCheckingSlot scs ON bd.status_checking_id = scs.status_checking_id
            JOIN Account a ON b.account_id = a.account_id
            JOIN UserProfile up ON a.account_id = up.account_id
            WHERE bd.slot_date = ? AND bd.slot_field_id = ?
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, slotDate);
            ps.setInt(2, slotFieldId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    info = extractFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return info;
    }

    private BookingSlotInfo extractFromResultSet(ResultSet rs) throws SQLException {
        BookingSlotInfo info = new BookingSlotInfo();
        info.setBookingDetailsId(rs.getInt("booking_details_id"));
        info.setBookingId(rs.getInt("booking_id"));
        info.setBookingDate(rs.getString("booking_date"));
        info.setSlotDate(rs.getString("slot_date"));
        info.setStartTime(rs.getString("start_time"));
        info.setEndTime(rs.getString("end_time"));
        info.setFieldName(rs.getString("field_name"));
        info.setFieldTypeName(rs.getString("field_type_name"));
        info.setSlotFieldPrice(rs.getBigDecimal("slot_field_price"));
        info.setSlotStatus(rs.getString("slot_status"));
        info.setCustomerName(rs.getString("customer_name"));
        info.setPhone(rs.getString("phone"));
        info.setEmail(rs.getString("email"));
        info.setNote(rs.getString("note"));
        return info;
    }

    ///Test
    public static void main(String[] args) {
        BookingSlotInfoDAO dao = new BookingSlotInfoDAO();

//        System.out.println("=== Test 1: Lấy toàn bộ danh sách lịch đặt ===");
//        List<BookingSlotInfo> list = dao.getAllBookingSlots();
//        for (BookingSlotInfo info : list) {
//            printInfo(info);
//        }

        System.out.println("\n=== Test 2: Tìm theo slot_date và slot_field_id ===");
        String slotDate = "2025-06-18";
        int slotFieldId = 12; // Nhớ dùng ID hợp lệ trong DB
        BookingSlotInfo result = dao.getBySlotDateAndSlotFieldId(slotDate, slotFieldId);
        if (result != null) {
            printInfo(result);
        } else {
            System.out.println("Không tìm thấy ca sân với ngày " + slotDate + " và slot_field_id " + slotFieldId);
        }
    }

    private static void printInfo(BookingSlotInfo info) {
        System.out.println("-----------------------------");
        System.out.println("Mã chi tiết: " + info.getBookingDetailsId());
        System.out.println("Mã đơn: " + info.getBookingId());
        System.out.println("Ngày đặt: " + info.getBookingDate());
        System.out.println("Ngày diễn ra: " + info.getSlotDate());
        System.out.println("Thời gian: " + info.getStartTime() + " - " + info.getEndTime());
        System.out.println("Sân: " + info.getFieldName());
        System.out.println("Loại sân: " + info.getFieldTypeName());
        System.out.println("Giá: " + info.getSlotFieldPrice() + " VND");
        System.out.println("Trạng thái: " + info.getSlotStatus());
        System.out.println("Người đặt: " + info.getCustomerName());
        System.out.println("SĐT: " + info.getPhone());
        System.out.println("Email: " + info.getEmail());
        System.out.println("Ghi chú: " + (info.getNote() != null ? info.getNote() : "Không có"));
    }
}
