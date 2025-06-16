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
import model.Account;
import model.UserProfile;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "UpdateUser", urlPatterns = {"/updateUser"})
public class UpdateUser extends HttpServlet {

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
    HttpSession session = request.getSession();
    String mess = "";
    
    try {
        
        String firstName = request.getParameter("fname");
        String lastName = request.getParameter("lname");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String username = request.getParameter("username");
        String phone = request.getParameter("phone");
        String id = request.getParameter("id");
        String avatar = request.getParameter("avatar");
        
        // Kiểm tra dữ liệu đầu vào
        if (username == null || username.trim().isEmpty()) {
            mess = "Tên đăng nhập không được để trống";
            session.setAttribute("mess", mess);
            request.getRequestDispatcher("UI/hoSoNguoiDung.jsp").forward(request, response);
            return;
        }
        
        AccountDAO accountDAO = new AccountDAO();
        Account currentAccount = (Account) session.getAttribute("account");
        
        // Kiểm tra username đã tồn tại và không phải là username hiện tại
        if (!username.equals(currentAccount.getUsername())) {
            Account existingAccount = accountDAO.getAccountByUsername(username);
            if (existingAccount != null) {
                mess = "Tài khoản đã tồn tại";
                session.setAttribute("mess", mess);
                request.getRequestDispatcher("UI/hoSoNguoiDung.jsp").forward(request, response);
                return;
            }
        }
        
        // Cập nhật thông tin profile
        UserProfileDAO userProfileDAO = new UserProfileDAO();
        UserProfile userProfile = new UserProfile(firstName, lastName, address, gender, dob, phone, avatar);
        userProfileDAO.updateProfile1(userProfile, id);
        
        // Cập nhật username nếu thay đổi
        if (!username.equals(currentAccount.getUsername())) {
            accountDAO.updateUsername(username, id);
        }
        
        // Lấy lại thông tin mới nhất từ db
        int accountId = Integer.parseInt(id);
        UserProfile updatedProfile = userProfileDAO.getProfileByAccountId(accountId);
        Account updatedAccount = accountDAO.getAccountById(accountId);
        
        ToastUtil.setSuccessToast(request, "Cập nhật thông tin người dùng thành công!");
        
        session.setAttribute("userProfile", updatedProfile);
        session.setAttribute("account", updatedAccount);
        session.setAttribute("username", username);
        session.removeAttribute("mess"); 
        
        
        request.getRequestDispatcher("UI/hoSoNguoiDung.jsp").forward(request, response);
        
    } catch (Exception e) {
        e.printStackTrace();
        mess = "Đã xảy ra lỗi khi cập nhật thông tin";
        session.setAttribute("mess", mess);
        request.getRequestDispatcher("UI/hoSoNguoiDung.jsp").forward(request, response);
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
