/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.EventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.List;
import logic.CloudinaryUploader;
import model.Event;
import model.Title;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "UpdateEvent", urlPatterns = {"/admin/sua-chu-de"})
public class UpdateEvent extends HttpServlet {

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
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            int titleId = Integer.parseInt(request.getParameter("titleId"));
            String titleContent = request.getParameter("title_content");
            String content1 = request.getParameter("content1");
            String content2 = request.getParameter("content2");
            String title1 = request.getParameter("title1");
            String title2 = request.getParameter("title2");
            String title3 = request.getParameter("title3");
            String title4 = request.getParameter("title4");
            String type = request.getParameter("type");

            Part filePart1 = request.getPart("image1");
            Part filePart2 = request.getPart("image2");

            try {
                String cloudinaryUrl = uploader.uploadImage(filePart1, type);
                String cloudinaryUrl2 = uploader.uploadImage(filePart2, type);

                if (cloudinaryUrl == null || cloudinaryUrl2 == null) {
                    ToastUtil.setErrorToast(request, "Vui lòng chọn đúng định dạng ảnh (jpg, png, jpeg, gif, webp).");
                    redirectBack(request, response);
                    return;
                }
                switch (type.toLowerCase()) {
                    case "event":

                        // Tạo các đối tượng để update
                        Title title = new Title(titleId, title1, title2, title3, title4);
                        Event event = new Event();
                        event.setEventID(eventId);
                        event.setTitle_content(titleContent);
                        event.setContent1(content1);
                        event.setContent2(content2);
                        event.setTitle(title);

                        if (cloudinaryUrl != null) {
                            event.setImage_video(cloudinaryUrl);
                        }
                        if (cloudinaryUrl2 != null) {
                            event.setImage2(cloudinaryUrl2);
                        }

                        EventDAO dao = new EventDAO();
                        boolean success = dao.updateEventAndTitle(event);

                        if (success) {
                            ToastUtil.setSuccessToast(request, "Cập nhật chủ đề thành công.");
                        } else {
                            ToastUtil.setErrorToast(request, "Cập nhật chủ đề thất bại.");
                        }
                        break;

                }
            } catch (Exception e) {
                e.printStackTrace(); // ❗ In lỗi chi tiết ra console
                ToastUtil.setErrorToast(request, "Lỗi upload ảnh: " + e.getMessage());
            }

            redirectBack(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            ToastUtil.setErrorToast(request, "Đã xảy ra lỗi khi cập nhật chủ đề: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/sua-chu-de");

    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String referer = request.getHeader("referer");
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/home");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventId = request.getParameter("eventId");
        EventDAO eDao = new EventDAO();
        Event eve = eDao.getAllEventByEventId(eventId);
        System.out.println(eve);
        List<Event> listE = eDao.getAllEvent();

        request.setAttribute("listEvent", listE);
        request.setAttribute("event", eve);
        request.getRequestDispatcher("/admin/sua-event.jsp").forward(request, response);
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
