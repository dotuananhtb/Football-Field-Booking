/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import dao.EmailVerificationTokenDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import model.Account;
import model.EmailVerificationToken;

/**
 *
 * @author Admin
 */
@WebServlet(name = "resetPassword", urlPatterns = {"/resetPassword"})
public class resetPassword extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet resetPassword</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet resetPassword at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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

        String tokenParam = request.getParameter("token");
        EmailVerificationTokenDAO tokenDAO = new EmailVerificationTokenDAO();
        AccountDAO dao = new AccountDAO();
        HttpSession session = request.getSession();
        if (tokenParam != null) {
            EmailVerificationToken token = tokenDAO.getTokenByValue(tokenParam);

            if (token == null) {
                request.setAttribute("mess", "Token không tồn tại hoặc đã được sử dụng!");
                request.getRequestDispatcher("UI/requestPassword.jsp").forward(request, response);
            } else if (token.isUsed()) {
                request.setAttribute("mess", "Token đã được sử dụng!");
                request.getRequestDispatcher("UI/requestPassword.jsp").forward(request, response);
            } else if (System.currentTimeMillis()
                    > LocalDateTime.parse(token.getExpiresAt()).toInstant(ZoneOffset.UTC).toEpochMilli()) {
                request.setAttribute("mess", "Token đã hết hạn!");
                request.getRequestDispatcher("UI/requestPassword.jsp").forward(request, response);
            } else {
//                // Cập nhật trạng thái tài khoản và token
//
//                tokenDAO.markTokenAsUsed(token.getToken());
//
//                // ✅ Xác minh thành công: chuyển hướng về trang chủ
//                response.sendRedirect("UI/home.jsp");

                Account acc = dao.getAccountById(token.getAccountId());
                request.setAttribute("email", acc.getEmail());
                session.setAttribute("token", token.getToken());
                request.getRequestDispatcher("UI/resetPassword.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("mess", "Liên kết không hợp lệ!");
            request.getRequestDispatcher("UI/requestPassword.jsp").forward(request, response);
        }
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String cPassword = request.getParameter("confirmPassword");
        EmailVerificationTokenDAO tokenDAO = new EmailVerificationTokenDAO();
        AccountDAO dao = new AccountDAO();
        Account acc = dao.getAccountById(dao.getAcountIdByEmail(email));

        if (!password.equals(cPassword)) {
            request.setAttribute("mess", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("UI/resetPassword.jsp").forward(request, response);
            return;
        }
        if (!dao.isStrongPassword(password)) {
            request.setAttribute("mess", "ít nhất 8 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("UI/resetPassword.jsp").forward(request, response);
            return;
        }
        if (dao.isSamePassword(acc.getAccountId(), password)) {
            request.setAttribute("mess", "Mật khẩu mới không được trùng với mật khẩu cũ!");
            request.setAttribute("email", acc.getEmail());
            request.getRequestDispatcher("UI/resetPassword.jsp").forward(request, response);
            return;
        }
        

        HttpSession session = request.getSession();
        String tokenParam = (String) session.getAttribute("token");
        EmailVerificationToken token = tokenDAO.getTokenByValue(tokenParam);
        // kiểm tra xem có tồn tại hay không, hết hạn chưa, đã sử dụng chưa
        if (token == null) {
            request.setAttribute("mess", "Token không tồn tại hoặc đã được sử dụng!");
            request.getRequestDispatcher("UI/requestPassword.jsp").forward(request, response);
        } else if (token.isUsed()) {
            request.setAttribute("mess", "Token đã được sử dụng!");
            request.getRequestDispatcher("UI/requestPassword.jsp").forward(request, response);
        } else if (System.currentTimeMillis()
                > LocalDateTime.parse(token.getExpiresAt()).toInstant(ZoneOffset.UTC).toEpochMilli()) {
            request.setAttribute("mess", "Token đã hết hạn!");
            request.getRequestDispatcher("UI/requestPassword.jsp").forward(request, response);
        }
        EmailVerificationToken evt = new EmailVerificationToken();
        evt.setToken((String) session.getAttribute("token"));

        evt.setUsed(true);
        dao.updatePassword(email, password);
        // Cập nhật trạng thái tài khoản và token

        tokenDAO.markTokenAsUsed(evt.getToken());

        //Xác minh thành công: chuyển hướng về trang chủ
        response.sendRedirect("UI/home.jsp");
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
