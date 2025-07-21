/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
import jakarta.servlet.http.Part;
import java.sql.Timestamp;
import logic.CloudinaryUploader;
import model.Blog;
import model.Event;
import model.Title;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "UpdateBaiDang", urlPatterns = {"/admin/sua-bai-dang"})
@MultipartConfig
public class UpdateBaiDang extends HttpServlet {

    private final CloudinaryUploader uploader = new CloudinaryUploader();

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int blogId = Integer.parseInt(request.getParameter("blogId"));

        blogDAO bDao = new blogDAO();

        Blog b = bDao.getBlogById(blogId);
        request.setAttribute("blog", b);
        request.getRequestDispatcher("SuaBaiDang.jsp").forward(request, response);
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

        try {
            int blogId = Integer.parseInt(request.getParameter("blogId"));
            String title = request.getParameter("title");
            String slug = request.getParameter("slug");
            String sum = request.getParameter("sum");
            String tag = request.getParameter("tag");
            String type = request.getParameter("type");

            String content = request.getParameter("title1");

            // Ảnh cũ
            String oldImage1 = request.getParameter("oldImage1");

            Part filePart1 = request.getPart("image1");

            String cloudinaryUrl1 = null;

            try {
                if (filePart1 != null && filePart1.getSize() > 0) {
                    cloudinaryUrl1 = uploader.uploadImage(filePart1, type);
                }

            } catch (Exception e) {
                e.printStackTrace();
                ToastUtil.setErrorToast(request, "Lỗi khi upload ảnh: " + e.getMessage());
                redirectBack(request, response);
                return;
            }

            // Khởi tạo và gán dữ liệu
            Blog b = new Blog();
            b.setBlogId(blogId);
            b.setTitle(title);
            b.setSlug(slug);
            b.setSummary(sum);
            b.setTags(tag);
            b.setContent(content);
            Timestamp updatedAt = new Timestamp(System.currentTimeMillis());
            b.setUpdatedAt(updatedAt);

            // Gán ảnh mới nếu có, nếu không dùng ảnh cũ
            b.setThumbnailUrl(cloudinaryUrl1 != null ? cloudinaryUrl1 : oldImage1);

            // Gán title
            // Cập nhật CSDL
            blogDAO bDao = new blogDAO();
            boolean success = bDao.updateBlog(b);

            if (success) {
                ToastUtil.setSuccessToast(request, "Cập nhật bài đăng thành công.");
            } else {
                ToastUtil.setErrorToast(request, "Cập nhật bài đăng thất bại.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            ToastUtil.setErrorToast(request, "Đã xảy ra lỗi khi cập nhật: " + e.getMessage());
        }

        redirectBack(request, response);

    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String referer = request.getHeader("referer");
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/home");
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
