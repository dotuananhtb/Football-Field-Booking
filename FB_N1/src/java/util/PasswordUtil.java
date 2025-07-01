/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Đỗ Tuấn Anh
 */
package util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Mã hoá mật khẩu (khi đăng ký)
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    // Kiểm tra mật khẩu (khi đăng nhập)
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }//plainpw la mk get tu nguoi dung nhap vao nhe ae, con hashedpw la mk lay ra tu db nhe ae(da ma hoa)

    public static void main(String[] args) {
        String raw = "Tx)Ezn1>,iXL";
        String hashed = "$2a$10$MIGdePsLq.kyHExrBm9jVefFzrF2aLNolSagOnoAIiUKgzs1i7hPS"; // dán từ DB 

        boolean match = BCrypt.checkpw(raw, hashed);
        System.out.println("Matched: " + match);
    }

}
