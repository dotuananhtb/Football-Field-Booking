package controller;

import dao.CommentDAO;
import model.Comment;
import model.Account;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import util.ToastUtil;

@WebServlet(name = "UpdateCommentServlet", urlPatterns = {"/cap-nhat-binh-luan"})
public class UpdateCommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String commentIdStr = request.getParameter("commentId");
            String content = request.getParameter("content");
            String postIdStr = request.getParameter("postId");
            HttpSession session = request.getSession(false);
            Account acc = (Account) session.getAttribute("account");

            if (acc == null) {
                response.sendRedirect("/FB_N1/login");
                return;
            }

            if (commentIdStr != null && content != null && postIdStr != null) {
                int commentId = Integer.parseInt(commentIdStr);
                int postId = Integer.parseInt(postIdStr);

                CommentDAO commentDAO = new CommentDAO();
                Comment comment = commentDAO.getCommentById(commentId);

                // Kiểm tra xem người dùng có quyền chỉnh sửa comment này không
                if (comment != null && comment.getAccountId() == acc.getAccountId()) {
                    comment.setContentCmt(content);
                    commentDAO.updateComment(comment);
                    ToastUtil.setSuccessToast(request, "Cập nhật bình luận thành công!");
                } else {
                    ToastUtil.setErrorToast(request, "Bạn không có quyền chỉnh sửa bình luận này!");
                }
            }
            response.sendRedirect(request.getContextPath() + "/chi-tiet-bai-viet?postId=" + postIdStr);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
        }
    }
} 