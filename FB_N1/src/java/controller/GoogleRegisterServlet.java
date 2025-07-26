/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import dao.AccountDAO;
import dao.EmailVerificationTokenDAO;
import dao.UserProfileDAO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.UserProfile;
import util.ToastUtil;

@WebServlet("/googleRegister")
public class GoogleRegisterServlet extends HttpServlet {

    private AccountDAO accountDAO;

    @Override
    public void init() throws ServletException {
        accountDAO = new AccountDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Lấy thông tin người dùng từ request
            String userInfoJson = (String) request.getAttribute("userInfo");
            JsonObject userInfo = new JsonParser().parse(userInfoJson).getAsJsonObject();

            String googleId = userInfo.get("id").getAsString();
            String email = userInfo.get("email").getAsString();
            String firstName = userInfo.get("given_name").getAsString();
            String lastName = userInfo.get("family_name").getAsString();
            String avatar = userInfo.get("picture").getAsString();

            // Kiểm tra email có tồn tại trong DB không bằng hàm checkTonTaiEmail
            if (accountDAO.checkTonTaiEmail(email)) {
                // Nếu email tồn tại, kiểm tra status_id
                int statusId = accountDAO.getStatusIdByEmail(email);
                if (statusId == 1 || statusId == 2) {

                    if (statusId == 2) {
                        EmailVerificationTokenDAO emailVerificationTokenDAO = new EmailVerificationTokenDAO();
                        emailVerificationTokenDAO.activateAccount(accountDAO.getAccountByEmail(email).getAccountId());
                    }
                    // Đăng nhập nếu status_id là 1 hoặc 2

                    Account acc = accountDAO.getAccountByEmail(email);
                    UserProfile profile = acc.getUserProfile();

                    request.getSession().setAttribute("username", acc.getUsername());
                    request.getSession().setAttribute("account", acc);
                    request.getSession().setAttribute("userProfile", profile);

                    request.getSession().setAttribute("message", "Đăng nhập thành công!");

                    String redirectPath = (String) request.getSession().getAttribute("redirectAfterLogin");

                    if (redirectPath != null && !redirectPath.trim().isEmpty() && !redirectPath.equals("/dang-nhap")) {
                        request.getSession().removeAttribute("redirectAfterLogin");
                        String finalRedirect = request.getContextPath() + redirectPath;
                        ToastUtil.setSuccessToast(request, "Đăng nhập bằng Google thành công!");
                        response.sendRedirect(response.encodeRedirectURL(finalRedirect)); // ✅ dùng encodeRedirectURL

                    } else {
                        ToastUtil.setSuccessToast(request, "Đăng nhập bằng Google thành công!");
                        response.sendRedirect(request.getContextPath() + "/home");
                    }
                    return;

                } else if (statusId == 3) {
                    // Chuyển đến trang khóa tài khoản
                    ToastUtil.setErrorToast(request, "Tài khoản liên kết với email này đang bị khoá !");
                    request.getRequestDispatcher("/dang-nhap").forward(request, response);
                }
            } else {
                // Email chưa tồn tại, gọi addGoogleAccount
                boolean success = accountDAO.addGoogleAccount(googleId, email, firstName, lastName, avatar, null);
                if (success) {
                    Account acc = accountDAO.getAccountByEmail(email);
                    UserProfile profile = acc.getUserProfile();

                    request.getSession().setAttribute("username", acc.getUsername());
                    request.getSession().setAttribute("account", acc);
                    request.getSession().setAttribute("userProfile", profile);

                    request.getSession().setAttribute("message", "Đăng nhập thành công!");

                    String redirectPath = (String) request.getSession().getAttribute("redirectAfterLogin");

                    if (redirectPath != null && !redirectPath.trim().isEmpty() && !redirectPath.equals("/dang-nhap")) {
                        request.getSession().removeAttribute("redirectAfterLogin");
                        String finalRedirect = request.getContextPath() + redirectPath;
                        ToastUtil.setSuccessToast(request, "Đăng kí bằng Google thành công!");
                        response.sendRedirect(response.encodeRedirectURL(finalRedirect)); // ✅ dùng encodeRedirectURL

                    } else {
                        ToastUtil.setSuccessToast(request, "Đăng kí bằng Google thành công!");
                        response.sendRedirect(request.getContextPath() + "/home");
                    }
                    return;
                } else {
                    response.getWriter().println("<h2>Đăng ký thất bại!</h2>");
                }
            }

        } catch (Exception e) {
            response.getWriter().println("<h2>Lỗi khi xử lý đăng ký Google:</h2>");
            response.getWriter().println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace(response.getWriter());
        }
    }
}
