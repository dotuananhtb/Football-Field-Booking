/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package mailverify;

/**
 *
 * @author Đỗ Tuấn Anh
 */
import java.util.Properties;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;

public class SendMail {

    public static final String HOST_NAME = "smtp.gmail.com";
    public static final int TSL_PORT = 587;
    public static final String APP_EMAIL = "he180507dotuananh@gmail.com";
    public static final String APP_PASSWORD = "vqhb mvgk lsrk xoyu";  // Đổi thành mật khẩu ứng dụng

    // Gửi email cơ bản
    public boolean guiMail(String email, String noidung, String nameUser) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST_NAME);
        props.put("mail.smtp.port", TSL_PORT);
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", HOST_NAME);
        props.put("mail.debug", "true");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(APP_EMAIL, APP_PASSWORD);
            }
        });
        try {

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(APP_EMAIL, "Trùm Shop", "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Xác nhận đơn hàng", "UTF-8");

            String body = "Xin chào " + nameUser + ",<br><br>"
                    + "Cảm ơn bạn đã đăng ký tài khoản.<br>"
                    + "Vui lòng xác minh email bằng cách nhấn vào liên kết sau:<br>"
                    + "<a href='" + noidung + "'>Xác minh tài khoản</a><br><br>"
                    + "Trân trọng.";

            message.setContent(body, "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("✅ Email đã được gửi thành công!");
            return true;
        } catch (MessagingException | UnsupportedEncodingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
