/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.EventDAO;
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
import java.util.List;
import logic.CloudinaryUploader;
import model.Event;
import model.Slider;
import model.Title;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name="UpdateSlider", urlPatterns={"/admin/sua-slider"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 5 * 1024 * 1024,   // 5MB
    maxRequestSize = 10 * 1024 * 1024 // 10MB
)
public class UpdateSlider extends HttpServlet {
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
        try {
            int sliderId = Integer.parseInt(request.getParameter("slider_id"));
            System.out.println(sliderId +"abc");
            String title_content = request.getParameter("title_content");
        String content1 = request.getParameter("content1");
        String content2 = request.getParameter("content2");
        String content3 = request.getParameter("content3");
        Part filePart1 = request.getPart("image1");
        String oldImage1 = request.getParameter("oldImage1");
        
        String type = request.getParameter("type");
        String cloudinaryUrl = null;
        

            try {
                if (filePart1 != null && filePart1.getSize() > 0) {
                    cloudinaryUrl = uploader.uploadImage(filePart1, type);
                }

                
            } catch (Exception e) {
                e.printStackTrace();
                ToastUtil.setErrorToast(request, "Lỗi khi upload ảnh: " + e.getMessage());
                redirectBack(request, response);
                return;
            }

            // Khởi tạo và gán dữ liệu
            Slider slide = new Slider();
            slide.setSlider_id(sliderId);
            slide.setSlider_name(title_content);
            slide.setContent1_big(content1);
            slide.setContent1_small(content2);
            slide.setContent2_small(content3);

            // Gán ảnh mới nếu có, nếu không dùng ảnh cũ
            slide.setImage(cloudinaryUrl != null ? cloudinaryUrl : oldImage1);
            

            
           

            // Cập nhật CSDL
            SliderDAO slideDao = new SliderDAO();
            boolean success = slideDao.updateSlider(slide);

            if (success) {
                ToastUtil.setSuccessToast(request, "Cập nhật chủ đề thành công.");
            } else {
                ToastUtil.setErrorToast(request, "Cập nhật chủ đề thất bại.");
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
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       String slider_id = request.getParameter("slider_id");
       SliderDAO dao = new SliderDAO();
       Slider slide = dao.getAllSliderBySliderID(slider_id);
       List<Slider> listS = dao.getAllSlider();
       request.setAttribute("slider", slide);
       request.setAttribute("ListSlider", listS);
       request.getRequestDispatcher("/admin/sua-slider.jsp").forward(request, response);
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
