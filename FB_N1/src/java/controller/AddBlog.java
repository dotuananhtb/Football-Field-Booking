/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.AccountDAO;
import dao.EventDAO;
import dao.blogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.sql.Timestamp;
import logic.CloudinaryUploader;
import model.Account;
import model.Blog;
import model.Event;
import model.Title;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name="AddBlog", urlPatterns={"/admin/tao-moi-bai-dang"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 5 * 1024 * 1024,   // 5MB
    maxRequestSize = 10 * 1024 * 1024 // 10MB
)
public class AddBlog extends HttpServlet {
   private final CloudinaryUploader uploader = new CloudinaryUploader();
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("TaoMoiBaiDang.jsp").forward(request, response);
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
            HttpSession session = request.getSession();
            String title = request.getParameter("title");
            String slug = request.getParameter("slug");
            String sum = request.getParameter("sum");
            String tag = request.getParameter("tag");
            String type = request.getParameter("type");
            
            String content = request.getParameter("title1");
            Part filePart1 = request.getPart("image1");
             AccountDAO accountDAO = new AccountDAO();
            Account currentAccount = (Account) session.getAttribute("account");
            
            blogDAO bDao = new blogDAO();

        try {
            String cloudinaryUrl = uploader.uploadImage(filePart1, type);
            

            if (cloudinaryUrl == null ) {
                ToastUtil.setErrorToast(request, "Vui lòng chọn đúng định dạng ảnh (jpg, png, jpeg, gif, webp).");
                redirectBack(request, response);
                return;
            }
            switch (type.toLowerCase()) {
                case "blog":

                   
                    Blog blog = new Blog(title, slug, sum, content, cloudinaryUrl, currentAccount.getAccountId(), 1, tag);

                    boolean n = bDao.insertBlog(blog);
                    if (n) {
                        ToastUtil.setSuccessToast(request, "Thêm bài đăng thành công");
                    } else {
                        ToastUtil.setErrorToast(request, "Thêm bài đăng không thành công");
                    }
                    break;

            }

        } catch (Exception e) {
            e.printStackTrace(); // ❗ In lỗi chi tiết ra console
            ToastUtil.setErrorToast(request, "Lỗi upload ảnh: " + e.getMessage());
        }

        redirectBack(request, response);
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String referer = request.getHeader("referer");
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/home");
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
