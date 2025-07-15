package controller;

import dao.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import util.PasswordUtil;
import util.ToastUtil;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/changePassword"})
public class ChangePasswordServlet extends HttpServlet {
    //doi mat khau 123

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
       

    }

    
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         HttpSession session = request.getSession();
        String pass = request.getParameter("pass");
        String repass = request.getParameter("re-pass");
         String hashPass =   PasswordUtil.hashPassword(pass);
         System.out.println(hashPass);
        AccountDAO accountDAO = new AccountDAO();
        Account currentAccount = (Account) session.getAttribute("account");
        
        String oldPass = currentAccount.getPassword();
         System.out.println(oldPass);
        
        if(PasswordUtil.checkPassword(pass,oldPass )){
            ToastUtil.setErrorToast(request, "Mật khẩu mới không thể trùng mật khẩu cũ");
        }else{
           if(!pass.equals(repass)){
              ToastUtil.setErrorToast(request, "Nhập lại mật khẩu không giống nhau");
           }else{
               accountDAO.update_Password(currentAccount.getUsername(), PasswordUtil.hashPassword(repass));
               ToastUtil.setSuccessToast(request, "Đổi mật khẩu thành công");
           }
        }
        
        
        
        response.sendRedirect(request.getContextPath() + "/changePassword");
        
        
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("UI/changePassword.jsp").forward(request, response);
    }

   

    @Override
    public String getServletInfo() {
        return "Servlet xử lý thay đổi mật khẩu";
    }
}
