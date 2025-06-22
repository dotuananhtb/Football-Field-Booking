/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

/**
 *
 * @author Đỗ Tuấn Anh
 */
import dao.AccountDAO;
import dao.BookingDAO;
import dao.BookingDetailsDAO;
import dao.OfflineCustomerDAO;
import dao.OfflineUserDAO;
import dao.SaleDAO;
import dao.SlotsOfFieldDAO;
import java.math.BigDecimal;
import model.Booking;
import model.BookingDetails;
import java.sql.*;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import mailverify.SendMail;
import model.Account;
import model.OfflineCustomer;
import model.OfflineUser;
import util.CodeUtil;
import util.DBContext;
import websocket.AppWebSocket;

public class BookingService extends DBContext {

    private BookingDAO bookingDAO = new BookingDAO();
    private BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();
    private SlotsOfFieldDAO slotsOfFieldDAO = new SlotsOfFieldDAO();

//     1. Tạo đơn đặt sân
    public boolean createBooking(Account account, List<BookingDetails> detailsList) {
        Connection conn = null;
        try {
            // 1. Tạo connection dùng chung
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // 2. Tạo các DAO
            BookingDAO bookingDAO = new BookingDAO();
            BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();
            SaleDAO saleDAO = new SaleDAO();

            // 3. Gán connection
            bookingDAO.setConnection(conn);
            bookingDetailsDAO.setConnection(conn);
            saleDAO.setConnection(conn);

            // 4. Tính toán booking
            int slotCount = detailsList.size();
            Integer saleId = saleDAO.getSaleIdBySlotCount(slotCount);
            BigDecimal totalAmount = bookingDAO.calculateTotalBooking(detailsList);

            // 5. Sinh mã booking_code (ddMMyyXXXXX)
            String bookingCode;
            do {
                bookingCode = CodeUtil.generateBookingCode(); // cần viết hàm này
            } while (bookingDAO.isBookingCodeExists(bookingCode));

            // 6. Tạo booking object
            Booking booking = new Booking();
            booking.setAccountId(account.getAccountId());
            booking.setEmail(account.getEmail());
            booking.setSaleId(saleId);
            booking.setTotalAmount(totalAmount);
            booking.setBookingCode(bookingCode); // gán code

            // 7. Ghi Booking
            int bookingId = bookingDAO.insertBooking(booking);
            if (bookingId == -1) {
                conn.rollback();
                return false;
            }

            // 8. Ghi từng bookingDetails
            int detailIndex = 1;
            for (BookingDetails detail : detailsList) {
                Map<String, String> timeMap = slotsOfFieldDAO.getStartEndTimeBySlotFieldId(detail.getSlotFieldId());
                if (timeMap != null) {
                    detail.setStartTime(timeMap.get("start_time"));
                    detail.setEndTime(timeMap.get("end_time"));
                }
                detail.setBookingId(bookingId);
                detail.setStatusCheckingId(1);

                // Gán mã booking_details_code dạng {bookingCode}_01
                String suffix = String.format("_%02d", detailIndex++);
                detail.setBookingDetailsCode(bookingCode + suffix);

                if (!bookingDetailsDAO.insertBookingDetail(detail)) {
                    conn.rollback();
                    return false;
                }
            }

            // 9. Commit
            conn.commit();

            // 10. Gửi socket cập nhật lịch
            Set<String> affectedFieldIds = new HashSet<>();
            for (BookingDetails detail : detailsList) {
                String fieldId = slotsOfFieldDAO.getFieldIdBySlotFieldId(detail.getSlotFieldId());
                if (fieldId != null) {
                    affectedFieldIds.add(fieldId);
                }
            }
            AppWebSocket.broadcastCalendarUpdates(affectedFieldIds);
            AppWebSocket.broadcastToRole("1", "newBooking", "Khách hàng " + account.getUsername() + " vừa đặt sân.");

            // 11. Gửi mail (nếu cần)
            String finalBookingId = Integer.toString(bookingId);
            new Thread(() -> {
                try {
                    SendMail sender = new SendMail();
                    sender.guiMailDatSanThanhCong(
                            account.getEmail(),
                            account.getUserProfile().getLastName() + " " + account.getUserProfile().getFirstName(),
                            finalBookingId,
                            totalAmount
                    );
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }).start();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
//
    ///

    public boolean createOfflineBooking(OfflineUser offlineUser, int createdByAccountId, List<BookingDetails> detailsList) {
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // DAO khởi tạo
            BookingDAO bookingDAO = new BookingDAO();
            BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();
            OfflineCustomerDAO offlineCustomerDAO = new OfflineCustomerDAO();
            SlotsOfFieldDAO slotsOfFieldDAO = new SlotsOfFieldDAO();
            SaleDAO saleDAO = new SaleDAO();

            // Gán connection
            bookingDAO.setConnection(conn);
            bookingDetailsDAO.setConnection(conn);
            offlineCustomerDAO.setConnection(conn);
            slotsOfFieldDAO.setConnection(conn);
            saleDAO.setConnection(conn);

            // 1. Tính sale và tổng tiền
            int slotCount = detailsList.size();
            Integer saleId = saleDAO.getSaleIdBySlotCount(slotCount);
            BigDecimal totalAmount = bookingDAO.calculateTotalBooking(detailsList);

            // 2. Sinh booking_code duy nhất
            String bookingCode;
            do {
                bookingCode = CodeUtil.generateBookingCode(); // Viết trong CodeUtil
            } while (bookingDAO.isBookingCodeExists(bookingCode));

            // 3. Tạo Booking (người tạo là nhân viên)
            Booking booking = new Booking();
            booking.setAccountId(createdByAccountId);
            booking.setEmail(null);
            booking.setSaleId(saleId);
            booking.setTotalAmount(totalAmount);
            booking.setBookingCode(bookingCode); // Gán code mới

            int bookingId = bookingDAO.insertBooking(booking);
            if (bookingId == -1) {
                conn.rollback();
                return false;
            }

            // 4. Gán bookingId cho khách offline
            OfflineCustomer offlineCustomer = new OfflineCustomer();
            offlineCustomer.setBookingId(bookingId);
            offlineCustomer.setOfflineUserId(offlineUser.getOfflineUserId());
            if (!offlineCustomerDAO.insertOfflineCustomer(offlineCustomer)) {
                conn.rollback();
                return false;
            }

            // 5. Ghi từng BookingDetails
            int detailIndex = 1;
            for (BookingDetails detail : detailsList) {
                Map<String, String> timeMap = slotsOfFieldDAO.getStartEndTimeBySlotFieldId(detail.getSlotFieldId());
                if (timeMap != null) {
                    detail.setStartTime(timeMap.get("start_time"));
                    detail.setEndTime(timeMap.get("end_time"));
                }

                detail.setBookingId(bookingId);
                detail.setStatusCheckingId(1); // đã xác nhận
                String detailCode = bookingCode + String.format("_%02d", detailIndex++);
                detail.setBookingDetailsCode(detailCode); // Gán mã chi tiết

                if (!bookingDetailsDAO.insertBookingDetail(detail)) {
                    conn.rollback();
                    return false;
                }
            }

            // 6. Commit transaction
            conn.commit();

            // 7. Gửi socket cập nhật lịch sân
            Set<String> affectedFieldIds = new HashSet<>();
            for (BookingDetails detail : detailsList) {
                String fieldId = slotsOfFieldDAO.getFieldIdBySlotFieldId(detail.getSlotFieldId());
                if (fieldId != null) {
                    affectedFieldIds.add(fieldId);
                }
            }
            AppWebSocket.broadcastCalendarUpdates(affectedFieldIds);

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

// 2. Hủy đơn (chuyển trạng thái từng detail về Canceled)
    public boolean cancelBooking(int bookingDetailsId) {

        boolean updated = false;

        updated = bookingDetailsDAO.updateStatus(bookingDetailsId, 3); // 3 = Canceled

        return updated;
    }

    // 3. Lấy danh sách chi tiết đặt sân theo bookingId
    public List<BookingDetails> getBookingDetails(int bookingId) {
        return bookingDetailsDAO.getDetailsByBookingId(bookingId);
    }

    // 4. Lấy danh sách lịch sử đặt sân theo userId
    public List<Booking> getBookingsByUser(int userId) {
        return bookingDAO.getBookingsByAccountId(userId);
    }

    // 5. Kiểm tra xung đột đặt sân
    public boolean isSlotAvailable(int slotFieldId, String slotDate) {
        BookingDetails detail = bookingDetailsDAO.getBySlotFieldAndDate(slotFieldId, slotDate);
        return detail == null || detail.getStatusCheckingId() == 3; // chưa đặt hoặc đã hủy thì ok
    }

    // 6. Cập nhật trạng thái (tùy loại: pending, checked, cancel...)
    public boolean updateStatus(int bookingDetailId, int newStatus) {
        return bookingDetailsDAO.updateStatus(bookingDetailId, newStatus);
    }
    //7.Check thời gian thực dk trước 30p mới dc huỷ

    public boolean isCancelable(int bookingDetailsId) {
        String sql = "SELECT bd.slot_date, sd.start_time "
                + "FROM BookingDetails bd "
                + "JOIN SlotsOfField sof ON bd.slot_field_id = sof.slot_field_id "
                + "JOIN SlotsOfDay sd ON sof.slot_id = sd.slot_id "
                + "WHERE bd.booking_details_id = ?";

        try (Connection con = DBContext.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, bookingDetailsId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    LocalDate slotDate = LocalDate.parse(rs.getString("slot_date"));
                    LocalTime startTime = LocalTime.parse(rs.getString("start_time"));
                    LocalDateTime startDateTime = LocalDateTime.of(slotDate, startTime);
                    LocalDateTime now = LocalDateTime.now();

                    long minutesUntilStart = Duration.between(now, startDateTime).toMinutes();
                    return minutesUntilStart >= 30;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Không tìm thấy hoặc lỗi → không cho hủy
    }

    

    //////////
//    public static void main(String[] args) {
//        System.out.println("=== Bắt đầu chương trình ===");
//
//        // Khởi tạo Service và DAO
//        System.out.println("Khởi tạo service và DAO...");
//        BookingService bookingService = new BookingService();
//        SlotsOfFieldDAO slotsOfFieldDAO = new SlotsOfFieldDAO();
//        AccountDAO accountDAO = new AccountDAO();
//
//        // Lấy tài khoản mẫu
//        System.out.println("Lấy tài khoản...");
//        Account account = accountDAO.getAccountById(3);
//        System.out.println("Tài khoản: " + account.getEmail());
//
//        // Tạo danh sách BookingDetails
//        System.out.println("Tạo danh sách BookingDetails...");
//        List<BookingDetails> detailsList = new ArrayList<>();
//
//        // Booking detail 1
//        System.out.println("Tạo detail 1...");
//        BookingDetails detail1 = new BookingDetails();
//        detail1.setSlotFieldId(101);
//        BigDecimal price1 = slotsOfFieldDAO.getPriceBySlotFieldId(101);
//        System.out.println("→ Giá slot 101: " + price1);
//        detail1.setSlotFieldPrice(price1);
//        detail1.setExtraMinutes(0);
//        detail1.setExtraFee(BigDecimal.ZERO);
//        detail1.setSlotDate("2025-06-20");
//        detail1.setNote("Trận sáng");
//
//        // Booking detail 2
//        System.out.println("Tạo detail 2...");
//        BookingDetails detail2 = new BookingDetails();
//        detail2.setSlotFieldId(102);
//        BigDecimal price2 = slotsOfFieldDAO.getPriceBySlotFieldId(102);
//        System.out.println("→ Giá slot 102: " + price2);
//        detail2.setSlotFieldPrice(price2);
//        detail2.setExtraMinutes(15);
//        detail2.setExtraFee(new BigDecimal("50000"));
//        detail2.setSlotDate("2025-06-20");
//        detail2.setNote("Trận chiều");
//
//        // Thêm vào list
//        detailsList.add(detail1);
//        detailsList.add(detail2);
//
//        System.out.println("Đã tạo xong " + detailsList.size() + " booking detail.");
//        System.out.println("Gọi hàm createBooking...");
//
//        // Gọi hàm đặt sân
//        boolean result = bookingService.createBooking(account, detailsList);
//
//        System.out.println("=== Kết quả ===");
//        if (result) {
//            System.out.println("✅ Đặt sân thành công!");
//        } else {
//            System.out.println("❌ Đặt sân thất bại!");
//        }
//
//        System.out.println("=== Kết thúc chương trình ===");
//    }
}

////----------////
//    public boolean createBooking(Account account, List<BookingDetails> detailsList) {
//        String insertBookingSQL = "INSERT INTO Booking (account_id, sale_id, booking_date, total_amount, email) VALUES (?, ?, ?, ?, ?)";
//        String insertDetailSQL = "INSERT INTO BookingDetails (booking_id, slot_field_id, slot_field_price, extra_minutes, extra_fee, slot_date, note, status_checking_id) "
//                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
//
//        PreparedStatement psBooking = null;
//        PreparedStatement psDetail = null;
//        ResultSet rs = null;
//
//        try {
//            connection.setAutoCommit(false);
//
//            // B1: Tính toán
//            int slotCount = detailsList.size();
//            Integer saleId = new SaleDAO().getSaleIdBySlotCount(slotCount);
//            BigDecimal totalAmount = bookingDAO.calculateTotalBooking(detailsList);
//
//            // B2: Insert Booking
//            psBooking = connection.prepareStatement(insertBookingSQL, Statement.RETURN_GENERATED_KEYS);
//            psBooking.setInt(1, account.getAccountId());
//            if (saleId != null) {
//                psBooking.setInt(2, saleId);
//            } else {
//                psBooking.setNull(2, Types.INTEGER);
//            }
//            psBooking.setString(3, LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
//            psBooking.setBigDecimal(4, totalAmount);
//            psBooking.setString(5, account.getEmail());
//
//            int affected = psBooking.executeUpdate();
//            if (affected == 0) {
//                connection.rollback();
//                return false;
//            }
//
//            rs = psBooking.getGeneratedKeys();
//            int bookingId = -1;
//            if (rs.next()) {
//                bookingId = rs.getInt(1);
//            } else {
//                connection.rollback();
//                return false;
//            }
//
//            // B3: Insert từng BookingDetail
//            psDetail = connection.prepareStatement(insertDetailSQL);
//            for (BookingDetails d : detailsList) {
//                psDetail.setInt(1, bookingId);
//                psDetail.setInt(2, d.getSlotFieldId());
//                psDetail.setBigDecimal(3, d.getSlotFieldPrice());
//                psDetail.setInt(4, d.getExtraMinutes());
//                psDetail.setBigDecimal(5, d.getExtraFee());
//                psDetail.setString(6, d.getSlotDate());
//                psDetail.setString(7, d.getNote());
//                psDetail.setInt(8, 1); // status_checking_id = 1
//
//                psDetail.addBatch();
//            }
//            psDetail.executeBatch();
//
//            // B4: Commit transaction
//            connection.commit();
//
////            // B5: Gửi email hoặc log phụ trong Thread mới
//            String finalBookingId = Integer.toString(bookingId);
//            new Thread(() -> {
//                try {
//                    // Ví dụ: gửi mail xác nhận đặt sân
//                    SendMail sender = new SendMail();
//                    sender.guiMailDatSanThanhCong(account.getEmail(), account.getUserProfile().getLastName() + account.getUserProfile().getFirstName(), finalBookingId,totalAmount);
//                } catch (Exception ex) {
//                    ex.printStackTrace(); // không ảnh hưởng logic chính
//                }
//            }).start();
//            return true;
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            try {
//                connection.rollback();
//            } catch (SQLException ex) {
//                ex.printStackTrace();
//            }
//            return false;
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//                if (psBooking != null) {
//                    psBooking.close();
//                }
//                if (psDetail != null) {
//                    psDetail.close();
//                }
//                connection.setAutoCommit(true);
//            } catch (SQLException e) {
//                e.printStackTrace();
//            }
//        }
//    }
//--------------------//
