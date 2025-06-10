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
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import model.Account;
import model.UserProfile;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private static final String SECRET_KEY = "6LcquVMrAAAAAGVqDcJAVf_gN-a66-dMxPwtLTvr";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(true);
        String submit = request.getParameter("submit_Btn");

        if (submit == null) {
            request.getRequestDispatcher("UI/login.jsp").forward(request, response);
        } else {
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
            UserProfileDAO profile_dao = new UserProfileDAO();
            
            boolean isSuccess = dao.checkLogin(username, password);
            int a = dao.getRoleIDbyAccount(username, password);
            int b = dao.getStatusIDbyAccount(username, password);

            
            Account acc = dao.getAccountById(dao.getAccountIDbyUsername(username));
            UserProfile profile = profile_dao.getProfileByAccountId(dao.getAccountIDbyUsername(username));

            if (isSuccess && b == 1) {
                session.setAttribute("username", username);
                /////
                session.setAttribute("acc", acc);
                session.setAttribute("profile", profile);

                if ("on".equals(remember)) {
                    Cookie userCookie = new Cookie("username", username);
                    Cookie passCookie = new Cookie("password", password);
                    Cookie rememberCookie = new Cookie("remember", "true");

                    userCookie.setMaxAge(7 * 24 * 60 * 60);
                    passCookie.setMaxAge(7 * 24 * 60 * 60);
                    rememberCookie.setMaxAge(7 * 24 * 60 * 60);

                    userCookie.setPath("/");
                    passCookie.setPath("/");
                    rememberCookie.setPath("/");

                    response.addCookie(userCookie);
                    response.addCookie(passCookie);
                    response.addCookie(rememberCookie);
                } else {
                    Cookie userCookie = new Cookie("username", username);
                    Cookie passCookie = new Cookie("password", password);
                    Cookie rememberCookie = new Cookie("remember", "true");

                    userCookie.setMaxAge(0);
                    passCookie.setMaxAge(0);
                    rememberCookie.setMaxAge(0);

                    userCookie.setPath("/");
                    passCookie.setPath("/");
                    rememberCookie.setPath("/");

                    response.addCookie(userCookie);
                    response.addCookie(passCookie);
                    response.addCookie(rememberCookie);
                }

                response.sendRedirect("home");

            } else if (isSuccess && b == 2) {
                request.getRequestDispatcher("UI/UnverifyAccount.jsp").forward(request, response);
            } else if (isSuccess && b == 3) {
                request.getRequestDispatcher("UI/Account_Lock.jsp").forward(request, response);
            } else {
                String errorMess = "Tên đăng nhập hoặc mật khẩu không đúng.";
                request.setAttribute("error", errorMess);
                request.getRequestDispatcher("UI/login.jsp").forward(request, response);
            }
        }
    }

    private boolean verifyRecaptcha(String gRecaptchaResponse) throws IOException {
        String SECRET_KEY = "6LcquVMrAAAAAGVqDcJAVf_gN-a66-dMxPwtLTvr"; // Lấy từ Google
        String url = "https://www.google.com/recaptcha/api/siteverify";
        String params = "secret=" + URLEncoder.encode(SECRET_KEY, "UTF-8")
                + "&response=" + URLEncoder.encode(gRecaptchaResponse, "UTF-8");

        URL obj = new URL(url);
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod("POST");
        con.setDoOutput(true);
        con.getOutputStream().write(params.getBytes("UTF-8"));

        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine, response = "";
        while ((inputLine = in.readLine()) != null) {
            response += inputLine;
        }
        in.close();

        return response.contains("\"success\": true");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("UI/login.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
