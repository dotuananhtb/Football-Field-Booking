/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author Đỗ Tuấn Anh
 */
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class CodeUtil {

    // Tạo mã Booking Code dạng: ddMMyyABCDE
    public static String generateBookingCode() {
        String dateStr = new SimpleDateFormat("ddMMyy").format(new Date());
        String randomStr = randomAlphaNumeric(5); // A-Z0-9
        return dateStr + randomStr;
    }

    // Sinh mã BookingDetails Code dựa trên bookingCode và chỉ số thứ tự
    public static String generateBookingDetailsCode(String bookingCode, int index) {
        return bookingCode + "_" + String.format("%02d", index);
    }

    // Random chuỗi 5 ký tự
    private static String randomAlphaNumeric(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        Random rand = new Random();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(rand.nextInt(chars.length())));
        }
        return sb.toString();
    }

    // Sinh mã BookingCode không trùng (cần truyền BookingDAO)
    public static String generateUniqueBookingCode(dao.BookingDAO bookingDAO) {
        String code;
        int attempts = 0;
        do {
            code = generateBookingCode();
            attempts++;
            if (attempts > 10) {
                throw new RuntimeException("Không thể tạo mã booking code duy nhất sau nhiều lần thử.");
            }
        } while (bookingDAO.isBookingCodeExists(code));
        return code;
    }
}
