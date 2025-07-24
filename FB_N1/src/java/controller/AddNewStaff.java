/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.AccountDAO;
import dao.RoleDAO;
import dao.StatusAccountDAO;
import dao.UserProfileDAO;
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
import model.Role;
import model.StatusAccount;
import model.UserProfile;
import util.PasswordUtil;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name="AddNewStaff", urlPatterns={"/admin/them-nhan-vien"})
public class AddNewStaff extends HttpServlet {
   
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
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
       String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String firstName = request.getParameter("fname");
        String phone = request.getParameter("phone");
        String lastName = request.getParameter("lname");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String createdAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        String avatar = "./assets/images/avata/avt123.jpeg";
        int statusId = 1;
        int roleId = 2;
         
        AccountDAO ad = new AccountDAO();
        UserProfileDAO user = new UserProfileDAO();

        try {
          if (ad.checkTonTaiUsername(username)) {
                ToastUtil.setErrorToast(request,"Tên đăng nhập đã tồn tại!");
                response.sendRedirect( request.getContextPath() + "/admin/quan-li-nhan-vien");
                return;
            }
          if(ad.checkTonTaiEmail(email)){
                ToastUtil.setErrorToast(request,"Email đã tồn tại!");
                response.sendRedirect( request.getContextPath() + "/admin/quan-li-nhan-vien");
                return;
          }
          if(user.checkTonTaiPhone(phone)){
              ToastUtil.setErrorToast(request,"Số điện thoại đã tồn tại!");
                response.sendRedirect( request.getContextPath() + "/admin/quan-li-nhan-vien");
                return;
          }
          
          
          UserProfile profile = new UserProfile(roleId, firstName, lastName, address, gender, dob, phone, avatar);
            
            Account account = new Account(statusId, username, PasswordUtil.hashPassword(password), email, createdAt, profile);

            if ( ad.insertAccountWithProfile2(account)) {
                ToastUtil.setSuccessToast(request, "Thêm nhân viên thành công!");
            } else {
                ToastUtil.setErrorToast(request, "Thêm nhân viên không thành công!");
            }

        } catch (Exception e) {
            response.getWriter().write("Lỗi hệ thống: " + e.getMessage());
        }
                doGet(request, response);
        
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int roleId = 2;
        StatusAccountDAO sDao = new StatusAccountDAO();
        AccountDAO aDao = new AccountDAO();
        RoleDAO rDao = new RoleDAO();
        List<Account> listA = aDao.getAccountByRoleId(roleId);
        List<StatusAccount> listS = sDao.getStatusAccount();
        List<Role> listR = rDao.getAllRoles();
        
        request.setAttribute("listRole", listR);
        request.setAttribute("listUser", listA);
        request.setAttribute("listStatus", listS);
         request.getRequestDispatcher("/admin/manage-staff.jsp").forward(request, response);
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
