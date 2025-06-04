package controller;

import dao.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import model.Account;
import model.UserProfile;
/////
@WebServlet(name = "Dang_ki", urlPatterns = {"/dang-ki"})
public class DangKi extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8"); // trả về text đơn giản

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String password_confirm = request.getParameter("password_confirm");
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String createdAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        String avatar = "./assets/images/avata/avt123.jpeg";
        int statusId = 2;
        int roleId = 3;

        AccountDAO ad = new AccountDAO();

        try {
            if (!password.equals(password_confirm)) {
                response.getWriter().write("Mật khẩu xác nhận không khớp!");
                return;
            }

            if (ad.checkTonTaiUsername(username)) {
                response.getWriter().write("Tên đăng nhập đã tồn tại!");
                return;
            }

            if (ad.checkTonTaiEmail(email)) {
                response.getWriter().write("Email đã được sử dụng!");
                return;
            }

            UserProfile profile = new UserProfile(roleId, firstName, lastName, address, gender, dob, phone, avatar);
            Account account = new Account(statusId, username, password, email, createdAt, profile);

            if (ad.addAccountAndSendVerificationEmail(account)) {
                response.getWriter().write("Đăng ký thành công! Vui lòng kiểm tra email.");
            } else {
                response.getWriter().write("Đăng ký thất bại. Vui lòng thử lại.");
            }

        } catch (Exception e) {
            response.getWriter().write("Lỗi hệ thống: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("UI/dangki.jsp").forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng ký người dùng có xác minh email";
    }
}
