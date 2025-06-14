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
import dao.SaleDAO;
import dao.SlotsOfFieldDAO;
import java.math.BigDecimal;
import model.Booking;
import model.BookingDetails;
import java.sql.*;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import mailverify.SendMail;
import model.Account;
import util.DBContext;

public class BookingService extends DBContext {

    private BookingDAO bookingDAO = new BookingDAO();
    private BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();

//     1. Tạo đơn đặt sân
    public boolean createBooking(Account account, List<BookingDetails> detailsList) {
        Connection conn = null;

        try {
            // 1. Tạo connection dùng chung
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // 2. Tạo các DAO như bình thường
            BookingDAO bookingDAO = new BookingDAO();
            BookingDetailsDAO bookingDetailsDAO = new BookingDetailsDAO();
            SaleDAO saleDAO = new SaleDAO();

            // 3. Gán connection chung vào các DAO
            bookingDAO.setConnection(conn);
            bookingDetailsDAO.setConnection(conn);
            saleDAO.setConnection(conn);

            // 4. Thực hiện logic 
            int slotCount = detailsList.size();
            Integer saleId = saleDAO.getSaleIdBySlotCount(slotCount);
            BigDecimal totalAmount = bookingDAO.calculateTotalBooking(detailsList);

            Booking booking = new Booking();
            booking.setAccountId(account.getAccountId());
            booking.setEmail(account.getEmail());
            booking.setSaleId(saleId);
            booking.setTotalAmount(totalAmount);

            int bookingId = bookingDAO.insertBooking(booking);
            if (bookingId == -1) {
                conn.rollback();
                return false;
            }

            for (BookingDetails detail : detailsList) {
                detail.setBookingId(bookingId);
                detail.setStatusCheckingId(1);
                if (!bookingDetailsDAO.insertBookingDetail(detail)) {
                    conn.rollback();
                    return false;
                }
            }

            conn.commit();
            
            String finalBookingId = Integer.toString(bookingId);
            new Thread(() -> {
                try {
                    // Ví dụ: gửi mail xác nhận đặt sân
                    SendMail sender = new SendMail();
                    sender.guiMailDatSanThanhCong(account.getEmail(), account.getUserProfile().getLastName()+" "+ account.getUserProfile().getFirstName(), finalBookingId,totalAmount);
                } catch (Exception ex) {
                    ex.printStackTrace(); // không ảnh hưởng logic chính
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
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

// 2. Hủy đơn (chuyển trạng thái từng detail về Canceled)
    public boolean cancelBooking(int bookingId) {
        List<BookingDetails> details = bookingDetailsDAO.getDetailsByBookingId(bookingId);
        boolean allUpdated = true;
        for (BookingDetails detail : details) {
            boolean success = bookingDetailsDAO.updateStatus(detail.getBookingDetailsId(), 3); // 3 = Canceled
            if (!success) {
                allUpdated = false;
            }
        }
        return allUpdated;
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

    //////////
    public static void main(String[] args) {
        System.out.println("=== Bắt đầu chương trình ===");

        // Khởi tạo Service và DAO
        System.out.println("Khởi tạo service và DAO...");
        BookingService bookingService = new BookingService();
        SlotsOfFieldDAO slotsOfFieldDAO = new SlotsOfFieldDAO();
        AccountDAO accountDAO = new AccountDAO();

        // Lấy tài khoản mẫu
        System.out.println("Lấy tài khoản...");
        Account account = accountDAO.getAccountById(3);
        System.out.println("Tài khoản: " + account.getEmail());

        // Tạo danh sách BookingDetails
        System.out.println("Tạo danh sách BookingDetails...");
        List<BookingDetails> detailsList = new ArrayList<>();

        // Booking detail 1
        System.out.println("Tạo detail 1...");
        BookingDetails detail1 = new BookingDetails();
        detail1.setSlotFieldId(101);
        BigDecimal price1 = slotsOfFieldDAO.getPriceBySlotFieldId(101);
        System.out.println("→ Giá slot 101: " + price1);
        detail1.setSlotFieldPrice(price1);
        detail1.setExtraMinutes(0);
        detail1.setExtraFee(BigDecimal.ZERO);
        detail1.setSlotDate("2025-06-20");
        detail1.setNote("Trận sáng");

        // Booking detail 2
        System.out.println("Tạo detail 2...");
        BookingDetails detail2 = new BookingDetails();
        detail2.setSlotFieldId(102);
        BigDecimal price2 = slotsOfFieldDAO.getPriceBySlotFieldId(102);
        System.out.println("→ Giá slot 102: " + price2);
        detail2.setSlotFieldPrice(price2);
        detail2.setExtraMinutes(15);
        detail2.setExtraFee(new BigDecimal("50000"));
        detail2.setSlotDate("2025-06-20");
        detail2.setNote("Trận chiều");

        // Thêm vào list
        detailsList.add(detail1);
        detailsList.add(detail2);

        System.out.println("Đã tạo xong " + detailsList.size() + " booking detail.");
        System.out.println("Gọi hàm createBooking...");

        // Gọi hàm đặt sân
        boolean result = bookingService.createBooking(account, detailsList);

        System.out.println("=== Kết quả ===");
        if (result) {
            System.out.println("✅ Đặt sân thành công!");
        } else {
            System.out.println("❌ Đặt sân thất bại!");
        }

        System.out.println("=== Kết thúc chương trình ===");
    }

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