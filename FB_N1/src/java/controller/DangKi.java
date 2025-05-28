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

@WebServlet(name = "Dang_ki", urlPatterns = {"/dang-ki"})
public class DangKi extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Lấy dữ liệu từ form
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
        String createdAt = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        String avatar = "assets/img/avatars/avatar_goc.jpg";

        int statusId = 3; // Mặc định chưa xác minh
        int roleId = 3;   // Mặc định vai trò user

        AccountDAO ad = new AccountDAO();

        try {
            // Kiểm tra xác nhận mật khẩu
            if (!password.equals(password_confirm)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                request.getRequestDispatcher("dangki.jsp").forward(request, response);
                return;
            }

            // Kiểm tra username đã tồn tại chưa
            if (ad.checkTonTaiUsername(username)) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                request.getRequestDispatcher("dangki.jsp").forward(request, response);
                return;
            }

            // Kiểm tra email đã tồn tại chưa
            if (ad.checkTonTaiEmail(email)) {
                request.setAttribute("error", "Email đã được sử dụng!");
                request.getRequestDispatcher("dangki.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng tài khoản
            UserProfile profile = new UserProfile(roleId, firstName, lastName, address, gender, dob, phone, avatar);
            Account account = new Account(statusId, username, password, email, createdAt, profile);

            // Thêm vào DB và gửi email xác minh
            if (ad.addAccountAndSendVerificationEmail(account)) {
                request.setAttribute("message", "Đăng ký thành công! Vui lòng kiểm tra email để xác minh tài khoản.");
                request.getRequestDispatcher("dangnhap.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
                request.getRequestDispatcher("dangki.jsp").forward(request, response);
            }

        } catch (Exception e) {
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("dangki.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng ký người dùng có xác minh email";
    }
}
