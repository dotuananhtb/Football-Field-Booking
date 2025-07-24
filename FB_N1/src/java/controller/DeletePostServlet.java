package controller;

import dao.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import util.ToastUtil;

@WebServlet(name = "DeletePostServlet", urlPatterns = {"/xoa-bai-viet"})
public class DeletePostServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String postIdStr = request.getParameter("postId");
        String from = request.getParameter("from");
        if (postIdStr != null) {
            int postId = Integer.parseInt(postIdStr);
            PostDAO postDAO = new PostDAO();
            postDAO.softDeletePost(postId);
        }

        if ("admin".equals(from)) {
            ToastUtil.setSuccessToast(request, "Xoá bài viết thành công!");
            response.sendRedirect("/FB_N1/admin/quan-ly-bai-viet-bat-doi");
        } else {
            ToastUtil.setSuccessToast(request, "Xoá bài viết thành công!");
            response.sendRedirect("quan-ly-bai-viet-nguoi-dung");
        }
    }
}
