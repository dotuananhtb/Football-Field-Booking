/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.EventDAO;
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
import model.Title;
import util.ToastUtil;

/**
 *
 * @author VAN NGUYEN
 */
@WebServlet(name = "UpdateEvent", urlPatterns = {"/admin/sua-chu-de"})
@MultipartConfig
public class UpdateEvent extends HttpServlet {

    private final CloudinaryUploader uploader = new CloudinaryUploader();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            int titleId = Integer.parseInt(request.getParameter("titleId"));
            String titleContent = request.getParameter("title_content");
            String content1 = request.getParameter("content1");
            String content2 = request.getParameter("content2");
            String type = request.getParameter("type");

            String title1 = request.getParameter("title1");


            // Ảnh cũ
            String oldImage1 = request.getParameter("oldImage1");
            String oldImage2 = request.getParameter("oldImage2");

            Part filePart1 = request.getPart("image1");
            Part filePart2 = request.getPart("image2");

            String cloudinaryUrl1 = null;
            String cloudinaryUrl2 = null;

            try {
                if (filePart1 != null && filePart1.getSize() > 0) {
                    cloudinaryUrl1 = uploader.uploadImage(filePart1, type);
                }

                if (filePart2 != null && filePart2.getSize() > 0) {
                    cloudinaryUrl2 = uploader.uploadImage(filePart2, type);
                }
            } catch (Exception e) {
                e.printStackTrace();
                ToastUtil.setErrorToast(request, "Lỗi khi upload ảnh: " + e.getMessage());
                redirectBack(request, response);
                return;
            }

            // Khởi tạo và gán dữ liệu
            Event event = new Event();
            event.setEventID(eventId);
            event.setTitle_content(titleContent);
            event.setContent1(content1);
            event.setContent2(content2);

            // Gán ảnh mới nếu có, nếu không dùng ảnh cũ
            event.setImage_video(cloudinaryUrl1 != null ? cloudinaryUrl1 : oldImage1);
            event.setImage2(cloudinaryUrl2 != null ? cloudinaryUrl2 : oldImage2);

            // Gán title
            Title title = new Title(titleId, title1);
            event.setTitle(title);

            // Cập nhật CSDL
            EventDAO dao = new EventDAO();
            boolean success = dao.updateEventAndTitle(event);

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventId = request.getParameter("eventId");

        EventDAO eDao = new EventDAO();
        Event eve = eDao.getAllEventByEventId(eventId);
        List<Event> listE = eDao.getAllEvent();

        request.setAttribute("listEvent", listE);
        request.setAttribute("event", eve);
        request.getRequestDispatcher("/admin/sua-event.jsp").forward(request, response);
    }

    private void redirectBack(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String referer = request.getHeader("referer");
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/home");
    }

    @Override
    public String getServletInfo() {
        return "Cập nhật sự kiện và tiêu đề";
    }
}
