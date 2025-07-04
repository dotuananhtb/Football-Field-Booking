package mailverify;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.Properties;

public class SendMail {

    public static final String HOST_NAME = "smtp.gmail.com";
    public static final int TSL_PORT = 587;
    public static final String APP_EMAIL = "he180507dotuananh@gmail.com";
    public static final String APP_PASSWORD = "vqhb mvgk lsrk xoyu";

    // ✅ Tạo Properties chung
    private Properties getMailProperties() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST_NAME);
        props.put("mail.smtp.port", TSL_PORT);
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.ssl.trust", HOST_NAME);
        props.put("mail.debug", "true");
        return props;
    }

    // ✅ Tạo Session chung
    private Session getMailSession() {
        return Session.getInstance(getMailProperties(), new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(APP_EMAIL, APP_PASSWORD);
            }
        });
    }

    // ✅ Gửi mail dùng chung
    private boolean sendHtmlEmail(String toEmail, String subject, String htmlContent, String displaySenderName) {
        try {
            MimeMessage message = new MimeMessage(getMailSession());
            message.setFrom(new InternetAddress(APP_EMAIL, displaySenderName, "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("✅ Đã gửi email tới: " + toEmail);
            return true;
        } catch (MessagingException | UnsupportedEncodingException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Gửi xác minh đơn giản
    public boolean guiMail(String email, String noidung, String nameUser) {
        String subject = "Xác thực đăng kí tài khoản";
        String content = "Xin chào " + nameUser + ",<br><br>"
                + "Cảm ơn bạn đã đăng ký tài khoản.<br>"
                + "Vui lòng xác minh email bằng cách nhấn vào liên kết sau:<br>"
                + "<a href='" + noidung + "'>Xác minh tài khoản</a><br><br>"
                + "Trân trọng.";
        return sendHtmlEmail(email, subject, content, "Sân Bóng Việt Nam");
    }

    // ✅ Gửi reset password
    public boolean guiResetPasswordMail(String email, String noidung, String nameUser) {
        String subject = "Xác thực tài khoản";
        String content = "Xin chào " + nameUser + ",<br><br>"
                + "Bạn đã yêu cầu đặt lại mật khẩu.<br>"
                + "Vui lòng nhấn vào liên kết để đặt lại mật khẩu:<br>"
                + "<a href='" + noidung + "'>Đặt lại mật khẩu</a><br><br>"
                + "Trân trọng.";
        return sendHtmlEmail(email, subject, content, "Football Star");
    }

    // ✅ Gửi xác minh đẹp
    public boolean guiMailFULLHD(String email, String linkXacThuc, String nameUser) {
        String subject = "Xác thực tài khoản - Football Star";
        String content = "<!DOCTYPE html><html><head><meta charset='UTF-8'>"
                + "<style>body{font-family:Arial,sans-serif;background:#f0f2f5;} .container{max-width:600px;margin:40px auto;background:#fff;border-radius:10px;padding:20px;}"
                + ".header{background:#4CAF50;color:#fff;padding:20px;text-align:center;font-size:24px;}"
                + ".btn{display:inline-block;margin-top:20px;padding:10px 20px;background:#4CAF50;color:white;text-decoration:none;border-radius:5px;}"
                + ".footer{padding:15px;font-size:14px;color:#999;text-align:center;}</style>"
                + "</head><body><div class='container'>"
                + "<div class='header'>Xác minh tài khoản</div>"
                + "<p>Xin chào <strong>" + nameUser + "</strong>,</p>"
                + "<p>Cảm ơn bạn đã đăng ký tài khoản tại <strong>Football Star</strong>.</p>"
                + "<p>Vui lòng nhấn vào nút bên dưới để xác minh địa chỉ email:</p>"
                + "<a class='btn' href='" + linkXacThuc + "'>Xác minh tài khoản</a>"
                + "<p>Nếu bạn không đăng ký tài khoản, vui lòng bỏ qua email này.</p>"
                + "<div class='footer'>Trân trọng,<br>Đội ngũ Football Star</div></div></body></html>";
        return sendHtmlEmail(email, subject, content, "Football Star");
    }

    // ✅ Gửi thông báo đặt sân
    public boolean guiMailDatSanThanhCong(String email, String nameUser, String maDon, BigDecimal tongTien) {
        String subject = "Xác nhận đặt sân thành công - Football Star";
        String content = "<!DOCTYPE html><html><head><meta charset='UTF-8'>"
                + "<style>body{font-family:Arial;background:#f4f4f4;} .container{max-width:600px;margin:40px auto;background:#fff;border-radius:10px;padding:20px;}"
                + ".header{background:#28a745;color:#fff;padding:20px;text-align:center;font-size:24px;}"
                + ".footer{padding:20px;font-size:14px;color:#999;text-align:center;}</style>"
                + "</head><body><div class='container'>"
                + "<div class='header'>Đặt sân thành công!</div>"
                + "<p>Xin chào <strong>" + nameUser + "</strong>,</p>"
                + "<p>Chúng tôi xác nhận rằng bạn đã đặt sân thành công tại <strong>Football Star</strong>.</p>"
                + "<p><strong>Mã đơn đặt:</strong> " + maDon + "</p>"
                + "<p><strong>Tổng tiền:</strong> " + tongTien.toPlainString() + " VND</p>"
                + "<p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi.</p>"
                + "<p>Hẹn gặp bạn tại sân!</p>"
                + "<div class='footer'>Trân trọng,<br>Đội ngũ Football Star</div></div></body></html>";
        return sendHtmlEmail(email, subject, content, "Football Star");
    }

    public boolean guiMailDangKyGoogle(String email, String fullName, String username, String password) {
        String subject = "Tài khoản đã được tạo thành công - Football Star";

        String content = "<!DOCTYPE html><html><head><meta charset='UTF-8'>"
                + "<style>"
                + "body { font-family: Arial, sans-serif; background-color: #f0f2f5; margin: 0; padding: 0; }"
                + ".container { max-width: 600px; margin: 40px auto; background: #ffffff; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); overflow: hidden; }"
                + ".header { background-color: #007bff; color: white; padding: 20px; text-align: center; font-size: 24px; }"
                + ".content { padding: 30px; text-align: left; line-height: 1.6; }"
                + ".footer { padding: 15px; font-size: 14px; color: #999999; text-align: center; }"
                + "</style></head><body>"
                + "<div class='container'>"
                + "<div class='header'>Tài khoản Google đã được tạo</div>"
                + "<div class='content'>"
                + "<p>Xin chào <strong>" + fullName + "</strong>,</p>"
                + "<p>Bạn đã đăng ký tài khoản qua Google tại <strong>Football Star</strong>.</p>"
                + "<p>Dưới đây là thông tin đăng nhập của bạn:</p>"
                + "<ul>"
                + "<li><strong>Tên đăng nhập:</strong> " + username + "</li>"
                + "<li><strong>Mật khẩu:</strong> " + password + "</li>"
                + "</ul>"
                + "<p>Bạn có thể thay đổi mật khẩu sau khi đăng nhập.</p>"
                + "<p>Chúc bạn có trải nghiệm tuyệt vời cùng Football Star!</p>"
                + "</div>"
                + "<div class='footer'>Trân trọng,<br>Đội ngũ Football Star</div>"
                + "</div></body></html>";

        return sendHtmlEmail(email, subject, content, "Football Star");
    }

    // ✅ Test nhanh
    public static void main(String[] args) {
        SendMail sendMail = new SendMail();
        String emailNguoiNhan = "huubinh0601@gmail.com";
        String tenNguoiDung = "Nguyễn Văn A";
        String linkXacThuc = "http://localhost:8080/XacThucTaiKhoan?token=abc123xyz";

        boolean result = sendMail.guiMailDatSanThanhCong(emailNguoiNhan, tenNguoiDung, "453435", BigDecimal.ONE);
        if (result) {
            System.out.println("✅ Gửi email thành công.");
        } else {
            System.out.println("❌ Gửi email thất bại.");
        }
    }
}
