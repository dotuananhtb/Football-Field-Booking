/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import dao.UserProfileDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.lang.System.Logger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import model.Account;
import model.UserProfile;
import org.w3c.dom.ls.LSOutput;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private static final String SECRET_KEY = "6LcquVMrAAAAAGVqDcJAVf_gN-a66-dMxPwtLTvr";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("UI/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String gRecaptchaResponse = request.getParameter("g-recaptcha-response");

        boolean isCaptchaVerified = verifyRecaptcha(gRecaptchaResponse);

        if (!isCaptchaVerified) {
            request.setAttribute("error", "Xác minh captcha thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("UI/login.jsp").forward(request, response);
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        AccountDAO dao = new AccountDAO();
        boolean isSuccess = dao.checkLogin(username, password);
        int roleID = dao.getRoleIDbyAccount(username, password);
        int statusID = dao.getStatusIDbyAccount(username, password);

        if (isSuccess && statusID == 1) {
            Account acc = dao.getAccountByUsername(username);

            session.setAttribute("account", acc);
            session.setAttribute("userProfile", acc.getUserProfile());
            session.setAttribute("roleID", roleID);
            session.setAttribute("statusID", statusID);

            // Xử lý ghi nhớ
            if ("on".equals(remember)) {
                Cookie userCookie = new Cookie("username", username);
                Cookie rememberCookie = new Cookie("remember", "true");
                userCookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
                rememberCookie.setMaxAge(7 * 24 * 60 * 60);
                userCookie.setPath("/");
                rememberCookie.setPath("/");
                response.addCookie(userCookie);
                response.addCookie(rememberCookie);
            } else {
                Cookie userCookie = new Cookie("username", null);
                Cookie rememberCookie = new Cookie("remember", null);
                userCookie.setMaxAge(0);
                rememberCookie.setMaxAge(0);
                userCookie.setPath("/");
                rememberCookie.setPath("/");
                response.addCookie(userCookie);
                response.addCookie(rememberCookie);
            }

            // ✅ Redirect về trang trước khi login nếu có
            String redirectPath = (String) session.getAttribute("redirectAfterLogin");


            if (redirectPath != null && !redirectPath.trim().isEmpty() && !redirectPath.equals("/login")) {
                session.removeAttribute("redirectAfterLogin");
                String finalRedirect = request.getContextPath() + redirectPath;
                response.sendRedirect(response.encodeRedirectURL(finalRedirect)); // ✅ dùng encodeRedirectURL

            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }

        } else if (isSuccess && statusID == 2) {
            request.getRequestDispatcher("UI/UnverifyAccount.jsp").forward(request, response);
        } else if (isSuccess && statusID == 3) {
            request.getRequestDispatcher("UI/Account_Lock.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng.");
            request.getRequestDispatcher("UI/login.jsp").forward(request, response);
        }
    }

    private boolean verifyRecaptcha(String gRecaptchaResponse) throws IOException {
        String url = "https://www.google.com/recaptcha/api/siteverify";
        String params = "secret=" + URLEncoder.encode(SECRET_KEY, "UTF-8")
                + "&response=" + URLEncoder.encode(gRecaptchaResponse, "UTF-8");

        HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();
        con.setRequestMethod("POST");
        con.setDoOutput(true);
        con.getOutputStream().write(params.getBytes("UTF-8"));

        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        StringBuilder responseStr = new StringBuilder();
        String inputLine;
        while ((inputLine = in.readLine()) != null) {
            responseStr.append(inputLine);
        }
        in.close();

        return responseStr.toString().contains("\"success\": true");
    }
}
