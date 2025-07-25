package mailverify;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.Properties;
import config.SecretsConfig;

public class SendMail {

    public static final String HOST_NAME = SecretsConfig.get("SMTP_HOST");
    public static final int TSL_PORT = Integer.parseInt(SecretsConfig.get("SMTP_PORT"));
    public static final String APP_EMAIL = SecretsConfig.get("SMTP_USER");
    public static final String APP_PASSWORD = SecretsConfig.get("SMTP_PASSWORD");

    // Tao Properties chung
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

    // Tao Session chung
    private Session getMailSession() {
        return Session.getInstance(getMailProperties(), new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(APP_EMAIL, APP_PASSWORD);
            }
        });
    }

    // Gui mail dung chung
    private boolean sendHtmlEmail(String toEmail, String subject, String htmlContent, String displaySenderName) {
        try {
            MimeMessage message = new MimeMessage(getMailSession());
            message.setFrom(new InternetAddress(APP_EMAIL, displaySenderName, "UTF-8"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            System.out.println("Da gui email toi: " + toEmail);
            return true;
        } catch (MessagingException | UnsupportedEncodingException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Gui xac minh don gian
    public boolean guiMail(String email, String noidung, String nameUser) {
        String subject = "Xac thuc dang ki tai khoan";
        String content = "Xin chao " + nameUser + ",<br><br>"
                + "Cam on ban da dang ky tai khoan.<br>"
                + "Vui long xac minh email bang cach nhan vao lien ket sau:<br>"
                + "<a href='" + noidung + "'>Xac minh tai khoan</a><br><br>"
                + "Tran trong.";
        return sendHtmlEmail(email, subject, content, "San Bong Viet Nam");
    }

    // Gui reset password
    public boolean guiResetPasswordMail(String email, String noidung, String nameUser) {
        String subject = "Xac thuc tai khoan";
        String content = "Xin chao " + nameUser + ",<br><br>"
                + "Ban da yeu cau dat lai mat khau.<br>"
                + "Vui long nhan vao lien ket de dat lai mat khau:<br>"
                + "<a href='" + noidung + "'>Dat lai mat khau</a><br><br>"
                + "Tran trong.";
        return sendHtmlEmail(email, subject, content, "Football Star");
    }

    // Gui xac minh dep
    public boolean guiMailFULLHD(String email, String linkXacThuc, String nameUser) {
        String subject = "Xac thuc tai khoan - Football Star";
        String content = "<!DOCTYPE html><html><head><meta charset='UTF-8'>"
                + "<style>body{font-family:Arial,sans-serif;background:#f0f2f5;} .container{max-width:600px;margin:40px auto;background:#fff;border-radius:10px;padding:20px;}"
                + ".header{background:#4CAF50;color:#fff;padding:20px;text-align:center;font-size:24px;}"
                + ".btn{display:inline-block;margin-top:20px;padding:10px 20px;background:#4CAF50;color:white;text-decoration:none;border-radius:5px;}"
                + ".footer{padding:15px;font-size:14px;color:#999;text-align:center;}</style>"
                + "</head><body><div class='container'>"
                + "<div class='header'>Xac minh tai khoan</div>"
                + "<p>Xin chao <strong>" + nameUser + "</strong>,</p>"
                + "<p>Cam on ban da dang ky tai khoan tai <strong>Football Star</strong>.</p>"
                + "<p>Vui long nhan vao nut ben duoi de xac minh dia chi email:</p>"
                + "<a class='btn' href='" + linkXacThuc + "'>Xac minh tai khoan</a>"
                + "<p>Neu ban khong dang ky tai khoan, vui long bo qua email nay.</p>"
                + "<div class='footer'>Tran trong,<br>Doi ngu Football Star</div></div></body></html>";
        return sendHtmlEmail(email, subject, content, "Football Star");
    }

    // Gui thong bao dat san
    public boolean guiMailDatSanThanhCong(String email, String nameUser, String maDon, BigDecimal tongTien) {
        String subject = "Xac nhan dat san thanh cong - Football Star";
        String content = "<!DOCTYPE html><html><head><meta charset='UTF-8'>"
                + "<style>body{font-family:Arial;background:#f4f4f4;} .container{max-width:600px;margin:40px auto;background:#fff;border-radius:10px;padding:20px;}"
                + ".header{background:#28a745;color:#fff;padding:20px;text-align:center;font-size:24px;}"
                + ".footer{padding:20px;font-size:14px;color:#999;text-align:center;}</style>"
                + "</head><body><div class='container'>"
                + "<div class='header'>Dat san thanh cong!</div>"
                + "<p>Xin chao <strong>" + nameUser + "</strong>,</p>"
                + "<p>Chung toi xac nhan rang ban da dat san thanh cong tai <strong>Football Star</strong>.</p>"
                + "<p><strong>Ma don dat:</strong> " + maDon + "</p>"
                + "<p><strong>Tong tien:</strong> " + tongTien.toPlainString() + " VND</p>"
                + "<p>Cam on ban da su dung dich vu cua chung toi.</p>"
                + "<p>Hen gap ban tai san!</p>"
                + "<div class='footer'>Tran trong,<br>Doi ngu Football Star</div></div></body></html>";
        return sendHtmlEmail(email, subject, content, "Football Star");
    }

    public boolean guiMailDangKyGoogle(String email, String fullName, String username, String password) {
        String subject = "Tai khoan da duoc tao thanh cong - Football Star";

        String content = "<!DOCTYPE html><html><head><meta charset='UTF-8'>"
                + "<style>"
                + "body { font-family: Arial, sans-serif; background-color: #f0f2f5; margin: 0; padding: 0; }"
                + ".container { max-width: 600px; margin: 40px auto; background: #ffffff; border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); overflow: hidden; }"
                + ".header { background-color: #007bff; color: white; padding: 20px; text-align: center; font-size: 24px; }"
                + ".content { padding: 30px; text-align: left; line-height: 1.6; }"
                + ".footer { padding: 15px; font-size: 14px; color: #999999; text-align: center; }"
                + "</style></head><body>"
                + "<div class='container'>"
                + "<div class='header'>Tai khoan Google da duoc tao</div>"
                + "<div class='content'>"
                + "<p>Xin chao <strong>" + fullName + "</strong>,</p>"
                + "<p>Ban da dang ky tai khoan qua Google tai <strong>Football Star</strong>.</p>"
                + "<p>Duoi day la thong tin dang nhap cua ban:</p>"
                + "<ul>"
                + "<li><strong>Ten dang nhap:</strong> " + username + "</li>"
                + "<li><strong>Mat khau:</strong> " + password + "</li>"
                + "</ul>"
                + "<p>Ban co the thay doi mat khau sau khi dang nhap.</p>"
                + "<p>Chuc ban co trai nghiem tuyet voi cung Football Star!</p>"
                + "</div>"
                + "<div class='footer'>Tran trong,<br>Doi ngu Football Star</div>"
                + "</div></body></html>";

        return sendHtmlEmail(email, subject, content, "Football Star");
    }

    // Test nhanh
    public static void main(String[] args) {
        SendMail sendMail = new SendMail();
        String emailNguoiNhan = "huubinh0601@gmail.com";
        String tenNguoiDung = "Nguyen Van A";
        String linkXacThuc = "http://localhost:8080/XacThucTaiKhoan?token=abc123xyz";

        boolean result = sendMail.guiMailDatSanThanhCong(emailNguoiNhan, tenNguoiDung, "453435", BigDecimal.ONE);
        if (result) {
            System.out.println("Gui email thanh cong.");
        } else {
            System.out.println("Gui email that bai.");
        }
    }
}
