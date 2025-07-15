/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "BaiDang", urlPatterns = {"/bai-dang"})
public class BaiDang extends HttpServlet {

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        blogDAO bDao = new blogDAO();
        List<Blog> listB = bDao.getAllBlog();
        List<Blog> listB1 = bDao.getLatest3Blogs();

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
        System.out.println(listB);
        System.out.println(listB1);
        System.out.println(listTag);

        request.setAttribute("listB", listB);
        request.setAttribute("listB1", listB1);
        request.setAttribute("listTag", listTag);

        request.getRequestDispatcher("UI/baiDang.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
