package controller;

import dao.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import util.ToastUtil;

@WebServlet(name = "UpdatePostStatusServlet", urlPatterns = {"/cap-nhat-trang-thai-bai-viet"})
public class UpdatePostStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postIdStr = request.getParameter("postId");
        String newStatus = request.getParameter("newStatus");
        String from = request.getParameter("from");
        if (postIdStr != null && newStatus != null) {
            int postId = Integer.parseInt(postIdStr);
            PostDAO postDAO = new PostDAO();
            postDAO.updatePostStatus(postId, newStatus);
            ToastUtil.setSuccessToast(request, "Cập nhật trạng thái thành công!");
        }
        if ("admin".equals(from)) {
            response.sendRedirect(request.getContextPath() + "/admin/managerPost");
        } else {
            response.sendRedirect("quan-ly-bai-viet-nguoi-dung");
        }
    }
} 