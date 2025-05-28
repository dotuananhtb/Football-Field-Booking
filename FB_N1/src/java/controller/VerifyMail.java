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
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import model.EmailVerificationToken;

/**
 *
 * @author Đỗ Tuấn Anh
 */
@WebServlet(name = "VerifyMail", urlPatterns = {"/verify"})
public class VerifyMail extends HttpServlet {

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
            out.println("<title>Servlet VerifyMail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyMail at " + request.getContextPath() + "</h1>");
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

        if (tokenParam == null || tokenParam.isEmpty()) {
            request.setAttribute("message", "Liên kết không hợp lệ!");
            request.getRequestDispatcher("result.jsp").forward(request, response);
            return;
        }

        EmailVerificationTokenDAO tokenDAO = new EmailVerificationTokenDAO();
        EmailVerificationToken token = tokenDAO.getTokenByValue(tokenParam);

        if (token == null) {
            request.setAttribute("message", "Token không tồn tại hoặc đã được sử dụng!");
            request.getRequestDispatcher("result.jsp").forward(request, response);
        } else if (token.isUsed()) {
            request.setAttribute("message", "Token đã được sử dụng!");
            request.getRequestDispatcher("result.jsp").forward(request, response);
        } else if (System.currentTimeMillis()
                > LocalDateTime.parse(token.getExpiresAt()).toInstant(ZoneOffset.UTC).toEpochMilli()) {
            request.setAttribute("message", "Token đã hết hạn!");
            request.getRequestDispatcher("result.jsp").forward(request, response);
        } else {
            // Cập nhật trạng thái tài khoản và token
            tokenDAO.activateAccount(token.getAccountId()) ;

            tokenDAO.markTokenAsUsed(token.getToken());

            // ✅ Xác minh thành công: chuyển hướng về trang chủ
            response.sendRedirect("home.jsp");
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
