/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package mailverify;

/**
 *
 * @author Admin
 */
import java.util.Properties;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import jakarta.mail.internet.MimeUtility;
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
            message.setFrom(new InternetAddress(APP_EMAIL, "Sân Bóng Việt Nam", "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Xác thực đăng kí tài khoản", "UTF-8");

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

    public boolean guiResetPasswordMail(String email, String noidung, String nameUser) {
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
            message.setFrom(new InternetAddress(APP_EMAIL, "Football Star", "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Xác thực tài khoản", "UTF-8");

            String body = "Xin chào " + nameUser + ",<br><br>"
                    + "Yeu cau quen mat khau.<br>"
                    + "Vui long vao bam vao duong lien ket de dat lai mat khau:<br>"
                    + "<a href='" + noidung + "'>Xac minh tai khoan</a><br><br>"
                    + "Tran trong.";

            message.setContent(body, "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("✅ Email đã được gửi thành công!");
            return true;
        } catch (MessagingException | UnsupportedEncodingException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean guiMailFULLHD(String email, String linkXacThuc, String nameUser) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.host", HOST_NAME);
        props.put("mail.smtp.starttls.enable", "true");
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
            message.setFrom(new InternetAddress(APP_EMAIL, "Football Star", "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject(MimeUtility.encodeText("Xac thuc tai khoan - Football Star", "UTF-8", "B"));

            String emailContent = "<!DOCTYPE html>"
                    + "<html><head>"
                    + "<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>"
                    + "<style>"
                    + "body { font-family: Arial, sans-serif; background-color: #f0f2f5; margin: 0; padding: 0; }"
                    + ".container { max-width: 600px; margin: 40px auto; background: #ffffff; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); overflow: hidden; }"
                    + ".header { background-color: #4CAF50; color: white; padding: 20px; text-align: center; font-size: 24px; }"
                    + ".content { padding: 30px; text-align: center; }"
                    + ".btn { display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 5px; }"
                    + ".footer { padding: 15px; font-size: 14px; color: #999999; text-align: center; }"
                    + "</style>"
                    + "</head><body>"
                    + "<div class='container'>"
                    + "<div class='header'>Xac minh tai khoan</div>"
                    + "<div class='content'>"
                    + "<p>Xin chao <strong>" + nameUser + "</strong>,</p>"
                    + "<p>Cam on ban da dang ky tai khoan tai <strong>Football Star</strong>.</p>"
                    + "<p>Vui long nhan vao nut ben duoi de xac minh dia chi email cua ban:</p>"
                    + "<a class='btn' href='" + linkXacThuc + "'>Xac minh tai khoan</a>"
                    + "<p>Neu ban khong dang ky tai khoan, vui long bo qua email nay.</p>"
                    + "</div>"
                    + "<div class='footer'>Tran trong,<br> Doi ngu Football Star</div>"
                    + "</div>"
                    + "</body></html>";

            message.setContent(emailContent, "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("✅ Email xac minh da duoc gui thanh cong!");
            return true;
        } catch (MessagingException | UnsupportedEncodingException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        SendMail sendMail = new SendMail();

        String emailNguoiNhan = "xekeh64169@ofular.com"; // 👉 Địa chỉ email cần test
        String tenNguoiDung = "Nguyễn Văn A";         // 👉 Tên người nhận
        String linkXacThuc = "http://localhost:8080/XacThucTaiKhoan?token=abc123xyz"; // 👉 Link xác minh (có thể sinh động bằng UUID/token thật)

        boolean result = sendMail.guiMailFULLHD(emailNguoiNhan, linkXacThuc, tenNguoiDung);

        if (result) {
            System.out.println("✅ Gửi email xác minh thành công.");
        } else {
            System.out.println("❌ Gửi email xác minh thất bại.");
        }
    }

}
