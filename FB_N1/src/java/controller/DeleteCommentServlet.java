package controller;

import dao.CommentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Comment;

import java.io.IOException;

@WebServlet(name = "DeleteCommentServlet", urlPatterns = {"/deleteComment"})
public class DeleteCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        
        // Kiểm tra đăng nhập
        if (account == null) {
            response.sendRedirect("login");
            return;
        }

        int roleId = account.getRoleId();
        int userId = account.getAccountId();

        try {
            int commentId = Integer.parseInt(request.getParameter("commentId"));
            CommentDAO commentDAO = new CommentDAO();
            Comment comment = commentDAO.getCommentById(commentId);

            // Kiểm tra comment tồn tại
            if (comment == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy bình luận!");
                return;
            }

            // Chỉ cho phép xóa nếu là chủ comment hoặc là staff/admin
            if (comment.getAccountId() == userId || roleId == 1 || roleId == 2) {
                commentDAO.deleteComment(commentId);
                // Chuyển hướng hoặc thông báo thành công
                response.sendRedirect("blogdetails?postId=" + comment.getPostId());
            } else {
                // Báo lỗi không đủ quyền
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền xóa bình luận này!");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID bình luận không hợp lệ!");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra khi xóa bình luận!");
        }
    }
} 