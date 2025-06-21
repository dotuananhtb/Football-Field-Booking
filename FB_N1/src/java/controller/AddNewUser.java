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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.Account;
import model.StatusAccount;
import model.UserProfile;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name="AddNewUser", urlPatterns={"/admin/addUser"})
public class AddNewUser extends HttpServlet {
   
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
      
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    

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

        request.setCharacterEncoding("UTF-8");
         // trả về text đơn giản

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String createdAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        String avatar = "./assets/images/avata/avt123.jpeg";
        int statusId = 1;
        int roleId = 3;

        AccountDAO ad = new AccountDAO();

        try {
           if (ad.checkTonTaiUsername(username)) {
                ToastUtil.setErrorToast(request,"Tên đăng nhập đã tồn tại!");
                response.sendRedirect( request.getContextPath() + "/admin/quan-li-nhan-vien");
                return;
            }

            if (ad.checkTonTaiEmail(email)) {
                ToastUtil.setErrorToast(request, "Email đã tồn tại!");
                response.sendRedirect( request.getContextPath() + "/admin/quan-li-nhan-vien");
                return;
            }

            UserProfile profile = new UserProfile(roleId, firstName, lastName, address, gender, dob, phone, avatar);
            Account account = new Account(statusId, username, password, email, createdAt, profile);

            if (ad.insertAccountWithProfile(account)) {
                ToastUtil.setSuccessToast(request, "Thêm người dùng thành công!");
            } else {
                ToastUtil.setErrorToast(request, "Thêm người dùng không thành công!");
            }

        } catch (Exception e) {
            response.getWriter().write("Lỗi hệ thống: " + e.getMessage());
        }
                doGet(request, response);
        
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int roleId = 3;
        StatusAccountDAO sDao = new StatusAccountDAO();
        AccountDAO aDao = new AccountDAO();
        List<Account> listA = aDao.getAccountByRoleId(roleId);
        List<StatusAccount> listS = sDao.getStatusAccount();
        request.setAttribute("listUser", listA);
        request.setAttribute("listStatus", listS);
         request.getRequestDispatcher("/admin/manage-user.jsp").forward(request, response);
    } 
   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
