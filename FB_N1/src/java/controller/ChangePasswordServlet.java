package controller;

import dao.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/changePassword"})
public class ChangePasswordServlet extends HttpServlet {
    //doi mat khau 123

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = "UI/changePassword.jsp";
        try {
            HttpSession session = request.getSession();
           // String username="admin_user";
            String username = (String) session.getAttribute("username");

            // Kiểm tra đăng nhập
            if (username == null || username.isEmpty()) {
                response.sendRedirect("home");
                return;
            }

            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            // Kiểm tra dữ liệu đầu vào
            if (currentPassword == null || newPassword == null || confirmPassword == null
                    || currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
                request.getRequestDispatcher(url).forward(request, response);
                return;
            }

            // Kiểm tra mật khẩu mới và xác nhận mật khẩu
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp!");
                request.getRequestDispatcher(url).forward(request, response);
                return;
            }

            // Kiểm tra độ dài mật khẩu mới
            if (newPassword.length() < 6) {
                request.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
                request.getRequestDispatcher(url).forward(request, response);
                return;
            }

            AccountDAO accountDAO = new AccountDAO();

            // Kiểm tra mật khẩu hiện tại
            if (!accountDAO.checkPassword(username, currentPassword)) {
                request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
                request.getRequestDispatcher(url).forward(request, response);
                return;
            }

            // Thực hiện đổi mật khẩu
            if (accountDAO.update_Password(username, newPassword)) {
                request.setAttribute("success", "Đổi mật khẩu thành công!");
            } else {
                request.setAttribute("error", "Đổi mật khẩu thất bại! ");
            }

        } catch (Exception e) {
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        request.getRequestDispatcher(url).forward(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý thay đổi mật khẩu";
    }
}
