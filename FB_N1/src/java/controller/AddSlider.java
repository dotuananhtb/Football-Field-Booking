/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import logic.CloudinaryUploader;
import model.Event;
import model.Slider;
import model.Title;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name="AddSlider", urlPatterns={"/admin/tao-moi-slider"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 5 * 1024 * 1024,   // 5MB
    maxRequestSize = 10 * 1024 * 1024 // 10MB
)
public class AddSlider extends HttpServlet {
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

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String title_content = request.getParameter("title_content");
        String content1 = request.getParameter("content1");
        String content2 = request.getParameter("content2");
        String content3 = request.getParameter("content3");
        Part filePart1 = request.getPart("image1");
        
        String type = request.getParameter("type");
        SliderDAO slideDao = new SliderDAO();
         try {
            String cloudinaryUrl = uploader.uploadImage(filePart1, type);
            

            if (cloudinaryUrl == null ) {
                ToastUtil.setErrorToast(request, "Vui lòng chọn đúng định dạng ảnh (jpg, png, jpeg, gif, webp).");
                redirectBack(request, response);
                return;
            }
            switch (type.toLowerCase()) {
                case "slider":

                   Slider slider = new Slider(title_content, cloudinaryUrl, content1, content2, content3);

                    boolean n = slideDao.insertSlider(slider);
                    if (n) {
                        ToastUtil.setSuccessToast(request, "Thêm Slider thành công");
                    } else {
                        ToastUtil.setErrorToast(request, "Thêm Slider không thành công");
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
        
        
    
    
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("/admin/tao-moi-slider.jsp").forward(request, response);
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
