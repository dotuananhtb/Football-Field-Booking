/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import dao.StatusAccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.StatusAccount;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "UserManagementServlet", urlPatterns = {"/admin/quan-li-tai-khoan"})
public class UserManagementServlet extends HttpServlet {

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountId = request.getParameter("aId");
        String statusId = request.getParameter("sId");
        
        AccountDAO aDao = new AccountDAO();
        boolean a = aDao.changeStatus(accountId, statusId);
        if(a){
            ToastUtil.setSuccessToast(request, "Đổi trạng thái thành công!");
        }
          response.sendRedirect(request.getContextPath() + "/admin/quan-li-tai-khoan");
    }
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int roleId = 3;
       StatusAccountDAO sDao = new StatusAccountDAO();
       AccountDAO aDao = new AccountDAO();
        
        List<StatusAccount> listS = sDao.getStatusAccount();

        List<Account> listA = aDao.getAccountByRoleId(roleId);
        request.setAttribute("listUser", listA);
        request.setAttribute("listStatus", listS);
        request.getRequestDispatcher("/admin/manage-user.jsp").forward(request, response);

    }

   

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
