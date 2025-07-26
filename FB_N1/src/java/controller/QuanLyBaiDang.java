/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.StatusBlogDAO;
import dao.blogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Blog;
import model.Status_Blog;
import util.TimeAgoUtil;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name="QuanLyBaiDang", urlPatterns={"/admin/quan-li-bai-dang"})
public class QuanLyBaiDang extends HttpServlet {
   
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

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        
          blogDAO bDao = new blogDAO();
          StatusBlogDAO s = new StatusBlogDAO();
         List<Status_Blog> list = s.getAllStatus();
        List<Blog> listB = bDao.getAllBlog();
        
        request.setAttribute("listS", list);
        request.setAttribute("listB", listB);
        request.getRequestDispatcher("QuanLyBaiDang.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        int blogId = Integer.parseInt(request.getParameter("bId"));
        int statusId = Integer.parseInt(request.getParameter("sId"));
        blogDAO bDao = new blogDAO();
        
        boolean a = bDao.changeStatus(blogId, statusId);
        if(a){
            ToastUtil.setSuccessToast(request, "Đổi trạng thái thành công!");
        }
          response.sendRedirect(request.getContextPath() + "/admin/quan-li-bai-dang");
        
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
