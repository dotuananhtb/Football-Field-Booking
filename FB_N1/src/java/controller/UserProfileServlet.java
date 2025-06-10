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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name="UserProfile", urlPatterns={"/userProfile"})
public class UserProfileServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
//        HttpSession session = request.getSession();
//        Account a = (Account) session.getAttribute("username");
//        UserProfileDAO dao = new UserProfileDAO();
//        int u = a.getAccountId();
//        model.UserProfile uP = dao.getProfileByAccountId(u);
//        session.setAttribute("userProfile", uP);
           HttpSession session = request.getSession();
           String accountID = (String) session.getAttribute("username");
           AccountDAO dao = new AccountDAO();
           int accountID_int = dao.getAccountIDbyUsername(accountID);
           
           Account account = dao.getAccountById(accountID_int);
           UserProfileDAO uPDAO = new UserProfileDAO();
           UserProfile uP = uPDAO.getProfileByAccountId(accountID_int);
           
           session.setAttribute("userProfile", uP);
           session.setAttribute("account",account);
//           response.sendRedirect("UI/hoSoNguoiDung.jsp");
request.getRequestDispatcher("UI/hoSoNguoiDung.jsp").forward(request, response);
        
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
