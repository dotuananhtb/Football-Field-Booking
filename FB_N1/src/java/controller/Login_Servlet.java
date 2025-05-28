/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.LoginDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "Login_Servlet", urlPatterns = {"/login"})
public class Login_Servlet extends HttpServlet {

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

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember"); // null nếu không check

        LoginDAO dao = new LoginDAO();
        boolean isSuccess = dao.checkLogin(username, password);
        if (isSuccess) {
            session.setAttribute("username", username);

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
//                    session.setAttribute("password", password);
//                    session.setAttribute("remember", remember);

                Cookie userCookie = new Cookie("username", "");
                Cookie passCookie = new Cookie("password", "");
                Cookie rememberCookie = new Cookie("remember", "");

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

        } else {
            request.setAttribute("error", "Invalid Login");
            request.getRequestDispatcher("UI/home.jsp").forward(request, response);

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
        processRequest(request, response);
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
