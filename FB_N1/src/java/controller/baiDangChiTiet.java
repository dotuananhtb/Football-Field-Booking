/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import com.google.gson.Gson;
import dao.blogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Blog;
import util.TimeAgoUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name="baiDangChiTiet", urlPatterns={"/bai-dang-chi-tiet"})
public class baiDangChiTiet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
      
       
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
       
          
        String slug = request.getParameter("slug");
        System.out.println("slug =" +slug);
        blogDAO bDao = new blogDAO();
        Blog blog = bDao.getBlogBySlug(slug);
        List<Blog> listB1 = bDao.getLatest3Blogs();
        for (Blog b : listB1) {
            b.setTimeAgo(TimeAgoUtil.getTimeAgo(b.getCreatedAt()));
        }
        
        Set<String> rawTags = bDao.getAllTags();
        Set<String> individualTags = new HashSet<>();

        for (String tagGroup : rawTags) {
            if (tagGroup != null && !tagGroup.trim().isEmpty()) {
                String[] splitTags = tagGroup.split(",");
                for (String tag : splitTags) {
                    String trimmed = tag.trim().toLowerCase(); // chuẩn hóa
                    if (!trimmed.isEmpty()) {
                        individualTags.add(trimmed);
                    }
                }
            }
        }
        List<String> listTag = new ArrayList<>(individualTags);

       

            // Xử lý thời gian "X phút trước"
            blog.setTimeAgo(TimeAgoUtil.getTimeAgo(blog.getCreatedAt()));
            request.setAttribute("listB1", listB1);
            request.setAttribute("listTag", listTag);
            request.setAttribute("blog", blog);
            
            request.getRequestDispatcher("UI/baiDangChitiet.jsp").forward(request, response);
        
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
